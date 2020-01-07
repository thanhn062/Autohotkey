;==============================
;==             Title: Autohotkey Voice Command
;==             Author: Thanh Ngo
;==             Date: 11/25/2019
;==             Description: A way to control your computer freely with autohotokey combine with voice command
;==				example:
;==				Google Home / Alexa > IFTTT > Pushbullet > Autohotkey
;==============================
;==             Manual
;==============================
;== -Commands:
;==         - shutdown                       - shut down computer
;==         - logout                            - log out of user
;==         - hibernate                       - put pc into hibernation
;==         - sleep                              - sleep pc
;==         - restart                            - restart pc
;==         - monitor_off                    - turn off monitor
;==         - lockinput|<on/off>        - lock / unlock key & mosue input
;==         - open|<file name>          - example: "hey google open homework"
;==         - append|<text>               -
;==         - msgbox|<text>               -
;==         - speech2text|<text>        -
;==         - send|<key>                    -
;==============================
;~ SendMessage 0x112, 0xF140, 0, , Program Manager  ; Start screensaver
;~ SendMessage 0x112, 0xF170, 2, , Program Manager  ; Monitor off

;~ #SingleInstance
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#Persistent
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Run as Admin
   ExitApp
}

token = 00000000000000000000
FileDelete, output.txt
SetTimer, PushBullet, 850  ; Set timer for script to check one the command folder everything 500ms/ half a seconds (you can change this)
return


PushBullet:
action =
action_0 =
action_1 =
action_2 =
action := getPush()
if (action) {
   StringSplit, action_, action, |												        	; Split action parameters

   if (action_1 = "speech2text")                                                       ; [SPEECH2TEXT]
      Send %action_2%
   else if (action_1 = "msgbox")
      MsgBox % action_2
   else if (action_1 = "open")                                                           ; [OPEN] <speech >
      Run, %action_2%
   else if (action_1 = "append")                                                       ; [APPEND] file (append|<content>)
      FileAppend,  %action_2%`r`n, note.txt
   else if (action_1 = "shutdown")                                                   ; [SHUTDOWN] (force)
      Shutdown, 8
   else if (action_1 = "monitor_off")                                             ; [MONITOR_OFF]
      SendMessage 0x112, 0xF170, 2, , Program Manager
   else if (action_1 = "logoff")                                                        ; [LOGOFF] user (close all data)
   {
      Shutdown, 0
      SendMessage 0x112, 0xF170, 2, , Program Manager           ; turn off screen
   }
   else if (action_1 = "lock") 
   {                                                  
      Run rundll32.exe user32.dll`,LockWorkStation                    ; [LOCK] user (keep all data)
      Sleep 1000                                                                              ; Wait 1 second,
      SendMessage 0x112, 0xF170, 2, , Program Manager        ; turn off screen
   }
   else if (action_1 = "restart")                                                   ; [RESTART] computer
      Shutdown, 2
   
; Parameter #1: Pass 1 instead of 0 to hibernate rather than suspend.
; Parameter #2: Pass 1 instead of 0 to suspend immediately rather than asking each application for permission.
; Parameter #3: Pass 1 instead of 0 to disable all wake events.
   else if (action_1 = "sleep")                                                  ; [SLEEP] computer
      DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
   else if (action_1 = "hibernate")                                            ; [HIBERNATE] computer
      DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)
   ;    INPUT 
   else if (action_1 = "lockinput")
   {
      if (action_2 = "on")
         hk(1,1,"")
      else
      {
         Loop
         {
            BlockInput, Off
            InputBox, password, PIN Code, Input PIN code to unlock input`nDefault is blank, just enter,HIDE, 100, 100
            If (password = "")
            {
               hk(0,0,"")
               break
            }
         }
      }
   }
   else if (action_1 = "send")
      Send, {%action_2%}
}
return

; ====== FUNCTIONS ========
getPush() {
	global token, prev_time, prev_action
	; Run REQUEST curl for latest message
		Run, %comspec% /c curl -u %token%: https://api.pushbullet.com/v2/pushes?limit=1 -o output.txt,,hide
		IfExist, output.txt
			while (!output)
				FileReadLine, output, output.txt, 1									; Make sure the variable is loaded into var
		FileDelete, output.txt		        ; Delete 
        if (!output)
         return
		pos := RegExMatch(output, "modified(.*)type", modified)	; RegExMatch to look for timestamp
		StringTrimRight, modified, modified, 6									; Clean up the variable
		StringTrimLeft, modified, modified, 11

		pos := RegExMatch(output, "body(.*)}]", action)					; RegExMatch to look for message content
		StringTrimRight, action, action, 3											; Clean up the variable
		StringTrimLeft, action, action, 7
		;~ MsgBox "%action%"`n"%modified%"`n"%prev_action%"`n"%output%"
      
      if (!prev_time) ; set initial timestamp
      {
         prev_time := modified
         return
      }
      ; If it's the timetamp is newer than the last
      if (prev_time < modified)
      {
         prev_action := action
         prev_time := modified
         return action
      }
}

; https://www.autohotkey.com/boards/viewtopic.php?t=33925
; Function to disabled keyboard & mouse
hk(keyboard:=0, mouse:=0, message:="", timeout:=3) { 
   static AllKeys
   if !AllKeys {
      s := "||NumpadEnter|Home|End|PgUp|PgDn|Left|Right|Up|Down|Del|Ins|"
      Loop, 254
      {
         k := GetKeyName(Format("VK{:0X}", A_Index))
         IfInString, k, Numpad
            continue
         else IfInString, k, Enter
            continue
         else IfInString, k, BackSpace
            continue
         else
            s .= InStr(s, "|" k "|") ? "" : k "|"
      }
      
      For k,v in {Control:"Ctrl",Escape:"Esc"}
         AllKeys := StrReplace(s, k, v)
      
      ;~ StringReplace, AllKeys, AllKeys, |0|,, All
      ;~ Loop, 9
         ;~ StringReplace, AllKeys, AllKeys, |%A_index%|,, All
      
      AllKeys := StrSplit(Trim(AllKeys, "|"), "|")
      BlockInput, On
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
return
;Emergency Exit
F5::ExitApp


