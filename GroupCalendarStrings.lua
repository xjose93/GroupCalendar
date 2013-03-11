﻿GroupCalendar =
{
	EventLib = MCEventLib,
	AddonPath = "Interface\\Addons\\GroupCalendar"
}

MCDebugLib:InstallDebugger("GroupCalendar", GroupCalendar, {r=0.8,g=0.5,b=1})

GroupCalendar.VersionString = "4.6.1 (SpanishXJ @vGaming.es)"

GroupCalendar_cTitle = "Group Calendar v%s"

GroupCalendar.cSingleItemFormat = "%s"
GroupCalendar.cTwoItemFormat = "%s and %s"
GroupCalendar.cMultiItemFormat = "%s{{, %s}} and %s"

GroupCalendar_cSun = "Sun"
GroupCalendar_cMon = "Mon"
GroupCalendar_cTue = "Tue"
GroupCalendar_cWed = "Wed"
GroupCalendar_cThu = "Thu"
GroupCalendar_cFri = "Fri"
GroupCalendar_cSat = "Sat"

GroupCalendar_cSunday = "Sunday"
GroupCalendar_cMonday = "Monday"
GroupCalendar_cTuesday = "Tuesday"
GroupCalendar_cWednesday = "Wednesday"
GroupCalendar_cThursday = "Thursday"
GroupCalendar_cFriday = "Friday"
GroupCalendar_cSaturday = "Saturday"

GroupCalendar_cSelfWillAttend = "%s will attend"
GroupCalendar_cGuildOnly = "<%s> members only"

GroupCalendar_cMonthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
GroupCalendar_cDayOfWeekNames = {GroupCalendar_cSunday, GroupCalendar_cMonday, GroupCalendar_cTuesday, GroupCalendar_cWednesday, GroupCalendar_cThursday, GroupCalendar_cFriday, GroupCalendar_cSaturday}

GroupCalendar_cLoadMessage = "Group Calendar loaded.  Use /cal for a list of commands.  The user's manual is online at http://wobbleworks.com/groupcalendar/manual"
GroupCalendar_cInitializingGuilded = "Group Calendar: Initializing settings for guilded player"
GroupCalendar_cInitializingUnguilded = "Group Calendar: Initializing settings for unguilded player"
GroupCalendar_cLocalTimeNote = "(%s local)"

GroupCalendar_cOptions = "Setup..."

GroupCalendar_cCalendar = "Calendar"
GroupCalendar_cSetup = "Setup"
GroupCalendar_cBackup = "Backup"
GroupCalendar_cAbout = "About"

GroupCalendar_cUseServerDateTime = "Use server dates and times"
GroupCalendar_cUseServerDateTimeDescription = "Turn on to show events using the server date and time, turn off to use your local date and time"
GroupCalendar_cShowDarkmoonCalendar = "Show Darkmoon Faire"
GroupCalendar_cShowDarkmoonCalendarDescription = "Turn on to show the Darkmoon Faire schedule"
GroupCalendar_cShowWeeklyCalendar = "Show weekly events"
GroupCalendar_cShowWeeklyCalendarDescription = "Turn on to show weekly events such as the Fishing Extravaganza"
GroupCalendar_cShowPvPCalendar = "Show pvp weekends"
GroupCalendar_cShowPvPCalendarDescription = "Turn on to show PvP weekends"

GroupCalendar_cSetupTitle = "Calendar Setup"
GroupCalendar_cConfigModeLabel = "Configuration:"
GroupCalendar_cAutoChannelConfig = "Automatic"
GroupCalendar_cManualChannelConfig = "Manual"
GroupCalendar_cAdminChannelConfig = "Administrator"

GroupCalendar_cUseGuildChannel = "Use Guild data channel"
GroupCalendar_cUseGuildChannelDescription = "Uses the built-in data channel for your guild.  This channel is not accessible by anyone outside your guild."

GroupCalendar_cUseSharedChannel = "Use shared data channel"
GroupCalendar_cUseSharedChannelDescription = "Uses a public data channel for calendar data.  This channel is accessible to anyone of the same faction on your server so you should use a password to restrict access."

GroupCalendar_cApplyChannelChanges = "Apply"
GroupCalendar_cManualConfigTipDescription = "Allows you to manually enter the channel and password information."
GroupCalendar_cStoreAutoConfigTipDescription = "Allows a guild officer to store channel configuration information in the selected players note in the guild roster."
GroupCalendar_cAutoConfigPlayerTipDescription = "The name of the player in the guild roster containing the channel configuration data."
GroupCalendar_cChannelNameTipTitle = "Channel name"
GroupCalendar_cChannelNameTipDescription = "The name of the chat channel which will be used to send and receive event data from other players"
GroupCalendar_cConnectChannel = "Connect"
GroupCalendar_cDisconnectChannel = "Disconnect"
GroupCalendar_cChannelStatus =
{
	Starting = {mText = "Status: Starting up...", mColor = {r = 1, g = 1, b = 0.3}},
	Synching = {mText = "Status: Synchronizing with network %s", mColor = {r = 0.3, g = 1, b = 0.3}},
	Suspended = {mText = "Status: Suspended (logging out)", mColor = {r = 1, g = 1, b = 0.3}},
	Connected = {mText = "Status: Data channel is connected", mColor = {r = 0.3, g = 1, b = 0.3}},
	Disconnected = {mText = "Status: Data channel is not connected", mColor = {r = 1, g = 0.5, b = 0.2}},
	Initializing = {mText = "Status: Initializing data channel", mColor = {r = 1, g = 1, b = 0.3}},
	Error = {mText = "Error: %s", mColor = {r = 1, g = 0.2, b = 0.4}},
}

GroupCalendar_cConnected = "Connected"
GroupCalendar_cDisconnected = "Disconnected"
GroupCalendar_cTooManyChannels = "You have already joined the maximum number of channels"
GroupCalendar_cJoinChannelFailed = "Failed to join the channel for an unknown reason"
GroupCalendar_cWrongPassword = "The password is incorrect"
GroupCalendar_cAutoConfigNotFound = "Configuration data not found in the guild roster"
GroupCalendar_cErrorAccessingNote = "Couldn't retrieve configuration data"

GroupCalendar_cTrustConfigTitle = "Trust Setup"
GroupCalendar_cTrustConfigDescription = "Trust determines who you allow to provide you with events.  It does NOT limit who can see events in your calendar.  Use a password on the data channel to restrict who can see your calendar."
GroupCalendar_cTrustGroupLabel = "Trust:"
GroupCalendar_cEvent = "Event"
GroupCalendar_cEdit = "Edit"
GroupCalendar_cAttendance = "Attendance"

GroupCalendar_cAboutTitle = "About Group Calendar"
GroupCalendar_cTitleVersion = "Group Calendar v"..GroupCalendar.VersionString

GroupCalendar.cAuthor = "Designed and written by John Stephen with contributions by %s"
GroupCalendar_cTestersTitle = "Testers for 4.3"
GroupCalendar_cSpecialThanksTitle = "Special thanks to"
GroupCalendar.cTranslationCredit = "Translations by %s"
GroupCalendar_cGuildURL = "In memory of David Ramirez - 2009\r\rwobbleworks.com"

GroupCalendar_cRebuildDatabase = "Rebuild Database"
GroupCalendar_cRebuildDatabaseDescription = "Rebuilds the event database for your character.  This may solve problems with people not seeing all of your events, but there is a slight risk that some event attendance replies could get lost."

GroupCalendar_cTrustGroups =
{
	"Anyone who has access to the data channel",
	"Other members of your guild",
	"Only those explicitly listed below"
}

GroupCalendar_cTrustAnyone = "Trust anyone who has access to the data channel"
GroupCalendar_cTrustGuildies = "Trust other members of your guild"
GroupCalendar_cTrustMinRank = "Minimum rank to show:"
GroupCalendar_cTrustNobody = "Trust only those explicitly listed below"
GroupCalendar_cTrustedPlayers = "Additional players"
GroupCalendar_cExcludedPlayers = "Ignore events and requests from players"
GroupCalendar_cPlayerName = "Name:"
GroupCalendar_cRemoveExcluded = "Remove"
GroupCalendar_cAddExcluded = "Add"

CalendarEventViewer_cTitle = "View Event"
CalendarEventViewer_cDone = "Done"

CalendarEventViewer_cLevelRangeFormat = "Levels %i to %i"
CalendarEventViewer_cMinLevelFormat = "Levels %i and up"
CalendarEventViewer_cMaxLevelFormat = "Up to level %i"
CalendarEventViewer_cAllLevels = "All levels"
CalendarEventViewer_cSingleLevel = "Level %i only"

CalendarEventViewer_cYes = "Yes! I will attend this event"
CalendarEventViewer_cNo = "No. I won't attend this event"
CalendarEventViewer_cMaybe = "Maybe. I'm not sure yet"

CalendarEventViewer_cResponseMessage =
{
	"Status: No response sent",
	"Status: Waiting for confirmation",
	"Status: Confirmed - Attending",
	"Status: Confirmed - On standby",
	"Status: Confirmed - Not attending",
	"Status: Banned from event",
	"Status: Confirmed - Maybe attending",
	"Status: Confirmed - Pending approval",
}

CalendarEventEditorFrame_cTitle = "Add/Edit Event"
CalendarEvent_cDone = "Done"
CalendarEvent_cDelete = "Delete"
CalendarEvent_cGroupTabTitle = "Group"

CalendarEvent_cConfirmDeleteMsg = "Delete \"%s\"?"

-- Event names

GroupCalendar_cGeneralEventGroup = "General"
GroupCalendar_cPersonalEventGroup = "Personal (not shared)"
GroupCalendar_cRaidClassicEventGroup = "Raids (Classic)"
GroupCalendar_cTBCRaidEventGroup = "Raids (Burning Crusade)"
GroupCalendar_cWotLKRaidNEventGroup = "Raids (WotLK)"
GroupCalendar_cDungeonEventGroup = "Dungeons (Classic)"
GroupCalendar_cOutlandsDungeonEventGroup = "Dungeons (Burning Crusade)"
GroupCalendar_cWotLKDungeonEventGroup = "Dungeons (WotLK)"
GroupCalendar_cOutlandsHeroicDungeonEventGroup = "Heroics (Burning Crusade)"
GroupCalendar_cWotLKHeroicDungeonEventGroup = "Heroics (WotLK)"
GroupCalendar_cBattlegroundEventGroup = "PvP"
GroupCalendar_cOutdoorRaidEventGroup = "Outdoor Raids"

GroupCalendar_cMeetingEventName = "Meeting"
GroupCalendar_cBirthdayEventName = "Birthday"
GroupCalendar_cRoleplayEventName = "Roleplaying"
GroupCalendar_cHolidayEventName = "Holiday"
GroupCalendar_cDentistEventName = "Dentist"
GroupCalendar_cDoctorEventName = "Doctor"
GroupCalendar_cVacationEventName = "Vacation"
GroupCalendar_cOtherEventName = "Other"

GroupCalendar_cAQREventName = "Ruins of Ahn'Qiraj"
GroupCalendar_cAQTEventName = "Ahn'Qiraj Temple"
GroupCalendar_cBFDEventName = "Blackfathom Deeps"
GroupCalendar_cBRDEventName = "Blackrock Depths"
GroupCalendar_cUBRSEventName = "Blackrock Spire (Upper)"
GroupCalendar_cLBRSEventName = "Blackrock Spire (Lower)"
GroupCalendar_cBWLEventName = "Blackwing Lair"
GroupCalendar_cDeadminesEventName = "The Deadmines"
GroupCalendar_cDMEventName = "Dire Maul"
GroupCalendar_cGnomerEventName = "Gnomeregan"
GroupCalendar_cMaraEventName = "Maraudon"
GroupCalendar_cMCEventName = "Molten Core"
GroupCalendar_cOnyxiaEventName = "Onyxia's Lair"
GroupCalendar_cRFCEventName = "Ragefire Chasm"
GroupCalendar_cRFDEventName = "Razorfen Downs"
GroupCalendar_cRFKEventName = "Razorfen Kraul"
GroupCalendar_cSMEventName = "Scarlet Monastery"
GroupCalendar_cScholoEventName = "Scholomance"
GroupCalendar_cSFKEventName = "Shadowfang Keep"
GroupCalendar_cStockadesEventName = "The Stockades"
GroupCalendar_cStrathEventName = "Stratholme"
GroupCalendar_cSTEventName = "The Sunken Temple"
GroupCalendar_cUldEventName = "Uldaman"
GroupCalendar_cWCEventName = "Wailing Caverns"
GroupCalendar_cZFEventName = "Zul'Farrak"
GroupCalendar_cZGEventName = "Zul'Gurub"

GroupCalendar_cTheEyeEventName = "The Eye"
GroupCalendar_cSerpentshrineEventName = "Serpentshrine"
GroupCalendar_cMagtheridonEventName = "Magtheridon"
GroupCalendar_cHyjalEventName = "Mount Hyjal"
GroupCalendar_cKarazhanEventName = "Karazhan"
GroupCalendar_cZulAmanEventName = "Zul'Aman"
GroupCalendar_cGruulEventName = "Gruul's Lair"
GroupCalendar_cBlackTempleEventName = "Black Temple"
GroupCalendar_cArcatrazEventName = "Tempest: Arcatraz"
GroupCalendar_cBotanicaEventName = "Tempest: Botanica"
GroupCalendar_cMechanarEventName = "Tempest: Mechanar"
			
GroupCalendar_cDurnholdeEventName = "CoT: Durnholde Keep"
GroupCalendar_cDarkPortalEventName = "CoT: Black Morass (Dark Portal)"

GroupCalendar_cAuchenaiCryptsEventName = "Auchindoun: Crypts"
GroupCalendar_cSethekkHallsEventName = "Auchindoun: Sethekk Halls"
GroupCalendar_cShadowLabyrinthEventName = "Auchindoun: Labyrinth"
GroupCalendar_cManaTombsEventName = "Auchindoun: Mana Tombs"

GroupCalendar_cSteamvaultEventName = "Coilfang: Steamvault"
GroupCalendar_cUnderbogEventName = "Coilfang: Underbog"
GroupCalendar_cSlavePensEventName = "Coilfang: Slave Pens"
			
GroupCalendar_cShatteredHallsEventName = "Hellfire: Shattered Halls"
GroupCalendar_cFurnaceEventName = "Hellfire: Blood Furnace"
GroupCalendar_cRampartsEventName = "Hellfire: Ramparts"

GroupCalendar_cArcatrazHEventName = "Tempest: Arcatraz (Heroic)"
GroupCalendar_cBotanicaHEventName = "Tempest: Botanica (Heroic)"
GroupCalendar_cMechanarHEventName = "Tempest: Mechanar (Heroic)"
			
GroupCalendar_cDurnholdeHEventName = "CoT: Durnholde Keep (Heroic)"
GroupCalendar_cDarkPortalHEventName = "CoT: Dark Portal (Heroic)"

GroupCalendar_cAuchenaiCryptsHEventName = "Auchindoun: Crypts (Heroic)"
GroupCalendar_cSethekkHallsHEventName = "Auchindoun: Sethekk Halls (Heroic)"
GroupCalendar_cShadowLabyrinthHEventName = "Auchindoun: Labyrinth (Heroic)"
GroupCalendar_cManaTombsHEventName = "Auchindoun: Mana Tombs (Heroic)"

GroupCalendar_cSteamvaultHEventName = "Coilfang: Steamvault (Heroic)"
GroupCalendar_cUnderbogHEventName = "Coilfang: Underbog (Heroic)"
GroupCalendar_cSlavePensHEventName = "Coilfang: Slave Pens (Heroic)"
			
GroupCalendar_cShatteredHallsHEventName = "Hellfire: Shattered Halls (Heroic)"
GroupCalendar_cFurnaceHEventName = "Hellfire: Blood Furnace (Heroic)"
GroupCalendar_cRampartsHEventName = "Hellfire: Ramparts (Heroic)"

GroupCalendar_cMagistersEventName = "Magister's Terrace"
GroupCalendar_cMagistersHEventName = "Magister's Terrace (Heroic)"
GroupCalendar_cSunwellEventName = "Sunwell Plateau"

GroupCalendar_cPvPEventName = "General PvP"
GroupCalendar_cA2v2EventName = "Arena (2v2)"
GroupCalendar_cA3v3EventName = "Arena (3v3)"
GroupCalendar_cA5v5EventName = "Arena (5v5)"
GroupCalendar_cABEventName = "Arathi Basin"
GroupCalendar_cAVEventName = "Alterac Valley"
GroupCalendar_cWSGEventName = "Warsong Gulch"
GroupCalendar_cEotSEventName = "Eye of the Storm"
GroupCalendar_cConquestEventName = "Isle of Conquest"
GroupCalendar_cDoomWalkerEventName = "Doomwalker"
GroupCalendar_cDoomLordKazzakEventName = "Doom Lord Kazzak"

-- WotLK dungeons

GroupCalendar_cAhnkaletEventName = "Ahn'kahet: The Old Kingdom"
GroupCalendar_cAzjolNerubEventName = "Azjol-Nerub"
GroupCalendar_cCullingEventName = "CoT: The Culling of Stratholme"
GroupCalendar_cDrakTharonEventName = "Drak'Tharon Keep"
GroupCalendar_cGundrakEventName = "Gun'Drak"
GroupCalendar_cTheNexusEventName = "The Nexus"
GroupCalendar_cTheOculusEventName = "The Oculus"
GroupCalendar_cHallsofLightningEventName = "Ulduar: Halls of Lightning"
GroupCalendar_cHallsofStoneEventName = "Ulduar: Halls of Stone"
GroupCalendar_cUtgardeEventName = "Utgarde Keep"
GroupCalendar_cSUtgardePinnacleEventName = "Utgarde Pinnacle"
GroupCalendar_cTheVioletHoldEventName = "Violet Hold"
GroupCalendar_cChampionEventName = "Trial of the Champion"
GroupCalendar_cForgeOfSoulsEventName = "The Forge of Souls"
GroupCalendar_cHallsOfReflectionEventName = "Halls of Reflection"
GroupCalendar_cPitOfSaronEventName = "Pit of Saron"
GroupCalendar_cAhnkaletHEventName = "Ahn'kahet: The Old Kingdom (Heroic)"
GroupCalendar_cAzjolNerubHEventName = "Azjol-Nerub (Heroic)"
GroupCalendar_cCullingHEventName = "CoT: The Culling of Stratholme (Heroic)"
GroupCalendar_cDrakTharonHEventName = "Drak'Tharon Keep (Heroic)"
GroupCalendar_cGundrakHEventName = "Gun'Drak (Heroic)"
GroupCalendar_cTheNexusHEventName = "The Nexus (Heroic)"
GroupCalendar_cTheOculusHEventName = "The Oculus (Heroic)"
GroupCalendar_cHallsofLightningHEventName = "Ulduar: Halls of Lightning (Heroic)"
GroupCalendar_cHallsofStoneHEventName = "Ulduar: Halls of Stone (Heroic)"
GroupCalendar_cUtgardeHEventName = "Utgarde Keep (Heroic)"
GroupCalendar_cUtgardePinnacleHEventName = "Utgarde Pinnacle (Heroic)"
GroupCalendar_cTheVioletHoldHEventName = "Violet Hold (Heroic)"
GroupCalendar_cChampionHEventName = "Trial of the Champion (Heroic)"
GroupCalendar_cForgeOfSoulsHEventName = "The Forge of Souls (Heroic)"
GroupCalendar_cHallsOfReflectionHEventName = "Halls of Reflection (Heroic)"
GroupCalendar_cPitOfSaronHEventName = "Pit of Saron (Heroic)"

-- WotLK raids

GroupCalendar_cNaxxEventName = "Naxxramas (10 Player)"
GroupCalendar_cNaxxHEventName = "Naxxramas (25 Player)"
GroupCalendar_cEternityEventName = "The Eye of Eternity (10 Player)"
GroupCalendar_cEternityHEventName = "The Eye of Eternity (25 Player)"
GroupCalendar_cObsidianEventName = "The Obsidian Sanctum (10 Player)"
GroupCalendar_cObsidianHEventName = "The Obsidian Sanctum (25 Player)"
GroupCalendar_cArchavonEventName = "Vault of Archavon (10 Player)"
GroupCalendar_cArchavonHEventName = "Vault of Archavon (25 Player)"
GroupCalendar_cUlduarEventName = "Ulduar (10 Player)"
GroupCalendar_cUlduarHEventName = "Ulduar (25 Player)"
GroupCalendar_cCrusaderEventName = "Trial of the Crusader (10 Player)"
GroupCalendar_cCrusaderHEventName = "Trial of the Crusader (25 Player)"
GroupCalendar_cGrandCrusaderEventName = "Trial of the Grand Crusader (10 Player)"
GroupCalendar_cGrandCrusaderHEventName = "Trial of the Grand Crusader (25 Player)"
GroupCalendar_cIcecrownCitadelEventName = "Icecrown Citadel (10 Player)"
GroupCalendar_cIcecrownCitadelHEventName = "Icecrown Citadel (25 Player)"
GroupCalendar_cRubyEventName = "The Ruby Sanctum (10 Player)"
GroupCalendar_cRubyHEventName = "The Ruby Sanctum (25 Player)"

-- Resets

GroupCalendar_cZGResetEventName = "Zul'Gurub Resets"
GroupCalendar_cMCResetEventName = "Molten Core Resets"
GroupCalendar_cOnyxiaResetEventName = "Onyxia Resets"
GroupCalendar_cBWLResetEventName = "Blackwing Lair Resets"
GroupCalendar_cAQRResetEventName = "Ruins of Ahn'Qiraj Resets"
GroupCalendar_cAQTResetEventName = "Ahn'Qiraj Temple Resets"
GroupCalendar_cNaxxResetEventName = "Naxxramas Resets"
GroupCalendar_cKarazhanResetEventName = "Karazhan Resets"
GroupCalendar_cZulAmanResetEventName = "Zul'Aman Resets"
GroupCalendar_cBlackTempleResetEventName = "Black Temple Resets"
GroupCalendar_cTheEyeResetEventName = "The Eye Resets"
GroupCalendar_cSerpentshrineResetEventName = "Serpentshrine Resets"
GroupCalendar_cMagtheridonResetEventName = "Magtheridon Resets"
GroupCalendar_cHyjalResetEventName = "Mount Hyjal Resets"
GroupCalendar_cGruulResetEventName = "Gruul's Lair Resets"
GroupCalendar_cSunwellResetEventName = "Sunwell Plateau Resets"

GroupCalendar_cTransmuteCooldownEventName = "Transmute Available"
GroupCalendar_cAlchemyResearchCooldownEventName = "Alchemy Research Available"
GroupCalendar_cSaltShakerCooldownEventName = "Salt Shaker Available"
GroupCalendar_cMoonclothCooldownEventName = "Mooncloth Available"
GroupCalendar_cPrimalMoonclothCooldownEventName = "Primal Mooncloth Available"
GroupCalendar_cSpellclothCooldownEventName = "Spellcloth Available"
GroupCalendar_cShadowclothCooldownEventName = "Shadowcloth Available"
GroupCalendar_cEbonweaveCooldownEventName = "Ebonweave Available"
GroupCalendar_cSpellweaveCooldownEventName = "Spellweave Available"
GroupCalendar_cMoonshroudCooldownEventName = "Moonshroud Available"
GroupCalendar_cSnowmasterCooldownEventName = "SnowMaster 9000 Available"
GroupCalendar_cBrilliantGlassCooldownEventName = "Brilliant Glass Available"
GroupCalendar_cVoidShatterCooldownEventName = "Void Shatter Available"
GroupCalendar_cVoidSphereCooldownEventName = "Void Sphere Available"
GroupCalendar_cInscriptionCooldownEventName = "Inscription Research Available"
GroupCalendar_cInscription2CooldownEventName = "Northrend Inscription Research Available"
GroupCalendar_cTitansteelCooldownEventName = "Smelt Titansteel Available"

GroupCalendar_cPersonalEventOwner = "Private"

GroupCalendar_cRaidInfoMCName = GroupCalendar_cMCEventName
GroupCalendar_cRaidInfoOnyxiaName = GroupCalendar_cOnyxiaEventName
GroupCalendar_cRaidInfoZGName = GroupCalendar_cZGEventName
GroupCalendar_cRaidInfoBWLName = GroupCalendar_cBWLEventName
GroupCalendar_cRaidInfoAQRName = GroupCalendar_cAQREventName
GroupCalendar_cRaidInfoAQTName = GroupCalendar_cAQTEventName
GroupCalendar_cRaidInfoNaxxName = GroupCalendar_cNaxxEventName
GroupCalendar_cRaidInfoKarazhanName = GroupCalendar_cKarazhanEventName
GroupCalendar_cRaidInfoZulAmanName = GroupCalendar_cZulAmanEventName
GroupCalendar_cRaidInfoSunwellName = GroupCalendar_cSunwellEventName

-- Race names

GroupCalendar_cDwarfRaceName = "Dwarf"
GroupCalendar_cGnomeRaceName = "Gnome"
GroupCalendar_cHumanRaceName = "Human"
GroupCalendar_cNightElfRaceName = "Night Elf"
GroupCalendar_cOrcRaceName = "Orc"
GroupCalendar_cTaurenRaceName = "Tauren"
GroupCalendar_cTrollRaceName = "Troll"
GroupCalendar_cUndeadRaceName = "Undead"
GroupCalendar_cBloodElfRaceName = "Blood Elf"
GroupCalendar_cDraeneiRaceName = "Draenei"

-- Class names

GroupCalendar_cFemaleDruidClassName = "Druid"
GroupCalendar_cMaleDruidClassName = "Druid"
GroupCalendar_cFemaleHunterClassName = "Hunter"
GroupCalendar_cMaleHunterClassName = "Hunter"
GroupCalendar_cFemaleMageClassName = "Mage"
GroupCalendar_cMaleMageClassName = "Mage"
GroupCalendar_cFemalePaladinClassName = "Paladin"
GroupCalendar_cMalePaladinClassName = "Paladin"
GroupCalendar_cFemalePriestClassName = "Priest"
GroupCalendar_cMalePriestClassName = "Priest"
GroupCalendar_cFemaleRogueClassName = "Rogue"
GroupCalendar_cMaleRogueClassName = "Rogue"
GroupCalendar_cFemaleShamanClassName = "Shaman"
GroupCalendar_cMaleShamanClassName = "Shaman"
GroupCalendar_cFemaleWarlockClassName = "Warlock"
GroupCalendar_cMaleWarlockClassName = "Warlock"
GroupCalendar_cFemaleWarriorClassName = "Warrior"
GroupCalendar_cMaleWarriorClassName = "Warrior"
GroupCalendar_cFemaleDeathknightClassName = "Death Knight"
GroupCalendar_cMaleDeathknightClassName = "Death Knight"

-- Plural forms of class names

GroupCalendar_cDruidsClassName = "Druids"
GroupCalendar_cHuntersClassName = "Hunters"
GroupCalendar_cMagesClassName = "Mages"
GroupCalendar_cPaladinsClassName = "Paladins"
GroupCalendar_cPriestsClassName = "Priests"
GroupCalendar_cRoguesClassName = "Rogues"
GroupCalendar_cShamansClassName = "Shamans"
GroupCalendar_cWarlocksClassName = "Warlocks"
GroupCalendar_cWarriorsClassName = "Warriors"
GroupCalendar_cDeathknightsClassName = "Death Knights"

-- ClassColorNames are the indices for the RAID_CLASS_COLORS array found in FrameXML\Fonts.xml
-- in the English version of WoW these are simply the class names in caps, I don't know if that's
-- true of other languages so I'm putting them here in case they need to be localized

GroupCalendar_cDruidClassColorName = "DRUID"
GroupCalendar_cHunterClassColorName = "HUNTER"
GroupCalendar_cMageClassColorName = "MAGE"
GroupCalendar_cPaladinClassColorName = "PALADIN"
GroupCalendar_cPriestClassColorName = "PRIEST"
GroupCalendar_cRogueClassColorName = "ROGUE"
GroupCalendar_cShamanClassColorName = "SHAMAN"
GroupCalendar_cWarlockClassColorName = "WARLOCK"
GroupCalendar_cWarriorClassColorName = "WARRIOR"
GroupCalendar_cDeathknightClassColorName = "DEATHKNIGHT"

-- Label forms of the class names for the attendance panel.  Usually just the plural
-- form of the name followed by a colon

GroupCalendar_cDruidsLabel = GroupCalendar_cDruidsClassName..":"
GroupCalendar_cHuntersLabel = GroupCalendar_cHuntersClassName..":"
GroupCalendar_cMagesLabel = GroupCalendar_cMagesClassName..":"
GroupCalendar_cPaladinsLabel = GroupCalendar_cPaladinsClassName..":"
GroupCalendar_cPriestsLabel = GroupCalendar_cPriestsClassName..":"
GroupCalendar_cRoguesLabel = GroupCalendar_cRoguesClassName..":"
GroupCalendar_cShamansLabel = GroupCalendar_cShamansClassName..":"
GroupCalendar_cWarlocksLabel = GroupCalendar_cWarlocksClassName..":"
GroupCalendar_cWarriorsLabel = GroupCalendar_cWarriorsClassName..":"
GroupCalendar_cDeathknightsLabel = GroupCalendar_cDeathknightsClassName..":"

GroupCalendar_cTimeLabel = "Time:"
GroupCalendar_cDurationLabel = "Duration:"
GroupCalendar_cEventLabel = "Event:"
GroupCalendar_cTitleLabel = "Title:"
GroupCalendar_cLevelsLabel = "Levels:"
GroupCalendar_cLevelRangeSeparator = "to"
GroupCalendar_cDescriptionLabel = "Description:"
GroupCalendar_cCommentLabel = "Comment:"

CalendarEditor_cNewEvent = "New Event..."
CalendarEditor_cEventsTitle = "Events"
CalendarEditor_cPasteEvent = "Paste Event"
CalendarEditor_cCopyEvent = "Copy"

CalendarEvent_cNotAttending = "Not attending"
CalendarEvent_cConfirmed = "Confirmed"
CalendarEvent_cDeclined = "Declined"
CalendarEvent_cStandby = "On Standby List"
CalendarEvent_cMaybe = "Maybe attending"
CalendarEvent_cPending = "Pending"
CalendarEvent_cBanned = "Banned"
CalendarEvent_cUnknownStatus = "Unknown %s"

GroupCalendar_cChannelNameLabel = "Channel:"
GroupCalendar_cPasswordLabel = "Password:"

GroupCalendar_cSingleTimeDateFormat = "%s %s"
GroupCalendar_cTimeDateRangeFormat = "%s from %s to %s"

GroupCalendar_cPluralMinutesFormat = "%d minutes"
GroupCalendar_cSingularHourFormat = "%d hour"
GroupCalendar_cPluralHourFormat = "%d hours"
GroupCalendar_cSingularHourPluralMinutes = "%d hour %d minutes"
GroupCalendar_cPluralHourPluralMinutes = "%d hours %d minutes"

if string.sub(GetLocale(), -2) == "US" then
	GroupCalendar_cLongDateFormat = "$month $day, $year"
	GroupCalendar_cShortDateFormat = "$monthNum/$day"
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $month $day, $year"
else
	GroupCalendar_cLongDateFormat = "$day. $month $year"
	GroupCalendar_cShortDateFormat = "$day.$monthNum"
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $day. $month $year"
end

GroupCalendar_cNotAttendingCategory = "Not attending"
GroupCalendar_cAttendingCategory = "Attending"
GroupCalendar_cPendingApprovalCategory = "Pending requests and changes"
GroupCalendar_cStandbyCategory = "Standby"
GroupCalendar_cMaybeCategory = "Maybe"
GroupCalendar_cWhispersCategory = "Recent whispers"
GroupCalendar_cBannedCategory = "Banned"

GroupCalendar_cClassAttendanceNameFormat = "$name ($level $class)"
GroupCalendar_cStatusAttendanceNameFormat = "$name ($status $role)"
GroupCalendar_cRoleAttendanceNameFormat = "$name ($level $role)"

GroupCalendar_cNumPlayersPlusStandbyFormat = "%d "..HIGHLIGHT_FONT_COLOR_CODE.."(+%d)"..FONT_COLOR_CODE_CLOSE
GroupCalendar_cNumPlayersFormat = "%d"

GroupCalendar_cTotalNumPlayersFormat = "%s players"

BINDING_HEADER_GROUPCALENDAR_TITLE = "Group Calendar"
BINDING_NAME_GROUPCALENDAR_TOGGLE = "Toggle GroupCalendar"

GroupCalendar_cCharactersLabel = "Character:"

GroupCalendar_cPending = "Pending"
GroupCalendar_cConfirmed = "Accepted"
GroupCalendar_cStandby = "Standby"
GroupCalendar_cMaybe = "Maybe Attending"
GroupCalendar_cDeclined = "Not Attending"
GroupCalendar_cBanned = "Banned"
GroupCalendar_cRemove = "Remove"
GroupCalendar_cEditPlayer = "Edit Player..."
GroupCalendar_cInviteNow = "Invite to group"
GroupCalendar_cStatus = "Status"
GroupCalendar_cAddPlayerEllipses = "Add player..."

GroupCalendar_cAddPlayer = "Add player"
GroupCalendar_cPlayerLevel = "Level:"
GroupCalendar_cPlayerClassLabel = "Class:"
GroupCalendar_cPlayerRaceLabel = "Race:"
GroupCalendar_cPlayerStatusLabel = "Status:"
GroupCalendar_cRankLabel = "Guild rank:"
GroupCalendar_cGuildLabel = "Guild:"
GroupCalendar_cRoleLabel = "Role:"
GroupCalendar_cSave = "Save"
GroupCalendar_cLastWhisper = "Last whisper:"
GroupCalendar_cReplyWhisper = "Whisper reply:"

GroupCalendar_cUnknown = "Unknown"
GroupCalendar_cAutoConfirmationTitle = "Auto Confirm by Class"
GroupCalendar_cRoleConfirmationTitle = "Auto Confirm by Role"
GroupCalendar_cManualConfirmationTitle = "Manual Confirmations"
GroupCalendar_cClosedEventTitle = "Closed Event"
GroupCalendar_cMinLabel = "min"
GroupCalendar_cMaxLabel = "max"

GroupCalendar_cAddPlayerTitle = "Add..."
GroupCalendar_cAutoConfirmButtonTitle = "Settings..."

GroupCalendar_cClassLimitDescription = "Set the minimum and maximum number of players for each class.  Minimums will be met first, extra spots beyond the minimum will be filled until the maximum is reached or the group is full."
GroupCalendar_cRoleLimitDescription = "Set the minimum and maximum numbers of players for each role.  Minimums will be met first, extra spots beyond the minimum will be filled until the maximum is reached or the group is full.  You can also reserve spaces within each role for particular classes (requiring one ranged dps to be a shadow priest for example)"

GroupCalendar_cViewGroupBy = "Group by"
GroupCalendar_cViewByStatus = "Status"
GroupCalendar_cViewByClass = "Class"
GroupCalendar_cViewByRole = "Role"
GroupCalendar_cViewSortBy = "Sort by"
GroupCalendar_cViewByDate = "Date"
GroupCalendar_cViewByRank = "Rank"
GroupCalendar_cViewByName = "Name"

GroupCalendar_cMaxPartySizeLabel = "Maximum party size:"
GroupCalendar_cMinPartySizeLabel = "Minimum party size:"
GroupCalendar_cNoMinimum = "No minimum"
GroupCalendar_cNoMaximum = "No maximum"
GroupCalendar_cPartySizeFormat = "%d players"

GroupCalendar_cInviteButtonTitle = "Invite Selected"
GroupCalendar_cAutoSelectButtonTitle = "Select Players..."
GroupCalendar_cAutoSelectWindowTitle = "Select Players"

GroupCalendar_cNoSelection = "No players selected"
GroupCalendar_cSingleSelection = "1 player selected"
GroupCalendar_cMultiSelection = "%d players selected"

GroupCalendar_cInviteNeedSelectionStatus = "Select players to be invited"
GroupCalendar_cInviteReadyStatus = "Ready to invite"
GroupCalendar_cInviteInitialInvitesStatus = "Sending initial invitations"
GroupCalendar_cInviteAwaitingAcceptanceStatus = "Waiting for initial acceptance"
GroupCalendar_cInviteConvertingToRaidStatus = "Converting to raid"
GroupCalendar_cInviteInvitingStatus = "Sending invitations"
GroupCalendar_cInviteCompleteStatus = "Invitations completed"
GroupCalendar_cInviteReadyToRefillStatus = "Ready to fill vacant slots"
GroupCalendar_cInviteNoMoreAvailableStatus = "No more players available to fill the group"
GroupCalendar_cRaidFull = "Raid full"

GroupCalendar_cInviteWhisperFormat = "[Group Calendar] You are being invited to the event '%s'.  Please accept the invitation if you wish to join this event."
GroupCalendar_cAlreadyGroupedWhisper = "[Group Calendar] You are already in a group.  Please /w back when you leave your group."

GroupCalendar_cJoinedGroupStatus = "Joined"
GroupCalendar_cInvitedGroupStatus = "Invited"
GroupCalendar_cReadyGroupStatus = "Ready"
GroupCalendar_cGroupedGroupStatus = "In another group"
GroupCalendar_cStandbyGroupStatus = "Standby"
GroupCalendar_cMaybeGroupStatus = "Maybe"
GroupCalendar_cDeclinedGroupStatus = "Declined invitation"
GroupCalendar_cOfflineGroupStatus = "Offline"
GroupCalendar_cLeftGroupStatus = "Left group"

GroupCalendar_cPriorityLabel = "Priority:"
GroupCalendar_cPriorityDate = "Date"
GroupCalendar_cPriorityRank = "Rank"

GroupCalendar_cConfirmSelfUpdateMsg = "%s"
GroupCalendar_cConfirmSelfUpdateParamFormat = "Changes have been made to the events for $mUserName from another computer.  If you use multiple computers or you crashed or re-installed the game then you should choose Update to restore your events.  Choose Delete if you believe changes should not have been made from another computer."
GroupCalendar_cConfirmSelfRSVPUpdateParamFormat = "Changes have been made to the attendance requests for $mUserName from another computer.  If you use multiple computers or you crashed or re-installed the game then you should choose Accept to restore your attendance requests.  Choose Delete if you believe changes should not have been made from another computer."
GroupCalendar_cUpdate = "Update"

GroupCalendar_cConfirmClearWhispers = "Clear all recent whispers?"
GroupCalendar_cClear = "Clear"

CalendarDatabases_cTitle = "Group Calendar Versions"
CalendarDatabases_cRefresh = "Refresh"
CalendarDatabases_cRefreshDescription = "Requests online players to send their version numbers.  It may take several minutes for version numbers to update.  Updates received while this window is closed will still be recorded and can be viewed at a later time."

GroupCalendar_cVersionFormat = "Group Calendar v%s"
GroupCalendar_cShortVersionFormat = "v%s"
GroupCalendar_cVersionUpdatedFormat = "as of %s %s (local time)"
GroupCalendar_cVersionUpdatedUnknown = "Date version info was last seen is unknown"

GroupCalendar_cToggleVersionsTitle = "Show Player Versions"
GroupCalendar_cToggleVersionsDescription = "Shows what version of Group Calendar other players are running"

GroupCalendar_cChangesDelayedMessage = "Group Calendar: Changes made while synchronizing with the network will not be sent until synchronization is completed."

GroupCalendar_cConfirmKillMsg = "Are you sure you want to force the events from %s out of the network?"; 
GroupCalendar_cKill = "Kill"

GroupCalendar_cNotAnOfficerError = "Only guild officers are not allowed to do that"
GroupCalendar_cUserNameExpected = "Expected user name"
GroupCalendar_cDatabaseNotFoundError = "Database for %s not found."
GroupCalendar_cCantKillGuildieError = "Can't purge a user who's in your guild"

GroupCalendar_cTooltipScheduleItemFormat = "%s (%s)"

GroupCalendar_cAvailableMinutesFormat = "%s in %d minutes"
GroupCalendar_cAvailableMinuteFormat = "%s in %d minute"
GroupCalendar_cStartsMinutesFormat = "%s starts in %d minutes"
GroupCalendar_cStartsMinuteFormat = "%s starts in %d minute"
GroupCalendar_cStartingNowFormat = "%s is starting now"
GroupCalendar_cAlreadyStartedFormat = "%s has already started"
GroupCalendar_cHappyBirthdayFormat = "Happy birthday %s!"

GroupCalendar_cTimeRemainingFormat = "(%d:%02d remaining)"
GroupCalendar_cUnknownEventType = "%s (New event type, upgrade your GroupCalendar)"

GroupCalendar_cConfirmResetMsg = "Are you sure you want to reset the calendar for %s? All events and requests for this character will be deleted."
GroupCalendar_cConfirmResetRealmMsg = "Are you sure you want to reset the calendars for all of your characters on %s? All events will be deleted for all of your characters on this server."
GroupCalendar_cConfirmResetAllMsg = "Are you sure you want to reset the calendars for all of your characters on all realms? All events will be deleted for all of your characters on all servers."
GroupCalendar_cReset = "Reset"

GroupCalendar_cNone = "None"

GroupCalendar_cAttendanceNote = "You have changed your attendance status for %s.  Please allow one minute before logging off to ensure your request is forwarded to the network.  Your status will show as Pending until the event creator logs on."
GroupCalendar_cUnknownClockOption = "Unknown clock option"
GroupCalendar_cBadAgeValue = "The maximum event age must be between 1 and 60 days"
GroupCalendar_cViewMenuFormat = "View by %s/%s"
GroupCalendar_cDefaultTimeFormat = 12
GroupCalendar_cDefaultStartDay = "Sun"
GroupCalendar_cForeignRealmFormat = "%s of %s"

GroupCalendar_cMHRole = "Healer"
GroupCalendar_cOHRole = "Off-healer"
GroupCalendar_cMTRole = "Tank"
GroupCalendar_cOTRole = "Off-tank"
GroupCalendar_cRDRole = "Ranged"
GroupCalendar_cMDRole = "Melee"

GroupCalendar_cMHPluralRole = "Healers"
GroupCalendar_cOHPluralRole = "Off-healers"
GroupCalendar_cMTPluralRole = "Tanks"
GroupCalendar_cOTPluralRole = "Off-tanks"
GroupCalendar_cRDPluralRole = "Ranged"
GroupCalendar_cMDPluralRole = "Melee"

GroupCalendar_cMHPluralLabel = GroupCalendar_cMHPluralRole..":"
GroupCalendar_cOHPluralLabel = GroupCalendar_cOHPluralRole..":"
GroupCalendar_cMTPluralLabel = GroupCalendar_cMTPluralRole..":"
GroupCalendar_cOTPluralLabel = GroupCalendar_cOTPluralRole..":"
GroupCalendar_cRDPluralLabel = GroupCalendar_cRDPluralRole..":"
GroupCalendar_cMDPluralLabel = GroupCalendar_cMDPluralRole..":"

GroupCalendar_cClockNotSetWarning = "WARNING: %s indicate that their clocks are set significantly different than yours.  Check your time, date and time zone settings as this may cause problems with posting or signing up for events, especially if you log in from multiple computers."

GroupCalendar.cWhisperSummaryDateHeader    = "%s"
GroupCalendar.cWhisperSummaryEvent         = "    $time $event [ID $id]"
GroupCalendar.cWhisperSummaryEventStatus   = "    $time $event [ID $id] ($status)"
GroupCalendar.cWhisperSummaryNoEvents      = "No upcoming events"
GroupCalendar.cWhisperSummaryInvalidOption = "%s is not a valid option.  Use '!gc help' to get a list of available commands"

GroupCalendar.cWhisperHelp =
{
	"!gc - Same thing as !gc summary",
	"!gc summary - Lists events for the next seven days",
	"!gc yes eventid - Signs up for an event as Attending",
	"!gc no eventid - Signs up for an event as Not Attending",
	"!gc maybe eventid - Sign up for an event as a Maybe Attending",
	"!gc help - Shows this list of commands",
	"Event IDs appear in the summary of events.  If the event was created by the same character that you're whispering you can just use the number, otherwise use the name-number format to specify the event"
}

GroupCalendar.cDatabasesTotalFormat = "%d databases"

GroupCalendar_cConfirmDeleteRSVP = "Are you sure you want to remove %s from the list?"

GroupCalendar.cCantReloadUI = GroupCalendar_cTitleVersion.." includes new files which World of Warcraft won't load until you restart the game.  Group Calendar can not work until you restart Warcraft."

GroupCalendar.cWhisperAccessDenied = "Access to events for %s is denied"
GroupCalendar.cWhisperCantProxy = "You must whisper %s or one of their alts to sign up for that event"
GroupCalendar.cWhisperDatabaseNotFound = "Database for %s not found"
GroupCalendar.cWhisperEventNotFound = "Event ID %d was not found in the database for %s"
GroupCalendar.cWhisperFailed = "Request failed for an unknown reason.  Have the organizer add you manually instead."
GroupCalendar.cWhisperNotGuildmate = "Event signups for players outside the guild are not supported yet"
GroupCalendar.cWhisperEventStatus = "Your status for %s on %s at %s is now %s"
GroupCalendar.cWhisperAllDayStatus = "Your status for %s on %s is now %s"
GroupCalendar.cWhisperWTFError = "Unable to decipher the event ID '%s'"
GroupCalendar.cWhisperHelpReminder = "Whisper '!gc help' for more commands"

GroupCalendar.cAttendanceNoticeYes = "$name will be attending $event on $date"
GroupCalendar.cAttendanceNoticeLimitStandby = "Putting $name on standby for $event on $date: Class or role limit already reached"
GroupCalendar.cAttendanceNoticeStandby = "$name will be available as a standby player for $event on $date"
GroupCalendar.cAttendanceNoticeNo = "$name will not be attending $event on $date"
GroupCalendar.cAttendanceNoticeBanned = "Discarding request from $name for $event on $date: Player was banned from the event"
GroupCalendar.cAttendanceNoticeManual = "Putting $name on standby for $event on $date: Event requires you to confirm attendees"
GroupCalendar.cAttendanceUnknownQualifiedError = "You are not qualified for this event, but the software did not report a reason"
GroupCalendar.cAttendanceNoticeMaybe = "$name might be attending $event on $date"

GroupCalendar.cAttendanceClosedEvent = "The event or a closed event -- all players must be manually added by the owner"
GroupCalendar.cAttendanceUnknownLevel = "The event has level restrictions and your level is unknown"
GroupCalendar.cAttendanceLevelTooLow = "Your level is too low for this event"
GroupCalendar.cAttendanceLevelTooHigh = "Your level is too high for this event"
GroupCalendar.cAttendanceGuildMembersOnly = "This event is for members of <%s> only"
GroupCalendar.cAttendanceRankTooLow = "Your guild rank is too low to attend this event"
GroupCalendar.cAttendanceNotAllowed = "You are not permitted to access this calendar"
GroupCalendar.cAttendanceSynching = "Group Calendar is synchronizing with the network.  Try again in a few minutes."

GroupCalendar.cNewerVersionMessage = "A newer version is available (%s)"

GroupCalendar.cBackupTitle = "Backup and Restore"
GroupCalendar.cNoBackups = "No backups have been made yet.  A backup will be automatically made if your calendar is modified on another computer, or you can use the 'Backup Now' button."
GroupCalendar.cBackupNow = "Backup Now"
GroupCalendar.cBackupNowDescription = "Saves a copy of the events and attendance requests for %s."
GroupCalendar.cConfirmDeleteBackup = "Are you sure you want to delete the backup from %s?"
GroupCalendar.cConfirmRestoreBackup = "Are you sure you want to restore the backup from %s?"
GroupCalendar.cRestoreBackup = "Restore"
GroupCalendar.cBackupRestored = "The backup has been restored.  The restored events should begin appearing for other players within a minute or two."

GroupCalendar.cNetworkSyncComplete = "Network synchronization completed"

GroupCalendar.cMinimapButtonHint = "Left-click to show Group Calendar."
GroupCalendar.cMinimapButtonHint2 = "Right-click to show the WoW calendar."

GroupCalendar.cDoubleOwnerError = "$SenderName is claiming to be the owner of the database for $DatabaseOwner, but your copy of Group Calendar thinks that you're the owner.  Use the command '/cal disown $DatabaseOwner' if you are not the owner of $DatabaseOwner's events."
GroupCalendar.cDontHaveDatabaseError = "You don't have a database for %s"
GroupCalendar.cDontOwnDatabaseError = "You don't own the database for %s"
GroupCalendar.cDatabaseDisownedMessage = "Database for %s is no longer considered to be part of your account"

GroupCalendar.cBlizzardOwner = "Blizzard"
GroupCalendar.cAllDay = "All day"

GroupCalendar.cName = "Name"
GroupCalendar.cVersion = "Version"

GroupCalendar.cResetVersions = "Reset"
GroupCalendar.cResetVersionsDescription = "Clear this list so that only versions seen online after clicking this button will be displayed"
GroupCalendar.cAskResetVersions = "Are you sure you want to reset the version list?  No events will be affected, but Group Calendar's memory of what version players are running will be erased.  Players will not show up again until they are seen online."

GroupCalendar.cRSVPConfirmMessage =
{
	Y = "$name is confirmed to attend $event on $date",
	S = "$name is on standby for $event on $date",
}
