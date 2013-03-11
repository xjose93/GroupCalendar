GroupCalendar.TradeskillCooldownIDs =
{
	-- Alchemy
	
	[11479] = "Alchemy", -- TransmuteIronToGold
	[11480] = "Alchemy", -- TransmuteMithrilToTruesilver
	[17187] = "Alchemy", -- TransmuteArcanite
	[17559] = "Alchemy", -- TransmuteAirToFire
	[17560] = "Alchemy", -- TransmuteFireToEarth
	[17562] = "Alchemy", -- TransmuteWaterToAir
	[17563] = "Alchemy", -- TransmuteUndeathToWater
	[17561] = "Alchemy", -- TransmuteEarthToWater
	[17564] = "Alchemy", -- TransmuteWaterToUndeath
	[17565] = "Alchemy", -- TransmuteLifeToEarth
	[17566] = "Alchemy", -- TransmuteEarthToLife
	[28566] = "Alchemy", -- TransmutePrimalAirToFire
	[28567] = "Alchemy", -- TransmutePrimalEarthToWater
	[28568] = "Alchemy", -- TransmutePrimalFireToEarth
	[28569] = "Alchemy", -- TransmutePrimalWaterToAir
	[28582] = "Alchemy", -- TransmutePrimalManaToFire
	[28583] = "Alchemy", -- TransmutePrimalFireToMana
	[28584] = "Alchemy", -- TransmutePrimalLifeToEarth
	[28585] = "Alchemy", -- TransmutePrimalEarthToLife
	[28580] = "Alchemy", -- TransmutePrimalShadowToWater
	[28581] = "Alchemy", -- TransmutePrimalWaterToShadow
	[29688] = "Alchemy", -- TransmutePrimalMight
	[32765] = "Alchemy", -- TransmuteEarthstormDiamond
	[32766] = "Alchemy", -- TransmuteSkyfireDiamond

	
	[53777] = "Alchemy", -- Transmute: Eternal Air to Earth
	[53776] = "Alchemy", -- Transmute: Eternal Air to Water
	[53781] = "Alchemy", -- Transmute: Eternal Earth to Air
	[53782] = "Alchemy", -- Transmute: Eternal Earth to Shadow
	[53775] = "Alchemy", -- Transmute: Eternal Fire to Life
	[53774] = "Alchemy", -- Transmute: Eternal Fire to Water
	[53773] = "Alchemy", -- Transmute: Eternal Life to Fire
	[53771] = "Alchemy", -- Transmute: Eternal Life to Shadow
	[53779] = "Alchemy", -- Transmute: Eternal Shadow to Earth
	[53780] = "Alchemy", -- Transmute: Eternal Shadow to Life
	[53783] = "Alchemy", -- Transmute: Eternal Water to Air
	[53784] = "Alchemy", -- Transmute: Eternal Water to Fire
	[54020] = "Alchemy", -- Transmute: Eternal Might

	[60893] = "AlchemyResearch", -- Northrend Alchemy Research
	
	--Enchanting
	
	[45765] = "VoidShatter", -- VoidShatter
	[28028] = "VoidSphere", -- VoidSphere
	
	-- Tailoring
	
	[18560] = "Tailoring", -- Mooncloth
	[26751] = "PrimalMooncloth", -- PrimalMooncloth
	[31373] = "Spellcloth", -- Spellcloth
	[36686] = "Shadowcloth", -- Shadowcloth
	[56002] = "Ebonweave", -- Ebonweave
	[56003] = "Spellweave", -- Spellweave
	[56001] = "Moonshroud", -- Moonshroud
	
	-- Jewelcrafting
	
	[47280] = "BrilliantGlass", -- BrilliantGlass
	
	-- Inscription

	[61288] = "InscrResearch", -- InscriptionResearch
	[61177] = "InscrResearch2", -- NorthrendInscriptionResearch
	
	-- Mining
	
	[55208] = "Titansteel",
}

----------------------------------------
GroupCalendar.TradeSkillAPI = {}
----------------------------------------

function GroupCalendar.TradeSkillAPI:GetSkillLine()
	local vName, vCurrentLevel, vMaxLevel = GetTradeSkillLine()
	
	return vName, vCurrentLevel, vMaxLevel
end

function GroupCalendar.TradeSkillAPI:GetNumSkills()
	return GetNumTradeSkills()
end

function GroupCalendar.TradeSkillAPI:GetSkillInfo(pIndex)
	local vSkillName, vSkillType, vNumAvailable, vIsExpanded = GetTradeSkillInfo(pIndex)
	
	return vSkillName, vSkillType, vNumAvailable, vIsExpanded
end

function GroupCalendar.TradeSkillAPI:GetSkillCooldown(pIndex)
	return GetTradeSkillCooldown(pIndex)
end

function GroupCalendar.TradeSkillAPI:GetSkillSpellID(pIndex)
	local vLink = GetTradeSkillRecipeLink(pIndex)
	
	if not vLink then
		return
	end
	
	local _, _, vSpellID = vLink:find("|Henchant:(%d+)")
	
	return tonumber(vSpellID)
end

----------------------------------------
----------------------------------------

function GroupCalendar.GetSkillCooldowns(pSkillAPI)
	local vNumSkills = pSkillAPI:GetNumSkills()
	local vCooldowns
	
	for vSkillIndex = 1, vNumSkills do
		local vSpellID = pSkillAPI:GetSkillSpellID(vSkillIndex)
		local vCooldownID = GroupCalendar.TradeskillCooldownIDs[vSpellID]
		
		if vCooldownID then
			if not vCooldowns then
				vCooldowns = {}
			end
			
			if not vCooldowns[vCooldownID] then
				local vCooldown = pSkillAPI:GetSkillCooldown(vSkillIndex)
				
				vCooldowns[vCooldownID] = vCooldown
			end
		end
	end
	
	return vCooldowns
end

----------------------------------------
-- Item cooldowns
----------------------------------------

GroupCalendar.CoolDowns_cCooldownItemInfo =
{
	[15846] = {EventID = "Leatherworking"}, -- Salt Shaker
	[17716] = {EventID = "Snowmaster"}, -- Snowmaster 9000
}

function GroupCalendar.Cooldowns_ScheduleCheckItems()
	MCSchedulerLib:ScheduleUniqueTask(0.5, GroupCalendar.Cooldowns_CheckItems)
end

function GroupCalendar.Cooldowns_CheckItems()
	for vBagIndex = 0, NUM_BAG_SLOTS do
		local vNumBagSlots = GetContainerNumSlots(vBagIndex)
		
		for vBagSlotIndex = 1, vNumBagSlots do
			local vStart, vDuration, vEnable = GetContainerItemCooldown(vBagIndex, vBagSlotIndex)
			
			if vStart > 0 and vDuration > 0 and vEnable > 0 then
				GroupCalendar.Cooldowns_CheckItem(vBagIndex, vBagSlotIndex, vStart, vDuration)
			end
		end -- for vBagSlotIndex
	end -- for vBagIndex
end

function GroupCalendar.Cooldowns_CheckItem(pBagIndex, pBagSlotIndex, pStart, pDuration)
	local vItemLink = GetContainerItemLink(pBagIndex, pBagSlotIndex)

	if not vItemLink then
		return
	end
	
	local vStartIndex,
			vEndIndex,
			vLinkColor,
			vItemCode,
			vItemEnchantCode,
			vItemJewelCode1,
			vItemJewelCode2,
			vItemJewelCode3,
			vItemJewelCode4,
			vItemSubCode,
			vUnknownCode5,
			vItemName = strfind(vItemLink, GroupCalendar_cItemLinkFormat)
	
	if not vStartIndex then
		return
	end
	
	vItemCode = tonumber(vItemCode)
	
	local vCooldownItemInfo = GroupCalendar.CoolDowns_cCooldownItemInfo[vItemCode]
	
	if not vCooldownItemInfo then
		return
	end
	
	vRemainingTime = pDuration - (GetTime() - pStart)
	
	if vRemainingTime <= 0 then
		return
	end
	
	if vRemainingTime > MCDateLib.cSecondsPerDay * 7 then
		-- GroupCalendar:ErrorMessage("Internal error: Cooldown is greater than 7 days for %s.  Please report this problem.", vItemName)
		return
	end
	
	GroupCalendar.Database.ScheduleTradeskillCooldownEvent(GroupCalendar.UserDatabase, vCooldownItemInfo.EventID, vRemainingTime)
end
