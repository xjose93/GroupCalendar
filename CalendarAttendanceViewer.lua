----------------------------------------
-- AttendanceViewer
----------------------------------------

GroupCalendar.AttendanceViewer = {}

GroupCalendar.cNumPlainAttendanceItems = 16
GroupCalendar.cAttendanceItemHeight = 16
GroupCalendar.cNumAutoConfirmAttendanceRoleItems = 12
GroupCalendar.cNumAutoConfirmAttendanceStatusItems = 12
GroupCalendar.cNumAutoConfirmAttendanceClassItems = 10

function GroupCalendar.AttendanceViewer.Initialize(pAttendanceViewer, pAllowEdits)
	GroupCalendar.InitializeFrame(pAttendanceViewer, GroupCalendar._AttendanceViewer)
	
	pAttendanceViewer:Construct()
	
	if pAllowEdits then
		pAttendanceViewer:SetCanEdit(true)
	end
end

function GroupCalendar.AttendanceViewer.OnVerticalScroll(self)
	self:GetParent():OnVerticalScroll()
end

function GroupCalendar.AttendanceViewer.ShowMessageTooltip(pOwner, pName, pMessages, pColor)
	if not pName then
		return
	end
	
	GameTooltip:SetOwner(pOwner, "ANCHOR_LEFT")
	GameTooltip:AddLine(pName)
	
	local vColor = {r = 1, g = 1, b = 1}
	
	if pColor then
		vColor = pColor
	end
	
	if type(pMessages) == "table" then
		for vIndex, vText in ipairs(pMessages) do
			GameTooltip:AddLine(vText, vColor.r, vColor.g, vColor.b, 1)
		end
	else
		GameTooltip:AddLine(pMessages, vColor.r, vColor.g, vColor.b, 1)
	end
	
	GameTooltip:Show()
end

----------------------------------------
-- _AttendanceViewer
----------------------------------------

GroupCalendar._AttendanceViewer =
{
	Widgets =
	{
		"ExpandAll",
		"GroupTab",
		"ExpandAllButton",
		"ScrollFrame",
		"ScrollbarTrench",
		"ViewMenu",
		
		MainView =
		{
			AutoConfirm =
			{
				"Menu",
				"Options",
			},
			
			"AddButton",
			
			ClassTotals =
			{
				PRIEST = {"Label"},
				PALADIN = {"Label"},
				MAGE = {"Label"},
				WARLOCK = {"Label"},
				WARRIOR = {"Label"},
				DRUID = {"Label"},
				ROGUE = {"Label"},
				SHAMAN = {"Label"},
				HUNTER = {"Label"},
				DEATHKNIGHT = {"Label"},
			},
			
			RoleTotals =
			{
				MH = {"Label"},
--				OH = {"Label"},
				MT = {"Label"},
--				OT = {"Label"},
				RD = {"Label"},
				MD = {"Label"}
			},
			
			StatusTotals =
			{
				YES = {"Label"},
				NO = {"Label"},
				PENDING = {"Label"},
				MAYBE = {"Label"},
				BANNED = {"Label"},
				STANDBY = {"Label"},
			},
		},
		
		GroupView =
		{
		}
	}
}

function GroupCalendar._AttendanceViewer:Construct()
	self.NumItems = GroupCalendar.cNumAttendanceItems
	self.CollapsedCategories = {}
	self.ListSortMode = "Date"
	self.ListGroupMode = "Role"
	self.Panels =
	{
		{Tab = self.Widgets.ExpandAll, Panel = self.Widgets.MainView},
		{Tab = self.Widgets.GroupTab, Panel = self.Widgets.GroupView},
	}
	
	self.CurrentPanel = self.Widgets.MainView
	
	self:SetScript("OnShow", function (self, ...) self:OnShow(...) end)
	self:SetScript("OnHide", function (self, ...) self:OnShow(...) end)
	
	-- Set the text color for the class totals
	
	for vClassID, vClassInfo in pairs(GroupCalendar.ClassInfoByClassCode) do
		local vCount = self.Widgets.MainView.ClassTotals[vClassInfo.color]
		local vColor = RAID_CLASS_COLORS[vClassInfo.color]
		
		vCount:SetTextColor(vColor.r, vColor.g, vColor.b)
		vCount.Label:SetTextColor(vColor.r, vColor.g, vColor.b)
	end
	
	-- Set the text color for the role totals
	
	for vRoleID, vRoleInfo in pairs(GroupCalendar.RoleInfoByID) do
		local vCount = self.Widgets.MainView.RoleTotals[vRoleID]
		local vColor = RAID_CLASS_COLORS[GroupCalendar.cRoleColorName[vRoleID]]
		
		vCount:SetTextColor(vColor.r, vColor.g, vColor.b)
		vCount.Label:SetTextColor(vColor.r, vColor.g, vColor.b)
	end
	
	self.Widgets.MainView.AutoConfirm.Menu.AttendanceViewer = self
	self.Widgets.MainView.AutoConfirm.Options.AttendanceViewer = self
	
	self:SetTotalsVisible(true, true)
end

function GroupCalendar._AttendanceViewer:AnyItemsCollapsed()
	if not self.CollapsedCategories then
		return false
	end
	
	-- Get the group
	
	local vGroup
	
	if self.CurrentPanel == self.Widgets.MainView then
		vGroup = self.EventListInfo.AttendanceCounts
	
	elseif self.CurrentPanel == self.Widgets.GroupView then
		vGroup = GroupCalendar.Invites.Group
	else
		GroupCalendar:ErrorMessage("AnyItemsCollapsed: Unknown view %s", self.CurrentPanel:GetName())
		return
	end
	
	--
	
	if not vGroup then
		return false
	end
	
	for vCategory, vCollapsed in pairs(self.CollapsedCategories) do
		if vCollapsed and vGroup.Categories[vCategory] then
			return true
		end
	end
	
	return false
end

function GroupCalendar._AttendanceViewer:OnShow()
	self:ShowPanel(self.Widgets.MainView)
	
	GroupCalendar.WhisperLog:SetNotificationFunc(self.UpdateWhispers, self)
	GroupCalendar.WhisperLog:SetWhisperFilterFunc(self.FilterWhispers, self)
end

function GroupCalendar._AttendanceViewer:OnHide()
	GroupCalendar.WhisperLog:SetNotificationFunc(nil, nil, nil)
	
	if GetNumPartyMembers() == 0
	and GetNumRaidMembers() == 0 then
		GroupCalendar.Invites:EndEvent(self.Event)
	else
		GroupCalendar.Invites:SetChangedFunc(nil, nil)
	end
end

function GroupCalendar._AttendanceViewer:SetEvent(pDatabase, pEvent)
	self.Database = pDatabase
	self.Event = pEvent
	self.Group = nil
	
	if self.Event.mRoleConfirm
	or self.Event.mClosed
	or self.Event.mManualConfirm then
		self.ListGroupMode = "Role"
	else
		self.ListGroupMode = "Class"
	end
	
	self.ListSortMode = "Date"

	self.Widgets.ViewMenu.ListSortMode = self.ListSortMode
	self.Widgets.ViewMenu.ListGroupMode = self.ListGroupMode
	
	self.EventListInfo = {}
	self.CollapsedCategories = {}

	-- Update the auto confirm enable
	
	local vAutoConfirmMenu = self.Widgets.MainView.AutoConfirm.Menu
	local vAutoConfirmOptions = self.Widgets.MainView.AutoConfirm.Options
	
	if self.Event.mClosed then
		CalendarDropDown_SetSelectedValue(vAutoConfirmMenu, "CLOSED")
	elseif self.Event.mManualConfirm then
		CalendarDropDown_SetSelectedValue(vAutoConfirmMenu, "MAN")
	elseif self.Event.mRoleConfirm then
		CalendarDropDown_SetSelectedValue(vAutoConfirmMenu, "ROLE")
	else
		CalendarDropDown_SetSelectedValue(vAutoConfirmMenu, "AUT")
	end
	
	GroupCalendar.SetButtonEnable(vAutoConfirmOptions, not self.Event.mManualConfirm and not self.Event.mClosed)
	
	--
	
	self:UpdateAttendanceCounts()
end

function GroupCalendar._AttendanceViewer:SetGroup(pGroup)
	self.Group = pGroup
end

function GroupCalendar._AttendanceViewer:EventChanged(pDatabase, pEvent)
	self.Database = pDatabase
	self.Event = pEvent
	
	self:UpdateAttendanceCounts()
	GroupCalendar.Invites:EventChanged(pDatabase, pEvent)
	
	self:Update()
end

function GroupCalendar._AttendanceViewer:UpdateAttendanceCounts()
	local vHadWhispers = self.EventListInfo.AttendanceCounts
			           and self.EventListInfo.AttendanceCounts.Categories["WHISPERS"] ~= nil
	
	self.EventListInfo.AttendanceCounts =
			CalendarEvent_GetAttendanceList(
					self.Database,
					self.Event,
					self.ListGroupMode)
	
	-- Add in the recent whispers, but only if they're not in the attendance list
	-- and only if the event is editable
	
	if not vHadWhispers then
		self.CollapsedCategories["WHISPERS"] = true
	end
	
	local vAttendanceList = self.EventListInfo.AttendanceCounts
	local vGroupList = GroupCalendar.Invites.Group
	
	if self.mCanEdit then
		local vPlayerWhispers = GroupCalendar.WhisperLog:GetPlayerWhispers(self.Event)
		
		for vPlayerName, vWhispers in pairs(vPlayerWhispers) do
			vAttendanceList:AddWhisper(vPlayerName, vWhispers)
		end
	end
	
	CalendarEvent_SortAttendanceCounts(self.EventListInfo.AttendanceCounts, self.ListGroupMode, self.ListSortMode)
end

function GroupCalendar._AttendanceViewer:FilterWhispers(pPlayerName)
	local vAttendanceList = self.EventListInfo.AttendanceCounts
	
	if vAttendanceList.Items
	and vAttendanceList.Items[pPlayerName] then
		return false
	end
	
	if GroupCalendar.Invites.Group
	and GroupCalendar.Invites.Group.Items[pPlayerName] then
		return false
	end
	
	return true
end

function GroupCalendar._AttendanceViewer:UpdateWhispers()
	if not self.EventListInfo.AttendanceCounts:RemoveCategory("WHISPERS") then
		-- Collapse the category if this is the first one
		
		self.CollapsedCategories["WHISPERS"] = true
	end
	
	local vAttendanceList = self.EventListInfo.AttendanceCounts
	local vGroupList = GroupCalendar.Invites.Group
	
	local vPlayerWhispers = GroupCalendar.WhisperLog:GetPlayerWhispers(self.Event)
	
	for vPlayerName, vWhispers in pairs(vPlayerWhispers) do
		vAttendanceList:AddWhisper(vPlayerName, vWhispers)
	end
	
	CalendarEvent_SortAttendanceCounts(self.EventListInfo.AttendanceCounts, self.ListGroupMode, self.ListSortMode)
	
	self:Update()
end

function GroupCalendar._AttendanceViewer:SetCanEdit(pCanEdit)
	self.mCanEdit = pCanEdit
end

function GroupCalendar._AttendanceViewer:SetTotalsVisible(pShowTotals, pShowAutoConfirm)
	self.ShowTotals = pShowTotals
	self.ShowAutoConfirm = pShowAutoConfirm
	
	self:AdjustHeight()
end

function GroupCalendar._AttendanceViewer:AdjustHeight()
	local vClassTotals = self.Widgets.MainView.ClassTotals
	local vRoleTotals = self.Widgets.MainView.RoleTotals
	local vStatusTotals = self.Widgets.MainView.StatusTotals
	
	local vAutoConfirm = self.Widgets.MainView.AutoConfirm
	local vScrollFrame = self.Widgets.ScrollFrame
	local vScrollTrench = self.Widgets.ScrollbarTrench
	
	local vScrollFrameBaseHeight = 254
	local vScrollTrenchBaseHeight = 261
	
	if self.CurrentPanel == self.Widgets.GroupView
	or self.ShowTotals then
		local vFooterHeight
		local vCurTotals
		local vNumItems
		
		if self.ListGroupMode == "Role" then
			vClassTotals:Hide()
			vRoleTotals:Show()
			vStatusTotals:Hide()
			
			vAutoConfirm:SetPoint("BOTTOMLEFT", vRoleTotals, "TOPLEFT")
			
			vCurTotals = vRoleTotals
			vNumItems = GroupCalendar.cNumAutoConfirmAttendanceRoleItems
		elseif self.ListGroupMode == "Status" then
			vClassTotals:Hide()
			vRoleTotals:Hide()
			vStatusTotals:Show()
			
			vAutoConfirm:SetPoint("BOTTOMLEFT", vStatusTotals, "TOPLEFT")
			
			vCurTotals = vStatusTotals
			vNumItems = GroupCalendar.cNumAutoConfirmAttendanceStatusItems
		else
			vClassTotals:Show()
			vRoleTotals:Hide()
			vStatusTotals:Hide()
			
			vAutoConfirm:SetPoint("BOTTOMLEFT", vClassTotals, "TOPLEFT")
			
			vCurTotals = vClassTotals
			vNumItems = GroupCalendar.cNumAutoConfirmAttendanceClassItems
		end
		
		if self.CurrentPanel ~= self.Widgets.GroupView
		and self.ShowAutoConfirm then
			vAutoConfirm:Show()
			self.NumItems = vNumItems
			vFooterHeight = vAutoConfirm:GetHeight() + vCurTotals:GetHeight()
		else
			vAutoConfirm:Hide()
			self.NumItems = vNumItems + 1
			vFooterHeight = vCurTotals:GetHeight()
		end
		
		vScrollFrame:SetHeight(vScrollFrameBaseHeight - vFooterHeight)
		vScrollTrench:SetHeight(vScrollTrenchBaseHeight - vFooterHeight)
	else
		vClassTotals:Hide()
		vRoleTotals:Hide()
		vStatusTotals:Hide()
		vAutoConfirm:Hide()
		self.NumItems = GroupCalendar.cNumPlainAttendanceItems
		vScrollFrame:SetHeight(vScrollFrameBaseHeight)
		vScrollTrench:SetHeight(vScrollTrenchBaseHeight)
	end
end

function GroupCalendar._AttendanceViewer:Update()
	if not self:IsVisible() then
		return
	end
	
	local vAttendanceListName = self:GetName()
	
	-- Update the view menu
	
	UIDropDownMenu_SetText(self.Widgets.ViewMenu, string.format(GroupCalendar_cViewMenuFormat, self.ListGroupMode, self.ListSortMode))
	
	if self.CurrentPanel == self.Widgets.MainView then
		-- Update the scroll frame
		
		local vTotalCount = 0
		
		if self.EventListInfo.AttendanceCounts then
			for vCategory, vClassAttendanceInfo in pairs(self.EventListInfo.AttendanceCounts.Categories) do
				vTotalCount = vTotalCount + 1
				
				if not self.CollapsedCategories[vCategory] then
					vTotalCount = vTotalCount + vClassAttendanceInfo.mCount
				end
			end
		end
		
		FauxScrollFrame_Update(
				_G[vAttendanceListName.."ScrollFrame"],
				vTotalCount,
				self.NumItems,
				GroupCalendar.cAttendanceItemHeight,
				nil, nil, nil,
				nil,
				293, 316)
		
		self:UpdateAttendanceList()
		
		-- Update the expand/collapse all button
		
		self:UpdateTotals()
		
		-- Show or hide the add button
		
		local vAddButton = self.Widgets.MainView.AddButton
		
		if self.mCanEdit then
			vAddButton:Show()
		else
			vAddButton:Hide()
		end
		
	elseif self.CurrentPanel == self.Widgets.GroupView then
		local vGroupViewName = vAttendanceListName.."GroupView"
		local vSelectionInfoText = _G[vGroupViewName.."SelectionInfo"]
		local vStatusText = _G[vGroupViewName.."Status"]
		local vStatusMessage = GroupCalendar_cInviteStatusMessages[GroupCalendar.Invites.Status]
		local vInviteButton = _G[vGroupViewName.."Invite"]
		
		if vStatusMessage then
			vStatusText:SetText(vStatusMessage)
		elseif GroupCalendar.Invites.Status then
			vStatusText:SetText("Unknown "..GroupCalendar.Invites.Status)
		else
			vStatusText:SetText("Unknown (nil)")
		end
		
		local vNumSelected = GroupCalendar.Invites.NumSelected
		
		if not vNumSelected
		or vNumSelected == 0 then
			vSelectionInfoText:SetText(GroupCalendar_cNoSelection)
		elseif vNumSelected == 1 then
			vSelectionInfoText:SetText(GroupCalendar_cSingleSelection)
		else
			vSelectionInfoText:SetText(format(GroupCalendar_cMultiSelection, vNumSelected))
		end
		
		-- Update the scroll frame
		
		local vTotalCount = 0
		
		if self.EventListInfo.AttendanceCounts then
			for vCategory, vClassAttendanceInfo in pairs(GroupCalendar.Invites.Group.Categories) do
				vTotalCount = vTotalCount + 1
				
				if not self.CollapsedCategories[vCategory] then
					vTotalCount = vTotalCount + vClassAttendanceInfo.mCount
				end
			end
		end
		
		FauxScrollFrame_Update(
				_G[vAttendanceListName.."ScrollFrame"],
				vTotalCount,
				self.NumItems,
				GroupCalendar.cAttendanceItemHeight,
				nil, nil, nil,
				nil,
				293, 316)
		
		self:UpdateAttendanceList()
		
		-- Enable the invite button if the player is the raid or party leader
		-- or is not in a raid or pary
		
		local vEnableInvites = false
		local vInParty = GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
		
		if not vInParty
		or IsPartyLeader()
		or IsRaidLeader()
		or IsRaidOfficer() then
			vEnableInvites = true
		end
		
		GroupCalendar.SetButtonEnable(vInviteButton, vEnableInvites)
	end
end

function GroupCalendar._AttendanceViewer:ToggleExpandAll()
	-- Get the group
	
	local vGroup
	
	if self.CurrentPanel == self.Widgets.MainView then
		vGroup = self.EventListInfo.AttendanceCounts
	
	elseif self.CurrentPanel == self.Widgets.GroupView then
		vGroup = GroupCalendar.Invites.Group
	
	else
		GroupCalendar:ErrorMessage("AttendanceViewer:ToggleExpandAll: Unknown view "..self.CurrentPanel:GetName())
		return
	end
	
	-- Just return if there are no attendance items to toggle
	
	if not self
	or not vGroup then
		return
	end
	
	if self:AnyItemsCollapsed() then
		-- Expand all
		
		self.CollapsedCategories = {}
	else
		-- Collapse all
		
		self.CollapsedCategories = {}
		
		for vCategory, vClassAttendanceInfo in pairs(vGroup.Categories) do
			self.CollapsedCategories[vCategory] = true
		end
	end
	
	self:Update()
end

function GroupCalendar._AttendanceViewer:UpdateTotals()
	if self.ListGroupMode == "Role" then
		self:UpdateRoleTotals()
	elseif self.ListGroupMode == "Status" then
		self:UpdateStatusTotals()
	else
		self:UpdateClassTotals()
	end
end

function GroupCalendar._AttendanceViewer:UpdateClassTotals()
	for vClassCode, vClassInfo in pairs(GroupCalendar.ClassInfoByClassCode) do
		local vClassTotal = 0
		local vStandbyTotal = 0
		
		if self.EventListInfo.AttendanceCounts then
			local vCategoryInfo = self.EventListInfo.AttendanceCounts.Categories[vClassCode]
			
			if vCategoryInfo then
				vClassTotal = vCategoryInfo.mCount
				vStandbyTotal = vCategoryInfo.mStandbyCount
			end
		end
		
		local vCountTextItem = self.Widgets.MainView.ClassTotals[vClassInfo.color]
		
		vCountTextItem:SetText(string.format(
				tern(vStandbyTotal > 0, GroupCalendar_cNumPlayersPlusStandbyFormat, GroupCalendar_cNumPlayersFormat),
				vClassTotal,
				vStandbyTotal))
		
		if vClassTotal == 0 then
			vCountTextItem:SetTextColor(0.9, 0.2, 0.2)
		else
			local vColor = RAID_CLASS_COLORS[vClassInfo.color]
			vCountTextItem:SetTextColor(vColor.r, vColor.g, vColor.b)
		end
	end
end

function GroupCalendar._AttendanceViewer:UpdateRoleTotals()
	for vRoleID, vRoleInfo in pairs(GroupCalendar.RoleInfoByID) do
		local vRoleTotal = 0
		local vStandbyTotal = 0
		
		if self.EventListInfo.AttendanceCounts then
			local vCategoryInfo = self.EventListInfo.AttendanceCounts.Categories[vRoleID]
			
			if vCategoryInfo then
				vRoleTotal = vCategoryInfo.mCount
				vStandbyTotal = vCategoryInfo.mStandbyCount
			end
		end
		
		local vCountTextItem = self.Widgets.MainView.RoleTotals[vRoleID]
		
		vCountTextItem:SetText(string.format(
				tern(vStandbyTotal > 0, GroupCalendar_cNumPlayersPlusStandbyFormat, GroupCalendar_cNumPlayersFormat),
				vRoleTotal,
				vStandbyTotal))
		
		if vRoleTotal == 0 then
			vCountTextItem:SetTextColor(0.9, 0.2, 0.2)
		else
			local vColor = RAID_CLASS_COLORS[GroupCalendar.cRoleColorName[vRoleID]]
			vCountTextItem:SetTextColor(vColor.r, vColor.g, vColor.b)
		end
	end
end

function GroupCalendar._AttendanceViewer:UpdateStatusTotals()
	for vStatusID, vStatusInfo in pairs(GroupCalendar.cAttendanceCategories) do
		local vStatusWidget = self.Widgets.MainView.StatusTotals[vStatusID]
		
		if vStatusWidget then
			local vStatusTotal = 0
			local vStandbyTotal = 0
			
			if self.EventListInfo.AttendanceCounts then
				local vCategoryInfo = self.EventListInfo.AttendanceCounts.Categories[vStatusID]
				
				if vCategoryInfo then
					vStatusTotal = vCategoryInfo.mCount
					vStandbyTotal = vCategoryInfo.mStandbyCount
				end
			end
			
			vStatusWidget:SetText(string.format(
					tern(vStandbyTotal > 0, GroupCalendar_cNumPlayersPlusStandbyFormat, GroupCalendar_cNumPlayersFormat),
					vStatusTotal,
					vStandbyTotal))
			
			if vStatusTotal == 0 then
				vStatusWidget:SetTextColor(0.9, 0.2, 0.2)
			else
				vStatusWidget:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			end
		end
	end
end

function GroupCalendar._AttendanceViewer:SetItem(
					pIndex,
					pItemInfo,
					pLeftFormat,
					pRightFormat,
					pShowMenu,
					pMenuValue,
					pColor,
					pOffline,
					pIconPath,
					pChecked,
					pTooltipName,
					pTooltipText,
					pTooltipTextColor)
	
	if type(pIndex) == "table" then
		GroupCalendar:DebugStack()
	end
	
	local vListName = self:GetName()
	local vItemName = vListName.."Item"..pIndex
	local vItem = _G[vItemName]
	local vItemHighlight = _G[vItemName.."Highlight"]
	
	local vItemCategory = _G[vItemName.."Category"]
	local vItemLeftText = _G[vItemName.."Name"]
	local vItemRightText = _G[vItemName.."Status"]
	local vItemMenu = _G[vItemName.."Menu"]
	local vItemActionButton = _G[vItemName.."Action"]
	
	--
	
	vItemCategory:Hide()
	vItemLeftText:Show()
	vItemRightText:Show()
	vItemActionButton:Hide()
	
	if pShowMenu then
		CalendarDropDown_SetSelectedValue2(vItemMenu, pMenuValue)
		vItemMenu:Show()
		vItemRightText:SetWidth(112)
	else
		vItemMenu:Hide()
		vItemRightText:SetWidth(130)
	end
	
	vItemLeftText:SetText(string.gsub(pLeftFormat, "%$(%w+)", function (pField) return pItemInfo[pField] end))
	vItemRightText:SetText(string.gsub(pRightFormat, "%$(%w+)", function (pField) return pItemInfo[pField] end))
	
	if pColor then
		if pOffline then
			vItemLeftText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
		else
			vItemLeftText:SetTextColor(pColor.r, pColor.g, pColor.b)
		end
		
		vItemRightText:SetTextColor(pColor.r, pColor.g, pColor.b)
	else
		if pOffline then
			vItemLeftText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
		else
			vItemLeftText:SetTextColor(1, 1, 1)
		end
		vItemRightText:SetTextColor(1, 1, 1)
	end
	
	if pChecked ~= nil then
		vItem.Checkable = true
		vItem:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
		vItem:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
		vItemHighlight:SetTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
		vItem:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		vItem:SetChecked(pChecked)
	else
		vItem.Checkable = false
		if pIconPath then
			vItem:SetNormalTexture(pIconPath)
		else
			vItem:SetNormalTexture("")
		end
		vItem:SetPushedTexture("")
		vItem:SetCheckedTexture("")
		vItemHighlight:SetTexture("")
		vItem:SetChecked(false)
	end
	
	vItem.IsCategoryItem = false
	vItem:Show()
	
	vItem.TooltipName = pTooltipName
	vItem.TooltipText = pTooltipText
	vItem.TooltipTextColor = pTooltipTextColor
	
	return vItem
end

function GroupCalendar._AttendanceViewer:SetItemToRSVP(pIndex, pCategory, pRSVP, pNameFormat, pShowRank)
	local vItemInfo =
	{
		name = pRSVP.mName,
		class = GroupCalendar.Database.GetClassByClassCode(pRSVP.mClassCode),
		race = GroupCalendar.Database.GetRaceByRaceCode(pRSVP.mRaceCode),
		level = tostring(pRSVP.mLevel),
		role = GroupCalendar.Database.GetRoleByRoleCode(pRSVP.mRole),
		status = "",
	}
	
	-- Set the status
	
	local vShowStatusString = false
	
	if vShowStatusString then
		vItemInfo.status = self:GetStatusString(pRSVP.mStatus)
	elseif pShowRank then
		local vRank = GroupCalendar.Database.MapGuildRank(pRSVP.mGuild, pRSVP.mGuildRank)
		
		if vRank then
			vItemInfo.status = GuildControlGetRankName(vRank + 1)
		else
			vItemInfo.status = GroupCalendar_cUnknown
		end
	else
		local vDate, vTime = GroupCalendar.Database.GetRSVPOriginalDateTime(pRSVP)
		
		if vDate and vTime then
			vTime = vTime / 60 -- Convert from seconds to minutes
			
			if gGroupCalendar_Settings.ShowEventsInLocalTime then
				vDate, vTime = MCDateLib:GetLocalDateTimeFromServerDateTime(vDate, vTime)
			end
			
			local vShortDateString = GroupCalendar.GetShortDateString(vDate)
			local vShortTimeString = GroupCalendar.GetShortTimeString(vTime)
			
			vItemInfo.status = vShortDateString.." "..vShortTimeString
		end
	end
	
	local vColor = GroupCalendar.GetClassCodeColor(pRSVP.mClassCode)
	
	-- Get the icon path
	
	local vIconPath
	local vTooltipName = nil
	local vTooltipText = nil
	local vTooltipTextColor = nil
	
	if pRSVP.mComment and pRSVP.mComment ~= "" then
		vIconPath = GroupCalendar.AddonPath.."Textures\\AttendanceNoteIcon"
		vTooltipName = pRSVP.mName
		vTooltipText = GroupCalendar.UnescapeString(pRSVP.mComment)
	elseif pRSVP.mType == "Whisper" then
		vIconPath = GroupCalendar.AddonPath.."Textures\\AttendanceNoteIcon"
		
		vTooltipName = pRSVP.mName
		vTooltipText = pRSVP.mWhispers
		vTooltipTextColor = ChatTypeInfo["WHISPER"]
		vColor = vTooltipTextColor
	else
		vIconPath = ""
	end
	
	-- Set the item
	
	local vItem = self:SetItem(
							pIndex,
							vItemInfo,
							pNameFormat,
							"$status",
							self.mCanEdit,
							pRSVP.mStatus,
							vColor,
							false,
							vIconPath,
							nil,
							vTooltipName,
							vTooltipText,
							vTooltipTextColor)
	
	vItem.Item = pRSVP
end

function GroupCalendar._AttendanceViewer:SetItemToCategory(pIndex, pCategory, pActionFunc, pActionParam)
	local vItemName = self:GetName().."Item"..pIndex
	local vItem = _G[vItemName]
	
	local vItemHighlight = _G[vItemName.."Highlight"]
	local vItemCategory = _G[vItemName.."Category"]
	local vItemPlayerName = _G[vItemName.."Name"]
	local vItemPlayerStatus = _G[vItemName.."Status"]
	local vItemMenu = _G[vItemName.."Menu"]
	local vItemActionButton = _G[vItemName.."Action"]

	local vCategoryName
	
	if type(pCategory) == "number" then
		vCategoryName = GuildControlGetRankName(pCategory + 1)
	else
		vCategoryName = GroupCalendar.cAttendanceCategories[pCategory]
		
		if not vCategoryName then
			if self.ListGroupMode == "Role" then
				local vRoleInfo = GroupCalendar.RoleInfoByID[pCategory]
				
				if not vRoleInfo then
					vCategoryName = "Unknown role ("..(pCategory or "nil")..")"
				else
					vCategoryName = vRoleInfo.Name
				end
			else
				vCategoryName = GroupCalendar.Database.GetClassByClassCode(pCategory)
			end
		end
	end
	
	vItemCategory:SetText(vCategoryName)
	vItemCategory:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
	vItemCategory:Show()
	vItemPlayerName:Hide()
	vItemPlayerStatus:Hide()
	
	if pActionFunc then
		vItemActionButton.ActionFunc = pActionFunc
		vItemActionButton.ActionParam = pActionParam
		vItemActionButton:Show()
	else
		vItemActionButton:Hide()
	end
	
	vItemMenu:Hide()
	vItemPlayerStatus:SetWidth(130)
	
	if self.CollapsedCategories[pCategory] then
		vItem:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
		vItem:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
	else
		vItem:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up") 
		vItem:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
	end
	
	vItemHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
	vItem:SetChecked(false)
	
	vItem.Item = nil
	vItem.IsCategoryItem = true
	vItem.Category = pCategory
	
	vItem.TooltipName = nil
	vItem.TooltipText = nil
	vItem.TooltipTextColor = nil
	
	vItem:Show()
end

function GroupCalendar._AttendanceViewer:HideUnusedAttendanceItems(pFirstItem)
	local vListName = self:GetName()
	
	for vIndex = pFirstItem, GroupCalendar.cNumPlainAttendanceItems - 1 do
		local vItemName = vListName.."Item"..vIndex
		_G[vItemName]:Hide()
	end
end

function GroupCalendar._AttendanceViewer:UpdateAttendanceList()
	if self.CurrentPanel == self.Widgets.MainView then
		self:UpdateEventAttendance()
	
	elseif self.CurrentPanel == self.Widgets.GroupView then
		self:UpdateGroupAttendance()
	
	else
		GroupCalendar:ErrorMessage("Unknown attendance panel "..self.CurrentPanel:GetName())
	end
	
	local vExpandAllButton = self.Widgets.ExpandAllButton
	
	if self:AnyItemsCollapsed() then
		vExpandAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
	else
		vExpandAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
	end
end

function GroupCalendar._AttendanceViewer:UpdateGroupAttendance()
	self:UpdateAttendanceItems(GroupCalendar.Invites.Group, self.SetGroupItem)
end

function GroupCalendar._AttendanceViewer:UpdateEventAttendance()
	self:UpdateAttendanceItems(self.EventListInfo.AttendanceCounts, self.SetAttendanceItem)
end

function GroupCalendar._AttendanceViewer:SetGroupItem(pItemIndex, pCategory, pItem)
	local vItemInfo = {}
	local vToolTipName, vTooltipText
	local vIconPath
	
	vItemInfo.name = pItem.mName
	vItemInfo.status = GroupCalendar_cGroupStatusMessages[pItem.mGroupStatus]
	vItemInfo.class = GroupCalendar.Database.GetClassByClassCode(pItem.mClassCode)
	vItemInfo.race = GroupCalendar.Database.GetRaceByRaceCode(pItem.mRaceCode)
	vItemInfo.level = tostring(pItem.mLevel)
	vItemInfo.offline = pItem.mOffline
	
	-- Set the status
	
	local vStatusColumnFormat = ""
	
	if self.ListSortMode == "Rank" then
		local vRank = GroupCalendar.Database.MapGuildRank(pItem.mGuild, pItem.mGuildRank)
		
		if vRank then
			vItemInfo.rank = GuildControlGetRankName(vRank + 1)
		else
			vItemInfo.rank = GroupCalendar_cUnknown
		end
		
		vStatusColumnFormat = "$rank"
	elseif self.ListSortMode == "Date"
	or self.ListSortMode == "Name" then
		local vDate, vTime = GroupCalendar.Database.GetRSVPOriginalDateTime(pItem)
		
		if vDate and vTime then
			vTime = vTime / 60 -- Convert from seconds to minutes
			
			if gGroupCalendar_Settings.ShowEventsInLocalTime then
				vDate, vTime = MCDateLib:GetLocalDateTimeFromServerDateTime(vDate, vTime)
			end
			
			local vShortDateString = GroupCalendar.GetShortDateString(vDate)
			local vShortTimeString = GroupCalendar.GetShortTimeString(vTime)
			
			vItemInfo.date = vShortDateString.." "..vShortTimeString
			
			vStatusColumnFormat = "$date"
		end
	end
	
	local vNameColumnFormat
	
	if pCategory == "STANDBY" then
		vNameColumnFormat = GroupCalendar_cRoleAttendanceNameFormat
	else
		vNameColumnFormat = GroupCalendar_cStatusAttendanceNameFormat
	end
	
	local vSelected
	
	if pItem.mGroupStatus ~= "Joined" then
		vSelected = pItem.mSelected == true
	end
	
	local vItem = self:SetItem(
							pItemIndex,
							vItemInfo,
							vNameColumnFormat,
							vStatusColumnFormat,
							false,
							false,
							GroupCalendar.GetClassCodeColor(pItem.mClassCode),
							pItem.mOffline,
							vIconPath,
							vSelected,
							vTooltipName,
							vTooltipText)
	
	vItem.Item = pItem
end

function GroupCalendar._AttendanceViewer:SetAttendanceItem(pItemIndex, pCategory, pItem)
	local vShowRank = self.ListSortMode == "Rank"
	
	if pItem.mType == "Whisper" then
		self:SetItemToRSVP(pItemIndex, pCategory, pItem, GroupCalendar_cClassAttendanceNameFormat, vShowRank)
	
	elseif self.ListGroupMode == "Class"
	or self.ListGroupMode == "" then
		local vNameFormat

		if pCategory == "STANDBY"
		or pCategory == "PENDING" then
			vNameFormat = GroupCalendar_cClassAttendanceNameFormat
		else
			vNameFormat = GroupCalendar_cRoleAttendanceNameFormat
		end
		
		self:SetItemToRSVP(pItemIndex, pCategory, pItem, vNameFormat, vShowRank)
	elseif self.ListGroupMode == "Role" then
		local vNameFormat

		if pCategory == "STANDBY"
		or pCategory == "PENDING" then
			vNameFormat = GroupCalendar_cRoleAttendanceNameFormat
		else
			vNameFormat = GroupCalendar_cClassAttendanceNameFormat
		end
		
		self:SetItemToRSVP(pItemIndex, pCategory, pItem, vNameFormat, vShowRank)
	else
		self:SetItemToRSVP(pItemIndex, pCategory, pItem, GroupCalendar_cRoleAttendanceNameFormat, vShowRank)
	end
end

function GroupCalendar._AttendanceViewer:UpdateAttendanceItems(pAttendanceCounts, pSetItemFunction)
	local vTotalAttendeesItem = _G[self:GetName().."Total"]
	
	local vFirstItemIndex = FauxScrollFrame_GetOffset(_G[self:GetName().."ScrollFrame"])
	local vItemIndex = 0
	
	if not pAttendanceCounts then
		self:HideUnusedAttendanceItems(vItemIndex)
		vTotalAttendeesItem:SetText(string.format(GroupCalendar_cNumPlayersFormat, 0))
		return
	end
	
	if self.CurrentPanel ~= self.Widgets.GroupView
	and pAttendanceCounts.NumStandby
	and pAttendanceCounts.NumStandby > 0 then
		vTotalAttendeesItem:SetText(string.format(GroupCalendar_cTotalNumPlayersFormat, string.format(GroupCalendar_cNumPlayersPlusStandbyFormat, pAttendanceCounts.NumAttendees - pAttendanceCounts.NumStandby, pAttendanceCounts.NumStandby)))
	else
		vTotalAttendeesItem:SetText(string.format(GroupCalendar_cTotalNumPlayersFormat, string.format(GroupCalendar_cNumPlayersFormat, pAttendanceCounts.NumAttendees)))
	end
	
	for vIndex, vCategory in ipairs(pAttendanceCounts.SortedCategories) do
		local vClassAttendanceInfo = pAttendanceCounts.Categories[vCategory]
		
		if vFirstItemIndex == 0 then
			local vActionFunc = nil
			
			if vCategory == "WHISPERS" then
				vActionFunc = function (...) GroupCalendar.WhisperLog:AskClear(...) end
			end
			
			self:SetItemToCategory(vItemIndex, vCategory, vActionFunc, nil)
			
			vItemIndex = vItemIndex + 1
			
			if vItemIndex >= self.NumItems then
				self:HideUnusedAttendanceItems(vItemIndex)
				return
			end
		else
			vFirstItemIndex = vFirstItemIndex - 1
		end
		
		if not self.CollapsedCategories[vCategory] then
			if vFirstItemIndex >= vClassAttendanceInfo.mCount then
				vFirstItemIndex = vFirstItemIndex - vClassAttendanceInfo.mCount
			else
				for vIndex, vRSVP in ipairs(vClassAttendanceInfo.mAttendees) do
					if vFirstItemIndex == 0 then
						pSetItemFunction(self, vItemIndex, vCategory, vRSVP)
						
						vItemIndex = vItemIndex + 1
						
						if vItemIndex >= self.NumItems then
							self:HideUnusedAttendanceItems(vItemIndex)
							return
						end
					else
						vFirstItemIndex = vFirstItemIndex - 1
					end
				end
			end
		end
	end
	
	self:HideUnusedAttendanceItems(vItemIndex)
end

function GroupCalendar._AttendanceViewer:GetIndexedItem(pIndex)
	local vIndex = pIndex + FauxScrollFrame_GetOffset(_G[self:GetName().."ScrollFrame"])
	
	for vCategoryIndex, vCategory in ipairs(self.EventListInfo.AttendanceCounts.SortedCategories) do
		local vClassAttendanceInfo = self.EventListInfo.AttendanceCounts.Categories[vCategory]
		
		if vIndex == 0 then
			GroupCalendar:DebugMessage("AttendanceViewer:GetIndexedItem: Index specifies a header")
			return nil
		end
		
		GroupCalendar:DebugTable("    "..vCategory.." AttendanceInfo", vClassAttendanceInfo)
		
		vIndex = vIndex - 1
		
		if not self.CollapsedCategories[vCategory] then
			if vIndex < vClassAttendanceInfo.mCount then
				return vClassAttendanceInfo.mAttendees[vIndex + 1]
			end
			
			vIndex = vIndex - vClassAttendanceInfo.mCount
		else
			GroupCalendar:DebugMessage("    Category %s is collapsed", vCategory or "nil")
		end
	end
	
	GroupCalendar:DebugMessage("AttendanceViewer:GetIndexedItem: Index too high")
	GroupCalendar:DebugTable("    SortedCategories", self.EventListInfo.AttendanceCounts.SortedCategories)
	
	return nil
end

function GroupCalendar._AttendanceViewer:SetAutoConfirmMode(pMode)	
	GroupCalendar.SetButtonEnable(
			self.Widgets.MainView.AutoConfirm.Options,
			pMode == "ROLE" or pMode == "AUT")
end

function GroupCalendar._AttendanceViewer:OpenAutoConfirmOptions()
	local vAutConfirmMode = UIDropDownMenu_GetSelectedValue(self.Widgets.MainView.AutoConfirm.Menu)
	
	local vLimits = self.NewClassLimits
	
	if not vLimits then
		vLimits = self.Event.mLimits
	end
	
	CalendarRoleLimitsFrame:Open(
			vLimits,
			tern(vAutConfirmMode == "ROLE", GroupCalendar_cRoleConfirmationTitle, GroupCalendar_cAutoConfirmationTitle),
			false,
			function (...) GroupCalendar.EventViewer:SaveClassLimits(...) end)
end

function GroupCalendar._AttendanceViewer:OnVerticalScroll()
	self:Update()
end

function GroupCalendar._AttendanceViewer:Item_OnEnter(pItem)
	GroupCalendar.AttendanceViewer.ShowMessageTooltip(pItem, pItem.TooltipName, pItem.TooltipText, pItem.TooltipTextColor)
end

function GroupCalendar._AttendanceViewer:Item_OnLeave()
	GameTooltip:Hide()
end

function GroupCalendar._AttendanceViewer:Item_OnClick(pItem, pButton)
	if pItem.IsCategoryItem then
		if not self.CollapsedCategories[pItem.Category] then
			self.CollapsedCategories[pItem.Category] = true
		else
			self.CollapsedCategories[pItem.Category] = nil
		end
		
		self:Update()
		return
	end
	
	if not pItem.Checkable and pItem.SetChecked then
		pItem:SetChecked(false)
		return
	end
	
	if pItem.Item then
		if self.CurrentPanel == self.Widgets.GroupView then
			GroupCalendar.Invites:SetItemSelected(pItem.Item, not pItem.Item.mSelected)
		end
	end
end

function GroupCalendar._AttendanceViewer:DoListViewCommand(pCommand)
	if pCommand == "Class"
	or pCommand == "Role"
	or pCommand == "Status" then
		self.ListGroupMode = pCommand
	else
		self.ListSortMode = pCommand
	end
	
	self.Widgets.ViewMenu.ListSortMode = self.ListSortMode
	self.Widgets.ViewMenu.ListGroupMode = self.ListGroupMode
	
	self:EventChanged(self.Database, self.Event)
	GroupCalendar.Invites:SetGroupSortMode(self.ListGroupMode, self.ListSortMode)

	self:AdjustHeight() -- Update the frame for the new view
end

function GroupCalendar._AttendanceViewer:GroupListChanged()
	self:Update()
end

function GroupCalendar._AttendanceViewer:ShowPanel(pPanel)
	for _, vPanelInfo in ipairs(self.Panels) do
		if vPanelInfo.Panel == pPanel then
			vPanelInfo.Panel:Show()
			PanelTemplates_SelectTab(vPanelInfo.Tab)
			
			-- Handle panel-specific show code
			
			if pPanel == self.Widgets.GroupView then
				local vGroup = GroupCalendar.Invites:BeginEvent(self.Database, self.Event)
				
				self:SetGroup(vGroup)
				GroupCalendar.Invites:SetChangedFunc(self.GroupListChanged, self)
			end
		else
			if vPanelInfo.Panel == self.Widgets.GroupView then
				GroupCalendar.Invites:SetChangedFunc(nil, nil)
			end
			
			vPanelInfo.Panel:Hide()
			PanelTemplates_DeselectTab(vPanelInfo.Tab)
		end
	end
	
	self.CurrentPanel = pPanel
	
	self:AdjustHeight()
	self:Update()
end

----------------------------------------
-- CalendarAddPlayer
----------------------------------------

function CalendarAddPlayer_Open()
	CalendarAddPlayer_Reset()
	
	CalendarAddPlayerFrame:Show()
	CalendarAddPlayerFrameName:SetFocus()
end

function CalendarAddPlayer_Reset()
	CalendarAddPlayerFrame.IsWhisper = false
	CalendarAddPlayerFrame.Guild = nil
	
	CalendarAddPlayerFrameName:SetText("")
	CalendarAddPlayerFrameLevel:SetText("")
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRankMenu, nil)
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameStatusMenu, "Y")
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRoleMenu, "?")
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameClassMenu, "?")
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRaceMenu, "?")
	CalendarAddPlayerFrameComment:SetText("")
	
	if IsInGuild() then
		CalendarAddPlayerFrameRankMenu:Show()
	else
		CalendarAddPlayerFrameRankMenu:Hide()
	end
	
	CalendarAddPlayerFrameDeleteButton:Hide()
	
	CalendarAddPlayerFrameWhisper:Hide()
	CalendarAddPlayerFrame:SetHeight(CalendarAddPlayerFrame.NormalHeight)
end

function CalendarAddPlayer_OpenWhisper(pName, pDate, pTime, pWhispers)
	CalendarAddPlayer_Reset()
	
	CalendarAddPlayerFrame.IsWhisper = true
	CalendarAddPlayerFrame.Name = pName
	CalendarAddPlayerFrame.Date = pDate
	CalendarAddPlayerFrame.Time = pTime
	CalendarAddPlayerFrame.Whispers = pWhispers
	
	CalendarAddPlayerFrameName:SetText(pName)
	CalendarAddPlayer_AutoCompletePlayerInfo()
	
	CalendarAddPlayerFrameDeleteButton:Show()
	
	CalendarAddPlayerFrameWhisper:Show()
	CalendarAddPlayerFrameWhisperRecent:SetText(pWhispers[#pWhispers])
	
	if GroupCalendar.PlayerSettings.LastWhisperConfirmMessage then
		CalendarAddPlayerFrameWhisperReply:SetText(GroupCalendar.PlayerSettings.LastWhisperConfirmMessage)
	end
	
	if GroupCalendar.PlayerSettings.LastWhisperStatus then
		CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameStatusMenu, GroupCalendar.PlayerSettings.LastWhisperStatus)
	end
	
	local vColor = ChatTypeInfo["WHISPER"]
	
	CalendarAddPlayerFrameWhisperRecent:SetTextColor(vColor.r, vColor.g, vColor.b)
	CalendarAddPlayerFrameWhisperReply:SetTextColor(vColor.r, vColor.g, vColor.b)
	
	CalendarAddPlayerFrame:SetHeight(CalendarAddPlayerFrame.NormalHeight + CalendarAddPlayerFrameWhisper:GetHeight())
	
	CalendarAddPlayerFrame:Show()
	CalendarAddPlayerFrameName:SetFocus()
end

function CalendarAddPlayer_SaveNext()
	if CalendarAddPlayerFrame.IsWhisper then
		local vNextWhisper = GroupCalendar.WhisperLog:GetNextWhisper(CalendarAddPlayerFrame.Name)
		
		CalendarAddPlayer_Save()
		
		if vNextWhisper then
			CalendarAddPlayer_OpenWhisper(vNextWhisper.mName, vNextWhisper.mDate, vNextWhisper.mTime, vNextWhisper.mWhispers)
		else
			CalendarAddPlayer_Cancel()
		end
	else
		CalendarAddPlayer_Save()
		CalendarAddPlayer_Open()
	end
end

function CalendarAddPlayer_Delete()
	if not CalendarAddPlayerFrame.IsWhisper then
		return
	end
	
	local vNextWhisper = GroupCalendar.WhisperLog:GetNextWhisper(CalendarAddPlayerFrame.Name)
	
	GroupCalendar.WhisperLog:RemovePlayer(CalendarAddPlayerFrame.Name)
	
	if vNextWhisper then
		CalendarAddPlayer_OpenWhisper(vNextWhisper.mName, vNextWhisper.mDate, vNextWhisper.mTime, vNextWhisper.mWhispers)
	else
		CalendarAddPlayer_Cancel()
	end
end

function CalendarAddPlayer_EditRSVP(pRSVP)
	CalendarAddPlayer_Reset()
	
	CalendarAddPlayerFrame.RSVP = pRSVP
	CalendarAddPlayerFrameName:SetText(pRSVP.mName or "")
	CalendarAddPlayerFrameLevel:SetText(pRSVP.mLevel or "")
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameStatusMenu, pRSVP.mStatus)
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRoleMenu, pRSVP.mRole)
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameClassMenu, pRSVP.mClassCode)
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRaceMenu, pRSVP.mRaceCode)
	
	local vGuildRank = GroupCalendar.Database.MapGuildRank(pRSVP.mGuild, pRSVP.mGuildRank)
	
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRankMenu, vGuildRank)
	
	if pRSVP.mComment then
		CalendarAddPlayerFrameComment:SetText(GroupCalendar.UnescapeString(pRSVP.mComment))
	end
	
	CalendarAddPlayerFrame:Show()
	CalendarAddPlayerFrameName:SetFocus()
end

function CalendarAddPlayer_Done()
	CalendarAddPlayer_Save()
	CalendarAddPlayerFrame:Hide()
end

function CalendarAddPlayer_Cancel()
	CalendarAddPlayerFrame:Hide()
end

function CalendarAddPlayer_Save()
	CalendarAddPlayerFrameName:ClearFocus() -- Force auto-complete if necessary
	
	local vName = CalendarAddPlayerFrameName:GetText()
	
	if vName == "" then
		return
	end
	
	local vStatusCode = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameStatusMenu)
	local vRole = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameRoleMenu)
	local vClassCode = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameClassMenu)
	local vRaceCode = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameRaceMenu)
	local vLevel = tonumber(CalendarAddPlayerFrameLevel:GetText())
	local vComment = GroupCalendar.EscapeString(CalendarAddPlayerFrameComment:GetText())
	local vGuild = CalendarAddPlayerFrame.Guild
	local vGuildRank = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameRankMenu)
	
	if not vGuild then
		vGuild = GroupCalendar.PlayerGuild
	end
	
	if not vGuildRank then
		vGuild = nil
	end
	
	local vRSVP = GroupCalendar.Database.CreatePlayerRSVP(
							GroupCalendar.EventViewer.Database,
							GroupCalendar.EventViewer.Event,
							vName,
							vRaceCode,
							vClassCode,
							vLevel,
							vRole,
							vStatusCode,
							vComment,
							vGuild,
							vGuildRank,
							nil)
	
	if CalendarAddPlayerFrame.RSVP then
		-- if CalendarAddPlayerFrame.RSVP.mGuild then
		-- 	vRSVP.mGuild = CalendarAddPlayerFrame.RSVP.mGuild
		-- 	vRSVP.mGuildRank = CalendarAddPlayerFrame.RSVP.mGuildRank
		-- end
		
		vRSVP.mDate = CalendarAddPlayerFrame.RSVP.mDate
		vRSVP.mTime = CalendarAddPlayerFrame.RSVP.mTime
		vRSVP.mAlts = CalendarAddPlayerFrame.RSVP.mAlts
		
		-- Save the guild rank mapping
		
		GroupCalendar.Database.SetGuildRankMapping(
				CalendarAddPlayerFrame.RSVP.mGuild,
				CalendarAddPlayerFrame.RSVP.mGuildRank,
				vGuildRank)
	end
	
	--
	
	GroupCalendar.Database.AddEventRSVP(
			GroupCalendar.EventViewer.Database,
			GroupCalendar.EventViewer.Event,
			vName,
			vRSVP)
	
	if CalendarAddPlayerFrame.IsWhisper then
		GroupCalendar.WhisperLog:RemovePlayer(CalendarAddPlayerFrame.Name)
	end
	
	-- Send the reply /w if there is one
	
	if CalendarAddPlayerFrameWhisper:IsVisible() then
		local vReplyWhisper = CalendarAddPlayerFrameWhisperReply:GetText()
		
		if vReplyWhisper and vReplyWhisper ~= "" then
			GroupCalendar.PlayerSettings.LastWhisperConfirmMessage = vReplyWhisper
			SendChatMessage(vReplyWhisper, "WHISPER", nil, CalendarAddPlayerFrame.Name)
		end
		
		-- Remember what status was used
		
		GroupCalendar.PlayerSettings.LastWhisperStatus = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameStatusMenu)
		
		-- Remember what role was used for this class (to be implemented)
		
		GroupCalendar.PlayerSettings.LastWhisperRole = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameRoleMenu)
	end
	
	-- Remember the role setting
	
	local vDatabase = GroupCalendar.Database.GetDatabase(vName)
	
	if vDatabase then
		vDatabase.DefaultRole = vRole
	end
end

function CalendarAddPlayer_AutoCompletePlayerInfo()
	local vName = CalendarAddPlayerFrameName:GetText()
	local vUpperName = strupper(vName)
	
	local vGuildMemberIndex = GroupCalendar.Network:GetGuildMemberIndex(vName)
	
	if vGuildMemberIndex then
		local vMemberName, vRank, vRankIndex, vLevel, vClass, vZone, vNote, vOfficerNote, vOnline = GetGuildRosterInfo(vGuildMemberIndex)
		
		CalendarAddPlayerFrameName:SetText(vMemberName)
		CalendarAddPlayerFrameLevel:SetText(vLevel)
		CalendarAddPlayerFrameClassMenu:SetSelectedValue(GroupCalendar.Database.GetClassCodeByClass(vClass))
		-- CalendarAddPlayerFrameRaceMenu:SetSelectedValue(GroupCalendar.Database.GetRaceCodeByRace(vRace))
		CalendarAddPlayerFrameRankMenu:SetSelectedValue(vRankIndex)
		
		CalendarAddPlayerFrame.Guild = GroupCalendar.PlayerGuild
		
		CalendarAddPlayerFrameRoleMenu:SetSelectedValue(GroupCalendar.GetMemberDefaultRole(vMemberName))
		
		return true
	end
	
	local vNumFriends = GetNumFriends()
	
	for vFriendIndex = 1, vNumFriends do
		local vFriendName, vLevel, vClass, vArea, vConnected = GetFriendInfo(vFriendIndex)
		
		if strupper(vFriendName) == vUpperName then
			if vConnected then
				CalendarAddPlayerFrameName:SetText(vFriendName)
				CalendarAddPlayerFrameLevel:SetText(vLevel)
				CalendarAddPlayerFrameClassMenu:SetSelectedValue(GroupCalendar.Database.GetClassCodeByClass(vClass))
				-- CalendarAddPlayerFrameRaceMenuSetSelectedValue(GroupCalendar.Database.GetRaceCodeByRace(vRace))
			end
			
			CalendarAddPlayerFrameRoleMenu:SetSelectedValue(GroupCalendar.GetMemberDefaultRole(vFriendName, vClass))
		end
		
		return
	end
	
	return false
end

function CalendarAddPlayerWhisper_OnEnter(self)
	if not CalendarAddPlayerFrame.IsWhisper then
		return
	end
	
	GroupCalendar.AttendanceViewer.ShowMessageTooltip(
			self,
			CalendarAddPlayerFrame.Name,
			CalendarAddPlayerFrame.Whispers,
			ChatTypeInfo["WHISPER"])
end

function CalendarAddPlayerWhisper_OnLeave(self)
	GameTooltip:Hide()
end

function CalendarAddPlayerWhisper_Reply(self)
	local vName
	
	if CalendarAddPlayerFrame.Name then
		vName = CalendarAddPlayerFrame.Name
	else
		vName = CalendarAddPlayerFrameName:GetText()
	end

	if not vName or vName == "" then
		return
	end
	
	DEFAULT_CHAT_FRAME.editBox:SetAttribute("chatType", "WHISPER")
	DEFAULT_CHAT_FRAME.editBox:SetAttribute("tellTarget", vName)
	
	ChatEdit_UpdateHeader(DEFAULT_CHAT_FRAME.editBox)
	
	if not DEFAULT_CHAT_FRAME.editBox:IsVisible() then
		ChatFrame_OpenChat("", DEFAULT_CHAT_FRAME)
	end
end

function CalendarRoleClassLimitItem_SetClassName(pItem, pClassName)
	local vItemName = pItem:GetName()
	local vMinEditBox = _G[vItemName.."Min"]
	
	local vColor = RAID_CLASS_COLORS[_G["GroupCalendar_c"..pClassName.."ClassColorName"]]
	
	vMinEditBox:SetTextColor(vColor.r, vColor.g, vColor.b)
end

function CalendarScrollbarTrench_SizeChanged(pScrollbarTrench)
	local vScrollbarTrenchName = pScrollbarTrench:GetName()
	local vScrollbarTrenchMiddle = _G[vScrollbarTrenchName.."Middle"]
	
	local vMiddleHeight= pScrollbarTrench:GetHeight() - 51
	vScrollbarTrenchMiddle:SetHeight(vMiddleHeight)
end

GroupCalendar.cAttendanceCategories =
{
	PENDING = GroupCalendar_cPendingApprovalCategory,
	YES = GroupCalendar_cAttendingCategory,
	STANDBY = GroupCalendar_cStandbyCategory,
	MAYBE = GroupCalendar_cMaybeCategory,
	NO = GroupCalendar_cNotAttendingCategory,
	WHISPERS = GroupCalendar_cWhispersCategory,
	BANNED = GroupCalendar_cBannedCategory,
}

function GroupCalendar.GetClassCodeColor(pClassCode)
	if not pClassCode then
		return NORMAL_FONT_COLOR
	end
	
	local vClassInfo = GroupCalendar.ClassInfoByClassCode[pClassCode]
	
	if not vClassInfo then
		return NORMAL_FONT_COLOR
	end
	
	local vClassColorName = _G["GroupCalendar_c"..vClassInfo.element.."ClassColorName"]
	
	return RAID_CLASS_COLORS[vClassColorName]
end

