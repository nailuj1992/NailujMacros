local addon = ...
local _, englishClass, _ = UnitClass("player")

--------------------------------------------------------------------
-- Nailuj Macros
-- ----------------
-- Creates/uses specific macros for my characters 
-- (identifying the spells according the language of the game).
--------------------------------------------------------------------

--------------------------------------------------------------------
-- List for all spells utilized for my macros
--------------------------------------------------------------------
local paladinSpells = {
	{343721, "Final Reckoning", "Juicio final"},
	{31884, "Avenging wrath", "Cólera vengativa"},
	{1022, "Blessing of protection", "Bendición de protección"},
	{6940, "Blessing of sacrifice", "Bendición de sacrificio"},
	{403876, "Divine protection", "Protección divina"},
	{7328, "Redemption", "Redención"},
	{31850, "Ardent Defender", "Defensor candente"},
	{853, "Hammer of Justice", "Martillo de Justicia"}
}

local druidSpells = {
	{22812, "Barkskin", "Piel de corteza"},
	{50769, "Revive", "Revivir"}
}

local warriorSpells = {
	{12975, "Last Stand", "Última carga"},
	{228920, "Ravager", "Devastador"},
	{100, "Charge", "Cargar"},
	{385952, "Shield Charge", "Carga con escudo"}
}

local deathKnightSpells = {
	{43265, "Death and decay", "Muerte y descomposición"}
}

local priestSpells = {
	{121536, "Angelic feather", "Pluma angélica"},
	{2061, "Flash heal", "Sanación relámpago"},
	{2060, "Heal", "Sanar"},
	{34861, "Holy Word: Sanctify", "Palabra Sagrada: Santificar"},
	{2050, "Holy Word: Serenity", "Palabra Sagrada: Serenidad"},
	{32375, "Mass Dispel", "Disipación en masa"},
	{10060, "Power Infusion", "Infusión de poder"},
	{33076, "Prayer of Mending", "Rezo de alivio"},
	{527, "Purify", "Purificar"},
	{139, "Renew", "Renovar"},
	{17, " Power Word: Shield", "Palabra de poder: escudo"},
	{589, " Shadow Word: Pain", "Palabra de las Sombras: dolor"},
	{585, " Smite", "Punición"},
	{373481, " Power Word: Life", "Palabra de poder: vida"},
	{8092, " Mind blast", "Explosión mental"},
	{33206, " Pain Suppression", "Supresión de dolor"},
	{47540, " Penance", "Penitencia"},
	{15286, " Vampiric Embrace", "Abrazo vampírico"},
	{205385, " Shadow Crash", "Fragor de sombra"}
}

local evokerSpells = {
	{360827, "Blistering Scales", "Escamas virulentas"},
	{360823, "Naturalize", "Naturalizar"},
	{374251, "Cauterizing Flame", "Llama cauterizante"},
	{375087, "Dragonrage", "Furia dracónica"},
	{364343, "Echo", "Eco"},
	{355913, "Emerald Blossom", "Flor esmeralda"},
	{361469, "Living Flame", "Llama viva"},
	{370665, "Rescue", "Rescate"},
	{366155, "Reversion", "Reversión"},
	{360995, "Verdant Embrace", "Abrazo glauco"}
}

local mageSpells = {
	{190356, "Blizzard", "Ventisca"},
	{12472, "Icy Veins", "Venas heladas"},
	{80353, "Time Warp", "Distorsión temporal"},
	{190319, "Combustion", "Combustión"},
	{2120, "Flamestrike", "Fogonazo"},
	{153561, "Meteor", "Meteorito"}
}

local shamanSpells = {
	{192058, "Capacitor Totem", "Tótem capacitador"},
	{2484, "Earthbind Totem", "Tótem Nexo Terrestre"},
	{1064, "Chain heal", "Sanación en cadena"},
	{77130, "Purify spirit", "Purificar espíritu"},
	{77472, "Healing wave", "Ola de sanación"},
	{61295, "Riptide", "Mareas Vivas"},
	{8004, "Healing surge", "Oleada de sanación"},
	{974, "Earth shield", "Escudo de tierra"}
}

--------------------------------------------------------------------
-- Create or update global macro
--------------------------------------------------------------------
function updateMacroNailuj(name,icon,src)
	if not InCombatLockdown() then
		local macroIndex = GetMacroIndexByName(name)
		local content = "#showtooltip " .. "\n" .. src;
		if macroIndex > 0 then
			EditMacro(macroIndex, name, icon, content)
		else
			CreateMacro(name, icon, content, 1)
		end
	end
end

--------------------------------------------------------------------
-- Core methods
--------------------------------------------------------------------

function chooseSpellByLanguage(spells, index)
	if GetLocale() == "esMX" then
		return spells[index][3]
	end
	return spells[index][2]
end

function createCustomMacroNailuj(button, spells, pos, name, body)
	local button = CreateFrame("Button", button, nil,  "SecureActionButtonTemplate")
	button:RegisterEvent("PLAYER_ENTERING_WORLD")
	button:RegisterEvent("UNIT_SPELLCAST_STOP")
	button:RegisterForClicks("LeftButtonDown", "LeftButtonUp" )
	button:SetAttribute("type","macro")
	button:SetScript("OnEvent", function(self,event, arg1)
			if not InCombatLockdown() then
				if event == "PLAYER_ENTERING_WORLD" then
					local _, _, icon, _, _, _, _, _ = GetSpellInfo(spells[pos][1])
					updateMacroNailuj(name, icon, body)
				end
				if event == "UNIT_SPELLCAST_STOP" and arg1 == "player" then
					local _, _, icon, _, _, _, _, _ = GetSpellInfo(spells[pos][1])
					updateMacroNailuj(name, icon, body)
				end
			end
		end)
end

--------------------------------------------------------------------
-- Creating paladin macros
--------------------------------------------------------------------
if englishClass == "PALADIN" then
	createCustomMacroNailuj("paladinFinalReckoningButton", paladinSpells, 1, "Final reckoning", "/use [@cursor] " .. chooseSpellByLanguage(paladinSpells, 1))
	createCustomMacroNailuj("paladinAvengingWrathButton", paladinSpells, 2, "Avenging wrath", "/use " .. chooseSpellByLanguage(paladinSpells, 2) .. "\n/use 14\n/y LET FLY!")
	createCustomMacroNailuj("paladinBlessOfProtectionButton", paladinSpells, 3, "B of protection", "/use [@mouseover] " .. chooseSpellByLanguage(paladinSpells, 3))
	createCustomMacroNailuj("paladinBlessOfSacrificeButton", paladinSpells, 4, "B of sacrifice", "/use [@mouseover] " .. chooseSpellByLanguage(paladinSpells, 4))
	createCustomMacroNailuj("paladinDivProtectionButton", paladinSpells, 5, "Div protection", "/use " .. chooseSpellByLanguage(paladinSpells, 5) .. "\n/use 14")
	createCustomMacroNailuj("paladinRedemptionButton", paladinSpells, 6, "Revive single", "/use " .. chooseSpellByLanguage(paladinSpells, 6) .. "\n/s Reviviendo al manco de %t xD")
	createCustomMacroNailuj("paladinArdentDefenderButton", paladinSpells, 7, "Ardent defender", "/use " .. chooseSpellByLanguage(paladinSpells, 7) .. "\n/use 13")
	createCustomMacroNailuj("paladinStunPvpFocusButton", paladinSpells, 8, "Stun PvP Focus", "/use [@focus] " .. chooseSpellByLanguage(paladinSpells, 8))
end

--------------------------------------------------------------------
-- Creating druid macros
--------------------------------------------------------------------
if englishClass == "DRUID" then
	createCustomMacroNailuj("druidBarkskinButton", druidSpells, 1, "Barkskin", "/use " .. chooseSpellByLanguage(druidSpells, 1) .. "\n/use 13")
	createCustomMacroNailuj("druidReviveButton", druidSpells, 2, "Revive single", "/use " .. chooseSpellByLanguage(druidSpells, 2) .. "\n/s Reviviendo al manco de %t xD")
end

--------------------------------------------------------------------
-- Creating warrior macros
--------------------------------------------------------------------
if englishClass == "WARRIOR" then
	createCustomMacroNailuj("warriorLastStandButton", warriorSpells, 1, "Last stand", "/use " .. chooseSpellByLanguage(warriorSpells, 1) .. "\n/use 13")
	createCustomMacroNailuj("warriorRavagerButton", warriorSpells, 2, "Ravager", "/use [@cursor] " .. chooseSpellByLanguage(warriorSpells, 2))
	createCustomMacroNailuj("warriorChargeButton", warriorSpells, 3, "Charge", "/use [nomod:alt] " .. chooseSpellByLanguage(warriorSpells, 3) .. "\n/use [mod:alt] " .. chooseSpellByLanguage(warriorSpells, 4))
end

--------------------------------------------------------------------
-- Creating DK macros
--------------------------------------------------------------------
if englishClass == "DEATHKNIGHT" then
	createCustomMacroNailuj("dkDeathDecayButton", deathKnightSpells, 1, "Death and Decay", "/use [@cursor] " .. chooseSpellByLanguage(deathKnightSpells, 1))
end

--------------------------------------------------------------------
-- Creating priest macros
--------------------------------------------------------------------
if englishClass == "PRIEST" then
	createCustomMacroNailuj("priestFeatherButton", priestSpells, 1, "Feather", "/use [@player] " .. chooseSpellByLanguage(priestSpells, 1))
	createCustomMacroNailuj("priestFlashHealButton", priestSpells, 2, "Flash Heal", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 2))
	createCustomMacroNailuj("priestHealButton", priestSpells, 3, "Heal", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 3))
	createCustomMacroNailuj("priestHwSanctifyButton", priestSpells, 4, "HW Sanctify", "/use [@cursor] " .. chooseSpellByLanguage(priestSpells, 4))
	createCustomMacroNailuj("priestHwSerenityButton", priestSpells, 5, "HW Serenity", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 5))
	createCustomMacroNailuj("priestMassDispelButton", priestSpells, 6, "Mass dispel", "/use [@cursor] " .. chooseSpellByLanguage(priestSpells, 6))
	createCustomMacroNailuj("priestPowerInfusionButton", priestSpells, 7, "Power Infusion", "/use [@focus] " .. chooseSpellByLanguage(priestSpells, 7) .. "\n/use [@mouseover] 14")
	createCustomMacroNailuj("priestPrayerMendingButton", priestSpells, 8, "Pr of mending", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 8))
	createCustomMacroNailuj("priestPurifyButton", priestSpells, 9, "Purify", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 9))
	createCustomMacroNailuj("priestRenewButton", priestSpells, 10, "Renew", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 10))
	createCustomMacroNailuj("priestPwShieldButton", priestSpells, 11, "PW Shield", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 11))
	createCustomMacroNailuj("priestKey1DisciButton", priestSpells, 12, "Key 1 disci", "/cast [@mouseover,exists] " .. chooseSpellByLanguage(priestSpells, 10) .. "\n" .. "/cast [@target] " .. chooseSpellByLanguage(priestSpells, 12))
	createCustomMacroNailuj("priestKey2DisciButton", priestSpells, 13, "Key 2 disci", "/cast [@mouseover,exists] " .. chooseSpellByLanguage(priestSpells, 2) .. "\n" .. "/cast [@target] " .. chooseSpellByLanguage(priestSpells, 13))
	createCustomMacroNailuj("priestKey4DisciButton", priestSpells, 15, "Key 4 disci", "/cast [@mouseover,exists] " .. chooseSpellByLanguage(priestSpells, 14) .. "\n" .. "/cast [@target] " .. chooseSpellByLanguage(priestSpells, 15))
	createCustomMacroNailuj("priestPainSuppressionButton", priestSpells, 16, "Pain Suppression", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 16))
	createCustomMacroNailuj("priestPenanceButton", priestSpells, 17, "Penance", "/cast [@mouseover,exists][@target,exists][@player] " .. chooseSpellByLanguage(priestSpells, 17))
	createCustomMacroNailuj("priestVampiricEmbraceButton", priestSpells, 18, "Vampiric Embrace", "/use " .. chooseSpellByLanguage(priestSpells, 18) .. "\n/use 13")
	createCustomMacroNailuj("priestShadowCrashButton", priestSpells, 19, "Shadow crash", "/use [@cursor] " .. chooseSpellByLanguage(priestSpells, 19))
end

--------------------------------------------------------------------
-- Creating evoker macros
--------------------------------------------------------------------
if englishClass == "EVOKER" then
	createCustomMacroNailuj("evokerBlisteringScalesButton", evokerSpells, 1, "BlisteringScales", "/use [@mouseover] " .. chooseSpellByLanguage(evokerSpells, 1))
	createCustomMacroNailuj("evokerDispelButton", evokerSpells, 3, "Dispel", "/use [nomod:alt, @mouseover] " .. chooseSpellByLanguage(evokerSpells, 2) .. " ; " .. " [mod:alt, @mouseover] " .. chooseSpellByLanguage(evokerSpells, 3))
	createCustomMacroNailuj("evokerDragonrageButton", evokerSpells, 4, "Dragonrage", "/use " .. chooseSpellByLanguage(evokerSpells, 4) .. "\n" .. "/use 13")
	createCustomMacroNailuj("evokerEchoButton", evokerSpells, 5, "Echo", "/use [@mouseover] " .. chooseSpellByLanguage(evokerSpells, 5))
	createCustomMacroNailuj("evokerEmeraldBlossomButton", evokerSpells, 6, "Emerald blossom", "/use [@player] " .. chooseSpellByLanguage(evokerSpells, 6))
	createCustomMacroNailuj("evokerLivingFlamePlayerButton", evokerSpells, 7, "Flame Player", "/use [@player] " .. chooseSpellByLanguage(evokerSpells, 7))
	createCustomMacroNailuj("evokerLivingFlameButton", evokerSpells, 7, "Living flame", "/use [@mouseover] " .. chooseSpellByLanguage(evokerSpells, 7))
	createCustomMacroNailuj("evokerRescueButton", evokerSpells, 8, "Rescue", "/use [@mouseover] " .. chooseSpellByLanguage(evokerSpells, 8))
	createCustomMacroNailuj("evokerReversionButton", evokerSpells, 9, "Reversion", "/use [@mouseover] " .. chooseSpellByLanguage(evokerSpells, 9))
	createCustomMacroNailuj("evokerVerdantEmbraceButton", evokerSpells, 10, "Verdant embrace", "/use [@mouseover] " .. chooseSpellByLanguage(evokerSpells, 10))
end
--------------------------------------------------------------------
-- Creating mage macros
--------------------------------------------------------------------
if englishClass == "MAGE" then
	createCustomMacroNailuj("mageBlizzardButton", mageSpells, 1, "Blizzard", "/use [@cursor] " .. chooseSpellByLanguage(mageSpells, 1))
	createCustomMacroNailuj("mageIcyVeinsButton", mageSpells, 2, "Icy veins", "/use " .. chooseSpellByLanguage(mageSpells, 2) .. "\n" .. "/use 13")
	createCustomMacroNailuj("mageTimeWarpButton", mageSpells, 3, "Time warp", "/use " .. chooseSpellByLanguage(mageSpells, 3) .. "\n" .. "/use 14")
	createCustomMacroNailuj("mageCombustionButton", mageSpells, 4, "Combustion", "/use " .. chooseSpellByLanguage(mageSpells, 4) .. "\n" .. "/use 13")
	createCustomMacroNailuj("mageFlamestrikeButton", mageSpells, 5, "Flamestrike", "/use [@cursor] " .. chooseSpellByLanguage(mageSpells, 5))
	createCustomMacroNailuj("mageMeteorButton", mageSpells, 6, "Meteor", "/use [@cursor] " .. chooseSpellByLanguage(mageSpells, 6))
end
--------------------------------------------------------------------
-- Creating shaman macros
--------------------------------------------------------------------
if englishClass == "SHAMAN" then
	createCustomMacroNailuj("shamanCapacitorTotemButton", shamanSpells, 1, "Capacitor Totem", "/use [@player] " .. chooseSpellByLanguage(shamanSpells, 1))
	createCustomMacroNailuj("shamanEarthbindTotemButton", shamanSpells, 2, "Earthbind Totem", "/use [@player] " .. chooseSpellByLanguage(shamanSpells, 2))
	createCustomMacroNailuj("shamanChainHealButton", shamanSpells, 3, "Chain Heal", "/use [@mouseover] " .. chooseSpellByLanguage(shamanSpells, 3))
	createCustomMacroNailuj("shamanPurifySpiritButton", shamanSpells, 4, "Purify Spirit", "/use [@mouseover] " .. chooseSpellByLanguage(shamanSpells, 4))
	createCustomMacroNailuj("shamanHealingWaveButton", shamanSpells, 5, "Healing wave", "/use [@mouseover] " .. chooseSpellByLanguage(shamanSpells, 5))
	createCustomMacroNailuj("shamanRiptideButton", shamanSpells, 6, "Riptide", "/use [@mouseover] " .. chooseSpellByLanguage(shamanSpells, 6))
	createCustomMacroNailuj("shamanHealingSurgeButton", shamanSpells, 7, "Healing surge", "/use [@mouseover] " .. chooseSpellByLanguage(shamanSpells, 7))
	createCustomMacroNailuj("shamanEarthShieldButton", shamanSpells, 8, "Earth Shield", "/use [@mouseover] " .. chooseSpellByLanguage(shamanSpells, 8))
end

