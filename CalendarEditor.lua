CalendarEditor_cMaxItems = 15

GroupCalendar.SelectedDate = -1
gCalendarEditor_CompiledSchedule = nil

function CalendarEditor_SetCompiledSchedule(pDate, pCompiledSchedule)
	-- Make sure the event editor and viewer is closed
	
	GroupCalendar.EventViewer:DoneViewing()
	
	--
	
	GroupCalendar.DeleteTable(gCalendarEditor_CompiledSchedule, 1)
	
	GroupCalendar.SelectedDate = pDate
	gCalendarEditor_CompiledSchedule = pCompiledSchedule
	
	-- Set the date being displayed
	
	CalendarEditorFrameSubTitle:SetText(GroupCalendar.GetLongDateString(pDate))
	
	CalendarEditor_BuildCompiledScheduleList(pCompiledSchedule)
	
	GroupCalendar.SetButtonEnable(CalendarEditorNewEventButton, GroupCalendar.SelectedDate >= GroupCalendar.MinimumEventDate)
	
	ShowUIPanel(CalendarEditorFrame)
end

function CalendarEditor_BuildCompiledScheduleList(pCompiledSchedule)
	local vItemIndex = 1
	local vTotalNumItems = 0
	
	if pCompiledSchedule ~= nil then
		-- Populate the schedule items
		
		vTotalNumItems = #pCompiledSchedule
		
		for vEventIndex, vCompiledEvent in ipairs(pCompiledSchedule) do
			local vEventItemName = "CalendarEditorEvent"..vItemIndex
			
			local vEventItemFrame = _G[vEventItemName]
			local vEventItemTime = _G[vEventItemName.."Time"]
			local vEventItemTitle = _G[vEventItemName.."Title"]
			local vEventItemOwner = _G[vEventItemName.."Owner"]
			local vEventItemCircled = _G[vEventItemName.."Circled"]
			
			local vEventInfo = GroupCalendar.EventInfoByID[vCompiledEvent.mEvent.mType]
			
			if vEventInfo and vEventInfo.allDay then
				vEventItemTime:SetText(vEventInfo.name)
			elseif vCompiledEvent.mEvent.mTime then
				local vTime
				
				if gGroupCalendar_Settings.ShowEventsInLocalTime then
					vTime = MCDateLib:GetLocalTimeFromServerTime(vCompiledEvent.mEvent.mTime)
				else
					vTime = vCompiledEvent.mEvent.mTime
				end
				
				vEventItemTime:SetText(GroupCalendar.GetShortTimeString(vTime))
			else
				vEventItemTime:SetText(GroupCalendar.cAllDay)
			end
			
			vEventItemTitle:SetText(GroupCalendar.Database.GetEventDisplayName(vCompiledEvent.mEvent))
			
			if vCompiledEvent.mOwner == "_BLIZZARD" then
				vEventItemOwner:SetText(GroupCalendar.cBlizzardOwner)
			else
				vEventItemOwner:SetText(vCompiledEvent.mOwner)
			end
			
			local vAttending = GroupCalendar.Database.PlayerIsAttendingEvent(vCompiledEvent.mOwner, vCompiledEvent.mEvent)
			
			if vAttending then
				if vAttending == "CONFIRMED" then
					vEventItemCircled:SetVertexColor(0, 1, 0)
				elseif vAttending == "CONFIRMED_STANDBY" or vAttending == "REQUESTED_STANDBY" then
					vEventItemCircled:SetVertexColor(0.5, 0.5, 1)
				elseif vAttending == "CONFIRMED_MAYBE" or vAttending == "REQUESTED_MAYBE" then
					vEventItemCircled:SetVertexColor(0.8, 0.8, 0.8)
				else
					vEventItemCircled:SetVertexColor(1, 1, 0)
				end
				
				vEventItemCircled:Show()
			else
				vEventItemCircled:Hide()
			end
			
			vEventItemFrame:Show()
			
			vItemIndex = vItemIndex + 1
			
			if vItemIndex > CalendarEditor_cMaxItems then
				break
			end
		end
	end
	
	FauxScrollFrame_Update(
			CalendarEditorScrollFrame,
			vTotalNumItems,
			CalendarEditor_cMaxItems,
			22,
			nil, nil, nil,
			nil,
			220, 254)
	
	for vIndex = vItemIndex, CalendarEditor_cMaxItems do
		local vEventItemFrame = _G["CalendarEditorEvent"..vIndex]
		
		vEventItemFrame:Hide()
	end
	
	if GroupCalendar.ClipboardEvent then
		CalendarEditorPasteEventButton:Enable()
	else
		CalendarEditorPasteEventButton:Disable()
	end
end

function CalendarEditor_ScheduleChanged(pDate, pSchedule)
	if pDate == GroupCalendar.SelectedDate then
		gCalendarEditor_CompiledSchedule = GroupCalendar.Database.GetCompiledSchedule(pDate, true)
		
		CalendarEditor_BuildCompiledScheduleList(gCalendarEditor_CompiledSchedule)
	end
end

function CalendarEditor_MajorDatabaseChange()
	if GroupCalendar.SelectedDate == -1 then
		return
	end
	
	GroupCalendar.DeleteTable(gCalendarEditor_CompiledSchedule, 1)
	
	gCalendarEditor_CompiledSchedule = GroupCalendar.Database.GetCompiledSchedule(GroupCalendar.SelectedDate, true)
	
	CalendarEditor_BuildCompiledScheduleList(gCalendarEditor_CompiledSchedule)
end

function CalendarEditor_IsOpen()
	return GroupCalendar.SelectedDate ~= -1
			and not GroupCalendar.EventViewer.Active
end

function CalendarEditor_Close()
	HideUIPanel(CalendarEditorFrame)
end

function CalendarEditor_OnShow()
	PlaySound("igCharacterInfoOpen")
end

function CalendarEditor_OnHide()
	PlaySound("igCharacterInfoClose")
	
	GroupCalendar.SelectedDate = -1
	GroupCalendar_EditorClosed()
end

function CalendarEditor_NewEvent()
	local vDatabase = GroupCalendar.Database.GetDatabase(GroupCalendar.PlayerName, true)
	local vEvent = GroupCalendar.Database.NewEvent(vDatabase, GroupCalendar.SelectedDate)
	
	GroupCalendar.EventViewer:ViewEvent(vDatabase, vEvent, true, true)
end

function CalendarEditor_PasteEvent()
	if not GroupCalendar.ClipboardEvent then
		return
	end
	
	local vDatabase = GroupCalendar.Database.GetDatabase(GroupCalendar.PlayerName, true)
	local vEvent = GroupCalendar.Database.NewEvent(vDatabase, GroupCalendar.SelectedDate, GroupCalendar.ClipboardEvent)
	
	GroupCalendar.EventViewer:ViewEvent(vDatabase, vEvent, true, true)
end

function CalendarEditor_EditIndexedEvent(pIndex)
	local vCompiledEvent = gCalendarEditor_CompiledSchedule[pIndex]
	local vDatabase = GroupCalendar.Database.GetDatabase(vCompiledEvent.mOwner, false, vCompiledEvent.mRealm)
	
	if vDatabase then
		GroupCalendar.EventViewer:ViewEvent(vDatabase, vCompiledEvent.mEvent, vDatabase.IsPlayerOwned and not GroupCalendar.Database.IsResetEventType(vCompiledEvent.mEvent.mType), false)
	end
end

function CalendarEditor_ShowEventItemTooltip(pEventItem)
	local vIndex = pEventItem:GetID()
	local vCompiledEvent = gCalendarEditor_CompiledSchedule[vIndex]
	local vDatabase = GroupCalendar.Database.GetDatabase(vCompiledEvent.mOwner, false, vCompiledEvent.mRealm)
	local vAttendance = {}
	
	if vCompiledEvent.mEvent.mAttendance then
		GameTooltip:SetOwner(pEventItem, "ANCHOR_LEFT")
		GameTooltip:AddLine(GroupCalendar.Database.GetEventDisplayName(vCompiledEvent.mEvent), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		
		for vAttendeeName, vRSVPString in pairs(vCompiledEvent.mEvent.mAttendance) do
			local vRSVP = GroupCalendar.Database.UnpackEventRSVP(vDatabase.UserName, vAttendeeName, vCompiledEvent.mEvent.mID, vRSVPString)
			local vStatus = GroupCalendar.GetRSVPStatusCategory(vRSVP)
			
			if vStatus then
				if not vAttendance[vStatus] then
					vAttendance[vStatus] = {}
				end
				
				table.insert(vAttendance[vStatus], vRSVP.mName)
			end
		end
		
		for vStatus, vAttendees in pairs(vAttendance) do
			table.sort(vAttendees)
		end
		
		CalendarEditor_AddTooltipAttendanceList(GroupCalendar.cAttendanceCategories.YES, vAttendance.YES, GREEN_FONT_COLOR)
		CalendarEditor_AddTooltipAttendanceList(GroupCalendar.cAttendanceCategories.NO, vAttendance.NO, RED_FONT_COLOR)
		CalendarEditor_AddTooltipAttendanceList(GroupCalendar.cAttendanceCategories.STANDBY, vAttendance.STANDBY, {r=0.5,g=0.5,b=1})
		CalendarEditor_AddTooltipAttendanceList(GroupCalendar.cAttendanceCategories.MAYBE, vAttendance.MAYBE, {r=0.8,g=0.8,b=0.8})
		CalendarEditor_AddTooltipAttendanceList(GroupCalendar.cAttendanceCategories.PENDING, vAttendance.PENDING, NORMAL_FONT_COLOR)
		
		GameTooltip:Show()
	end
end

function CalendarEditor_AddTooltipAttendanceList(pCategoryName, pAttendees, pColor)
	if not pAttendees then
		return
	end
	
	local vAttendees = table.concat(pAttendees, ", ")
	
	GameTooltip:AddLine(pCategoryName..": "..vAttendees, pColor.r, pColor.g, pColor.b, true)
end
