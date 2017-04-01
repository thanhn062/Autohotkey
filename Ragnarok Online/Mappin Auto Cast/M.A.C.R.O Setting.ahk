;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Recca - ragnarok.index@gmail.com
;
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}
#NoTrayIcon
SetBatchLines -1
#NoEnv 
SetWorkingDir %A_ScriptDir%
SendMode Input 
Coordmode, Pixel, Screen
CoordMode, Mouse, Window
MacroButtonNumber = 20
KeyboardButonNumber =100
KeyboardX = 15  
KeyboardY = 180
secondTime = 0
LoadSetting()
title = Mappin' Auto Cast RO - by : Recca ( http://ragindex.blogspot.com )
Gui, Color, F0F0F0
Gui, 2:Color, BEBED7
Gui, Font, w1000

Gui, Add, Text, x610 y476 w100 h32 gHideShow Border +Center cBlue, HIDE`nICONS
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, x13 y470 w974 h45 Border BackgroundTrans,
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Button, xp+5 yp+5 w130 h35 gClear, CLEAR ALL
Gui, Add, Button, xp+700 yp wp hp gSaveChanges, SAVE CHANGES
Gui, Add, Button, xp+135 yp wp hp gLoadCurr, Load Current Setting
Gui, Font, w0
Gui, Font, w0 norm
Gui, Add, Text, x15 y6 w164 h96 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, GroupBox, x15 y0 cBlue w80 h68, Skill Macro
Gui, Add, Picture, xp+18 y15 w40 h40 Border vMainStack1, %A_ScriptDir%\Mode\SpamMacro.bmp
Loop %MacroButtonNumber%
    Gui, Add, Picture,xp yp  hwndhWnd%A_Index%1 v1%A_Index% Border gControlMove1 +0x4000000 w40 h40 , %A_ScriptDir%\Mode\SpamMacro.bmp
Gui, Add, GroupBox, xp-18 yp+45 w80 h43 cBlue, Delay
Gui, Add, Edit, w60 xp+10 yp+15 +Number vSkillDelay
Gui, Add, UpDown, Range0-2147483647,%SkillDelay%
Gui, Add, GroupBox, x100 y0 cBlue w80 h68, Usable Macro
Gui, Add, Picture, xp+18 y15 w40 h40 Border vMainStack2, %A_ScriptDir%\Mode\Usable.bmp
Loop %MacroButtonNumber%
    Gui, Add, Picture,xp yp  hwndhWnd%A_Index%2 v2%A_Index% Border gControlMove2 +0x4000000 w40 h40 , %A_ScriptDir%\Mode\Usable.bmp
Gui, Add, GroupBox, xp-18 yp+45 w80 h43 cBlue, Delay
Gui, Add, Edit, w60 xp+10 yp+15 +Number vUsableDelay
Gui, Add, UpDown, Range0-2147483647,%UsableDelay%
Gui, Add, Text, x270 y6 w220 h168 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Groupbox, x270 y0 cBlue w220 h175, Self - Cast
Gui, Add, Picture, xp+13 y15 w40 h40 Border vMainStack3, %A_ScriptDir%\Mode\SelfCast.bmp
Loop %MacroButtonNumber%
    Gui, Add, Picture,xp yp  hwndhWnd%A_Index%3 v3%A_Index% Border gControlMove3 +0x4000000 w40 h40 , %A_ScriptDir%\Mode\SelfCast.bmp
Gui, Add, Text, xp yp+50 w80 cBlue, Activate by press the`nbutton twice
Gui, Add, Text, xp+75 yp-50, This will cast at the center`n of screen.`n====================`n/camera`nToggles between`n smooth/locked camera. `nOn | Off`n====================`nMake sure this ^ command`n is ON for 100`% accuracy
Gui, Add, Text, x185 y6 w80 h168 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Groupbox, x185 y0 cBlue w80 h175, Chain Macro
Gui, Add, Picture, xp+18 y15 w40 h40 Border vMainStack4, %A_ScriptDir%\Mode\Chain.bmp
Loop %MacroButtonNumber%
    Gui, Add, Picture,xp yp  hwndhWnd%A_Index%4 v4%A_Index% Border gControlMove4 +0x4000000 w40 h40 , %A_ScriptDir%\Mode\Chain.bmp
Gui, Add, Text, xp-10 yp+50, This will cast `na chain of `nkeys :`n`n Key #1 ->`n Key #2 ->`n Key #3 ->`n..........
Gui, Add, Text, x495 y6 w200 h170 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Groupbox, y0 x495 w200 h175 cBlue, 2-Hotkey Bar
Gui, Add, Picture, xp+5 y15 w40 h40 Border vMainStack5, %A_ScriptDir%\Mode\HK1.bmp
Loop 1
    Gui, Add, Picture,xp yp  hwndhWnd%A_Index%5 v5%A_Index% Border gControlMove5 +0x4000000 w40 h40 , %A_ScriptDir%\Mode\HK1.bmp
Gui, Add, Picture, xp+45 y15 w40 h40 Border vMainStack6, %A_ScriptDir%\Mode\HK2.bmp
Loop 1
    Gui, Add, Picture,xp yp  hwndhWnd%A_Index%6 v6%A_Index% Border gControlMove6 +0x4000000 w40 h40 , %A_ScriptDir%\Mode\HK2.bmp
Gui, Add, GroupBox, xp-50 yp+45 w100 h115 cBlue, Coordinates
Gui, Add, Edit, xp+5 yp+15 w89 +Center vCoor1,
Gui, Add, Button, xp yp+23 wp gPickCoor1, Pick coord #1
Gui, Add, Edit, xp yp+25 w89 +Center vCoor2,
Gui, Add, Button, xp yp+23 wp gPickCoor2, Pick coord #2
Gui, Add, Text, xp+97 yp-135, <-- Looks familiar ?`nthe 2 useless`nHotkey bar ?`n`n2-Hotkey Bar`ncan now be assign`nhotkey.`n`nThis will double`nclick the coordinate
Gui, Font, w1000 s14
Gui, Add, Text, x300 y476 +0x201 +Border  cGreen w200 h30 gRunApp, Run 'M.A.C.R.O.exe'
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Font, w0
Gui, Add, ActiveX,  x702 y8 w280 h165 vWB, Shell. Exlorer
Gui, Add, Text, x700 y6 w284 h168 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
WB.Navigate("http://textuploader.com/5efk2/raw")
wb.silent := true 
Gui, Font, w0 s30
Gui, Font, w0 s8
Gui, Add, Text, x14 y104 w165 h73 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, Add, GroupBox, x15 y100 cBLue w165 h76, Hotkeys to
Gui, Font, w1000
Gui, Add, Text, xp+2 yp+15 cBlue, PAUSE
Gui, Font, s10
Gui, Add, Button, xp yp+15 w80 h45 gHotkeyPause vHotkey_P, %PauseHotkey_L%
Gui, Font, s8
Gui, Add, Text, xp+80 yp-15 cBlue, EXIT
Gui, Font, s10
Gui, Add, Button, xp yp+15 w80 h45 gHotkeyExit vHotkey_E, %ExitHotkey_L%
Gui, Font, w0 s8
MakeKeyboard()
Gui, 2:Add, Progress, x-1 y-1 w300 h20 BackgroundA6B9E2 Disabled hwndHPROG
Gui, 2:Add, Text, x270 y3 w14 h10 r1 +0x4000 +Center gGuiClose2, X
Gui, 2:Font, w1000
Gui, 2:Add, Text, x0 y3 w300 h10 r1 +0x4000  +Center +BackgroundTrans gGuiMove2, Chain Macro Setup
Gui, 2:Font, w0
Gui, 2:Add, Listview, x0 y19 w330 h2 Background000000
Gui, 2:Add, Listview, x10 y30 w200 h200 +NoSortHdr vChainMacroLV AltSubmit gChainMacroLVX, #|Key|Delay|Mode
Gui, 2:Default
Gui, Listview, ChainMacroLV
LV_ModifyCol(2, 50)
Gui, 1:Default
Gui, 2:Add, GroupBox, xp+215 yp-6 w60 h50 cBlue, Key
Gui, 2:Add, GroupBox, xp yp+40 wp hp cBlue, Delay
Gui, 2:Add, GroupBox, xp yp+40 wp hp cBlue, Mode
Gui, 2:Add, Groupbox,xp yp+50 cBlue wp h130, Control
Gui, 2:Add, Button, xp+2 yp+15 w55 gAdd_CM, Add
Gui, 2:Add, Button, xp yp+24 wp gDel_CM, Delete
Gui, 2:Add, Button, xp yp+24 wp gmUp_CM, Move Up
Gui, 2:Add, Button, xp yp+24 wp gmDw_CM, Move Down
Gui, 2:Font, w1000
Gui, 2:Add, Button, xp-218 yp-7 w100 h50 gOK_CM, OK
Gui, 2:Add, Button, xp+101 yp wp h50 gGuiClose2, CANCEL
Gui, 2:Font, w0
Gui, 2:Add, Hotkey, x228 y40 w53 h20  Limit142 vKey_CM
Gui, 2:Add, Edit, xp yp+40 w53 h20 +Number vDelay_CM
Gui, 2:Add, UpDown, Range0-2147483647,100
Gui, 2:Add, DropDownList, xp yp+40 w53 Choose2 AltSubmit vMode_CM ,Click|No Click
Gui, 2:+ Toolwindow -Caption +AlwaysOnTop
Gui, 3:Add, Hotkey, x30 y15 w150 h20 vScriptHotkey
Gui, 3:Add, Text, +BackgroundTrans +Border x4 y4 w192 h92
Gui, 3:Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, 3:Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, 3:Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, 3:Add, Text, xp-1 yp-1 wp+2 hp+2 Border BackgroundTrans
Gui, 3:Add, Text, Center x40 y40 cblue, Press hotkey combination
Gui, 3:Add, Button, x20 y60 w80 h30 gOkay, OK
Gui, 3:Add, Button, xp+85 yp wp hp gGuiClose3, CANCEL
Gui, 3:+Toolwindow -Caption +AlwaysOnTop
Menu,Menu, Add, Remove Hotkey,Remove_Hotkey
Gui, Font, w0 s11
Gui, Add, StatusBar,
Gui, Show, w995 h540, %title%
Load()
Return
LoadCurr:
gosub Clear
Load()
return
RunApp:
Run, M.A.C.R.O.exe
return
PickCoor1:
PickCoor2:
StringRight, currCoor, A_ThisLabel, 1
MsgBox, 262208, Pick Coordinate, After this message box disappear`nthe next location you click will be record.
KeyWait LButton, D
Mousegetpos, x, y
WinGetActiveTitle, Title
GuiControl,, Coor%currCoor%, %x%,%y%
return
GuiClose4:
Gui, 4:submit
return
OK_CM:
LV_GetText(Confirm, 1)
RetrievedText =
if (Confirm ="")
    return
Loop % LV_GetCount()
{
    LV_GetText(RetrievedText1, A_Index,1)
    LV_GetText(RetrievedText2, A_Index,2)
    LV_GetText(RetrievedText3, A_Index,3)
    LV_GetText(RetrievedText4, A_Index,4)
    IfInString, RetrievedText4, No
        RetrievedText4 = ,u
    else
        RetrievedText4 =
    RetrievedText = %RetrievedText%%RetrievedText2%,%RetrievedText3%%RetrievedText4%->
}
StringTrimRight, RetrievedText, RetrievedText, 2
x%OnControl% = ChainMacro|%buttonName%|%RetrievedText%
Gui, 1:-Disabled
Gui, 2:submit
Gui, 1:default
GuiControlGet, displayButton,, %OnControl%, Text
SB_SetText("Chain Macro has been assigned to " . displayButton)
return
Add_CM:
Gui, 2:submit, nohide
Gui, 2:Default
Gui, Listview, ChainMacroLV
If Key_CM !=
{
    CM_Count++
    if Mode_CM = 1
        LV_Add("",CM_Count,Key_CM, Delay_CM, "Click")
    else
        LV_Add("",CM_Count,Key_CM, Delay_CM, "No Click")
}
    Loop % LV_GetCount()
        LV_Modify(A_Index,"",A_Index)
GuiControl, Focus, Key_CM
return
ChainMacroLVX:
if A_GuiEvent = Normal
    selectedRow := A_EventInfo
return
Del_CM:
Gui, 2:Default
Gui, Listview, ChainMacroLV
LV_Delete(selectedRow)
Loop % LV_GetCount()
    LV_Modify(A_Index,"",A_Index)
return
mUp_CM:
LV_GetText(fieldData1,selectedRow, 1)
LV_GetText(fieldData2,selectedRow, 2)
LV_GetText(fieldData3,selectedRow, 3)
LV_GetText(fieldData4,selectedRow, 4)
fieldData = %fieldData1%,%fieldData2%,%fieldData3%,%fieldData4%
LV_Delete(selectedRow)
if selectedRow != 1
    selectedRow--
LV_Insert(selectedRow,"",fieldData1,fieldData2,fieldData3,fieldData4)
LV_Modify(selectedRow, "Select")
Loop % LV_GetCount()
    LV_Modify(A_Index,"",A_Index)
return
mDw_CM:
if (selectedRow = LV_GetCount())
    return
LV_GetText(fieldData1,selectedRow, 1)
LV_GetText(fieldData2,selectedRow, 2)
LV_GetText(fieldData3,selectedRow, 3)
LV_GetText(fieldData4,selectedRow, 4)
fieldData = %fieldData1%,%fieldData2%,%fieldData3%,%fieldData4%
LV_Delete(selectedRow)
selectedRow++
LV_Insert(selectedRow,"",fieldData1,fieldData2,fieldData3,fieldData4)
LV_Modify(selectedRow, "Select")
Loop % LV_GetCount()
    LV_Modify(A_Index,"",A_Index)
return
Clear:
Loop 7
{
    GuiControlGet, MainStack%A_Index%,Pos
    if A_index = 5
        GuiControl, Move, 50, % "x" MainStack%A_Index%X "y" MainStack%A_Index%Y
    if A_index = 6
        GuiControl, Move, 60, % "x" MainStack%A_Index%X "y" MainStack%A_Index%Y
    currIndex := A_Index
    Loop %MacroButtonNumber%
    {
        GuiControl, Move, %currIndex%%A_index%, % "x" MainStack%currIndex%X "y" MainStack%currIndex%Y
    }
    GuiControl, Show, MainStack%A_Index%
    Loop 100
    {
        GuiControl, Show, Button%A_Index%
        xbutton%A_Index%=
    }
}
return
SaveChanges:
Gui, submit, nohide
FileRead, fileData, %A_ScriptDir%\M.A.C.R.O.ini
FileDelete, %A_ScriptDir%\M.A.C.R.O.ini
; Print Top Part
Loop, parse, fileData, `n
    {
    if A_LoopField =
        continue
    IfNotInString, A_LoopField, -----
        FileAppend, %A_LoopField%`n, %A_ScriptDir%\M.A.C.R.O.ini
    else
        break
    }
Loop, parse, fileData, `n
{
    if A_LoopField =
        continue
    IfInString, A_LoopField,----- M.A.C.R.O -----
    {
        FileAppend, %A_LoopField%`n, %A_ScriptDir%\M.A.C.R.O.ini
    Loop, 100
    {
        GuiControlGet, LoopButton,, button%A_Index%, Text
        buttonInfo := xbutton%A_Index%
        StringSplit, buttonInfo_, buttonInfo, |
        if buttonInfo !=
        {
        if (buttonInfo_1 = "MacroSpam")
            FileAppend, %buttonInfo_2%`n, %A_ScriptDir%\M.A.C.R.O.ini
        if (buttonInfo_1 ="UsableSpam")
            FileAppend, %buttonInfo_2%`,u`n, %A_ScriptDir%\M.A.C.R.O.ini
        if (buttonInfo_1 ="ChainMacro")
        {
            StringReplace, buttonInfo_3, buttonInfo_3,->,|,all
            content = %buttonInfo_2%->%buttonInfo_3%
            FileAppend, %content%`n, %A_ScriptDir%\M.A.C.R.O.ini
        }
        if (buttonInfo_1 ="SelfCast")
            FileAppend, %buttonInfo_2%`,s`n, %A_ScriptDir%\M.A.C.R.O.ini
        if (buttonInfo_1 = "12HotkeyBar")
            FileAppend, %buttonInfo_2%#1|%coor1%`n, %A_ScriptDir%\M.A.C.R.O.ini
        if (buttonInfo_1 = "22HotkeyBar")
            FileAppend, %buttonInfo_2%#2|%coor2%`n, %A_ScriptDir%\M.A.C.R.O.ini
        }
    }
        break
    }
}
IniWrite, %SkillDelay%, %A_ScriptDir%\M.A.C.R.O.ini,Setting,SkillDelay
IniWrite, %UsableDelay%, %A_ScriptDir%\M.A.C.R.O.ini,Setting,UsableDelay
IniWrite, %ExitHotkey%, %A_ScriptDir%\M.A.C.R.O.ini,Setting,ExitHotkey
IniWrite, %pauseHotkey%, %A_ScriptDir%\M.A.C.R.O.ini,Setting,pauseHotkey
SB_SetText("Changes has been saved")
return
HotkeyExit:
currChange = Exit
Gui, 3:Show, w200 h100, Hotkey
Gui, 3:Default
GuiControl, Focus, ScriptHotkey
GuiControl, , ScriptHotkey, %ExitHotkey%
return
HotkeyPause:
currChange = Pause
Gui, 3:Show, w200 h100, Hotkey
Gui, 3:Default
GuiControl, Focus, ScriptHotkey
GuiControl, , ScriptHotkey,%PauseHotkey%
return
Okay:
Gui, 3:submit
if currChange = Exit
{
    ExitHotkey := ScriptHotkey
    StringReplace, ExitHotkey_L, ExitHotkey, +, Shift +%A_Space%
    StringReplace, ExitHotkey_L, ExitHotkey_L, ^, Ctrl +%A_Space%
    StringReplace, ExitHotkey_L, ExitHotkey_L, !, Alt +%A_Space%
    Gui, 1:Default
    GuiControl,, Hotkey_E, %ExitHotkey_L%
}
if currChange = Pause
{
    PauseHotkey := ScriptHotkey
    StringReplace, PauseHotkey_L, PauseHotkey, +, Shift +%A_Space%
    StringReplace, PauseHotkey_L, PauseHotkey_L, ^, Ctrl +%A_Space%
    StringReplace, PauseHotkey_L, PauseHotkey_L, !, Alt +%A_Space%
    Gui, 1:Default
    GuiControl,, Hotkey_P, %PauseHotkey_L%
}
return
GuiClose3:
Gui, 3:submit
return
ControlMove1:
ControlMove2:
ControlMove3:
ControlMove4:
ControlMove5:
ControlMove6:
ControlMove7:
  StringRight, currLabel, A_ThisLabel, 1
  CheckOnControl()
  currCtrl := OnControl
  x%currCtrl%=
  Ix := SubStr( A_GuiControl,2 ), sHwnd := hWnd%Ix%%currLabel%
  DllCall( "SetWindowPos", UInt,sHwnd, UInt,0, UInt,0, UInt,0, UInt,0, UInt,0, UInt,0x43 )
  Sleep -1     ; ^ SWP_NOMOVE := 0x2 | SWP_NOSIZE := 0x1 | SWP_SHOWWINDOW := 0x40 = 0x43
  SendMessage, 0x112, 0xF012, 0,, ahk_id %sHwnd%             ; WM_SYSCOMMAND and SC_MOVE
  KeyWait LButton
  GuiControlGet,%A_GuiControl%, Pos
  GuiControl, Show, %A_GuiControl%
  OccupiedCell := %A_Guicontrol%x "," %A_Guicontrol%y
  string = %A_Guicontrol%x %A_Guicontrol%y
  CheckOnControl()
    if string != 2015
        GuiControl, Show, %currCtrl%
    if OnControl !=
        if currCtrl !=
            if (currCtrl != OnControl)
                    GuiControl, Show, %currCtrl%
  CheckRegButton()
  CheckCell()
  preChain := A_Guicontrol
  if assigned != 1
{
    GuiControlGet, MainStack%currLabel%, Pos
    GuiControl, Move, %A_Guicontrol%,% "x" MainStack%currLabel%X "y" MainStack%currLabel%Y
    GuiControl, Show, %OnControl%
    x%currCtrl%=
}
return
GuiClose:
ExitApp
return
GuiClose2:
Gui, 1:Default
Gui, 1:-Disabled
GuiControlGet, MainStack4, Pos
GuiControl, Move, %preChain%,% "x" MainStack4X "y" MainStack4Y
GuiControl, Show, %OnControl%
SB_SetText("Chain Macro Setup canceled...")
Gui, 2:submit
return
GuiMove2:
PostMessage, 0xA1, 2
return
Remove_Hotkey:
StringLeft, leftChar, GuiControl, 1
Loop, 7
{
    if leftChar = 5
    {
       
        GuiControlGet, MainStack5, Pos
        GuiControl, Move, %GuiControl%,% "x" MainStack5X "y" MainStack5Y
        GuiControl, Show, %OnControl%
        GuiControl, Show, MainStack5
        x%OnControl% = 
        break
    }
    if leftChar = 6
    {
       
        GuiControlGet, MainStack6, Pos
        GuiControl, Move, %GuiControl%,% "x" MainStack6X "y" MainStack6Y
        GuiControl, Show, %OnControl%
        GuiControl, Show, MainStack6
         x%OnControl% = 
        break
    }
    if (leftChar = A_Index)
    {
    GuiControlGet, MainStack%A_Index%, Pos
    GuiControl, Move, %GuiControl%,% "x" MainStack%A_Index%X "y" MainStack%A_Index%Y
    GuiControl, Show, %OnControl%
     x%OnControl% = 
    }
}
return
GuiContextMenu:
MouseGetPos,mouseX,mouseY,, controlName
if A_GuiControl = 
    return
IfInString, controlName, Button
    return
IfInString, A_GuiControl, This will
    return
IfInString, controlName, SysLink1
    return
IfInString, controlName, statusbar321
    return
IfInString, A_GuiControl, script
    return
IfInString, A_GuiControl, Buttons
    return
IfInString, A_GuiControl, useless
    return
IfInString, A_GuiControl, ini
    return
IfInString, A_GuiControl, Hotkey
    return
IfInString, A_GuiControl, Hide
    return
IfInString, A_GuiControl, Info
    return
IfInString, A_GuiControl, Activate
    return
GuiControlGet,%A_GuiControl%, Pos
tempX := %A_Guicontrol%x
tempY := %A_Guicontrol%y
GuiControl := A_GuiControl
CheckOnControl()
IfInString, A_GuiControl, button
    return
if (tempX = 20 and tempY = 15)
    return
IfInString, controlName, Static
    Menu,Menu,Show
return
HideShow:
WinGetPos, tempoX, tempoY, , , %title%
xX := tempoX+18
yY := tempoY+206
SplashImage, %A_ScriptDir%\Keyboard.png, B X%xX% Y%yY%
KeyWait LButton
SplashImage, Off
return
Load()
{
    global
    SelfCast_C = 1
    ChainMacro_C = 1
    MacroSpam_C = 1
    UsableSpam_C = 1
    start := false
    start1 := false
    start2 := false

    Loop, read, %A_ScriptDir%\M.A.C.R.O.ini
    {
        IfInString, A_Loopreadline, ----- M.A.C.R.O -----
        {
            start := true
            continue
        }
        if start = 1
        {
            IfInString, A_Loopreadline, ->
            {
                StringReplace, fix, A_Loopreadline, ->, #
                StringSplit, fix_, fix, #
                Loop, 100
                {
                GuiControlGet, buttonNameX,, button%A_Index%, text
                if (fix_1 = buttonNameX)
                {
                    GuiControlGet, button%A_Index%, Pos
                    GuiControl, Move, 4%ChainMacro_C%,% "x" button%A_Index%x-1 "y" button%A_Index%y-1
                    ChainMacro_C++
                    GuiControl, Hide, button%A_Index%
                    StringReplace, fix, fix, |, ->, all
                    StringReplace, fix, fix, #, |
                    xbutton%A_Index% = ChainMacro|%fix%
                    break
                }
                }
            }
            else IfInString, A_Loopreadline, ,u
            {
                StringTrimRight, fix, A_Loopreadline, 2
                Loop, 100
                {
                    GuiControlGet, buttonNameX,, button%A_Index%, text
                    if (fix = buttonNameX)
                    {
                        GuiControlGet, button%A_Index%, Pos
                        GuiControl, Move, 2%UsableSpam_C%,% "x" button%A_Index%x-1 "y" button%A_Index%y-1
                        UsableSpam_C++
                        GuiControl, Hide, button%A_Index%
                        xbutton%A_Index% = UsableSpam|%fix%
                        break
                    }
                }
            }
            else IfInString, A_Loopreadline, ,s
            {
                StringTrimRight, fix, A_Loopreadline, 2
                Loop, 100
                {
                    GuiControlGet, buttonNameX,, button%A_Index%, text
                    if (fix = buttonNameX)
                    {
                        GuiControlGet, button%A_Index%, Pos
                        GuiControl, Move, 3%SelfCast_C%,% "x" button%A_Index%x-1 "y" button%A_Index%y-1
                        SelfCast_C++
                        GuiControl, Hide, button%A_Index%
                        xbutton%A_Index% = SelfCast|%fix%
                        break
                    }
                }
            }
            else IfInString, A_LoopReadLine, #1
            {
                StringReplace, fix, A_LoopReadline, #1, |
                StringSplit, fix_, fix, |
                GuiControl,, Coor1, %fix_3%
                Loop, 100
                {
                    GuiControlGet, buttonNameX,, button%A_Index%, text
                    if (fix_1 = buttonNameX)
                    {
                        GuiControlGet, button%A_Index%, Pos
                        GuiControl, Move, 50,% "x" button%A_Index%x-1 "y" button%A_Index%y-1
                        GuiControl, Hide, button%A_Index%
                        GuiControl, Hide, MainStack5
                        xbutton%A_Index% = 12HotkeyBar|%fix_1%|%fix_3%
                        break
                    }
                }
            }
            else IfInString, A_LoopReadLine, #2
            {
                StringReplace, fix, A_LoopReadline, #2, |
                StringSplit, fix_, fix, |
                GuiControl,, Coor2, %fix_3%
                Loop, 100
                {
                    GuiControlGet, buttonNameX,, button%A_Index%, text
                    if (fix_1 = buttonNameX)
                    {
                        GuiControlGet, button%A_Index%, Pos
                        GuiControl, Move, 60,% "x" button%A_Index%x-1 "y" button%A_Index%y-1
                        GuiControl, Hide, button%A_Index%
                        GuiControl, Hide, MainStack6
                        xbutton%A_Index% = 22HotkeyBar|%fix_1%|%fix_3%
                        break
                    }
                }
            }
            else
            {
                fix := A_Loopreadline
                Loop, 100
                {
                    GuiControlGet, buttonNameX,, button%A_Index%, text
                    if (fix = buttonNameX)
                    {
                        GuiControlGet, button%A_Index%, Pos
                        GuiControl, Move, 1%MacroSpam_C%,% "x" button%A_Index%x-1 "y" button%A_Index%y-1
                        MacroSpam_C++
                        GuiControl, Hide, button%A_Index%
                        xbutton%A_Index% = MacroSpam|%fix%
                        break
                    }
                }
            }
        }
    }
}
CheckOnControl()
{
    global
    GuiControlGet,%A_GuiControl%, Pos
    picX := %A_Guicontrol%x
    picY := %A_Guicontrol%y
    tempX := picX+20
    tempY := picY+20
    OnControl =
    Loop %KeyboardButonNumber%
    {
        GuiControlGet,button%A_Index%, Pos
        temp1X := button%A_index%x
        temp1Y := button%A_index%y
        expand1X := temp1X + 40
        expand1Y := temp1Y + 40
        verCheck = 0
        horCheck = 0
        if tempX between %temp1X% and %expand1X%
            verCheck = 1
        if tempY between %temp1Y% and %expand1Y%
            horCheck = 1
        if ( verCheck = 1 and horCheck = 1 )
            OnControl = button%A_Index%
    }
}
CheckRegButton()
{
    global
    GuiControlGet,%A_GuiControl%, Pos
    picX := %A_Guicontrol%x
    picY := %A_Guicontrol%y
    tempX := picX+20
    tempY := picY+20
    assigned = 0
    x%OnControl% = 0
    Loop %KeyboardButonNumber%
    {
        GuiControlGet, displayButton,, button%A_Index%, Text
        GuiControlGet,button%A_Index%, Pos
        temp1X := button%A_index%x
        temp1Y := button%A_index%y
        expand1X := temp1X + 40
        expand1Y := temp1Y + 40
        verCheck = 0
        horCheck = 0
        if tempX between %temp1X% and %expand1X%
            verCheck = 1
        if tempY between %temp1Y% and %expand1Y%
            horCheck = 1
        if ( verCheck = 1 and horCheck = 1 )
        {
            GuiControl, Move, %A_Guicontrol%,% "x" temp1X-1 "y" temp1Y-1
            assigned = 1
            GuiControl, Hide, button%A_Index%
            GuiControlGet, buttonName,, button%A_Index%, text
            if currLabel = 1
            {
                SB_SetText("'Macro Spam' is assigned to " . displayButton . ". --- Hold down this button to spam SKILL --- AHK code = Loop ( Send Key -> Click -> Delay )")
                x%OnControl% = MacroSpam|%buttonName%
                StringTrimLeft, temporary, A_Guicontrol, 1
                if (temporary = MacroButtonNumber)
                    GuiControl, Hide, MainStack%currLabel%
            }
            if currLabel = 2
            {
                SB_SetText("'Usable Spam' is assigned to " . displayButton . ". --- Hold down this button to spam POTION --- AHK code = Loop ( Send Key -> Delay )")
                x%OnControl% = UsableSpam|%buttonName%
                StringTrimLeft, temporary, A_Guicontrol, 1
                if (temporary = MacroButtonNumber)
                    GuiControl, Hide, MainStack%currLabel%
            }
            if currLabel = 3
            {
                SB_SetText("'Self-Cast' is assigned to " . displayButton . ". --- Default: Press this button twice to self-cast. --- AHK code = ( Send Key -> Click at center of screen -> Move mouse back to old location )")
                x%OnControl% = SelfCast|%buttonName%
                StringTrimLeft, temporary, A_Guicontrol, 1
                if (temporary = MacroButtonNumber)
                    GuiControl, Hide, MainStack%currLabel%
            }
            if currLabel = 4
            {
                StringTrimLeft, temporary, A_Guicontrol, 1
                if (temporary = MacroButtonNumber)
                    GuiControl, Hide, MainStack%currLabel%
                secondTime = 1
                CheckCell()
                secondTime = 0
                if occupied = 0
                {
                    SB_SetText("Setting up chain macro...")
                    Gui, 2:Show, w290, Chain Macro Setup
                    Gui, 2:Default
                    Gui, Listview, ChainMacroLV
                    LV_Delete()
                    GuiControl, Focus, Key_CM
                    CM_Count = 0
                    Gui, 1:+Disabled
                }
                return
            }
            if currLabel = 5
            {
                GuiControl, Hide, MainStack%currLabel%
                SB_SetText("1st hotkey of '2-Hotkey Bar'has been assigned to " . displayButton)
                x%OnControl% = 12HotkeyBar|%buttonName%
            }
            if currLabel = 6
            {
                GuiControl, Hide, MainStack%currLabel%
                SB_SetText("2nd hotkey of '2-Hotkey Bar'has been assigned to " . displayButton)
                x%OnControl% = 22HotkeyBar|%buttonName%
            }
        }
    }
}

CheckCell()
{
    global
    occupied = 0
    if assigned = 0
        return
    Loop 7
    {
    AIndex := A_Index
    Loop %MacroButtonNumber%
    {
        GuiControlGet,%AIndex%%A_Index%, Pos
        tempX := %AIndex%%A_index%x
        tempY := %AIndex%%A_index%y
        expandX := tempX + 40
        expandY := tempY + 40
        StringSplit, split_, OccupiedCell, `,
        random = %AIndex%%A_Index%
        if (random = A_GuiControl)
            continue
        if (tempX = 20 and tempY = 15)
            continue
        currX := split_1
        currY := split_2
        currExpandX := currX+ 40
        currExpandY := currY+ 40
        verticalCheck = 0
        horizonCheck = 0
        cenX := currX+20
        cenY := currY+20
        if cenX between %tempX% and %expandX%
            verticalCheck = 1
        if cenY between %tempY% and %expandY%
            horizonCheck = 1
        if (horizonCheck = 1 and verticalCheck = 1)
        {
            SB_SetText("Only 1 hotkey can be assign per button !!!")
            GuiControlGet, MainStack%currLabel%, Pos
            GuiControl, Move, %A_Guicontrol%,% "x" MainStack%currLabel%X "y" MainStack%currLabel%Y
            occupied = 1
            if secondTime = 0
                Loop 2
                    SoundBeep, 1000 ,50
        }
    }
    }
}
MakeKeyboard()
{
    global
Gui, Font, w1000 s10
Gui, Add, Text, x%KeyboardX% y%KeyboardY% w970 h285 +0x201 +Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 +0x201 +Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 +0x201 +Border BackgroundTrans
Gui, Add, Text, xp-1 yp-1 wp+2 hp+2 +0x201 +Border BackgroundTrans
Gui, Add, Text, xp+8 yp+10 w40 h40 +0x201 +Border vbutton1 cBlue, Esc
Gui, Add, Text, xp+60 yp wp hp +0x201 +Border vbutton2, F1
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton3, F2
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton4, F3
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton5, F4
Gui, Add, Text, xp+55 yp wp hp +0x201 +Border vbutton6, F5
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton7, F6
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton8, F7
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton9, F8
Gui, Add, Text, xp+55 yp wp hp +0x201 +Border vbutton10, F9
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton11 cBlue, F10
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton12 cBlue, F11
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton13 cBlue, F12
Gui, Add, Text, xp-575 yp+50 wp hp +0x201 +Border vbutton14, ``
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton15, 1
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton16, 2
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton17,3
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton18,4
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton19,5
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton20,6
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton21,7
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton22,8
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton23,9
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton24,0
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton25,-
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton26,=
Gui, Add, Text, xp+45 yp wp hp +Border vbutton27, Back`nspace
Gui, Add, Text, xp-585 yp+45 wp hp +0x201 +Border vbutton28, Tab
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton29,Q
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton30,W
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton31,E
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton32,R
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton33,T
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton34,Y
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton35,U
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton36,I
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton37,O
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton38,P
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton39,[
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton40,]
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton41,\
Gui, Add, Text, xp-585 yp+45 wp hp +Border vbutton42,Caps`nLock
Gui, Add, Text, xp+65 yp wp hp +0x201 +Border vbutton43,A
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton44,S
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton45,D
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton46,F
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton47,G
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton48,H
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton49,J
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton50,K
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton51,L
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton52,;
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton53,'
Gui, Add, Text, xp+45 yp w65 hp +0x201 +Border cRed, Enter
Gui, Add, Text, xp-560 yp+45 w40 hp +0x201 +Border vbutton54,LShift
Gui, Add, Text, xp+80 yp wp hp +0x201 +Border vbutton55,Z
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton56,X
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton57,C
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton58,V
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton59,B
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton60,N
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton61,M
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton62,,
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton63,.
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton64,/
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton65,RShift
Gui, Add, Text, xp-530 yp+45 wp hp +0x201 +Border vbutton66,LCtrl
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton67 cRed,#
Gui, Add, Text, xp+45 yp wp hp +0x201 +Border vbutton68,LAlt
Gui, Add, Text, xp+190 yp w40 hp +0x201 Border vbutton69, Space
Gui, Add, Text, xp-140 yp-1 w310 hp+2 +0x201 +Border BackgroundTrans
Gui, Add, Text, xp+325 yp w40 hp +0x201 +Border vbutton70,RAlt
Gui, Add, Text, xp+45 yp w40 hp +0x201 +Border vbutton71,RCtrl
Gui, Add, Text, xp+125 yp w40 hp +0x201 +Border vbutton72,<
Gui, Add, Text, xp+45 yp w40 hp +0x201 +Border vbutton73,v
Gui, Add, Text, xp+45 yp w40 hp +0x201 +Border vbutton74,>
Gui, Add, Text, xp-45 yp-45 w40 hp +0x201 +Border vbutton75,^
Gui, Add, Text, xp-45 yp-185 w40 hp +Border vbutton76 cBlue,Print`nScreen
Gui, Add, Text, xp+45 yp w40 hp +Border vbutton77,Scroll Lock
Gui, Add, Text, xp+45 yp w40 hp +Border vbutton78,Pause Break
Gui, Add, Text, xp-90 yp+50 w40 hp +0x201 +Border vbutton79 cBlue,Insert
Gui, Add, Text, xp+45 yp w40 hp +0x201 +Border vbutton80,Home
Gui, Add, Text, xp+45 yp w40 hp +Border vbutton81,Page`nUp
Gui, Add, Text, xp-90 yp+45 w40 hp +0x201 +Border vbutton82,Delete
Gui, Add, Text, xp+45 yp w40 hp +0x201 +Border vbutton83,End
Gui, Add, Text, xp+45 yp w40 hp +Border vbutton84,Page`nDown
Gui, Add, Text, xp+60 yp-45 w40 h40 +Border vbutton85, Num`nLock
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton86, /
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton87, *
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton88, -
Gui, Add, Text, xp-135 yp+45 w40 h40 +0x201 +Border vbutton89, 7
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton90, 8
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton91, 9
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton92, +
Gui, Add, Text, xp-135 yp+45 w40 h40 +0x201 +Border vbutton93, 4
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton94, 5
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton95, 6
Gui, Add, Text, xp-90 yp+45 w40 h40 +0x201 +Border vbutton96, 1
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton97, 2
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton98, 3
Gui, Add, Text, xp-90 yp+45 w40 h40 +0x201 +Border vbutton99, 0
Gui, Add, Text, xp+45 yp w40 h40 +0x201 +Border vbutton100, Del/.
Gui, Add, Text, xp+90 yp-90 w40 h130 +0x201 +Border cRed, Enter
Gui, font, s8
Gui, Add, Link, xp-130 yp-140, By : Recca`n<a href="http://ragindex.blogspot.com">http://ragindex.blogspot.com</a>`n
}
LoadSetting()
{
    global
    IniRead, SkillDelay, M.A.C.R.O.ini, Setting, SkillDelay
    IniRead, UsableDelay, M.A.C.R.O.ini, Setting, UsableDelay
    IniRead, PauseHotkey, M.A.C.R.O.ini, Setting, PauseHotkey
    StringReplace, PauseHotkey_L, PauseHotkey, +, Shift +%A_Space%
    StringReplace, PauseHotkey_L, PauseHotkey_L, ^, Ctrl +%A_Space%
    StringReplace, PauseHotkey_L, PauseHotkey_L, !, Alt +%A_Space%
    IniRead, ExitHotkey, M.A.C.R.O.ini, Setting, ExitHotkey
    StringReplace, ExitHotkey_L, ExitHotkey, +, Shift +%A_Space%
    StringReplace, ExitHotkey_L, ExitHotkey_L, ^, Ctrl +%A_Space%
    StringReplace, ExitHotkey_L, ExitHotkey_L, !, Alt +%A_Space%
    IniRead, selfCast_Mode, M.A.C.R.O.ini, Activate, selfCast
}