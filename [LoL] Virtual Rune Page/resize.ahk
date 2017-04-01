#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

RunWait, %comspec% /c images\IrfanViewPortable\IrfanViewPortable.exe "" "%A_LoopFileFullPath%" "" /resize=(29,0) /convert=images\search\%name%.bmp,, Hide