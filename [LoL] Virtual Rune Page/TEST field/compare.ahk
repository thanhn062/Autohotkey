#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;~ #Include ScreenClipping.ahk
;~ ---- Example for /crop:
;~ i_view32.exe c:\test.jpg /crop=(10,10,300,300)
;~ i_view32.exe c:\test.jpg /crop=(10,10,300,300) /convert=c:\giftest.gif
;~ F1::
;~ Run, %comspec% /c "" "%A_ScriptDir%" ""\IrfanViewPortable\ && start IrfanViewPortable.exe  %A_ScriptDir%\icon_runes_ability_power_red_tier3.png /crop=(22`,33`,59`,54),, Hide
;~ if not A_IsAdmin
;~ {
   ;~ Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ;~ ExitApp
;~ }

;~ listOfRune =
;~ (Ltrim
	
;~ )
;~ Run, %comspec% /c images\IrfanViewPortable\IrfanViewPortable.exe icon_runes_ability_power_red_tier3.png /crop=(22`,33`,38`,22) /convert=giftest.bmp,, Hide


;~ Run, %comspec% /c cd "" "%A_ScriptDir%" "" && start i_view32.exe "" "%A_ScriptDir%" "" \icon_runes_ability_power_red_tier3.png /crop=(10,10,200,200),, Hide
;~ ^Lbutton::SC_ScreenClipping()


;~ 1920 x 1080
;~ Gui, Add, Picture, , 1920x1080 1600x900.bmp
size=64
;~ Gui, Add, Picture, w%size% h%size% , RUNE_5267.png
GUi, Add, ActiveX, w200 h200 vWB, Shell . Explorer
Gui, Add, Picture, , %A_ScriptDir%\images\rune\icon_runes_ability_power_red_tier3.png
WB.silent := true
WB.Navigate("about:blank")
;~ <img src="%A_ScriptDir%\1920x1080 1600x900.bmp"><br>
html =	
(
<!DOCTYPE html>
<html>
	<body>
		<!-- <img src="%A_ScriptDir%\1920x1080 1600x900.bmp"> 
		<img style="width: %size%px; height: %size%px"  src="%A_ScriptDir%\images\rune\icon_runes_ability_power_red_tier3.png"> -->
		
		<img src="%A_ScriptDir%\TEST field\1920x1080 1600x900.bmp">
		<img style="width: %size%px; height: %size%px" src="%A_ScriptDir%\images\rune\icon_runes_ability_power_red_tier1.png">
		<img style="width: %size%px; height: %size%px" src="%A_ScriptDir%\images\rune\icon_runes_ability_power_red_tier2.png">
		<img style="width: %size%px; height: %size%px" src="%A_ScriptDir%\images\rune\icon_runes_ability_power_red_tier3.png">
	</body>
</html>
)
WB.Document.Write(html)
Gui, Show
x = 38
return

F1::
;~ WinGetPos, leagueX, leagueY, leagueW, leagueH, League Client
;~ Loop
x--
ToolTip %x%
	ImageSearch, findX, findY, 0, 0, A_ScreenWidth, A_ScreenHeight,*94 *w29 *h-1 %A_ScriptDir%\images\search\icon_runes_ability_power_red_tier3.bmp
	if !ErrorLevel
		MouseMove, findX, findY
return

F5::ExitApp

ImageSearchArea(x1,y1,x2,y2,img) {
	
}

GuiClose:
ExitApp