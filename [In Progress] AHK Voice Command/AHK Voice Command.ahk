;==============================
;==             Title: Autohotkey Voice Command
;==             Author: Thanh Ngo
;==             Date: 11/25/2019
;==============================
;==             Manual
;==============================
;== -Commands:
;==     + Main:
;==         X- shutdown
;==         X- logout
;==         X- hibernate
;==         X- sleep
;==         X- restart
;==
;==     + Monitor:
;==         X- monitor_off
;==
;==     + InputLock
;==         X- lockinput / unlockinput
;==
;==     + File
;==         X- open:<path>
;==         X- append:<path>
;==
;==     + Notification
;==         X- msgbox:<text>
;==         X- noti:<text>
;==
;==     +Voice Type
;==         X speech2text
;==============================
;~ SendMessage 0x112, 0xF140, 0, , Program Manager  ; Start screensaver
;~ SendMessage 0x112, 0xF170, 2, , Program Manager  ; Monitor off
    

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir C:\Users\thanh_\OneDrive\AHKVC\  ; Ensures a consistent starting directory.
#Persistent
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Run as Admin
   ExitApp
}
SetTimer, OneDrive, 250  ; Set timer for script to check one the command folder everything 250ms or a quarter of a seconds (you can change this)
return

F5::ExitApp
OneDrive:
; Reset variable
action =
action_1 =
action_2 =

; Checking for new commands.    
IfExist, command.txt
{
   FileReadLine, action, command.txt, 1                                 ; Read 1st line of .txt (action)
   if (action)                                                                               ; wait until variable is fill
      FileDelete, command.txt                                                   ; Delete command, and wait for new command.
   StringSplit, action_, action, |
   
   ;    VOICE
   if (action_1 = "speech2text")                                                ; [SPEECH2TEXT]
      Send %action_2%
   ;    MESSAGE BOX
   else if (action_1 = "msgbox")                                                 ; [MSGBOX]|<text>
      MsgBox,,, %action_2%
   else if (action_1 = "noti")                                                      ; [NOTI]|<text>
      TrayTip, AHK Voice Command, %action_2%
   ;    FILE
   else if (action_1 = "open")                                                  ; [OPEN] file
      Run, %action_2%
   else if (action_1 = "append")                                            ; [APPEND] file (append|<content>)
      FileAppend,  %action_2%`r`n, text.txt
   ;    MAIN
   else if (action_1 = "shutdown")                                                   ; [SHUTDOWN] (force)
      Shutdown, 8
   else if (action_1 = "monitor_OFF")                                      ; [MONITOR_OFF]
      SendMessage 0x112, 0xF170, 2, , Program Manager
   else if (action_1 = "logoff")                                                 ; [LOGOFF] user (close all data)
   {
      Shutdown, 0
      SendMessage 0x112, 0xF170, 2, , Program Manager ; turn off screen
   }
   else if (action_1 = "lock") 
   {                                                  
      Run rundll32.exe user32.dll`,LockWorkStation            ; [LOCK] user (keep all data)
      Sleep 1000                                                                       ; Wait 1 second,
      SendMessage 0x112, 0xF170, 2, , Program Manager  ; turn off screen
   }
   else if (action_1 = "restart")                                                 ; [RESTART] computer
      Shutdown, 2
   
; Parameter #1: Pass 1 instead of 0 to hibernate rather than suspend.
; Parameter #2: Pass 1 instead of 0 to suspend immediately rather than asking each application for permission.
; Parameter #3: Pass 1 instead of 0 to disable all wake events.
   
   else if (action_1 = "sleep")                                                  ; [SLEEP] computer
      DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
   else if (action_1 = "hibernate")                                            ; [HIBERNATE] computer
      DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)
   ;    INPUT 
   else if (action_1 = "lockinput_ON")                                      ; [INPUTLOCK_ON]
      hk(1,1,"")
   else if (action_1 = "lockinput_OFF")                                      ;[INPUTLOCK_OFF]
      hk(0,0,"")
}
return

; Function to disabled keyboard & mouse
hk(keyboard:=0, mouse:=0, message:="", timeout:=3) { 
   static AllKeys
   if !AllKeys {
      s := "||NumpadEnter|Home|End|PgUp|PgDn|Left|Right|Up|Down|Del|Ins|"
      Loop, 254
         k := GetKeyName(Format("VK{:0X}", A_Index))
       , s .= InStr(s, "|" k "|") ? "" : k "|"
      For k,v in {Control:"Ctrl",Escape:"Esc"}
         AllKeys := StrReplace(s, k, v)
      AllKeys := StrSplit(Trim(AllKeys, "|"), "|")
   }
   ;------------------
   For k,v in AllKeys {
      IsMouseButton := Instr(v, "Wheel") || Instr(v, "Button")
      Hotkey, *%v%, Block_Input, % (keyboard && !IsMouseButton) || (mouse && IsMouseButton) ? "On" : "Off"
   }
   if (message != "") {
      Progress, B1 M FS12 ZH0, %message%
      SetTimer, TimeoutTimer, % -timeout*1000
   }
   else
      Progress, Off
   Block_Input:
   Return
   TimeoutTimer:
   Progress, Off
   Return
}
