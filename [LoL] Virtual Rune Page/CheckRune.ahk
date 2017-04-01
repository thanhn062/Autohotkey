#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

x = 39
F1::
x--
ToolTip % x
	;~ ImageSearch, findX, findY, 0, 0, A_ScreenWidth, A_ScreenHeight,*94 *w29 *h-1 %A_ScriptDir%\images\search\icon_runes_ability_power_red_tier3.bmp
	ImageSearch, findX, findY, 0, 0, A_ScreenWidth, A_ScreenHeight,*110 *w11 *h-1 %A_ScriptDir%\images\search\icon_runes_ability_power_red_tier3.bmp
		if !ErrorLevel
			MouseMove, findX, findY
		
	;~ ImageSearch, findX, findY, 0, 0, A_ScreenWidth, A_ScreenHeight,*120 *w29 *h-1 %A_ScriptDir%\images\search\icon_runes_armor_red_tier3.png
		;~ if !ErrorLevel
			;~ MouseMove, findX, findY
		
	;~ ImageSearch, findX, findY, 0, 0, A_ScreenWidth, A_ScreenHeight,*150 *w28 *h-1 %A_ScriptDir%\images\search\icon_runes_attack_damage_red_tier3.png
		;~ if !ErrorLevel
			;~ MouseMove, findX, findY
return

F5::ExitApp
/*
x++
Red_Tier3 = 
(Ltrim
	Ability Power
	Armor
	Attack Damage
	Attack Speed
	Cooldown Reduction
	Critical Chance
	Critical Damage
	Health
	Lethality
	Magic Resist
	Mana
	Mana Regeneration
	Precision
	Scaling Ability Power
	Scaling Attack Damage
	Scaling Health
	Scaling Magic Resist
	Scaling Mana
)
Loop, parse, Red_Tier3, `n
{
	StringReplace, currRune, A_LoopField, %A_Space%,_,all
	ImageSearch, findX, findY, 0, 0, A_ScreenWidth, A_ScreenHeight,*94 *w29 *h-1 %A_ScriptDir%\images\search\icon_runes_%currRune%_red_tier3.png
		if !ErrorLevel
			MouseMove, findX, findY
}
/*
Loop, parse, Red_Tier3, `n
{
	if (A_Index = x)
	{
		StringReplace, currRune, A_LoopField, %A_Space%,_,all
		ImageSearch, findX, findY, 0, 0, A_ScreenWidth, A_ScreenHeight,*94 *w29 *h-1 %A_ScriptDir%\images\search\icon_runes_%currRune%_red_tier3.png
		if !ErrorLevel
			MouseMove, findX, findY
		break
	}
}
return