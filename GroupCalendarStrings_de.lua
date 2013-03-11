﻿if GetLocale() == "deDE" then
	GroupCalendar_cTitle = "GroupCalendar v%s"
	
	GroupCalendar.cSingleItemFormat = "%s"
	GroupCalendar.cTwoItemFormat = "%s und %s"
	GroupCalendar.cMultiItemFormat = "%s{{, %s}} und %s"

	GroupCalendar_cSun = "So"
	GroupCalendar_cMon = "Mo"
	GroupCalendar_cTue = "Di"
	GroupCalendar_cWed = "Mi"
	GroupCalendar_cThu = "Do"
	GroupCalendar_cFri = "Fr"
	GroupCalendar_cSat = "Sa"

	GroupCalendar_cSunday = "Sonntag"
	GroupCalendar_cMonday = "Montag"
	GroupCalendar_cTuesday = "Dienstag"
	GroupCalendar_cWednesday = "Mittwoch"
	GroupCalendar_cThursday = "Donnerstag"
	GroupCalendar_cFriday = "Freitag"
	GroupCalendar_cSaturday = "Samstag"

	GroupCalendar_cSelfWillAttend = "%s wird teilnehmen"
	GroupCalendar_cGuildOnly = "Nur für Mitglieder von %s"

	GroupCalendar_cMonthNames = {"Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"}
	GroupCalendar_cDayOfWeekNames = {GroupCalendar_cSunday, GroupCalendar_cMonday, GroupCalendar_cTuesday, GroupCalendar_cWednesday, GroupCalendar_cThursday, GroupCalendar_cFriday, GroupCalendar_cSaturday}

	GroupCalendar_cLoadMessage = "GroupCalendar geladen. Gib '/cal show' zur Anzeige ein"
	GroupCalendar_cInitializingGuilded = "GroupCalendar: Initialisiere Einstellungen für Gildenmitglieder"
	GroupCalendar_cInitializingUnguilded = "GroupCalendar: Initialisiere Einstellungen für andere Spieler"
	GroupCalendar_cLocalTimeNote = "(%s lokale Zeit)"

	GroupCalendar_cOptions = "Setup..."

	GroupCalendar_cCalendar = "Kalender"
	GroupCalendar_cSetup = "Konfiguration"
	GroupCalendar_cBackup = "Backup"
	GroupCalendar_cAbout = "Über"

	GroupCalendar_cUseServerDateTime = "Benutze Server-Zeitformat"
	GroupCalendar_cUseServerDateTimeDescription = "Aktivieren, um Events im Server-Zeitformat anzuzeigen. Deaktivieren, um Events im lokalen Zeitformat anzuzeigen."

	GroupCalendar_cSetupTitle = "Calendar Konfiguration"
	GroupCalendar_cConfigModeLabel = "Konfiguration:"
	GroupCalendar_cAutoChannelConfig = "Automatische Einrichtung"
	GroupCalendar_cManualChannelConfig = "Manuelle Einrichtung"
	GroupCalendar_cAdminChannelConfig = "Administrator"

	GroupCalendar_cUseGuildChannel = "Benutze Gilden-Datenchannel"
	GroupCalendar_cUseGuildChannelDescription = "Verwendet den integrierten Datenchannel der Gilde. Niemand au�erhalb der Gilde kann darauf zugreifen."

	GroupCalendar_cUseSharedChannel = "Benutze öffentlichen Datenchannel"
	GroupCalendar_cUseSharedChannelDescription = "Verwendet einen öffentlichen Chatkanal. Jeder Spieler eurer Fraktion kann darauf zugreifen, also solltet ihr den Zugriff mit einem Passwort beschränken."

	GroupCalendar_cApplyChannelChanges = "Übernehmen"
	GroupCalendar_cManualConfigTipDescription = "Manuelle Eingabe des Datenchannels und dessen Passwort."
	GroupCalendar_cStoreAutoConfigTipDescription = "Erlaubt es einem Offizier die Channel-Konfiguration in den Notizen des angegebenen Gildenmitglieds zu speichern."
	GroupCalendar_cAutoConfigPlayerTipDescription = "Der Name des Gildenmitglieds das die Konfigurationsdaten speichert."
	GroupCalendar_cChannelNameTipTitle = "Channel-Name"
	GroupCalendar_cChannelNameTipDescription = "Der Name des Chatkanals in welchem die Kalenderdaten zwischen den Spielern ausgetauscht werden"
	GroupCalendar_cConnectChannel = "Verbinden"
	GroupCalendar_cDisconnectChannel = "Trennen"
	GroupCalendar_cChannelStatus =
	{
		Starting = {mText = "Status: Initialisiere...", mColor = {r = 1, g = 1, b = 0.3}},
		Synching = {mText = "Status: Synchronisiere mit Netzwerk %s", mColor = {r = 0.3, g = 1, b = 0.3}},
		Suspended = {mText = "Status: Getrennt (Logge aus)", mColor = {r = 1, g = 1, b = 0.3}},
		Connected = {mText = "Status: Mit Datenchannel verbunden", mColor = {r = 0.3, g = 1, b = 0.3}},
		Disconnected = {mText = "Status: Nicht mit Datenchannel verbunden.", mColor = {r = 1, g = 0.2, b = 0.4}},
		Initializing = {mText = "Status: Verbinde mit Datenchannel...", mColor = {r = 1, g = 1, b = 0.3}},
		Error = {mText = "Fehler: %s", mColor = {r = 1, g = 0.2, b = 0.4}},
	}

	GroupCalendar_cConnected = "Verbunden"
	GroupCalendar_cDisconnected = "Getrennt"
	GroupCalendar_cTooManyChannels = "Man kann höchstens in 10 Channels gleichzeitig sein"
	GroupCalendar_cJoinChannelFailed = "Fehler beim Betreten des Channels"
	GroupCalendar_cWrongPassword = "Falsches Passwort"
	GroupCalendar_cAutoConfigNotFound = "Keine Daten in Gilden-Notizen gefunden"
	GroupCalendar_cErrorAccessingNote = "Fehler beim Empfangen der Konfigurationsdaten"

	GroupCalendar_cTrustConfigTitle = "Konfiguration Berechtigungen"
	GroupCalendar_cTrustConfigDescription = "Legt fest, wer dir Events schicken darf. Es wird NICHT festgelegt wer Events in deinem Kalender sehen kann.  Benutze ein Passwort für den Datenchannel, um zu verhindern, dass jeder deinen Kalender sehen kann."
	GroupCalendar_cTrustGroupLabel = "Berechtigt:"
	GroupCalendar_cEvent = "Event"
	GroupCalendar_cEdit = "Edit"
	GroupCalendar_cAttendance = "Anmeldungen"

	GroupCalendar_cAboutTitle = "Über GroupCalendar"
	GroupCalendar_cTitleVersion = "GroupCalendar v"..GroupCalendar.VersionString

	GroupCalendar.cAuthor = "Programmierung und Design von John Stephen mit Hilfe von %s"
	GroupCalendar_cTestersTitle = "Tester für 4.3"
	GroupCalendar_cSpecialThanksTitle = "Speziellen Dank für ihren Einsatz an"
	GroupCalendar.cTranslationCredit = "Übersetzungen von %s"
	GroupCalendar_cGuildURL = "In memory of David Ramirez - 2009\r\rwobbleworks.com"

	GroupCalendar_cRebuildDatabase = "Datenbank erneuern"
	GroupCalendar_cRebuildDatabaseDescription = "Erstellt die Event-Datenbank deines Charakters neu. Dies kann Probleme beheben, wenn andere Spieler nicht alle deine Events sehen können. Es besteht ein geringes Risiko das einige Anmeldungs-Bestätigungen verloren gehen können."

	GroupCalendar_cTrustGroups =
	{
		"Jeder mit Zugriff auf den Datenchannel",
		"Alle Gildenmitglieder",
		"Nur Spieler aus der Berechtigungs-Liste"
	}

	GroupCalendar_cTrustAnyone = "Berechtigt jeden mit Zugriff auf den Datenchannel"
	GroupCalendar_cTrustGuildies = "Berechtigt andere Mitglieder deiner Gilde"
	GroupCalendar_cTrustMinRank = "Mindestrang:"
	GroupCalendar_cTrustNobody = "Berechtigt nur Spieler die in der unteren Liste eingetragen sind"
	GroupCalendar_cTrustedPlayers = "Berechtigte Spieler"
	GroupCalendar_cExcludedPlayers = "Ignoriere Events und Anfragen von Spielern:"
	GroupCalendar_cPlayerName = "Name:"
	GroupCalendar_cAddExcluded = "Hinzufügen"
	GroupCalendar_cRemoveExcluded = "Entfernen"

	CalendarEventViewer_cTitle = "Event-Details"
	CalendarEventViewer_cDone = "Fertig"

	CalendarEventViewer_cLevelRangeFormat = "Level %i bis %i"
	CalendarEventViewer_cMinLevelFormat = "Ab Level %i"
	CalendarEventViewer_cMaxLevelFormat = "Bis Level %i"
	CalendarEventViewer_cAllLevels = "Alle Level"
	CalendarEventViewer_cSingleLevel = "Nur Level %i"

	CalendarEventViewer_cYes = "Ja - Ich werde teilnehmen"
	CalendarEventViewer_cNo = "Nein - Ich werde nicht teilnehmen"
	CalendarEventViewer_cMaybe = "Ich nehme vielleicht teil. (Maybe)"

	CalendarEventViewer_cResponseMessage =
	{
		"Status: Nichts gesendet",
		"Status: Warte auf Bestätigung",
		"Status: Bestätigung - Akzeptiert",
		"Status: Bestätigung - Standby",
		"Status: Bestätigung - Nicht teilnehmend",
		"Status: Vom Event ausgeschlossen",
		"Status: Bestätigung - Maybe attending",
		"Status: Bestätigung - Pending approval",
	}

	CalendarEventEditorFrame_cTitle = "Event Neu/Bearbeiten"
	CalendarEvent_cDone = "Fertig"
	CalendarEvent_cDelete = "Löschen"
	CalendarEvent_cGroupTabTitle = "Gruppe"

	CalendarEvent_cConfirmDeleteMsg = "Löschen \"%s\"?"

	-- Event names

	GroupCalendar_cGeneralEventGroup = "Allgemein"
	GroupCalendar_cPersonalEventGroup = "Persönlich (unsichtbar für andere)"
	GroupCalendar_cRaidEventGroup = "Raids"
	GroupCalendar_cDungeonEventGroup = "Instanzen (Azeroth)"
	GroupCalendar_cOutlandsDungeonEventGroup = "Instanzen (Scherbenwelt)"
	GroupCalendar_cOutlandsHeroicDungeonEventGroup = "Heroisch (Scherbenwelt)"
	GroupCalendar_cBattlegroundEventGroup = "PvP"
	GroupCalendar_cOutdoorRaidEventGroup = "Raids im Freien"

	GroupCalendar_cMeetingEventName = "Treffen"
	GroupCalendar_cBirthdayEventName = "Geburtstag"
	GroupCalendar_cRoleplayEventName = "Rollenspiel"
	GroupCalendar_cHolidayEventName = "Feiertag"
	GroupCalendar_cDentistEventName = "Zahnarzt"
	GroupCalendar_cDoctorEventName = "Doktor"
	GroupCalendar_cVacationEventName = "Urlaub"
	GroupCalendar_cOtherEventName = "Anderes"

	GroupCalendar_cAQREventName = "Ruinen von Ahn'Qiraj"
	GroupCalendar_cAQTEventName = "Tempel von Ahn'Qiraj"
	GroupCalendar_cBFDEventName = "Tiefschwarze Grotte"
	GroupCalendar_cBRDEventName = "Schwarzfelstiefen"
	GroupCalendar_cUBRSEventName = "Obere Schwarzfelsspitze"
	GroupCalendar_cLBRSEventName = "Untere Schwarzfelsspitze"
	GroupCalendar_cBWLEventName = "Pechschwingenhort"
	GroupCalendar_cDeadminesEventName = "Die Todesminen"
	GroupCalendar_cDMEventName = "Düsterbruch"
	GroupCalendar_cGnomerEventName = "Gnomeregan"
	GroupCalendar_cMaraEventName = "Maraudon"
	GroupCalendar_cMCEventName = "Geschmolzener Kern"
	GroupCalendar_cOnyxiaEventName = "Onyxias Hort"
	GroupCalendar_cRFCEventName = "Der Flammenschlund"
	GroupCalendar_cRFDEventName = "Hügel der Klingenhauer"
	GroupCalendar_cRFKEventName = "Kral der Klingenhauer"
	GroupCalendar_cSMEventName = "Scharlachrotes Kloster"
	GroupCalendar_cScholoEventName = "Scholomance"
	GroupCalendar_cSFKEventName = "Burg Schattenfang"
	GroupCalendar_cStockadesEventName = "Das Verlies"
	GroupCalendar_cStrathEventName = "Stratholme"
	GroupCalendar_cSTEventName = "Versunkener Tempel"
	GroupCalendar_cUldEventName = "Uldaman"
	GroupCalendar_cWCEventName = "Höhlen des Wehklagens"
	GroupCalendar_cZFEventName = "Zul'Farrak"
	GroupCalendar_cZGEventName = "Zul'Gurub"
	GroupCalendar_cNaxxEventName = "Naxxramas"

	GroupCalendar_cTheEyeEventName = "Festung: Auge des Sturms"
	GroupCalendar_cSerpentshrineEventName = "Echsenkessel: Schlangenschrein"
	GroupCalendar_cMagtheridonEventName = "Höllenfeuer: Magtheridons Kammer"
	GroupCalendar_cHyjalEventName = "HdZ: Hyjal der Vergangenheit"
	GroupCalendar_cKarazhanEventName = "Karazhan"
	GroupCalendar_cZulAmanEventName = "Zul'Aman"
	GroupCalendar_cGruulEventName = "Gruuls Unterschlupf"
	GroupCalendar_cBlackTempleEventName = "Der Schwarze Tempel"

	GroupCalendar_cArcatrazEventName = "Festung: Arkatraz"
	GroupCalendar_cBotanicaEventName = "Festung: Botanikum"
	GroupCalendar_cMechanarEventName = "Festung: Mechanar"

	GroupCalendar_cDurnholdeEventName = "HdZ: Vorgebirge des Alten Hügellandes"
	GroupCalendar_cDarkPortalEventName = "HdZ: Der Schwarze Morast"

	GroupCalendar_cAuchenaiCryptsEventName = "Auchindoun: Auchenaikrypta"
	GroupCalendar_cSethekkHallsEventName = "Auchindoun: Sethekkhallen"
	GroupCalendar_cShadowLabyrinthEventName = "Auchindoun: Schattenlabyrinth"
	GroupCalendar_cManaTombsEventName = "Auchindoun: Managruft"

	GroupCalendar_cSteamvaultEventName = "Echsenkessel: Dampfkammer"
	GroupCalendar_cUnderbogEventName = "Echsenkessel: Tiefensumpf"
	GroupCalendar_cSlavePensEventName = "Echsenkessel: Sklavenunterkünfte"

	GroupCalendar_cShatteredHallsEventName = "Höllenfeuer: Zerschmetterte Hallen"
	GroupCalendar_cFurnaceEventName = "Höllenfeuer: Blutkessel"
	GroupCalendar_cRampartsEventName = "Höllenfeuer: Bollwerk"

	GroupCalendar_cArcatrazHEventName = "Festung: Arcatraz (Heroisch)"
	GroupCalendar_cBotanicaHEventName = "Festung: Botanica (Heroisch)"
	GroupCalendar_cMechanarHEventName = "Festung: Mechanar (Heroisch)"

	GroupCalendar_cDurnholdeHEventName = "HdZ: Vorgebirge des Alten Hügellandes (Heroisch)"
	GroupCalendar_cDarkPortalHEventName = "HdZ: Der Schwarze Morast (Heroisch)"

	GroupCalendar_cAuchenaiCryptsHEventName = "Auchindoun: Auchenaikrypta (Heroisch)"
	GroupCalendar_cSethekkHallsHEventName = "Auchindoun: Sethekkhallen (Heroisch)"
	GroupCalendar_cShadowLabyrinthHEventName = "Auchindoun: Schattenlabyrinth (Heroisch)"
	GroupCalendar_cManaTombsHEventName = "Auchindoun: Managruft (Heroisch)"

	GroupCalendar_cSteamvaultHEventName = "Coilfang: Dampfkammer (Heroisch)"
	GroupCalendar_cUnderbogHEventName = "Coilfang: Tiefensumpf (Heroisch)"
	GroupCalendar_cSlavePensHEventName = "Coilfang: Sklavenunterkünfte (Heroisch)"

	GroupCalendar_cShatteredHallsHEventName = "Höllenfeuer: Zerschmetterte Hallen (Heroisch)"
	GroupCalendar_cFurnaceHEventName = "Höllenfeuer: Blutkessel (Heroisch)"
	GroupCalendar_cRampartsHEventName = "Höllenfeuer: Bollwerk (Heroisch)"

	GroupCalendar_cMagistersEventName = "Terrasse der Magister"
	GroupCalendar_cMagistersHEventName = "Terrasse der Magister (Heroisch)"
	GroupCalendar_cSunwellEventName = "Sonnenbrunnenplateau"

	GroupCalendar_cPvPEventName = "Allgemein PvP"
	GroupCalendar_cA2v2EventName = "Arena (2v2)"
	GroupCalendar_cA3v3EventName = "Arena (3v3)"
	GroupCalendar_cA5v5EventName = "Arena (5v5)"
	GroupCalendar_cABEventName = "Arathibecken"
	GroupCalendar_cAVEventName = "Alteractal"
	GroupCalendar_cWSGEventName = "Kriegshymnenschlucht"
	GroupCalendar_cEotSEventName = "Das Auge des Sturms"

	GroupCalendar_cDoomWalkerEventName = "Verdammniswandler"
	GroupCalendar_cDoomLordKazzakEventName = "Verdammnislord Kazzak"

	-- WotLK dungeons

	GroupCalendar_cAhnkaletEventName = "Ahn'kahet: Das alte Königreich"
	GroupCalendar_cAzjolNerubEventName = "Azjol-Nerub"
	GroupCalendar_cCullingEventName = "HdZ: Das Ausmerzen von Stratholme"
	GroupCalendar_cDrakTharonEventName = "Feste Drak'Tharon"
	GroupCalendar_cGundrakEventName = "Gun'Drak"
	GroupCalendar_cTheNexusEventName = "Der Nexus"
	GroupCalendar_cTheOculusEventName = "Das Oculus"
	GroupCalendar_cHallsofLightningEventName = "Ulduar: Die Hallen der Blitze"
	GroupCalendar_cHallsofStoneEventName = "Ulduar: Die Hallen des Steins"
	GroupCalendar_cUtgardeEventName = "Burg Utgarde"
	GroupCalendar_cSUtgardePinnacleEventName = "Turm Utgarde"
	GroupCalendar_cTheVioletHoldEventName = "Die violette Festung"

	GroupCalendar_cAhnkaletHEventName = "Ahn'kahet: Das alte Königreich (Heroisch)"
	GroupCalendar_cAzjolNerubHEventName = "Azjol-Nerub (Heroisch)"
	GroupCalendar_cCullingHEventName = "HdZ: Das Ausmerzen von Stratholme (Heroisch)"
	GroupCalendar_cDrakTharonHEventName = "Feste Drak'Tharon (Heroisch)"
	GroupCalendar_cGundrakHEventName = "Gun'Drak (Heroisch)"
	GroupCalendar_cTheNexusHEventName = "Der Nexus (Heroisch)"
	GroupCalendar_cTheOculusHEventName = "Das Oculus (Heroisch)"
	GroupCalendar_cHallsofLightningHEventName = "Ulduar: Die Hallen der Blitze (Heroisch)"
	GroupCalendar_cHallsofStoneHEventName = "Ulduar: Die Hallen des Steins (Heroisch)"
	GroupCalendar_cUtgardeHEventName = "Burg Utgarde (Heroisch)"
	GroupCalendar_cUtgardePinnacleHEventName = "Turm Utgarde (Heroisch)"
	GroupCalendar_cTheVioletHoldHEventName = "Die violette Festung (Heroisch)"

	-- WotLK raids
	
	GroupCalendar_cNaxxHEventName = "Naxxramas (Heroisch)"
	GroupCalendar_cEternityEventName = "Das Auge der Ewigkeit"
	GroupCalendar_cEternityHEventName = "Das Auge der Ewigkeit (Heroisch)"
	GroupCalendar_cObsidianEventName = "Das Obsidiansanktum"
	GroupCalendar_cObsidianHEventName = "Das Obsidiansanktum (Heroisch)"
	GroupCalendar_cArchavonEventName = "Archavons Kammer"
	GroupCalendar_cArchavonHEventName = "Archavons Kammer (Heroisch)"
	GroupCalendar_cUlduarEventName = "Ulduar"
	GroupCalendar_cUlduarHEventName = "Ulduar (Heroisch)"

	-- Resets
	
	GroupCalendar_cZGResetEventName = "Zul'Gurub Reset"
	GroupCalendar_cMCResetEventName = "Geschmolzener Kern Reset"
	GroupCalendar_cOnyxiaResetEventName = "Onyxia Reset"
	GroupCalendar_cBWLResetEventName = "Pechschwingenhort Reset"
	GroupCalendar_cAQRResetEventName = "Ahn'Qiraj Ruins Reset"
	GroupCalendar_cAQTResetEventName = "Ahn'Qiraj Temple Reset"
	GroupCalendar_cNaxxResetEventName = "Naxxramas Reset"
	GroupCalendar_cKarazhanResetEventName = "Karazhan Reset"
	GroupCalendar_cZulAmanResetEventName = "Zul'Aman Reset"
	GroupCalendar_cBlackTempleResetEventName = "Der Schwarze Tempel Reset"
	GroupCalendar_cTheEyeResetEventName = "Festung: Auge des Sturms Reset"
	GroupCalendar_cSerpentshrineResetEventName = "Echsenkessel: Schlangenschrein Reset"
	GroupCalendar_cMagtheridonResetEventName = "Höllenfeuer: Magtheridons Kammer Reset"
	GroupCalendar_cHyjalResetEventName = "HdZ: Hyjal der Vergangenheit Reset"
	GroupCalendar_cGruulResetEventName = "Gruuls Unterschlupf Reset"

	GroupCalendar_cTransmuteCooldownEventName = "Transmutation verfügbar"
	GroupCalendar_cAlchemyResearchCooldownEventName = "Alchemy Research Available"
	GroupCalendar_cSaltShakerCooldownEventName = "Salzstreuer verfügbar"
	GroupCalendar_cMoonclothCooldownEventName = "Mondstoff verfügbar"
	GroupCalendar_cPrimalMoonclothCooldownEventName = "Urmondstoff verfügbar"
	GroupCalendar_cSpellclothCooldownEventName = "Zauberstoff verfügbar"
	GroupCalendar_cShadowclothCooldownEventName = "Schattenstoff verfügbar"
	GroupCalendar_cEbonweaveCooldownEventName = "Ebonweave Available"
	GroupCalendar_cSpellweaveCooldownEventName = "Spellweave Available"
	GroupCalendar_cMoonshroudCooldownEventName = "Moonshroud Available"
	GroupCalendar_cSnowmasterCooldownEventName = "Schneemeister 9000 verfügbar"
	GroupCalendar_cBrilliantGlassCooldownEventName = "Brilliant Glass Available"
	GroupCalendar_cVoidShatterCooldownEventName = "Void Shatter Available"
	GroupCalendar_cVoidSphereCooldownEventName = "Void Sphere Available"
	GroupCalendar_cInscriptionCooldownEventName = "Inscription Research Available"
	GroupCalendar_cInscription2CooldownEventName = "Northrend Inscription Research Available"
	GroupCalendar_cTitansteelCooldownEventName = "Smelt Titansteel Available"

	GroupCalendar_cPersonalEventOwner = "Privat"

	GroupCalendar_cRaidInfoMCName = GroupCalendar_cMCEventName
	GroupCalendar_cRaidInfoOnyxiaName = GroupCalendar_cOnyxiaEventName
	GroupCalendar_cRaidInfoZGName = GroupCalendar_cZGEventName
	GroupCalendar_cRaidInfoBWLName = GroupCalendar_cBWLEventName
	GroupCalendar_cRaidInfoAQRName = GroupCalendar_cAQREventName
	GroupCalendar_cRaidInfoAQTName = GroupCalendar_cAQTEventName
	GroupCalendar_cRaidInfoNaxxName = GroupCalendar_cNaxxEventName
	GroupCalendar_cRaidInfoKarazhanName = GroupCalendar_cKarazhanEventName
	GroupCalendar_cRaidInfoZulAmanName = GroupCalendar_cZulAmanEventName

	-- Race names

	GroupCalendar_cDwarfRaceName = "Zwerg"
	GroupCalendar_cGnomeRaceName = "Gnom"
	GroupCalendar_cHumanRaceName = "Mensch"
	GroupCalendar_cNightElfRaceName = "Nachtelf"
	GroupCalendar_cOrcRaceName = "Ork"
	GroupCalendar_cTaurenRaceName = "Tauren"
	GroupCalendar_cTrollRaceName = "Troll"
	GroupCalendar_cUndeadRaceName = "Untote"
	GroupCalendar_cBloodElfRaceName = "Blutelf"
	GroupCalendar_cDraeneiRaceName = "Draenei"

	-- Class names
	
	GroupCalendar_cFemaleDruidClassName = "Druidin"
	GroupCalendar_cMaleDruidClassName = "Druide"
	GroupCalendar_cFemaleHunterClassName = "Jägerin"
	GroupCalendar_cMaleHunterClassName = "Jäger"
	GroupCalendar_cFemaleMageClassName = "Magierin"
	GroupCalendar_cMaleMageClassName = "Magier"
	GroupCalendar_cFemalePaladinClassName = "Paladin"
	GroupCalendar_cMalePaladinClassName = "Paladin"
	GroupCalendar_cFemalePriestClassName = "Priesterin"
	GroupCalendar_cMalePriestClassName = "Priester"
	GroupCalendar_cFemaleRogueClassName = "Schurkin"
	GroupCalendar_cMaleRogueClassName = "Schurke"
	GroupCalendar_cFemaleShamanClassName = "Schamanin"
	GroupCalendar_cMaleShamanClassName = "Schamane"
	GroupCalendar_cFemaleWarlockClassName = "Hexenmeisterin"
	GroupCalendar_cMaleWarlockClassName = "Hexenmeister"
	GroupCalendar_cFemaleWarriorClassName = "Kriegerin"
	GroupCalendar_cMaleWarriorClassName = "Krieger"
	
	-- Plural forms of class names

	GroupCalendar_cDruidsClassName = "Druiden"
	GroupCalendar_cHuntersClassName = "Jäger"
	GroupCalendar_cMagesClassName = "Magier"
	GroupCalendar_cPaladinsClassName = "Paladine"
	GroupCalendar_cPriestsClassName = "Priester"
	GroupCalendar_cRoguesClassName = "Schurken"
	GroupCalendar_cShamansClassName = "Schamanen"
	GroupCalendar_cWarlocksClassName = "Hexenmeister"
	GroupCalendar_cWarriorsClassName = "Krieger"

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

	GroupCalendar_cTimeLabel = "Uhrzeit:"
	GroupCalendar_cDurationLabel = "Dauer:"
	GroupCalendar_cEventLabel = "Event:"
	GroupCalendar_cTitleLabel = "Titel:"
	GroupCalendar_cLevelsLabel = "Level:"
	GroupCalendar_cLevelRangeSeparator = "bis"
	GroupCalendar_cDescriptionLabel = "Beschreibung:"
	GroupCalendar_cCommentLabel = "Kommentar:"

	CalendarEditor_cNewEvent = "Neues Event..."
	CalendarEditor_cEventsTitle = "Events"

	CalendarEvent_cNotAttending = "Nicht angemeldet"
	CalendarEvent_cConfirmed = "Bestätigt"
	CalendarEvent_cDeclined = "Abgelehnt"
	CalendarEvent_cStandby = "Auf Warteliste"
	CalendarEvent_cPending = "Wartet..."
	CalendarEvent_cBanned = "Ausgeschlossen"
	CalendarEvent_cUnknownStatus = "Unbekannt %s"

	GroupCalendar_cChannelNameLabel = "Channel:"
	GroupCalendar_cPasswordLabel = "Passwort:"

	GroupCalendar_cSingleTimeDateFormat = "%s %s"
	GroupCalendar_cTimeDateRangeFormat = "%s %s bis %s"

	GroupCalendar_cPluralMinutesFormat = "%d Minuten"
	GroupCalendar_cSingularHourFormat = "%d Stunde"
	GroupCalendar_cPluralHourFormat = "%d Stunden"
	GroupCalendar_cSingularHourPluralMinutes = "%d Stunde %d Minuten"
	GroupCalendar_cPluralHourPluralMinutes = "%d Stunden %d Minuten"

	GroupCalendar_cLongDateFormat = "$day, $month $year"
	GroupCalendar_cShortDateFormat = "$day,$monthNum"
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $day, $month $year"

	GroupCalendar_cNotAttendingCategory = "Abgemeldet"
	GroupCalendar_cAttendingCategory = "Angemeldet"
	GroupCalendar_cPendingApprovalCategory = "Anmeldung läuft"
	GroupCalendar_cStandbyCategory = "Standby"
	GroupCalendar_cMaybeCategory = "Maybe"
	GroupCalendar_cWhispersCategory = "Vor kurzem angeflüstert"
	GroupCalendar_cBannedCategory = "Vom Event Ausgeschlossen"

	GroupCalendar_cClassAttendanceNameFormat = "$name ($level $class)"
	GroupCalendar_cStatusAttendanceNameFormat = "$name ($status)"
	GroupCalendar_cRoleAttendanceNameFormat = "$name ($level $role)"
	
	GroupCalendar_cNumAttendeesFormat = "%d Anmeldungen"
	GroupCalendar_cTotalNumPlayersFormat = "%s Spieler"

	GroupCalendar_cTotalNumPlayersFormat = "%s players"

	BINDING_HEADER_GROUPCALENDAR_TITLE = "GroupCalendar"
	BINDING_NAME_GROUPCALENDAR_TOGGLE = "GroupCalendar an/aus"

	GroupCalendar_cCharactersLabel = "Charakter:"

	GroupCalendar_cPending = "Pending"
	GroupCalendar_cConfirmed = "Akzeptiert"
	GroupCalendar_cStandby = "Standby"
	GroupCalendar_cMaybe = "Maybe Attending"
	GroupCalendar_cDeclined = "Abgelehnt"
	GroupCalendar_cBanned = "Ausgeschlossen"
	GroupCalendar_cRemove = "Entfernen"
	GroupCalendar_cEditPlayer = "Bearbeite Spieler..."
	GroupCalendar_cInviteNow = "Gruppeneinlad."
	GroupCalendar_cStatus = "Status"
	GroupCalendar_cAddPlayerEllipses = "Spieler hinzu..."

	GroupCalendar_cAddPlayer = "Spieler hinzu"
	GroupCalendar_cPlayerLevel = "Level:"
	GroupCalendar_cPlayerClassLabel = "Klasse:"
	GroupCalendar_cPlayerRaceLabel = "Rasse:"
	GroupCalendar_cPlayerStatusLabel = "Status:"
	GroupCalendar_cRankLabel = "Gildenrang:"
	GroupCalendar_cGuildLabel = "Gilde:"
	GroupCalendar_cRoleLabel = "Aufgabe:"
	GroupCalendar_cSave = "Speichern"
	GroupCalendar_cLastWhisper = "Letzter Whisper:"
	GroupCalendar_cReplyWhisper = "Antwort-Whisper:"

	GroupCalendar_cUnknown = "Unbekannt"
	GroupCalendar_cAutoConfirmationTitle = "Automatische Bestätigung"
	GroupCalendar_cRoleConfirmationTitle = "Automatische Bestätigung durch Aufgabe"
	GroupCalendar_cManualConfirmationTitle = "Manuelle Bestätigung"
	GroupCalendar_cClosedEventTitle = "Event geschlossen"
	GroupCalendar_cMinLabel = "min"
	GroupCalendar_cMaxLabel = "max"

	GroupCalendar_cAddPlayerTitle = "Hinzu.."
	GroupCalendar_cAutoConfirmButtonTitle = "Optionen..."

	GroupCalendar_cClassLimitDescription = "Benutze die Felder, um die minimale und maximale Anzahl Spieler pro Klasse festzulegen.  Klassen, die das Minimum nicht erreicht haben, werden zuerst aufgefüllt. Danach werden noch freie Plätze in Anmeldereihenfolge vergeben."
	GroupCalendar_cRoleLimitDescription = "Benutze die Felder um die minimale und maximale Anzahl Spieler pro Aufgabe festzulegen.  Aufgaben, die das Minimum nicht erreicht haben, werden zuerst aufgefüllt. Danach werden noch freie Plätze in Anmeldereihenfolge vergeben.  Optional kannst Du die minimale Anzahl jeder Klasse für eine bestimmt Aufgabe festlegen (zum Beispiel: Es wird mindestens ein Schattenpriester als Fernkämpfer benötigt)"

	GroupCalendar_cViewGroupBy = "Gruppieren nach"
	GroupCalendar_cViewByStatus = "Status"
	GroupCalendar_cViewByClass = "Klasse"
	GroupCalendar_cViewByRole = "Aufgabe"
	GroupCalendar_cViewSortBy = "Sortiere nach"
	GroupCalendar_cViewByDate = "Datum"
	GroupCalendar_cViewByRank = "Rang"
	GroupCalendar_cViewByName = "Name"

	GroupCalendar_cMaxPartySizeLabel = "Maximale Gruppengröße:"
	GroupCalendar_cMinPartySizeLabel = "Minimale Gruppengröße:"
	GroupCalendar_cNoMinimum = "Kein Minimum"
	GroupCalendar_cNoMaximum = "Kein Maximum"
	GroupCalendar_cPartySizeFormat = "%d Spieler"

	GroupCalendar_cInviteButtonTitle = "Ausgewählte einladen"
	GroupCalendar_cAutoSelectButtonTitle = "Spieler wählen..."
	GroupCalendar_cAutoSelectWindowTitle = "Spieler wählen"

	GroupCalendar_cNoSelection = "Keine Spieler gewählt"
	GroupCalendar_cSingleSelection = "1 Spieler gewählt"
	GroupCalendar_cMultiSelection = "%d Spieler gewählt"

	GroupCalendar_cInviteNeedSelectionStatus = "Wähle Spieler für Einladung"
	GroupCalendar_cInviteReadyStatus = "Bereit zum Einladen"
	GroupCalendar_cInviteInitialInvitesStatus = "Sende erste Einladungen"
	GroupCalendar_cInviteAwaitingAcceptanceStatus = "Warte auf erste Rückmeldungen"
	GroupCalendar_cInviteConvertingToRaidStatus = "Umwandeln in Schlachtzug"
	GroupCalendar_cInviteInvitingStatus = "Sende Einladungen"
	GroupCalendar_cInviteCompleteStatus = "Einladungen komplett"
	GroupCalendar_cInviteReadyToRefillStatus = "Bereit, leere Plätze zu füllen"
	GroupCalendar_cInviteNoMoreAvailableStatus = "Keine weiteren Spieler verfügbar"
	GroupCalendar_cRaidFull = "Schlachtzug voll"

	GroupCalendar_cInviteWhisperFormat = "[GroupCalendar] Du bist eingeladen zum Event '%s'.  Bitte nimm die Einladung an, wenn du am Event teilnehmen willst."
	GroupCalendar_cAlreadyGroupedWhisper = "[GroupCalendar] Du bist bereits in einer Gruppe.  Bitte flüstere mir, wenn du die Gruppe verlassen hast."

	GroupCalendar_cJoinedGroupStatus = "Beigetreten"
	GroupCalendar_cInvitedGroupStatus = "Eingeladen"
	GroupCalendar_cReadyGroupStatus = "Bereit"
	GroupCalendar_cGroupedGroupStatus = "In anderer Gruppe"
	GroupCalendar_cStandbyGroupStatus = "Standby"
	GroupCalendar_cMaybeGroupStatus = "Maybe"
	GroupCalendar_cDeclinedGroupStatus = "Einladung abgewiesen"
	GroupCalendar_cOfflineGroupStatus = "Offline"
	GroupCalendar_cLeftGroupStatus = "Gruppe verlassen"

	GroupCalendar_cPriorityLabel = "Priorität:"
	GroupCalendar_cPriorityDate = "Datum"
	GroupCalendar_cPriorityRank = "Rang"

	GroupCalendar_cConfirmSelfUpdateMsg = "%s"
	
	GroupCalendar_cConfirmSelfUpdateParamFormat = "Für $mUserName wurden von einem anderen Computer aus Änderungen durchgeführt. Wenn Sie mehrere Computer verwenden, oder das Spiel abgestürzt ist oder re-installiert wurde, sollten Sie \"Aktualisieren\" wählen, um Ihre Termine wiederherzustellen. Wählen Sie \"Löschen\", falls Sie denken, dass die Änderungen durch den anderen Rechner falsch sind oder verworfen werden sollten."
	GroupCalendar_cConfirmSelfRSVPUpdateParamFormat = "Für $mUserName wurden von einem anderen Computer aus Änderungen an den Teilnahmeanfragen durchgeführt. Wenn Sie mehrere Computer verwenden, oder das Spiel abgestürzt ist oder re-installiert wurde, sollten Sie \"Aktualisieren\" wählen, um Ihre Teilnahmeanfragen wiederherzustellen. Wählen Sie \"Löschen\", falls Sie denken, dass die Änderungen durch den anderen Rechner falsch sind oder verworfen werden sollten."
	GroupCalendar_cUpdate = "Aktualisieren"
	
	GroupCalendar_cConfirmClearWhispers = "Die letzten Whispers entfernen?"
	GroupCalendar_cClear = "Leeren"

	CalendarDatabases_cTitle = "GroupCalendar Versionen"
	CalendarDatabases_cRefresh = "Aktualis."
	CalendarDatabases_cRefreshDescription = "Fordert Spieler auf, ihre Versionsnummern zu senden. Das Update kann einige Zeit dauern. Updates werden auch aufgezeichnet, wenn dieses Fenster geschlossen wird, und können später eingesehen werden."

	GroupCalendar_cVersionFormat = "GroupCalendar v%s"
	GroupCalendar_cShortVersionFormat = "v%s"
	GroupCalendar_cVersionUpdatedFormat = "am %s um %s (lokale Zeit)"
	GroupCalendar_cVersionUpdatedUnknown = "Das Datum der letzten Versionsinfo ist unbekannt"

	GroupCalendar_cToggleVersionsTitle = "Zeige Spieler-Info"
	GroupCalendar_cToggleVersionsDescription = "Zeigt an, welche Version von GroupCalendar bei anderen Spielern läuft."

	GroupCalendar_cChangesDelayedMessage = "GroupCalendar: Änderungen werden nach Abschluss der Synchronisation versandt."

	GroupCalendar_cConfirmKillMsg = "Bist du sicher, dass du die Events von %s aus dem Netzwerk entfernen willst?"; 
	GroupCalendar_cKill = "Entf."

	GroupCalendar_cNotAnOfficerError = "GroupCalendar: Nur Gildenoffiziere haben die Erlaubnis dazu"
	GroupCalendar_cUserNameExpected = "GroupCalendar: Nutzername erwartet"
	GroupCalendar_cDatabaseNotFoundError = "GroupCalendar: Datenbank für %s nicht gefunden."
	GroupCalendar_cCantKillGuildieError = "GroupCalendar: Entfernen von Gildenmitgliedern nicht möglich."

	GroupCalendar_cTooltipScheduleItemFormat = "%s (%s)"

	GroupCalendar_cAvailableMinutesFormat = "%s in %d Minuten"
	GroupCalendar_cAvailableMinuteFormat = "%s in %d Minute"
	GroupCalendar_cStartsMinutesFormat = "%s startet in %d Minuten"
	GroupCalendar_cStartsMinuteFormat = "%s starts in %d Minute"
	GroupCalendar_cStartingNowFormat = "%s startet jetzt"
	GroupCalendar_cAlreadyStartedFormat = "%s hat bereits begonnen"
	GroupCalendar_cHappyBirthdayFormat = "Herzlichen Glückwunsch zum Geburtstag %s!"

	GroupCalendar_cTimeRemainingFormat = "(%d:%02d verbleibend)"
	GroupCalendar_cUnknownEventType = "%s (Neuer Event-Typ, aktualisiere deinen GroupCalendar)"

	GroupCalendar_cConfirmResetMsg = "Sicher, dass Du den Calendar für %s zurücksetzen willst? Alle Events aller dieses Charakters werden entfernt!"
	GroupCalendar_cConfirmResetRealmMsg = "Sicher, dass du den Calendar aller deiner Charaktere auf %s zurücksetzen willst? Alle Events aller deiner Charaktere auf diesem Server werden entfernt!"
	GroupCalendar_cConfirmResetAllMsg = "Sicher, dass du den Calendar für alle deine Charaktere auf allen Servern zurücksetzen willst? Alle Events aller deiner Charaktere auf allen Servern werden entfernt!"
	GroupCalendar_cReset = "Reset"

	GroupCalendar_cNone = "Keines"

	GroupCalendar_cAttendanceNote = "Du hast deinen Teilname-Status für %s geändert. Bitte warte 2 Minuten bis zum Ausloggen, damit deine Anfrage weitergeleitet werden kann. Dein Status ist >Warte auf Bestätigung<, bis der Event-Ersteller einloggt."
	GroupCalendar_cUnknownClockOption = "Unbekannte Zeiteinstellung"
	GroupCalendar_cBadAgeValue = "The maximum event age must be between 1 and 60 days"
	GroupCalendar_cViewMenuFormat = "Sortierung nach %s/%s"
	GroupCalendar_cDefaultTimeFormat = 24
	GroupCalendar_cDefaultStartDay = "Mon"
	GroupCalendar_cForeignRealmFormat = "%s of %s"

	GroupCalendar_cMHRole = "Heiler"
	GroupCalendar_cOHRole = "Off-Heiler"
	GroupCalendar_cMTRole = "Tank"
	GroupCalendar_cOTRole = "Off-Tank"
	GroupCalendar_cRDRole = "Fernkämpfer"
	GroupCalendar_cMDRole = "Nahkämpfer"

	GroupCalendar_cMHPluralRole = "Heiler"
	GroupCalendar_cOHPluralRole = "Off-Heiler"
	GroupCalendar_cMTPluralRole = "Tanks"
	GroupCalendar_cOTPluralRole = "Off-Tanks"
	GroupCalendar_cRDPluralRole = "Fernkämpfer"
	GroupCalendar_cMDPluralRole = "Nahkämpfer"

	GroupCalendar_cMHPluralLabel = GroupCalendar_cMHPluralRole..":"
	GroupCalendar_cOHPluralLabel = GroupCalendar_cOHPluralRole..":"
	GroupCalendar_cMTPluralLabel = GroupCalendar_cMTPluralRole..":"
	GroupCalendar_cOTPluralLabel = GroupCalendar_cOTPluralRole..":"
	GroupCalendar_cRDPluralLabel = GroupCalendar_cRDPluralRole..":"
	GroupCalendar_cMDPluralLabel = GroupCalendar_cMDPluralRole..":"

	GroupCalendar_cClockNotSetWarning = "WARNING: %s indicate that their clocks are set to a significantly different time or date than yours.  Check your time and date settings as this may cause problems with posting or signing up for events, especially if you log in from multiple computers."

	GroupCalendar.cWhisperSummaryDateHeader    = "%s"
	GroupCalendar.cWhisperSummaryEvent         = "    $time $event [ID $id]"
	GroupCalendar.cWhisperSummaryEventStatus   = "    $time $event [ID $id] ($status)"
	GroupCalendar.cWhisperSummaryNoEvents      = "Keine anstehenden Events"
	GroupCalendar.cWhisperSummaryInvalidOption = "%s ist keine gültige Option.  Verwende '!gc help' um eine Liste verfügbarer Befehle zu erhalten"

	GroupCalendar.cWhisperHelp =
	{
		"!gc - Der gleiche Befehl wie !gc summary",
		"!gc summary - Zeigt Events der nächsten sieben Tage",
		"!gc yes eventid - Für ein Event als teilnehmend anmelden",
		"!gc no eventid - Für ein Event als nicht teilnehmend anmelden",
		"!gc maybe eventid - Für ein Event als unsicher anmelden",
		"!gc help - Zeigt die Liste der Befehle",
		"Event-IDs erscheinen in der Liste der Events. Wenn das Event von dem Charakter ist, den Du angewispert hast, kannst Du die Nummer verwenden- Verwende ansonsten das Name-Nummer Format um das Event zu spezifizieren."
	}

	GroupCalendar.cDatabasesTotalFormat = "%d Datenbanken"

	GroupCalendar_cConfirmDeleteRSVP = "Bist du sicher, dass Du %s von der Liste entfernen willst?"

	GroupCalendar.cCantReloadUI = GroupCalendar_cTitleVersion.." verwendet neue Dateien, und World of Warcraft verweigert den Ladevorgang dieser Dateien bis zu das Spiel komplett verlassen hast. Group Calendar wird deaktiviert, bis zu World of Warcraft neu gestartet hast."
	
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

	GroupCalendar.cNewerVersionMessage = "Eine neue Version ist verfügbar (%s)"

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

	GroupCalendar.cRSVPConfirmMessage =
	{
		Y = "$name is confirmed to attend $event on $date",
		S = "$name is on standby for $event on $date",
	}
end
