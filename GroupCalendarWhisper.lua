StaticPopupDialogs.CONFIRM_CALENDAR_CLEAR_WHISPERS =
{
	text = TEXT(GroupCalendar_cConfirmClearWhispers),
	button1 = TEXT(GroupCalendar_cClear),
	button2 = TEXT(CANCEL),
	OnAccept = function() GroupCalendar.WhisperLog:Clear() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

----------------------------------------
-- _Whisper
----------------------------------------

GroupCalendar._Whisper = {}
GroupCalendar._Whisper.Commands = {}

GroupCalendar._Whisper.CommandPrefix = "!gc"
GroupCalendar._Whisper.ResponsePrefix = "<GC>"

GroupCalendar._Whisper.CommandPrefix2 = GroupCalendar._Whisper.CommandPrefix.." "

GroupCalendar._Whisper.CommandPrefixLen = string.len(GroupCalendar._Whisper.CommandPrefix)
GroupCalendar._Whisper.CommandPrefix2Len = GroupCalendar._Whisper.CommandPrefixLen + 1
GroupCalendar._Whisper.ResponsePrefixLen = string.len(GroupCalendar._Whisper.ResponsePrefix)

function GroupCalendar._Whisper:Construct()
	MCEventLib:RegisterEvent("PLAYER_ENTERING_WORLD", self.PlayerEnteringWorld, self)
	self.ResponseQueue = {}
end

function GroupCalendar._Whisper:ChatFrame_MessageEventHandler(pFrame, pEvent, ...)
	if pEvent == "CHAT_MSG_WHISPER" then
		local vMessage = strlower(select(1, ...) or "")
		
		if vMessage == GroupCalendar._Whisper.CommandPrefix
		or string.sub(vMessage, 1, GroupCalendar._Whisper.CommandPrefix2Len) == GroupCalendar._Whisper.CommandPrefix2 then
			return
		end
	elseif pEvent == "CHAT_MSG_WHISPER_INFORM" then
		local vMessage = select(1, ...) or ""
		
		if string.sub(vMessage, 1, GroupCalendar._Whisper.ResponsePrefixLen) == GroupCalendar._Whisper.ResponsePrefix then
			return
		end
	end
	
	return self.Orig_ChatFrame_MessageEventHandler(pFrame, pEvent, ...)
end

function GroupCalendar._Whisper:ChatMessageWhisper(pEvent, ...)
	local vMessage = strlower(select(1, ...))
	local vSender = select(2, ...)
	
	-- Ignore it if it isn't a gc request
	
	if vMessage ~= GroupCalendar._Whisper.CommandPrefix
	and strsub(vMessage, 1, GroupCalendar._Whisper.CommandPrefix2Len) ~= GroupCalendar._Whisper.CommandPrefix2 then
		return
	end
	
	-- Ignore them if they're not supposed to be whispering us for calendars
	
	if not GroupCalendar.Network:UserIsTrusted(vSender, "RAT") then
		self:WhisperResponse(vSender, "You are not permitted to query this calendar")
		return
	end
	
	-- Ignore them if we're synch'ing
	
	local vChannelStatus, vStatusMessage, vStartTime = GroupCalendar.Network:GetStatus()
	
	if vChannelStatus == "Synching" or vChannelStatus == "Starting" then
		self:WhisperResponse(vSender, GroupCalendar.cAttendanceSynching)
		return
	end
	
	-- Figure out what they want
	
	vMessage = string.sub(vMessage, 5)
	
	local vStartIndex, vEndIndex, vCommand, vParameter = string.find(vMessage, "([^%s]+) ?(.*)")
	
	if not vCommand then
		vCommand = "SUMMARY"
	end
	
	vCommand = string.upper(vCommand)
	
	if self.Commands[vCommand] then
		self.Commands[vCommand](self, vSender, vParameter)
	else
		self:WhisperResponse(vSender, string.format(GroupCalendar.cWhisperSummaryInvalidOption, vCommand))
	end
end

function GroupCalendar._Whisper:GetEventSummary(pNumDays)
	local vCurrentDate, vCurrentTime = MCDateLib:GetServerDateTime()
	local vNumDays = pNumDays or 7
	
	-- Update the cached summary if necessary
	
	if vCurrentDate ~= self.CurrentDate then
		GroupCalendar.DeleteTable(self.EventSummary)
		
		self.EventSummary = GroupCalendar.Database.GetCompiledSchedule(vCurrentDate - 1, false, true)
		
		for vDateOffset = 0, vNumDays do
			self.EventSummary = GroupCalendar.Database.GetCompiledSchedule(vCurrentDate + vDateOffset, false, true, self.EventSummary)
		end
		
		self.CurrentDate = vCurrentDate
	end
	
	-- Return the summary
	
	return self.EventSummary
end

function GroupCalendar._Whisper:PlayerEnteringWorld()
	MCEventLib:UnregisterEvent("PLAYER_ENTERING_WORLD", self.PlayerEnteringWorld, self)
	self:HookChatFrame()
end

function GroupCalendar._Whisper:HookChatFrame()
	if self.Orig_ChatFrame_MessageEventHandler then
		return
	end
	
	self.Orig_ChatFrame_MessageEventHandler = ChatFrame_MessageEventHandler
	ChatFrame_MessageEventHandler = function (pFrame, pEvent, ...) return GroupCalendar.Whisper:ChatFrame_MessageEventHandler(pFrame, pEvent, ...) end
	
	MCEventLib:RegisterEvent("CHAT_MSG_WHISPER", self.ChatMessageWhisper, self)
end

function GroupCalendar._Whisper:WhisperResponse(pPlayerName, pMessage, ...)
	if select("#", ...) > 0 then
		pMessage = string.format(pMessage, ...)
	end
	
	if pPlayerName == nil then
		GroupCalendar:NoteMessage(pMessage)
	else
		table.insert(self.ResponseQueue, {Name = pPlayerName, Message = pMessage})
		
		if #self.ResponseQueue == 1 then
			MCSchedulerLib:ScheduleUniqueRepeatingTask(0.1, self.SendNextResponse, self)
		end
	end
end

function GroupCalendar._Whisper:SendNextResponse()
	if #self.ResponseQueue > 0 then
		local vResponse = table.remove(self.ResponseQueue, 1)
		
		if vResponse.Name == "_GUILD" then
			SendChatMessage(GroupCalendar._Whisper.ResponsePrefix.." "..vResponse.Message, "GUILD")
		else
			SendChatMessage(GroupCalendar._Whisper.ResponsePrefix.." "..vResponse.Message, "WHISPER", nil, vResponse.Name)
		end
	end

	if #self.ResponseQueue == 0 then
		MCSchedulerLib:UnscheduleTask(self.SendNextResponse, self)
	end
end

function GroupCalendar._Whisper:FindEventByIDString(pPlayerName, pEventIDString)
	local vStartIndex, vEndIndex, vOwnerName, vEventID = string.find(pEventIDString, "([^\-]*)\-?(%d*)")
	
	if not vOwnerName then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperWTFError, pEventIDString or "nil")
		return
	end
	
	if not vEventID or vEventID == "" then
		vEventID = tonumber(vOwnerName)
		vOwnerName = GroupCalendar.PlayerName
	else
		vEventID = tonumber(vEventID)
	end
	
	if not vEventID then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperWTFError, pEventIDString or "nil")
		return
	end
	
	local vDatabase = GroupCalendar.Database.GetDatabase(vOwnerName, false, GroupCalendar.RealmName, true)
	
	if not vDatabase then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperDatabaseNotFound, vOwnerName or "unknown")
		return
	end
	
	if not GroupCalendar.Database.DatabaseIsVisible(vDatabase) then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperAccessDenied, vDatabase.UserName)
		return
	end
	
	if not vDatabase.IsPlayerOwned then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperCantProxy, vDatabase.UserName)
		return
	end
	
	--
	
	local vEvent, vDate = GroupCalendar.Database.FindEventByID(vDatabase, vEventID)

	if not vEvent then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperEventNotFound, vEventID or "nil", vOwnerName or "nil")
	end
	
	return vDatabase, vDate, vEvent
end

function GroupCalendar._Whisper:PlayerIsQualifiedForEvent(pPlayerName, pDatabase, pEvent, pServerDate, pServerTime)
	if pEvent.mPrivate then
		return false
	end
	
	--
	
	if not GroupCalendar.Database.DatabaseIsVisible(pDatabase) then
		return false
	end
	
	-- Nobody qualifies for expired events
	
	if pEvent.mDate < pServerDate
	or (pEvent.mDate == pServerDate and pEvent.mTime and (pEvent.mTime + pEvent.mDuration) < pServerTime) then
		return false
	end
	
	--
	
	local vMemberInfo
	
	if pPlayerName ~= "_GUILD" then
		vMemberInfo = GroupCalendar.Network:GetGuildMemberInfo(pPlayerName or GroupCalendar.PlayerName)
	end
	
	local vQualified, vMessage = GroupCalendar.Database.PlayerInfoIsQualifiedForEvent(vMemberInfo, pEvent)
	
	if not vQualified then
		return false, vMessage
	end

	if not GroupCalendar.Database.EventIsVisibleToPlayerInfo(pEvent, vMemberInfo) then
		return false
	end
	
	return true
end

function GroupCalendar._Whisper:HandleAttendanceRequest(pEventIDString, pPlayerName, pStatus, pComment)
	-- Find the event they're interested in
	
	local vDatabase, vDate, vEvent = self:FindEventByIDString(pPlayerName, pEventIDString)
	
	if not vEvent then
		return -- Return silently since FindEventByIDString handles it's own error reporting
	end
	
	-- Get the player info (Currently limited to guild members, but this could be
	-- expanded to check other known databases for the needed info and in the future
	-- it may get the needed information from chat message params)
	
	local vMemberInfo = GroupCalendar.Network:GetGuildMemberInfo(pPlayerName)
	
	if pPlayerName ~= GroupCalendar.PlayerName and not vMemberInfo then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperNotGuildmate)
		return
	end
	
	-- Make sure they're qualified
	
	local vServerDate, vServerTime = MCDateLib:GetServerDateTime()
	local vQualified, vMessage = self:PlayerIsQualifiedForEvent(pPlayerName, vDatabase, vEvent, vServerDate, vServerTime)
	
	if not vQualified then
		self:WhisperResponse(pPlayerName, vMessage or GroupCalendar.cAttendanceUnknownQualifiedError)
		return
	end
	
	-- Create and process the attendance request
	
	local vRSVP = GroupCalendar.Database.CreatePlayerRSVP(
						vDatabase,
						vEvent,
						pPlayerName,
						GroupCalendar.Database.GetRaceCodeByRace(vMemberInfo.Race),
						GroupCalendar.Database.GetClassCodeByClass(vMemberInfo.Class),
						vMemberInfo.Level,
						GroupCalendar.GetMemberDefaultRole(pPlayerName),
						pStatus,
						pComment,
						GroupCalendar.PlayerGuild,
						vMemberInfo.RankIndex,
						nil) -- Alts
	
	GroupCalendar.Database.AddRSVP(vDatabase, vRSVP)
	
	-- Find out what happened with the request
	
	local vEventRSVP = GroupCalendar.Database.FindEventRSVP(vDatabase.UserName, vEvent, pPlayerName)
	
	if not vEventRSVP then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperFailed)
		return
	end
	
	-- Report the result back to the user
	
	local vEventName = GroupCalendar.Database.GetEventDisplayName(vEvent)
	local vDateString = GroupCalendar.GetLongDateString(vDate, true)
	local vStatusString = GroupCalendar.cStatusCodeStrings[vEventRSVP.mStatus] or "unknown"
	
	if vEvent.mTime then
		local vTimeString = GroupCalendar.GetShortTimeString(vEvent.mTime)
		
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperEventStatus, vEventName, vDateString, vTimeString, vStatusString)
	else
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperAllDayStatus, vEventName, vDateString, vStatusString)
	end
end

----------------------------------------
-- Commands
----------------------------------------

function GroupCalendar._Whisper.Commands:HELP(pPlayerName)
	for _, vHelpString in ipairs(GroupCalendar.cWhisperHelp) do
		self:WhisperResponse(pPlayerName, vHelpString)
	end
end

function GroupCalendar._Whisper.Commands:SUMMARY(pPlayerName)
	-- Get the player info (Currently limited to guild members, but this could be
	-- expanded to check other known databases for the needed info and in the future
	-- it may get the needed information from chat message params)
	
	local vMemberInfo
	
	if pPlayerName and pPlayerName ~= "_GUILD" then
		vMemberInfo = GroupCalendar.Network:GetGuildMemberInfo(pPlayerName or GroupCalendar.PlayerName)
		
		if not vMemberInfo then
			self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperNotGuildmate)
			return
		end
	end
	
	--
	
	local vEventSummary = self:GetEventSummary(7)
	local vDate
	local vNumEventsDisplayed = 0
	local vServerDate, vServerTime = MCDateLib:GetServerDateTime()
	
	if #vEventSummary > 0 then
		for vIndex, vEventInfo in ipairs(vEventSummary) do
			local vDatabase = GroupCalendar.Database.GetDatabase(vEventInfo.mOwner, false, vEventInfo.mRealm)
			
			-- Make sure they're qualified
			
			if vDatabase and self:PlayerIsQualifiedForEvent(pPlayerName, vDatabase, vEventInfo.mEvent, vServerDate, vServerTime) then
				-- Output a new date header if it's changing
				
				if vEventInfo.mEvent.mDate ~= vDate then
					local vDateString = GroupCalendar.GetLongDateString(vEventInfo.mEvent.mDate, true)
					
					vDate = vEventInfo.mEvent.mDate
					
					self:WhisperResponse(pPlayerName, format(GroupCalendar.cWhisperSummaryDateHeader, vDateString))
				end
				
				--
				
				local vTime = GroupCalendar.GetShortTimeString(vEventInfo.mEvent.mTime)
				local vName = GroupCalendar.Database.GetEventDisplayName(vEventInfo.mEvent)
				local vEventRSVP = GroupCalendar.Database.FindEventRSVP(vEventInfo.mOwner, vEventInfo.mEvent, pPlayerName)
				local vStatusString
				local vFormat
				local vEventID
				
				if vEventRSVP then
					vStatusString = GroupCalendar.cStatusCodeStrings[vEventRSVP.mStatus] or "unknown"
				end
				
				vEventID = vDatabase.UserName.."-"..vEventInfo.mEvent.mID
				
				if vStatusString then
					vFormat = GroupCalendar.cWhisperSummaryEventStatus
				else
					vFormat = GroupCalendar.cWhisperSummaryEvent
				end
				
				--
				
				self:WhisperResponse(pPlayerName, GroupCalendar.FormatNamed(vFormat, {time = vTime, event = vName, status = vStatusString, id = vEventID}))
				
				vNumEventsDisplayed = vNumEventsDisplayed + 1
			end
		end
	end
	
	if vNumEventsDisplayed == 0 then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperSummaryNoEvents)
	end
	
	if pPlayerName then
		self:WhisperResponse(pPlayerName, GroupCalendar.cWhisperHelpReminder)
	end
end

function GroupCalendar._Whisper.Commands:YES(pPlayerName, pEventIDString)
	self:HandleAttendanceRequest(pEventIDString, pPlayerName, "Y")
end

function GroupCalendar._Whisper.Commands:NO(pPlayerName, pEventIDString)
	self:HandleAttendanceRequest(pEventIDString, pPlayerName, "N")
end

function GroupCalendar._Whisper.Commands:MAYBE(pPlayerName, pEventIDString)
	self:HandleAttendanceRequest(pEventIDString, pPlayerName, "M")
end

----------------------------------------
--
----------------------------------------

GroupCalendar.Whisper = GroupCalendar.NewObject(GroupCalendar._Whisper)

----------------------------------------
-- WhisperLog
----------------------------------------

GroupCalendar.WhisperLog =
{
	mPlayers = {},
	mEvent = {}
}

function GroupCalendar.WhisperLog:AddWhisper(pPlayerName, pMessage)
	-- If no event is active then just ignore all whispers
	-- NOTE: Disabling this for now, it seems like it's better to have too
	-- many than too few whispers.  With this feature enabled, the organizer
	-- must remember to open the event before receiving whispers or else
	-- they'll be lost.  That can be a bit of a pain.
	
	--[[
	if not self.mEvent then
		return
	end
	]]
	
	-- Ignore whispers which appear to be data from other addons
	
	local vFirstChar = string.sub(pMessage, 1, 1)
	
	if vFirstChar == "<"
	or vFirstChar == "["
	or vFirstChar == "{"
	or vFirstChar == "!" then
		return
	end
	
	-- Filter if necessary
	
	if self.mWhisperFilterFunc
	and not self.mWhisperFilterFunc(self.mWhisperFilterParam, pPlayerName) then
		return
	end
	
	--
	
	local vPlayerLog = self.mPlayers[pPlayerName]
	
	if not vPlayerLog then
		vPlayerLog = {}
		
		vPlayerLog.mName = pPlayerName
		vPlayerLog.mDate, vPlayerLog.mTime = MCDateLib:GetServerDateTime60()
		vPlayerLog.mWhispers = {}
		
		self.mPlayers[pPlayerName] = vPlayerLog
	end
	
	local vLength = #vPlayerLog.mWhispers
	
	if vLength > 3 then
		table.remove(vPlayerLog.mWhispers, 1)
		vLength = vLength - 1
	end
	
	vPlayerLog.mWhispers[vLength + 1] = pMessage

	-- Notify
	
	if self.mNotificationFunc then
		self.mNotificationFunc(self.mNotifcationParam)
	end
end

function GroupCalendar.WhisperLog:AskClear()
	StaticPopup_Show("CONFIRM_CALENDAR_CLEAR_WHISPERS")
end

function GroupCalendar.WhisperLog:Clear()
	self.mPlayers = {}
	
	if self.mNotificationFunc then
		self.mNotificationFunc(self.mNotifcationParam)
	end
end

function GroupCalendar.WhisperLog:GetPlayerWhispers(pEvent)
	if self.mEvent ~= pEvent then
		self.mEvent = pEvent
		self:Clear()
	end
	
	return self.mPlayers
end

function GroupCalendar.WhisperLog:SetNotificationFunc(pFunc, pParam)
	self.mNotificationFunc = pFunc
	self.mNotifcationParam = pParam
end

function GroupCalendar.WhisperLog:SetWhisperFilterFunc(pFunc, pParam)
	self.mWhisperFilterFunc = pFunc
	self.mWhisperFilterParam = pParam
end

function GroupCalendar.WhisperLog:RemovePlayer(pPlayerName)
	self.mPlayers[pPlayerName] = nil

	-- Notify
	
	if self.mNotificationFunc then
		self.mNotificationFunc(self.mNotifcationParam)
	end
end

function GroupCalendar.WhisperLog:GetNextWhisper(pPlayerName)
	-- Make an indexed list of the whispers
	
	local vWhispers = {}
	
	for vName, vWhisper in pairs(self.mPlayers) do
		table.insert(vWhispers, vWhisper)
	end
	
	-- Sort by time
	
	table.sort(vWhispers, GroupCalendar.Database.CompareRSVPsByDate)
	
	--
	
	local vLowerName = strlower(pPlayerName)
	local vUseNext = false
	
	for vIndex, vWhisper in ipairs(vWhispers) do
		if vUseNext then
			return vWhisper
		end
		
		if vLowerName == strlower(vWhisper.mName) then
			vUseNext = true
		end
	end
	
	return nil
end
