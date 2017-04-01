#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

F1::
if FileExist("" A_ScreenWidth "x" A_ScreenWidth)
	WinGetPos, winX, winY, winW, winH, League Client

newW := winW+50
newH := winH+50
WinMove, League Client,, winX, winY, newW, newH