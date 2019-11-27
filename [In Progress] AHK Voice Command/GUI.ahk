#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include AHK Voice Command,ahk
;~ Icon, message.ico, , 1
Gui, Add, Edit
Gui, +AlwaysOnTop +ToolWindow +OwnDialogs
; Add Custom Menu
Menu, Tray, NoStandard
Menu, Menu, add, About
Menu, Menu, add, Setting
Menu, Menu, add, Exit
Menu, tray, add, About
Menu, tray, add, Setting
Menu, tray, add, Exit
Menu, Tray, Icon, icon.ico
;~ Gui, +Hidden
Gui, Show, w500 h500, Folder Action Listener
return

; Menu Label
About:
Gui, Show
return

Setting:
Gui, Show
return

Exit:
ExitApp
return

GuiClose:
GuiEscape:
Gui, hide
return

F5::ReLoad