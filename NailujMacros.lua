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
	button:RegisterForClicks("LeftButtonDown", "LeftButtonUp" )
	button:SetAttribute("type","macro")
	button:SetScript("OnEvent", function(self,event, arg1)
			if not InCombatLockdown() then
				if event == "PLAYER_ENTERING_WORLD" then
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
	createCustomMacroNailuj("priestPowerInfusionButton", priestSpells, 7, "Power Infusion", "/use [@mouseover] " .. chooseSpellByLanguage(priestSpells, 7) .. "\n/use [@mouseover] 14")
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

