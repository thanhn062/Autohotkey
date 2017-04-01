
#NoEnv 
SendMode Input
SetWorkingDir %A_ScriptDir%
#Persistent
#SingleInstance force
SetBatchLines -1
Coordmode, Pixel, Screen
CoordMode, Mouse, SCreen

; Run As Admin - because latest clients only work w/ Run as Admin
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

configName = M.A.C.R.O.ini

IfNotExist, %configName%
{
	MsgBox There is no '%configName%' within this folder, app will exit now.
	ExitApp
}
ToolTip, SPAM ON 
Sleep 1000
x := 0
x1 := 0
s := 0

IniRead, lagrate, %configName%, Setting, SkillDelay
IniRead, lagrate1, %configName%, Setting, UsableDelay
IniRead, Suspend1, %configName%, Setting, PauseHotkey
IniRead, Exit1, %configName%, Setting,ExitHotkey
Hotkey, %Suspend1%, Suspend1
Hotkey, %Exit1%, Exit1

Loop, read, %configName%
{
	IfInString, A_Loopreadline, ----- M.A.C.R.O -----
	{
		start := true
		continue
	}
	if start = 1
	{
		IfInString, A_Loopreadline, //
		{
			StringSplit, fix_, A_Loopreadline, //
			fix := fix_1
			StringReplace, fix, fix, %A_Tab%,,all
			StringReplace, fix, fix, %A_Space%,,all
		}
		else
		{
			fix := A_LoopReadLine
			StringReplace, fix, fix, %A_Tab%,,all
			StringReplace, fix, fix, %A_Space%,,all
		}
		if fix =
			continue
		IfInString, fix, ->
		{
			StringReplace, fix, fix, ->, #
			StringSplit, Hotk_, fix, #
			%Hotk_1%sequence = %Hotk_2%
			Hotkey, %Hotk_1%, sequenceStart
			Hotkey, %Hotk_1% Up, sequenceStop
		}
		else  IfInString, fix, ,u
		{
			StringTrimRight, nowHotk, fix, 2
			Hotkey, %nowHotk%, start1
			Hotkey, %nowHotk% Up, stop1
		}
		else  IfInString, fix, #
		{
			StringSplit, fix_, fix,#
			StringSplit, temp_, fix_2,|
			coor%temp_1% :=  temp_2
			Hotkey, %fix_1%, Quickslot%temp_1%
		}
		else IfInString, fix, ,s
		{
			StringTrimRight, nowHotk1, fix, 2
			Hotkey, %nowHotk1%, selfCast
			Hotkey, %nowHotk1% Up, selfCast1
		}
		else
		{
			Hotkey, %fix%, start
			Hotkey, %fix% Up, stop
		}
	}
}
ToolTip
return

QuickSlot1:
QuickSlot2:
StringRight, currSlot , A_ThisLabel, 1
tempASD := coor%currSlot%
StringSplit, slotTemp_, tempASD, `,
BlockInput, On
MouseGetPos, oldX, oldY
MouseMove, slotTemp_1,slotTemp_2
Sleep 20
Send {LButton Down}
Sleep 30
Send {LButton Up}
Sleep 20
Send {LButton Down}
Sleep 30
Send {LButton Up}
MouseMove, oldX, oldY
Sleep 50
BlockInput, off
return

selfCast1:
return
selfCast:
Send {%A_Thishotkey%}
if (A_Priorkey = A_ThisHotkey)
{
	if A_TimeSincePriorHotkey < 220
	{
		WinGetActiveTitle, ATitle
		WinGetPos, winX, winY, winW, winH, %ATitle%
		MouseGetPos, oriX, oriY
		x := (winW/2)+5
		y := (winH/2)+15
		offSetX := (A_ScreenWidth-(A_ScreenWidth - winX))+x
		offSetY := (A_ScreenHeight-(A_ScreenHeight - winY))+y
			DllCall("SetCursorPos", int, offSetX, int, offSetY)
			Send {%A_ThisHotkey%}
			Sleep 10
		   DllCall("mouse_event", "UInt", 0x02)
		   Sleep 20
			DllCall("mouse_event", "UInt", 0x04)
			Sleep 30
			DllCall("SetCursorPos", int, oriX, int, oriY)
	}
}
return

sequenceStart:
StringSplit, sequence_, %A_ThisHotkey%sequence, |
s := 1
while s = 1
{
	Loop %sequence_0%
	{
		temp := sequence_%A_Index%
		StringSplit, temp_, temp, `,
		if temp_0 = 3
		{
			Send {%temp_1%}
			Sleep %temp_2%
		}
		else
		{
			Send {%temp_1%}
			Sleep %temp_2%
			Send {LButton Down}
			Sleep 55
			Send {Lbutton Up}
			Sleep %temp_2%
		}
	}
	if s = 0
		break
}
return

sequenceStop:
s := 0
return

start:
x := 1
while x = 1
{
	Send {%A_ThisHotkey%}
	Sleep %lagrate%
	Click
	Sleep %lagrate%
}
return

stop:
x := 0
return

start1:
x1 := 1
while x1 = 1
{
	Send {%A_ThisHotkey%}
	Sleep %lagrate1%
}
return

stop1:
x1 := 0
return

Exit1:
ExitApp
return

Suspend1:
Suspend
toggle := !toggle
if toggle = 1
{
ToolTip, HOTKEY PAUSED
Sleep 1000
ToolTip
}
else
{
ToolTip, SCRIPT STARTED
Sleep 1000
ToolTip
}
return