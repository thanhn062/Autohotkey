#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetRuneCode()

F1::
WinGetPos, winX, winY, winW, winH, League Client
Code = 3Mx1x4|3Mx11x5
loadRune(Code)
;~ CoordMode, Pixel, Window
;~ ImageSearch, clickX, clickY, 0, 0, 359, winH, %A_ScriptDir%\mark\ability power.bmp
;~ ImageSearch, clickX, clickY, 0, 0, 359, winH, %A_ScriptDir%\images\search\mark\critical chance.bmp
;~ if ErrorLevel = 0
	;~ MouseMove, clickX, clickY
return

loadRune(RuneCode) {
	global winH
	Loop, parse, RuneCode, |
	{
		StringSplit, info_, A_LoopField, x
		StringLeft, R_Tier,  info_1, 1
		StringRight, R_Type, info_1, 1
		if R_Type = M
			R_Type = mark
		else if R_Type = S
			R_Type = seal
		else if R_Type = G
			R_Type = glyph
		else if R_Type = Q
			R_Type = quint
		temp := R_%info_1%%info_2%
		Loop
		{
			ImageSearch, clickX, clickY, 0, 0, 359, winH, %A_ScriptDir%\images\search\tier%R_Tier%\%R_Type%\%temp%.bmp
			if ErrorLevel = 0
			{
				Loop, %info_3%
				{
					MouseClick, R, clickX, clickY
					Sleep 50
				}
				break
			}
			else
			{
				Send {WheelDown}
				Sleep 250
			}
		}
	}
}

makeRuneCode() {
}

readRuneCode() {
}

SetRuneCode() {
	global
; MARK - TIER 2
	R_2M1 = Attack Damage
	R_2M2 = Attack Speed
	R_2M3 = Lethality
	R_2M4 = Magic Penetration
; MARK - TIER 3
	R_3M1 = Ability Power
	R_3M2 = Armor
	R_3M3 = Attack Damage
	R_3M4 = Attack Speed
	R_3M5 = Cooldown Reduction
	R_3M6 = Critical Chance
	R_3M7 = Critical Damage
	R_3M8 = Health
	R_3M9 = Lethality
	R_3M10 = Magic Penetration
	R_3M11 = Magic Resist
	R_3M12 = Mana
	R_3M13 = Mana Regeneration
	R_3M14 = Precision
	R_3M15 = Scaling Ability Power
	R_3M16 = Scaling Attack Damage
	R_3M17 = Scaling Health
	R_3M18 = Scaling Magic Resist
	R_3M19 = Scaling Mana
; SEAL - TIER 2
	R_2S1 = Armor
	R_2S2 = Health
	R_2S3 = Health Regeneration
	R_2S4 = Magic Resist
	R_2S5 = Scaling Health
; SEAL - TIER 3
	R_3S1 = Ability Power
	R_3S2 = Armor
	R_3S3 = Attack Damage
	R_3S4 = Attack Speed
	R_3S5 = Cooldown Reduction
	R_3S6 = Critical Chance
	R_3S7 = Critical Damage
	R_3S8 = Energy Regeneration
	R_3S9 = Gold
	R_3S10 = Health
	R_3S11 = Health Regeneration
	R_3S12 = Magic Resist
	R_3S13 = Mana
	R_3S14 = Mana Regeneration
	R_3S15 = Percent Health
	R_3S16 = Scaling Ability Power
	R_3S17 = Scaling Armor
	R_3S18 = Scaling Attack Damage
	R_3S19 = Scaling Health
	R_3S20 = Scaling Energy Regeneration
	R_3S21 = Scaling Health
	R_3S22 = Scaling Health Regeneration
	R_3S23 = Scaling Magic Resist
	R_3S24 = Scaling Mana
	R_3S25 = Scaling Mana Regeneration
; GLYPH - TIER 2
	R_2G1 = Ability Power
	R_2G2 = Cooldown Reduction
	R_2G3 = Magic Resist
	R_2G4 = Mana Regeneration
	R_2G5 = Scaling Health
; GLYPH - TIER 3
	R_3G1 = Ability Power
	R_3G2 = Armor
	R_3G3 = Attack Damage
	R_3G4 = Cooldown Reduction
	R_3G5 = Critical Chance
	R_3G6 = Critical Damage
	R_3G7 = Energy
	R_3G8 = Health
	R_3G9 = Health Regeneration
	R_3G10 = Magic Penetration
	R_3G11 = Magic Resist
	R_3G12 = Mana
	R_3G13 = Mana Regeneration
	R_3G14 = Scaling Ability Power
	R_3G15 = Scaling Attack Damage
	R_3G16 = Scaling Cooldown Reduction
	R_3G17 = Scaling Energy
	R_3G18 = Scaling Health
	R_3G19 = Scaling Magic Resist
	R_3G20 = Scaling Mana
	R_3G21 = Scaling Mana Regeneration
; QUINT - TIER 2
; QUINT - TIER 3
	R_3Q1 = Ability Power,
	R_3Q2 = Armor,
	R_3Q3 = Attack Damage,
	R_3Q4 = Attack Speed,
	R_3Q5 = Cooldown Reduction,
	R_3Q6 = Critical Chance,
	R_3Q7 = Energy,
	R_3Q9 = Energy Regeneration,
	R_3Q10 = Experience,
	R_3Q11 = Gold,
	R_3Q12 = Health,
	R_3Q13 = Health Regeneration,
	R_3Q14 = Lethality,
	R_3Q15 = Magic Penetration,
	R_3Q16 = Life Steal,
	R_3Q17 = Movement Speed,
	R_3Q18 = Percent Health,
	R_3Q19 = Precision,
	R_3Q20 = Scaling Armor,
	R_3Q21 = Scaling Attack Damage,
	R_3Q22 = Scaling Magic Resist,
	R_3Q23 = Scaling Mana,
	R_3Q24 = Spell Vamp
	
}
F5::ExitApp