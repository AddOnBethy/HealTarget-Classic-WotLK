local spellBeingCast, playerTarget, localClass, playerClass, spellFound, spellCheck
local ownFaction, ownLocaleFaction = UnitFactionGroup("player")


-- Beautified Print
local function Print(string)
	ChatFrame1:AddMessage(string, 1, 0.5, 0)
end

local function SpellIsFound(class, spell)
	spellCheck = nil
	for i = 1, #SPELLLIST[class] do
		if spell == SPELLLIST[class][i] then
			spellCheck = spell
		end
	end
	return spellCheck
end

local function ReturnSpellIcon(spellName)
	-- Druid
	if spellName == "Healing" then
		return "spell_nature_healingtouch"
	elseif spellName == "Nourish" then
		return "ability_druid_nourish"
	elseif spellName == "Rebirth" then
		return "spell_nature_reincarnation"
	elseif spellName == "Regrowth" then
		return "spell_nature_resistnature"
	elseif spellName == "Revive" then
		return "ability_druid_lunarguidance"
	-- Paladin
	elseif spellName == "Flash of Light" then
		return "spell_holy_flashheal"
	elseif spellName == "Holy Light" then
		return "spell_holy_holybolt"
	elseif spellName == "Redemption" then
		return "spell_holy_resurrection"
	-- Priest
	elseif spellName == "Binding Heal" then
		return "spell_holy_blindingheal"
	elseif spellName == "Flash Heal" then
		return "spell_holy_flashheal"
	elseif spellName == "Greater Heal" then
		return "spell_holy_greaterheal"
	elseif spellName == "Heal" then
		return "spell_holy_heal"
	elseif spellName == "Lesser Heal" then
		return "spell_holy_lesserheal"
	elseif spellName == "Penance" then
		return "spell_holy_penance"
	elseif spellName == "Prayer of Healing" then
		return "spell_holy_prayerofhealing02"
	elseif spellName == "Resurrection" then
		return "spell_holy_resurrection"
	-- Shaman
	elseif spellName == "Ancestral Spirit" then
		return "spell_nature_regenerate"
	elseif spellName == "Chain Heal" then
		return "spell_nature_healingwavegreater"
	elseif spellName == "Healing Wave" then
		return "spell_nature_magicimmunity"
	elseif spellName == "Lesser Healing Wave" then
		return "spell_nature_healingwavelesser"
	end
end

local function CastHandler(spellGUID, playerClass)
	localeTargetClass, targetClass = UnitClass("target")
	-- playerTarget = GetUnitName("playertarget")
	-- MainFrame.spellTex:SetTexture("Interface\\AddOns\\HealTarget\\icons\\spells\\" .. playerClass .. "\\" .. spellGUID .. ".tga")
	MainFrame.spellTex:SetTexture("Interface/Icons/" .. ReturnSpellIcon(spellGUID))
	if playerTarget and UnitIsPlayer("target") and UnitFactionGroup("target") == ownLocaleFaction then
		-- MainFrame.classTex:SetTexture("Interface\\AddOns\\HealTarget\\icons\\classes\\" .. targetClass .. ".tga")
		if targetClass == "DEATHKNIGHT" then
			TargetText:SetText("|cFFC41E3A" .. playerTarget .. "|r") -- red
			MainFrame.classTex:SetTexture("Interface/Icons/spell_deathknight_classicon")
			MainFrame:Show()
		elseif targetClass == "DRUID" then
			TargetText:SetText("|cFFFF7C0A" .. playerTarget .. "|r") -- orange
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_druid")
			MainFrame:Show()
		elseif targetClass == "HUNTER" then
			TargetText:SetText("|cFFAAD372" .. playerTarget .. "|r") -- green
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_hunter")
			MainFrame:Show()
		elseif targetClass == "MAGE" then
			TargetText:SetText("|cFF3FC7EB" .. playerTarget .. "|r") -- light blue
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_mage")
			MainFrame:Show()
		elseif targetClass == "PALADIN" then
			TargetText:SetText("|cFFF48CBA" .. playerTarget .. "|r") -- pink
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_paladin")
			MainFrame:Show()
		elseif targetClass == "PRIEST" then
			TargetText:SetText("|cFFFFFFFF" .. playerTarget .. "|r") -- white
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_priest")
			MainFrame:Show()
		elseif targetClass == "ROGUE" then
			TargetText:SetText("|cFFFFF468" .. playerTarget .. "|r") -- yellow
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_rogue")
			MainFrame:Show()
		elseif targetClass == "SHAMAN" then
			TargetText:SetText("|cFF0070DD" .. playerTarget .. "|r") -- blue
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_shaman")
			MainFrame:Show()
		elseif targetClass == "WARLOCK" then
			TargetText:SetText("|cFF8788EE" .. playerTarget .. "|r") -- purple
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_warlock")
			MainFrame:Show()
		elseif targetClass == "WARRIOR" then
			TargetText:SetText("|cFFC69B6D" .. playerTarget .. "|r") -- brown
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_warrior")
			MainFrame:Show()
		end
	elseif not playerTarget then
		if playerClass == "DRUID" then
			TargetText:SetText("|cFFFF7C0A" .. GetUnitName("player") .. "|r") -- orange
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_druid")
			MainFrame:Show()
		elseif playerClass == "PALADIN" then
			TargetText:SetText("|cFFFF1493" .. GetUnitName("player") .. "|r") -- pink
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_paladin")
			MainFrame:Show()
		elseif playerClass == "PRIEST" then
			TargetText:SetText("|cFFF5F5F5" .. GetUnitName("player") .. "|r") -- white
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_priest")
			MainFrame:Show()
		elseif playerClass == "SHAMAN" then
			TargetText:SetText("|cff0000ff" .. GetUnitName("player") .. "|r") -- blue
			MainFrame.classTex:SetTexture("Interface/Icons/classicon_shaman")
			MainFrame:Show()
		end
	elseif MainFrame:IsShown() then
		MainFrame:Hide()
	end
end

--f:SetScript("OnEvent", CastHandler);

MainFrame:SetScript("OnEvent", function(self, event, ...)
	-- Triggers on player spellcast, given the spell is found in SpellList.lua
	if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" then
		local unit = ...
		localePlayerClass, playerClass = UnitClass("player")
		if unit == "player" then
			if playerClass == "DRUID" or playerClass == "PALADIN" or playerClass == "PRIEST" or playerClass == "SHAMAN" then
				MainFrame:Hide()
				spellName = UnitCastingInfo("player")
				if SpellIsFound(playerClass, spellName) then
					CastHandler(spellName, playerClass)
				end
			end
		end
	end
	-- Triggers when player changes target
	if event == "PLAYER_TARGET_CHANGED" then
		playerTarget = GetUnitName("playertarget")
	end
	-- Triggers after player enters world or types "/reload"
	if event == "PLAYER_LOGIN" then
		DEFAULT_CHAT_FRAME:AddMessage("|cFF0070DDBethy|r's HealTarget 1.2 loaded. Download newest version from https://github.com/AddOnBethy/HealTarget-Classic-WotLK")
	end
end);