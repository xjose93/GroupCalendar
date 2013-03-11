local gMCDataChannelLib_Version = 14

if not MCDataChannelLib or MCDataChannelLib.Version < gMCDataChannelLib_Version then
	if not MCDataChannelLib then
		MCDataChannelLib =
		{
			ChannelInfo = {},
			EventIDs = {},
			ChatChannelsReady = false,
			
			SpecialChannelIDs =
			{
				["#GUILD"] = "GUILD",
				["#PARTY"] = "PARTY",
				["#RAID"] = "RAID",
				["#BATTLEGROUND"] = "BATTLEGROUND",
			},
			
			MaxSendBytesPerSecond = 800,
			NextSendTime = 0,
			RetransmitInterval = 15,
			
			PlayerName = UnitName("player"),
		}
		
		MCDebugLib:InstallDebugger("MCDataChannelLib", MCDataChannelLib, {r=1, g=0.5, b=0.25})
	else
		MCDataChannelLib:UnregisterEvents()
	end
	
	function MCDataChannelLib:NewChannel(pPrefix, pMessageFunction, pClientRef, pAltPrefix)
		if pAltPrefix == pPrefix then
			pAltPrefix = nil
		end
		
		local vChannelClient =
		{
			Prefix = pPrefix,
			AltPrefix = pAltPrefix,
			MessageFunction = pMessageFunction,
			ClientRef = pClientRef,
			
			Open = false,
			Name = nil,
			Password = nil,
			
			Delete = self.Delete,
			
			OpenChannel = self.OpenChannel,
			CloseChannel = self.CloseChannel,
			
			SendMessage = self.SendMessageToChannel,
			SendMessageToClient = self.SendMessageToClient,
			ResendLastMessage = self.ResendLastMessage,
			SendFailed = self.SendFailed,
			
			ReadyToSend = self.ReadyToSend,
			
			SentMessageQueue = {},
			UseAltPrefixQueue = {},
		}
		
		return vChannelClient
	end
	
	function MCDataChannelLib:OpenChannelClient(pChannelClient, pChannelName, pPassword)
		if not pChannelName then
			self:DebugMessage("OpenChannelClient called with no channel name")
			self:DebugStack()
			return false
		end
		
		-- Create the channel info if necessary
		
		local vUpperChannelName = strupper(pChannelName)
		local vChannelInfo = self.ChannelInfo[vUpperChannelName]
		local vNewChannel = false
		
		if not vChannelInfo then
			vChannelInfo =
			{
				Name = pChannelName,
				UpperName = vUpperChannelName,
				Password = pPassword,
				GotTooManyChannelsMessage = false,
				
				Clients = {},
				WildcardClients = {},
			}
			
			self.ChannelInfo[vUpperChannelName] = vChannelInfo
			
			vChannelInfo.Permanent = self.SpecialChannelIDs[vUpperChannelName] ~= nil
			
			if self.ChatChannelsReady
			or vChannelInfo.Permanent then
				self:JoinChannel(vChannelInfo)
			else
				self:SetChannelStatus(vChannelInfo, "INIT", "Initializing")
			end
		end
		
		-- Add the client
		
		pChannelClient.Name = pChannelName
		pChannelClient.Password = pPassword
		
		if not pChannelClient.Prefix then
			table.insert(vChannelInfo.WildcardClients, pChannelClient)
		else
			vChannelInfo.Clients[pChannelClient.Prefix] = pChannelClient
			
			if pChannelClient.AltPrefix then
				vChannelInfo.Clients[pChannelClient.AltPrefix] = pChannelClient
			end
		end
		
		-- Notify the client of the current status
		
		pChannelClient.Status = vChannelInfo.Status
		pChannelClient.StatusMessage = vChannelInfo.StatusMessage
		
		if vChannelInfo.ID then
			pChannelClient.Connected = true
			pChannelClient:SendMessageToClient("#STATUS", "CONNECTED")
		end
		
		if vChannelInfo.Status ~= "CONNECTED" then
			pChannelClient:SendMessageToClient("#STATUS", vChannelInfo.Status, vChannelInfo.StatusMessage)
		end
		
		return true
	end
	
	function MCDataChannelLib:CloseChannelClient(pChannelClient)
		local vChannelInfo = self.ChannelInfo[strupper(pChannelClient.Name)]
		
		if not vChannelInfo then
			return false
		end
		
		if not pChannelClient.Prefix then
			local vFoundClient = false
			
			for vIndex, vChannelClient in ipairs(vChannelInfo.WildcardClients) do
				if vChannelClient == pChannelClient then
					table.remove(vChannelInfo.WildcardClients, vIndex)
					vFoundClient = true
					break
				end
			end
			
			if not vFoundClient then
				return false
			end
		else
			if vChannelInfo.Clients[pChannelClient.Prefix] ~= pChannelClient then
				return false
			end
			
			vChannelInfo.Clients[pChannelClient.Prefix] = nil
			
			if pChannelClient.AltPrefix then
				vChannelInfo.Clients[pChannelClient.AltPrefix] = nil
			end
		end
		
		MCSchedulerLib:UnscheduleTask(pChannelClient.ResendLastMessage, pChannelClient) -- Make sure a resend isn't pending
		pChannelClient.SentMessageQueue = {}
		pChannelClient.UseAltPrefixQueue = {}
		
		pChannelClient.Name = nil
		pChannelClient.Password = nil
		
		pChannelClient.Connected = false
		pChannelClient.Status = "DISCONNECTED"
		pChannelClient.StatusMessage = nil
		pChannelClient:SendMessageToClient("#STATUS", "DISCONNECTED")
		
		-- Just return if there are still more clients
		
		if #vChannelInfo.WildcardClients > 0 then
			return true
		end
		
		if next(vChannelInfo.Clients) then
			return true
		end
		
		-- Otherwise shut down the channel
		
		self:LeaveChannel(vChannelInfo)
		self.ChannelInfo[vChannelInfo.UpperName] = nil
		
		return true
	end
	
	function MCDataChannelLib:JoinChannel(pChannelInfo)
		if pChannelInfo.Permanent then
			if not pChannelInfo.ID then
				-- self:TestMessage("JoinChannel: Joining permanent channel "..pChannelInfo.Name)
				
				pChannelInfo.ID = self.SpecialChannelIDs[pChannelInfo.UpperName]
				
				if pChannelInfo.ID == "GUILD" and not IsInGuild() then
					pChannelInfo.ID = nil
					pChannelInfo.Open = false
					self:SetChannelStatus(pChannelInfo, "ERROR", "Not in a guild")
					return false
				end
				
				pChannelInfo.Open = true
				
				self:SetChannelStatus(pChannelInfo, "CONNECTED")
				self:SetChannelStatus(pChannelInfo, "READY_TO_SEND")
			end
		else
			local vChannelID = GetChannelName(pChannelInfo.Name)
			
			-- If the channel isn't already present attempt to join it
			
			if not vChannelID
			or vChannelID == 0 then
				if not JoinTemporaryChannel(pChannelInfo.Name, pChannelInfo.Password) then
					pChannelInfo.ID = nil
					pChannelInfo.Open = false
					self:SetChannelStatus(pChannelInfo, "ERROR", "Joining channel failed")
					return false
				end
				
				vChannelID = GetChannelName(pChannelInfo.Name)
				
				if not vChannelID then
					pChannelInfo.ID = nil
					pChannelInfo.Open = false
					self:SetChannelStatus(pChannelInfo, "ERROR", "Joining channel failed")
					return false
				end
				
				self:SetChannelStatus(pChannelInfo, "CONNECTING")
			
			-- Otherwise note the ID and set it as connected
			
			elseif not pChannelInfo.ID then
				-- self:TestMessage("JoinChannel: Joining existing channel "..pChannelInfo.Name)
				
				pChannelInfo.ID = vChannelID
				pChannelInfo.Open = true
				
				self:SetChannelStatus(pChannelInfo, "CONNECTED")
				self:SetChannelStatus(pChannelInfo, "READY_TO_SEND")
				
				ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, pChannelInfo.Name)
			end
		end
	end
	
	function MCDataChannelLib:LeaveChannel(pChannelInfo)
		if not pChannelInfo.ID then
			return
		end
		
		if not pChannelInfo.Permanent then
			LeaveChannelByName(pChannelInfo.Name)
		end
		
		pChannelInfo.ID = nil
		pChannelInfo.Open = false
		
		self:SetChannelStatus(pChannelInfo, "DISCONNECTED")
	end
	
	function MCDataChannelLib:RegisterEvents()
		-- For suspending/resuming the chat channels during logout
		
		-- MCEventLib:RegisterEvent("PLAYER_CAMPING", MCDataChannelLib.SuspendChannels, MCDataChannelLib)
		-- MCEventLib:RegisterEvent("PLAYER_QUITING", MCDataChannelLib.SuspendChannels, MCDataChannelLib)
		-- MCEventLib:RegisterEvent("LOGOUT_CANCEL", MCDataChannelLib.ResumeChannels, MCDataChannelLib)

		MCEventLib:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE", MCDataChannelLib.ChatMsgChannelNotice, MCDataChannelLib)

		MCEventLib:RegisterEvent("CHAT_MSG_ADDON", MCDataChannelLib.ChatMsgAddon, MCDataChannelLib)
		MCEventLib:RegisterEvent("CHAT_MSG_CHANNEL", MCDataChannelLib.ChatMsgChannel, MCDataChannelLib)
		MCEventLib:RegisterEvent("CHAT_MSG_SYSTEM", MCDataChannelLib.ChatMsgSystem, MCDataChannelLib)
	end
	
	function MCDataChannelLib:UnregisterEvents()
		-- MCEventLib:UnregisterEvent("PLAYER_CAMPING", MCDataChannelLib.SuspendChannels, MCDataChannelLib)
		-- MCEventLib:UnregisterEvent("PLAYER_QUITING", MCDataChannelLib.SuspendChannels, MCDataChannelLib)
		-- MCEventLib:UnregisterEvent("LOGOUT_CANCEL", MCDataChannelLib.ResumeChannels, MCDataChannelLib)

		MCEventLib:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE", MCDataChannelLib.ChatMsgChannelNotice, MCDataChannelLib)

		MCEventLib:UnregisterEvent("CHAT_MSG_ADDON", MCDataChannelLib.ChatMsgAddon, MCDataChannelLib)
		MCEventLib:UnregisterEvent("CHAT_MSG_CHANNEL", MCDataChannelLib.ChatMsgChannel, MCDataChannelLib)
		MCEventLib:UnregisterEvent("CHAT_MSG_SYSTEM", MCDataChannelLib.ChatMsgSystem, MCDataChannelLib)
	end
	
	function MCDataChannelLib:SuspendChannels()
		MCDebugLib:DebugMessage("MCDataChannelLib:SuspendChannels")
		
		for _, vChannelInfo in pairs(self.ChannelInfo) do
			if not vChannelInfo.Suspended
			and vChannelInfo.Open then
				vChannelInfo.Suspended = true
				self:LeaveChannel(vChannelInfo)
			end
		end -- for
	end
	
	function MCDataChannelLib:ResumeChannels()
		MCDebugLib:DebugMessage("MCDataChannelLib:ResumeChannels")
		
		for _, vChannelInfo in pairs(self.ChannelInfo) do
			if vChannelInfo.Suspended then
				vChannelInfo.Suspended = false
				self:JoinChannel(vChannelInfo)
			end
		end -- for
	end
	
	function MCDataChannelLib:SetChannelStatus(pChannelInfo, pStatus, pMessage)
		pChannelInfo.Status = pStatus
		pChannelInfo.StatusMessage = pMessage
		
		local vConnected = pChannelInfo.ID ~= nil
		
		for vClientPrefix, vChannelClient in pairs(pChannelInfo.Clients) do
			if vClientPrefix ~= vChannelClient.AltPrefix then
				vChannelClient.Connected = vConnected
				vChannelClient.Status = pStatus
				vChannelClient.StatusMessage = pMessage
				vChannelClient:SendMessageToClient("#STATUS", pStatus, pMessage)
			end
		end

		for _, vChannelClient in pairs(pChannelInfo.WildcardClients) do
			vChannelClient.Connected = vConnected
			vChannelClient.Status = pStatus
			vChannelClient.StatusMessage = pMessage
			vChannelClient:SendMessageToClient("#STATUS", pStatus, pMessage)
		end
	end
	
	function MCDataChannelLib:SendMessageToClient(pSender, pMessageID, pMessage, pPrefix)
		-- If the message is an echo of our previous transmission, then remove
		-- the message from the top of the queue and send the next one
		
		if pSender == MCDataChannelLib.PlayerName
		and pMessageID == "DATA"
		and self.SentMessageQueue[1] == pMessage then
			table.remove(self.SentMessageQueue, 1)
			table.remove(self.UseAltPrefixQueue, 1)
			
			MCSchedulerLib:UnscheduleTask(self.ResendLastMessage, self)
			
			if #self.SentMessageQueue > 0 then
				MCDataChannelLib:SendChannelMessage(self, self.SentMessageQueue[1], self.UseAltPrefixQueue[1])				
				MCSchedulerLib:ScheduleTask(MCDataChannelLib.RetransmitInterval, self.ResendLastMessage, self, "MCDataChannelLib.ResendLastMessage")
			else
				self:SendMessageToClient("#STATUS", "READY_TO_SEND")
			end
		end
		
		-- Pass the message on to the client
		
		if self.ClientRef then
			self.MessageFunction(self.ClientRef, pSender, pMessageID, pMessage, pPrefix)
		else
			self.MessageFunction(pSender, pMessageID, pMessage, pPrefix)
		end
	end
	
	function MCDataChannelLib:ReadyToSend()
		return #self.SentMessageQueue == 0
	end
	
	MCDataChannelLib.cEscapedChatCharRegExp = "([`sS|])"

	MCDataChannelLib.cUnescapeChatCharMap =
	{
		a = "`",
		l = "s",
		u = "S",
		b = "|",
	}

	MCDataChannelLib.cEscapeChatCharMap = {}
	
	for vEscapeCode, vChar in pairs(MCDataChannelLib.cUnescapeChatCharMap) do
		MCDataChannelLib.cEscapeChatCharMap[vChar] = "`"..vEscapeCode
	end
	
	function MCDataChannelLib.EscapeChatString(pString)
		return string.gsub(pString, MCDataChannelLib.cEscapedChatCharRegExp, MCDataChannelLib.cEscapeChatCharMap)
	end

	function MCDataChannelLib.UnescapeChatString(pString)
		return string.gsub(pString, "`(.)", MCDataChannelLib.cUnescapeChatCharMap)
	end
	
	-- These functions are similar to the chat string functions above except that they're for
	-- implementing a GroupCalendar-style syntax for message packets
	
	MCDataChannelLib.cEscapedCharRegExp = "([~,/:;&|\n])"

	MCDataChannelLib.cUnescapeCharMap =
	{
		t = "~",
		c = ",",
		s = "/",
		n = ":",
		m = ";",
		a = "&",
		b = "|",
		n = "\n",
	}

	MCDataChannelLib.cEscapeCharMap = {} -- Generate the reverse map

	for vEscapeCode, vChar in pairs(MCDataChannelLib.cUnescapeCharMap) do
		MCDataChannelLib.cEscapeCharMap[vChar] = "~"..vEscapeCode
	end

	function MCDataChannelLib.EscapeString(pString)
		return string.gsub(pString, MCDataChannelLib.cEscapedCharRegExp, MCDataChannelLib.cEscapeCharMap)
	end

	function MCDataChannelLib.UnescapeString(pString)
		return string.gsub(pString, "~(.)", MCDataChannelLib.cUnescapeCharMap)
	end
	
	function MCDataChannelLib:SendChannelMessage(pChannelClient, pMessage, pUseAltPrefix)
		local vChannelInfo = self.ChannelInfo[pChannelClient.UpperName]
		
		if not vChannelInfo
		or not vChannelInfo.ID then
			return
		end
		
		local vPrefix = tern(pUseAltPrefix, pChannelClient.AltPrefix or pChannelClient.Prefix, pChannelClient.Prefix)
		
		if vChannelInfo.Permanent then
			if vChannelInfo.ID == "GUILD" and not IsInGuild() then
				self:LeaveChannel(vChannelInfo)
				self:SetChannelStatus(vChannelInfo, "ERROR", "Not in a guild")
				return
			end
			
			local vTotalMessageLength = vPrefix:len() + 1 + pMessage:len()
			
			if vTotalMessageLength > 254 then
				self:ErrorMessage("Error: Attempted to send addon data of %d bytes", vTotalMessageLength)
				self:ErrorMessage("Data: %s: %s", vPrefix, pMessage)
				self:CloseChannel()
				return
			end
			
			-- self:TestMessage("To ["..vChannelInfo.Name.."/"..pChannelClient.Prefix.."]:"..pMessage)
			SendAddonMessage(vPrefix, pMessage, vChannelInfo.ID)
			return
		end
		
		--
		
		local vMessage
		
		if vPrefix then
			vMessage = vPrefix..":"..pMessage
		else
			vMessage = pMessage
		end
		
		local vEscapedMessage = self.EscapeChatString(vMessage)
		
		if string.len(vEscapedMessage) > 254 then
			self:ErrorMessage("Error: Attempted to send chat data of "..string.len(vEscapedMessage).." bytes")
			self:ErrorMessage("Data: "..vEscapedMessage)
			self:CloseChannel()
			return
		end
		
		-- Send the message
		
		local vSavedAutoClearAFK = GetCVar("autoClearAFK")
		SetCVar("autoClearAFK", 0)
		
		SendChatMessage(vEscapedMessage, "CHANNEL", nil, vChannelInfo.ID)
		
		SetCVar("autoClearAFK", vSavedAutoClearAFK)
	end
	
	function MCDataChannelLib:LibraryReady()
		if self.ChatChannelsReady then
			return
		end
		
		self.ChatChannelsReady = true
		
		-- Open any waiting channels
		
		for _, vChannelInfo in pairs(self.ChannelInfo) do
			if not vChannelInfo.Permanent then
				self:JoinChannel(vChannelInfo)
			end
		end
	end
	
	function MCDataChannelLib:ChatMsgChannel(pEventID, pMessage, pSender, pLanguage, pChannelNameAndNum, pTargetName, pFlags, pZoneID, pChannelNumber, pChannelName)
		-- See if it's a channel we're interested in
		
		if not pChannelName then
			return
		end
		
		local vUpperChannelName = strupper(pChannelName)
		local vChannelInfo = self.ChannelInfo[vUpperChannelName]
		
		if not vChannelInfo then
			return
		end
		
		-- Decode the message
		
		local vMessage
		
		if strsub(pMessage, -8) == " ...hic!" then
			vMessage = self.UnescapeChatString(strsub(pMessage, 1, -9))
		else
			vMessage = self.UnescapeChatString(pMessage)
		end
		
		--
		
		local vStartIndex, vEndIndex, vPrefix, vMessageData = string.find(vMessage, "(%w+):(.*)")
		
		if not vStartIndex then
			for _, vChannelClient in pairs(vChannelInfo.WildcardClients) do
				vChannelClient:SendMessageToClient(pSender, "DATA", vMessage, vPrefix)
			end
			
			return
		end
		
		local vChannelClient = vChannelInfo.Clients[vPrefix]
		
		if vChannelClient then
			-- self:TestMessage("["..pChannelName.."/"..vPrefix.."]["..pSender.."]: "..vMessageData)
			
			vChannelClient:SendMessageToClient(pSender, "DATA", vMessageData, vPrefix)
		end
	end
	
	function MCDataChannelLib:ChatMsgAddon(pEventID, pPrefix, pMessage, pChannelName, pSender)
		local vChannelInfo = self.ChannelInfo["#"..pChannelName]
		
		if vChannelInfo then
			local vChannelClient = vChannelInfo.Clients[pPrefix]
			
			if not vChannelClient then
				return
			end
			
			-- MCDebugLib:AddDebugMessage(NORMAL_FONT_COLOR_CODE.."["..pChannelName.."/"..pPrefix.."]"..GREEN_FONT_COLOR_CODE.."["..pSender.."]: "..HIGHLIGHT_FONT_COLOR_CODE..pMessage..FONT_COLOR_CODE_CLOSE)
			
			vChannelClient:SendMessageToClient(pSender, "DATA", pMessage, pPrefix)
		end
		
		if pChannelName == "PARTY" then
			vChannelInfo = self.ChannelInfo["#RAID"]
			
			if vChannelInfo then
				local vChannelClient = vChannelInfo.Clients[pPrefix]
				
				if not vChannelClient then
					return
				end
				
				-- MCDebugLib:AddDebugMessage(NORMAL_FONT_COLOR_CODE.."["..pChannelName.."/"..pPrefix.."]"..GREEN_FONT_COLOR_CODE.."["..pSender.."]: "..HIGHLIGHT_FONT_COLOR_CODE..pMessage..FONT_COLOR_CODE_CLOSE)
				
				vChannelClient:SendMessageToClient(pSender, "DATA", pMessage, pPrefix)
			end
		end
	end
	
	function MCDataChannelLib:ChatMsgSystem(pEventID, pMessage)
		if pMessage == ERR_TOO_MANY_CHAT_CHANNELS then
			for _, vChannelInfo in pairs(self.ChannelInfo) do
				if vChannelInfo.Status == "CONNECTING"
				or vChannelInfo.Status == "ERROR" then
					vChannelInfo.GotTooManyChannelsMessage = true
					
					if vChannelInfo.Status == "ERROR" then
						self:SetChannelStatus(vChannelInfo, "ERROR", "Can't join more channels")
					end
				end
			end -- for
		end -- if
	end
	
	function MCDataChannelLib:ChatMsgChannelNotice(pEventID, pNoticeID, pArg2, pArg3, pChannelNameWithNum, pArg5, pArg6, pChannelType, pChannelNumber, pChannelName)
		-- self:DebugMessage("ChatMsgChannelNotice: %s %s %s", tostring(pEventID), tostring(pNoticeID), tostring(pChannelName))
		
		if not pChannelName then
			return
		end
		
		-- Just leave if it's not a channel we're interested in
		
		local vUpperChannelName = strupper(pChannelName)
		local vChannelInfo = self.ChannelInfo[vUpperChannelName]
		
		--
		
		if pNoticeID == "YOU_JOINED" then
			-- Once channels start showing up shorten the initialization delay
			
			if not self.ChatChannelsReady then
				MCSchedulerLib:SetTaskDelay(1, self.LibraryReady, self)
			end
			
			if not vChannelInfo then
				return
			end
			
			local vChannelID = GetChannelName(vChannelInfo.Name)
			
			if not vChannelID
			or vChannelID == 0 then
				vChannelInfo.ID = nil
				vChannelInfo.Open = false
				self:SetChannelStatus(vChannelInfo, "ERROR", "Internal Error (Channel ID not found)")
			
			elseif not vChannelInfo.ID then
				vChannelInfo.ID = vChannelID
				vChannelInfo.Open = true
				
				self:SetChannelStatus(vChannelInfo, "CONNECTED")
				self:SetChannelStatus(vChannelInfo, "READY_TO_SEND")
				
				ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, vChannelInfo.Name)
			
			else
				vChannelInfo.ID = vChannelID -- Update it in case it changed for some reason
			end
			
		elseif pNoticeID == "YOU_LEFT" then
			if not vChannelInfo then
				return
			end
			
			if vChannelInfo.ID then
				vChannelInfo.ID = nil
				vChannelInfo.Open = false
				self:SetChannelStatus(vChannelInfo, "DISCONNECTED")
			end
		
		elseif pNoticeID == "WRONG_PASSWORD" then
			if not vChannelInfo then
				return
			end
			
			vChannelInfo.ID = nil
			vChannelInfo.Open = false
			self:SetChannelStatus(vChannelInfo, "ERROR", "Wrong password")
		end
	end
	
	-- Channel methods
	
	function MCDataChannelLib:Delete()
		if self.Open then
			self:CloseChannel()
		end
	end

	function MCDataChannelLib:OpenChannel(pChannelName, pPassword)
		if self.Open then
			self:CloseChannel()
		end
		
		if MCDataChannelLib:OpenChannelClient(self, pChannelName, pPassword) then
			self.Name = pChannelName
			self.UpperName = strupper(pChannelName)
			self.Open = true
		end
	end

	function MCDataChannelLib:CloseChannel()
		if not self.Open then
			return
		end
		
		MCDataChannelLib:CloseChannelClient(self)
		self.Open = false
	end

	function MCDataChannelLib:SendMessageToChannel(pMessage, pUseAltPrefix)
		if self.DisableSend then
			return
		end
		
		table.insert(self.SentMessageQueue, pMessage)
		table.insert(self.UseAltPrefixQueue, pUseAltPrefix or false)
		
		if #self.SentMessageQueue > 1 then
			return
		end
		
		MCDataChannelLib:SendChannelMessage(self, pMessage, pUseAltPrefix)
		MCSchedulerLib:ScheduleTask(MCDataChannelLib.RetransmitInterval, self.ResendLastMessage, self, "MCDataChannelLib.ResendLastMessage")
	end
	
	function MCDataChannelLib:ResendLastMessage()
		MCDataChannelLib:SendChannelMessage(self, self.SentMessageQueue[1], self.UseAltPrefixQueue[1])
		MCSchedulerLib:ScheduleTask(MCDataChannelLib.RetransmitInterval, self.ResendLastMessage, self, "MCDataChannelLib.ResendLastMessage")
	end
	
	function MCDataChannelLib:SendFailed()
	end
	
	-- Utilities
	
	function MCDataChannelLib.ParseCommandString(pCommandString)
		-- Break the command into parts
		
		local vCommand = {}
		
		for vOpcode, vOperands in string.gmatch(pCommandString, "(%w+):?([^/]*)") do
			local vOperation = {}
			
			vOperation.opcode = vOpcode
			vOperation.operandString = vOperands
			vOperation.operands = MCDataChannelLib.ParseParameterString(vOperands)
			
			table.insert(vCommand, vOperation)
		end
		
		return vCommand
	end

	function MCDataChannelLib.ParseParameterString(pParameterString)
		local vParameters = {}
		local vIndex = 0
		local vFound = true
		local vStartIndex = 1
		
		while vFound do
			local vEndIndex
			
			vFound, vEndIndex, vParameter = string.find(pParameterString, "([^,]*),", vStartIndex)
			
			vIndex = vIndex + 1
			
			if not vFound then
				vParameters[vIndex] = string.sub(pParameterString, vStartIndex)
				break
			end
			
			vParameters[vIndex] = vParameter
			vStartIndex = vEndIndex + 1
		end
		
		return vParameters
	end
	
	--[[ New mechanism of message verification is self-throttling
	
	function MCDataChannelLib.SendAddonMessage(pPrefix, pMessage, pChannel)
		if not pMessage or type(pMessage) ~= "string" then
			return
		end
		
		local vNumBytes = string.len(pMessage)
		local vTime = GetTime()
		
		MCDataChannelLib.NextSendTime = MCDataChannelLib.NextSendTime + vNumBytes / MCDataChannelLib.MaxSendBytesPerSecond
		
		if MCDataChannelLib.NextSendTime < vTime then
			MCDataChannelLib.NextSendTime = vTime
		elseif MCDataChannelLib.NextSendTime > vTime + 0.75 then
			MCDataChannelLib.NextSendTime = vTime + 0.75
		end
	end
	
	if not MCDataChannelLib.DidHookSendAddonMessage then
		MCDataChannelLib.DidHookSendAddonMessage = true
		hooksecurefunc("SendAddonMessage", MCDataChannelLib.SendAddonMessage)
	end
	
	function MCDataChannelLib.SendChatMessage(pMessage, pType, pLanguage, pChannel)
		if not pMessage or type(pMessage) ~= "string" then
			return
		end
		
		local vNumBytes = string.len(pMessage)
		local vTime = GetTime()
		
		MCDataChannelLib.NextSendTime = MCDataChannelLib.NextSendTime + vNumBytes / MCDataChannelLib.MaxSendBytesPerSecond
		
		if MCDataChannelLib.NextSendTime < vTime then
			MCDataChannelLib.NextSendTime = vTime
		elseif MCDataChannelLib.NextSendTime > vTime + 0.75 then
			MCDataChannelLib.NextSendTime = vTime + 0.75
		end
	end
	
	if not MCDataChannelLib.DidHookSendChatMessage then
		MCDataChannelLib.DidHookSendChatMessage = true
		hooksecurefunc("SendChatMessage", MCDataChannelLib.SendChatMessage)
	end
	]]--
	
	--
	
	MCDataChannelLib.Version = gMCDataChannelLib_Version
	MCDataChannelLib:RegisterEvents()
	
	if not MCDataChannelLib.ChatChannelsReady then
		local vID1, vName1 = GetChannelList()
		
		-- If there are already channels then just signal that we're ready
		
		if vID1 then
			MCDataChannelLib:LibraryReady()
		
		-- Otherwise schedule a task to signal later after the world channels
		-- are joined
		
		else
			MCSchedulerLib:ScheduleTask(60, MCDataChannelLib.LibraryReady, MCDataChannelLib, "MCDataChannelLib.LibraryReady")
		end
	end
end
