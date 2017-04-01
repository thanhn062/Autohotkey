#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines -1

Loop, files, images\rune\*.png
	Total := A_Index
Loop, files, images\rune\*.png
{
	ToolTip, %A_Index% / %Total%
	StringTrimRight, name, A_LoopFileName, 4
	IfInString, A_LoopFileName, black
		RunWait, %comspec% /c images\IrfanViewPortable\IrfanViewPortable.exe "" "%A_LoopFileFullPath%" "" /crop=(46`,70`,69`,40) /convert=images\search\%name%.bmp,, Hide
	else
		RunWait, %comspec% /c images\IrfanViewPortable\IrfanViewPortable.exe "" "%A_LoopFileFullPath%" "" /crop=(22`,33`,38`,22) /convert=images\search\%name%.bmp,, Hide
}