; Ragindex Version: Final
; Language:       English
; Platform:       Any
; Author:         Recca a.k.a Pyan <rec_ca5@yahoo.com>

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
CoordMode, Mouse, Screen
#NoTrayIcon
#MaxMem 256
SetBatchLines -1
SetSystemCursor() 
;~ bg_color=94C4EC
AdOrder = 0
;~ 00568A
;~ 38719C
;~ 94C4EC
;~ d2edff
IniRead, styleFile,  %A_ScriptDir%\Data\ragindex.ini, Style, file
if styleFile = ERROR
{
	MsgBox, 16, ERROR, No style file set in 'ragindex.ini' App will reload with default style.
	IniWrite, blue_theme.ini, %A_ScriptDir%\Data\ragindex.ini, Style, file
	Reload
}

IniRead, Main_BG, %A_ScriptDir%\Data\Skin\%styleFile%, Main_Color, BG
IniRead, Main_Text, %A_ScriptDir%\Data\Skin\%styleFile%, Main_Color, Text

IniRead, Mob_Border, %A_ScriptDir%\Data\Skin\%styleFile%, Mob_Color, Border
IniRead, Mob_BG, %A_ScriptDir%\Data\Skin\%styleFile%, Mob_Color, Mob_BG
IniRead, Mob_Text, %A_ScriptDir%\Data\Skin\%styleFile%, Mob_Color, Text
IniRead, Mob_Header_BG, %A_ScriptDir%\Data\Skin\%styleFile%, Mob_Color, Header_BG
IniRead, Mob_Header_Text, %A_ScriptDir%\Data\Skin\%styleFile%, Mob_Color, Header_Text
IniRead, Mob_Main_Color, %A_ScriptDir%\Data\Skin\%styleFile%, Mob_Color, Main_Color
IniRead, Mob_Sub_Color, %A_ScriptDir%\Data\Skin\%styleFile%, Mob_Color, Sub_Color
IniRead, Mob_MVP_Type, %A_ScriptDir%\Data\Skin\%styleFile%, Mob_Color, MVP_Type
IniRead, Mob_OnMapBold, %A_ScriptDir%\Data\Skin\%styleFile%, Mob_Color, OnMapBold

IniRead, Item_Border, %A_ScriptDir%\Data\Skin\%styleFile%, Item_Color, Border
IniRead, Item_BG, %A_ScriptDir%\Data\Skin\%styleFile%, Item_Color, BG
IniRead, Item_Text, %A_ScriptDir%\Data\Skin\%styleFile%, Item_Color, Text
IniRead, Item_Header_BG, %A_ScriptDir%\Data\Skin\%styleFile%, Item_Color, Header_BG
IniRead, Item_Header_Text, %A_ScriptDir%\Data\Skin\%styleFile%, Item_Color, Header_Text

IniRead, Element_Strong, %A_ScriptDir%\Data\Skin\%styleFile%, Element_Color, Strong
IniRead, Element_Neutral, %A_ScriptDir%\Data\Skin\%styleFile%, Element_Color, Neutral
IniRead, Element_Weak, %A_ScriptDir%\Data\Skin\%styleFile%, Element_Color, Weak

IniRead, Tooltip_BG, %A_ScriptDir%\Data\Skin\%styleFile%, ToolTip_Color, BG
IniRead, Tooltip_Text, %A_ScriptDir%\Data\Skin\%styleFile%, ToolTip_Color, Text

IniRead, Shop_List_BG, %A_ScriptDir%\Data\Skin\%styleFile%, Shop_Color, List_BG
IniRead, Shop_List_Text, %A_ScriptDir%\Data\Skin\%styleFile%, Shop_Color, List_Text
IniRead, Shop_Border, %A_ScriptDir%\Data\Skin\%styleFile%, Shop_Color, Border
IniRead, Shop_BG, %A_ScriptDir%\Data\Skin\%styleFile%, Shop_Color, BG
IniRead, Shop_Location, %A_ScriptDir%\Data\Skin\%styleFile%, Shop_Color, Location
IniRead, Shop_Item, %A_ScriptDir%\Data\Skin\%styleFile%, Shop_Color, Item

IniRead, Title_BG, %A_ScriptDir%\Data\Skin\%styleFile%, Title_Color, BG
IniRead, Title_Text, %A_ScriptDir%\Data\Skin\%styleFile%, Title_Color, Text

bg_color=%Tooltip_BG%
txt_color=%Tooltip_Text%

Gui, Color, %Main_BG%
Gui, 2:Color, %Main_BG%
Gui, 3:Color, %Main_BG%
Gui, 4:Color, %Main_BG%
Gui, 5:Color, %Main_BG%

Gui, Add, ActiveX, +Hidden x10 y50 w565 h430 vNoticePage, Shell.Explorer
NoticePage.Navigate("http://textuploader.com/5701o/raw")
GuiControl, Show, NoticePage

Gui, font, c%Main_Text%
Gui, 2:font, c%Main_Text%
Gui, 3:font, c%Main_Text%
GetInfo()
GetEleInfo()
MakeSrcBar()

Gui, Add, ActiveX, +Hidden x10 y50 w565 h90 vSub, Shell Explorer
Sub.Navigate("about:blank")

MakeTable()
MakePrevNext()

Gui, +ToolWindow +AlwaysOnTop -border -Theme -caption
Gui, Show, x%closeX% y%closeY% w585 h530, %wintitle%
WinSet, Region, 0-0 w585 h535 r6-6, %wintitle%
;~ WinSet, Transparent, 255, %wintitle%
OnMessage(0x200, "Help")
return
;================================================================END GUI===============================================================
GuiClose:
Gui, 2:submit, nohide
IniWrite, %bexprate%, %A_ScriptDir%\Data\ragindex.ini, Rate, bexprate
IniWrite, %jexprate%, %A_ScriptDir%\Data\ragindex.ini, Rate, jexprate
IniWrite, %changerate%, %A_ScriptDir%\Data\ragindex.ini, Rate, droprate
IniWrite, %ChosenHotkey%, %A_ScriptDir%\Data\ragindex.ini, Hotkey, hotkey
WinGetPos, winX, winY
IniWrite, %winX%, %A_ScriptDir%\Data\ragindex.ini, Pos, winX
IniWrite, %winY%, %A_ScriptDir%\Data\ragindex.ini, Pos, winY
RestoreCursors()
ExitApp
return

GuiClose1:
Gui,  submit
return

Help:
Run, readme.txt
return

AddMob:
Gui +LastFound +OwnDialogs +AlwaysOnTop
FileSelectFile, addmob,,,,*.txt
notdone = 
if errorlevel = 1
{
	return
}
if renewal = 1
	file2add = %A_ScriptDir%\Data\RE\mob_db.txt
else
	file2add = %A_ScriptDir%\Data\PRE\mob_db.txt
FileRead, mobcontent, %file2add%
Loop, read, %addmob%
{
	StringSplit, array_, A_LoopReadline, `,
	IfInString, mobcontent, %array_1%=,
	{
		MsgBox, 4144,, Monster ID is already existed.
		notdone = 1
		break
	}
	StringReplace, loopreadline, A_LoopReadLine, `,, =`,
	FileAppend, %loopreadline%`r`n, %file2add%
}
if notdone =
	MsgBox, 4160,,Done ! Remember to add .gif files to <Image\Mob\<Mob ID>.gif> according to Mob ID & On map info in 'Onmap.txt'.
return

AddItem:
Gui +LastFound +OwnDialogs +AlwaysOnTop
FileSelectFile, additem,,,,*.txt
notdone = 
if errorlevel = 1
{
	return
}
	if renewal = 1
		file2add1 = %A_ScriptDir%\Data\RE\item_db.txt
	else
		file2add1 = %A_ScriptDir%\Data\PRE\item_db.txt
	FileRead, itemcontent, %file2add1%
Loop, read, %additem%
{
	StringSplit, array_, A_LoopReadline, `,
	IfInString, itemcontent, %array_1%=,
	{
		MsgBox, 4144,, Item ID is already existed.
		notdone = 1
		break
	}
	StringReplace, loopreadline1, A_LoopReadLine, `,, =`,
	FileAppend, %loopreadline1%`r`n, %file2add1%
}
if notdone =
	MsgBox, 4160,, Done ! Remember to add .gif files to <Image\Item\<Item ID>.gif> & Item's description in 'itemInfo.lub'.
return

Hotkey:
oldkey := ChosenHotkey
Hotkey,  %DaHotkey%, theToggle, off
Gui, 2:submit, nohide
if ChosenHotkey !=
{
	StringReplace, perm, ChosenHotkey,!,
	StringReplace, perm, perm,^,
	Hotkey,  %oldkey%, theToggle, off
	if perm !=
	{
		GuiControl, Focus, dummy
		Hotkey, %ChosenHotkey%, theToggle, on
	}
}
return

Topbar:
PostMessage, 0xA1, 2
KeyWait LButton
WinGetPos, winX, winY,,,%wintitle%
dockX := winX+584
3rdwinX := winX+584
3rdwinY := winY+144
WinMove, Setting,,dockX, winY
WinMove, xxx,,3rdwinX, 3rdwinY
return

Setting:
toggle2 := !toggle2
if toggle2 = 1
{
WinGetPos, dockX, dockY,,,%wintitle%
dockX := dockX+ 584
Gui, 2: +ToolWindow +AlwaysOnTop -border +Theme -caption 
Gui, 2:Show, w200 h145 x%dockX% y%dockY%, Setting
;~ WinSet, Region, 0-0 w555 h530 r6-6, Setting
}
else
{
	WinHide, Setting
}
return

1result:
Gui, submit, nohide
return

ItemSrc:
GuiControl, +Default, SearchItem
return

MobSrc:
GuiControl, +Default, SearchMob
Return

SrcMob:
Gui, submit, nohide
if hideMainAd =
{
	NoticePage.Navigate("about:blank")
	Sleep 0
	GuiControl, Hide, NoticePage
	hideMainAd = 1
}
Gui, 1:Default
onlyresult = 0
clicksearch = false
toscroll = mob
GuiControl,, Mob,
GuiControl,, loading, 0
if (Mob = A_Space or Mob ="")
{
	SB_SetText("...")
	Return
}

if StrLen(Mob) <= 1
{
	SB_SetText("Search string length need to be more than 1 characters.")
	return
}
if renewal = 1
	filetoread = %A_ScriptDir%\Data\RE\mob_db.txt
else
	filetoread = %A_ScriptDir%\Data\PRE\mob_db.txt
StringReplace, Mob, Mob, .,,all
StringReplace, Mob, Mob, `,,,all
StringReplace, Mob, Mob, /,,all
StringReplace, Mob, Mob, `;,,all
StringReplace, Mob, Mob, ',,all
StringReplace, Mob, Mob, [,,all
StringReplace, Mob, Mob, ],,all
if resultnum != 0
{
	Loop %resultnum%
	{
		reset++
		result%reset% =
	}
}
resultnum = 0
startresult = 0
picresult = 0
reset = 0

Loop, Read, %filetoread%
{
	if A_Index = 1
		continue
	StringSplit, line_,  A_LoopReadLine, `,
	currStr = %line_2% %line_3% %line_4%
	if Mob is integer
	{
		line_1 = =%line_1%
		strMob = =%Mob%=
		IfInString, line_1,%strMob%
		{
			resultnum++
			result%resultnum% := A_Index
			break
		}
	}
	else
	{
	if currStr contains %Mob%
	{
		resultnum++
		result%resultnum% := A_Index
	}
	}
}
EmpArr("line_")
currStr=
if (resultnum ="" or resultnum = 0)
{
	SB_SetText("Can't find mob...")
	Hideall()
	Return
}
Hideall()
Update()
return

SrcItem:
Gui, submit, nohide
if hideMainAd =
{
	NoticePage.Navigate("about:blank")
	Sleep 0
	GuiControl, Hide, NoticePage
	hideMainAd = 1
}
onlyresult = 0
clicksearch = false
toscroll = item
GuiControl,, Item,
GuiControl,, loading, 0
if (Item = A_Space or Item ="")
{
	SB_SetText("...")
	Return
}
if StrLen(Item) <= 1
{
	SB_SetText("Search string length need to be more than 1 characters.")
	return
}
if renewal = 1
	filetoread = %A_ScriptDir%\Data\RE\item_db.txt
else
	filetoread = %A_ScriptDir%\Data\PRE\item_db.txt
StringReplace, Item, Item, .,,all
StringReplace, Item, Item, `,,all
StringReplace, Item, Item, /,,all
StringReplace, Item, Item, `;,,all
StringReplace, Item, Item, ',,all
StringReplace, Item, Item, [,,all
StringReplace, Item, Item, ],,all
if resultnum != 0
{
	Loop %resultnum%
	{
		reset++
		result%reset% =
	}
}
resultnum = 0
startresult = 0
picresult = 0
reset = 0
Loop, Read, %filetoread%
{
	if A_Index = 1
		continue
	StringSplit, line_,  A_LoopReadLine, `,
	currStr = %line_2% %line_3% %line_4%
	if Item is integer
	{
		line_1 = =%line_1%
		strItem = =%Item%=
		IfInString, line_1,%strItem%
		{
			resultnum++
			result%resultnum% := A_Index
			break
		}
	}
	else
	{
	IfInString, currStr,%Item%
		{
			resultnum++
			result%resultnum% := A_Index
		}
	}
}
currStr=
EmpArr("line_")
	
if (resultnum ="" or resultnum = 0)
{
	SB_SetText("Can't find item...")
	Hideall()
	Return
}
Hideall()
UpdateItem()
Return

Prev:
if page = 1
	return
clicksearch = false
if inprogress = true
	return
AdOrder++
	if AdOrder = 1
		Sub.Navigate("http://textuploader.com/57kaf/raw")
	if AdOrder = 2
		Sub.Navigate("http://textuploader.com/57h82/raw")
	if AdOrder = 3
		Sub.Navigate("http://textuploader.com/57h8n/raw")
	if AdOrder = 4
		Sub.Navigate("http://textuploader.com/57h8w/raw")
	if AdOrder = 5
		Sub.Navigate("http://textuploader.com/57h8i/raw")
	if AdOrder = 6
		Sub.Navigate("http://textuploader.com/57h88/raw")
	if AdOrder = 7
		Sub.Navigate("http://textuploader.com/57xsd/raw")
	if AdOrder = 8
	{
		Sub.Navigate("http://textuploader.com/57xst/raw")
		AdOrder = 0
	}
inprogress = true
startY := 410
GuiControl, Move, Sub, x10 y50
1y := startY
2y := 1y+374
3y := 2y+374
4y := 3y+374
5y := 4y+374
6y := 5y+374
7y := 6y+374
8y := 7y+374
9y := 8y+374
10y := 9y+374
GuiControl, Enable, Next

if (page = numberofpage)
	picresult := picresult-(10+whatleft)
else
	picresult-=20
if (page = numberofpage)
	startresult := startresult-(10+whatleft)
else
	startresult-=20

page--
Hideall()
GuiControl,, loading, 0
howtoprog = 10
Loop 10
{
	if toscroll = mob
		Simplize()
	if toscroll = item
		Simple()
}
GuiControl,,pagestat, %page%/%numberofpage%
SB_SetText("Found " . resultnum . " results," . numberofpage . " pages")
inprogress = false
return

Next:
if (page = numberofpage)
	Return
if numberofpage = 1 or numberofpage =
	return
if inprogress = true
	return
AdOrder++
	if AdOrder = 1
		Sub.Navigate("http://textuploader.com/57kaf/raw")
	if AdOrder = 2
		Sub.Navigate("http://textuploader.com/57h82/raw")
	if AdOrder = 3
		Sub.Navigate("http://textuploader.com/57h8n/raw")
	if AdOrder = 4
		Sub.Navigate("http://textuploader.com/57h8w/raw")
	if AdOrder = 5
		Sub.Navigate("http://textuploader.com/57h8i/raw")
	if AdOrder = 6
		Sub.Navigate("http://textuploader.com/57h88/raw")
	if AdOrder = 7
		Sub.Navigate("http://textuploader.com/57xsd/raw")
	if AdOrder = 8
	{
		Sub.Navigate("http://textuploader.com/57xst/raw")
		AdOrder = 0
	}
clicksearch = false
inprogress = true
startY := 410
1y := startY
2y := 1y+374
3y := 2y+374
4y := 3y+374
5y := 4y+374
6y := 5y+374
7y := 6y+374
8y := 7y+374
9y := 8y+374
10y := 9y+374
GuiControl, Enable, Prev
page++
if (page = numberofpage)
{
	Hideall()
	GuiControl,, loading, 0
	howtoprog := 100/whatleft
	Loop %whatleft%
	{
		if toscroll = mob
			Simplize()
		if toscroll = item
			Simple()
	}
	GuiControl,, loading, 100
	GuiControl, Disable, Next
	SB_SetText("Found " . resultnum . " results," . numberofpage . " pages")
}
else
{
	Hideall()
	GuiControl,, loading, 0
	howtoprog = 10
	Loop 10
	{
		if toscroll = mob
			Simplize()
		if toscroll = item
			Simple()
	}
}
GuiControl,,pagestat, %page%/%numberofpage%
inprogress = false
return

ItemWin1:
ItemWin2:
ItemWin3:
ItemWin4:
ItemWin5:
ItemWin6:
ItemWin7:
ItemWin8:
ItemWin9:
ItemWin10:
if A_GuiEvent = Normal
{
	currItem1 := A_EventInfo
}
if currItem1 = 0
	return
StringReplace, ItemwinN, A_ThisLabel, ItemWin,,
winnum = %ItemwinN%
itemTT()
return

Table1:
Table2:
Table3:
Table4:
Table5:
Table6:
Table7:
Table8:
Table9:
Table10:
if A_GuiEvent = Normal
{
	currItem := A_EventInfo
}
if currItem = 0
	return
StringReplace, TableN, A_ThisLabel, Table,,
tablenum = %TableN%
QuickTT()
return

theToggle:
toggle := !toggle
if toggle = 1
{
	SplashImage, off
	Progress, off
	WinGetActiveTitle, activewin
	WinActivate, %activewin%
	RestoreCursors()
	WinHide, %wintitle%
	WinHide, Setting
	WinHide, xxx
	SplashImage, off
	Progress, off
}
else
{
	WinShow, %wintitle%
	WinActivate, %wintitle%
	SetSystemCursor()
}
Return

droprate1:
Gui, 2:submit, nohide
return
jexprate1:
Gui, 2:submit, nohide
return
bexprate1:
Gui, 2:submit, nohide
return

FreeMemory:
Gui, 2:submit, nohide
WinGetPos, winX, winY
IniWrite, %winX%, %A_ScriptDir%\Data\ragindex.ini, Pos, winX
IniWrite, %winY%, %A_ScriptDir%\Data\ragindex.ini, Pos, winY
IniWrite, %bexprate%, %A_ScriptDir%\Data\ragindex.ini, Rate, bexprate
IniWrite, %jexprate%, %A_ScriptDir%\Data\ragindex.ini, Rate, jexprate
IniWrite, %changerate%, %A_ScriptDir%\Data\ragindex.ini, Rate, droprate
IniWrite, %ChosenHotkey%, %A_ScriptDir%\Data\ragindex.ini, Hotkey, hotkey
Reload
return

npcLV:
if A_GuiEvent = DoubleClick
{
	Gui, 3:Default
	Gui, ListView, npcLV
	LV_GetText(1celldata1x,A_EventInfo,1)
	if 1celldata1x = 1
		return
	GuiControl, 3:+Hidden, npcLV
	GuiControl, 3:-Hidden, xwb
	GuiControl, 3:-Hidden, backButton
	Gui, 1:Default
		Loop %shop_0%
		{
			findmerc := shop_%A_Index%
			StringSplit, tempData_, findmerc, %A_Tab%
			StringTrimRight, npcInfo, tempData_1, 2
			npcName := tempData_3
			itemtosell := tempData_4	
			sprPos := InStr(itemtosell,",",,1,1)
			temPos := sprPos-1
			StringLeft, npcSprID, itemtosell, %temPos%
			tempPos=
			StringTrimLeft, itemtosell, itemtosell, %sprPos%
			StringReplace, itemtosell, itemtosell, :-1,,all
			sprPos=
			if renewal = 1
				file2readX = %A_ScriptDIr%\Data\RE\item_db.txt
			else
				file2readX = %A_ScriptDIr%\Data\PRE\item_db.txt
			if (npcInfo = 1celldata1x)
			{
				StringSplit, itemtosell_, itemtosell, `,
				timetoloop := itemtosell_0
				Loop %timetoloop%
				{
					look123 := itemtosell_%A_Index%
					if (A_Index = timetoloop)
						StringTrimRight, look123, look123, 1
					IniRead, sellinItem, %file2readX%, Item, %look123%
					StringSplit, sellinItem_, sellinItem, `,
					sellinItem=
					sellslot := sellinItem_11
					if (sellslot = "0" or sellslot ="")
						sellingslot = 
					else
						sellingslot = [%sellslot%]
					; fixing
					addComma("sellinItem_5")
					htmlcontent1 = <img src='%A_ScriptDir%\Image\Item\%look123%.gif'>  &nbsp; %sellinItem_3%&nbsp;%sellingslot% - %sellinItem_5%z <br>
					htmlcontent := htmlcontent htmlcontent1
					npcpath = %A_ScriptDir%\Image\NPC\%npcSprID%.gif
				}
				look123=
				StringReplace, npcInfo, npcInfo, `,,&nbsp;(
				npcInfo = %npcInfo%)
				xwb.navigate("about:blank")
				sleep 50
				npchtml =
				(
				<html>
					<body bgcolor="%Main_BG%"/> 
					<center><div align='middle' valign='top' ><img src='%npcpath%'></div></center>
					<font color=%Shop_Location%><center>%npcname% <br> %npcInfo%  </center>
					<table style="font-size:14" border = 1; cellspacing=0 ;cellpadding=3;  bordercolor="%Shop_Border%">
					<tr>
					<td bgcolor="%Shop_BG%"><div  style="overflow: auto ;width: 230px;height: 200px;"><font style="color:%Shop_Item%">%htmlcontent%</div></td></font>
					</tr>
					</table> 
					</html>
				)
				xwb.document.Write(npchtml)
				npchtml=
				htmlcontent=
				WinGetPos, dockX, dockY,,,%wintitle%
				dock1X := dockX+584
				dock1Y := dockY+144
				Gui, 3:Show, w258 h385 x%dock1X% y%dock1Y%,xxx
			}
		}
}
return

backButton:
GuiControl, 3:+Hidden, backButton
GuiControl, 3:+Hidden, xwb
GuiControl, 3:-Hidden, npcLV
xwb.Navigate("about:blank")
sleep 1
return

srcitemdes:
WinGetPos, winX, winY
onlyresult = 0
winX := winX+100
winY := winY+80
clicksearch = false
toscroll = item
GuiControl,, loading, 0
Gui +LastFound +OwnDialogs +AlwaysOnTop
InputBox, srcdes, Search Item Descriptions,Enter words or sentences you would like to search`n+ Examples of finding stat related items:`n       - "STR +" `, "drop chance" `, "enables use of"`n       - "after cast delay" `, "cast time" `, "`% chance of"`n       - "Demihuman" `, "Fire property" `, "medium size" ,,,,winX,winY
if ErrorLevel
	return
if srcdes=
	return
if StrLen(srcdes) <= 2
	return
if hideMainAd =
{
	NoticePage.Navigate("about:blank")
	Sleep 0
	GuiControl, Hide, NoticePage
	hideMainAd = 1
}
clicksearch = false
toscroll = item
GuiControl,, loading, 0
if renewal = 1
	filetoread = %A_ScriptDir%\Data\RE\item_db.txt
else
	filetoread = %A_ScriptDir%\Data\PRE\item_db.txt
if resultnum != 0
{
	Loop %resultnum%
	{
		reset++
		result%reset% =
	}
}
resultnum = 0
startresult = 0
picresult = 0
reset = 0
Loop, Read, %filetoread%
{
	if A_Index = 1
		continue
	StringSplit, line_,  A_LoopReadLine, `,
	StringTrimRight, line_1,line_1,1
	currStr := i%line_1%
	IfInString, currStr, ^
	{
	StringSplit, tempo_, currStr, ^
	Loop %tempo_0%
	{
		if A_index = 1
			temp := temp tempo_%A_Index%
		else
		{
			temp := temp "^" tempo_%A_Index%
			StringLeft, Tcolor, tempo_%A_Index%, 6
			StringReplace, temp, temp, ^%Tcolor%,, all
			StringReplace, temp, temp, ^000000,, all
		}
	}
	Loop %tempo_0%
	{
		tempo_%A_Index%=
	}
	currStr := temp
	temp=
	}
	IfInString, currStr,%srcdes%
		{
			resultnum++
			result%resultnum% := A_Index
		}
}
currStr=
	
if (resultnum ="" or resultnum = 0)
{
	SB_SetText("Can't find item description contain that string...")
	Hideall()
	Return
}
Hideall()
UpdateItem()
return

renewal:
gui, submit, nohide
if renewal = 1
{
FileRead, onmapfile, %A_ScriptDir%\Data\RE\Onmap.txt
StringSplit, onmapfile_, onmapfile, #
onmapfile=

FileRead, shops, %A_ScriptDir%\Data\RE\shops.txt
StringSplit, shop_, shops,`n
shops=

num=0
Loop %onmapfile_0%
{
num++
xID := onmapfile_%num%
StringReplace, xID, xID, `r`n,,all
StringReplace, xID, xID, %A_Space%,,all
num++
descX := onmapfile_%num%
lastone := 
StringReplace, descX, descX, `r`n,,
if xID is number
	m%xID% := descX
onmapfile_%A_Index%=
}
xID=
descX=
}

if renewal = 0
{
FileRead, onmapfile, %A_ScriptDir%\Data\PRE\Onmap.txt
StringSplit, onmapfile_, onmapfile, #
onmapfile=

FileRead, shops, %A_ScriptDir%\Data\PRE\shops.txt
StringSplit, shop_, shops,`n
shops=

num=0
Loop %onmapfile_0%
{
num++
xID := onmapfile_%num%
StringReplace, xID, xID, `r`n,,all
StringReplace, xID, xID, %A_Space%,,all
num++
descX := onmapfile_%num%
lastone := 
StringReplace, descX, descX, `r`n,,
if xID is number
	m%xID% := descX
onmapfile_%A_Index%=
}
xID=
descX=
}
return
;================================= HOT KEY SECTION
~Esc::
WinHide, xxx
WinHide, Setting
return

~Right::
IfWinNotActive %wintitle%
	return
if numberofpage =
	return
if (page = numberofpage)
	Return
goto Next
return

~Left::
IfWinNotActive %wintitle%
	return
if numberofpage =
	return
goto Prev
return

~Up::
~WheelUp::
IfWinNotActive %wintitle%
	return
if clicksearch = true
	return
if resultnum = 1
	return
if onlyresult = 1
	return
if 1y = 410
	return
rate = 50
if toscroll = item
{
if resultnum < 10
looptime := resultnum
else
	looptime := 10
Loop %looptime%
{
	%A_Index%y+=%rate%
}
GuiControl, Move, Sub, % "x10" "y" 1y-360
Loop %looptime%
{
	GuiControl, Move,  %A_Index%WB1, % "x0" "y" %A_index%y-282
	GuiControl, Move,  %A_Index%ItemWin,  % "x15" "y" %A_Index%y-59
}
}
if toscroll = mob
{
if resultnum < 10
	looptime := resultnum
else
	looptime := 10
Loop %looptime%
{
	%A_Index%y+=%rate%
}
GuiControl, Move, Sub, % "x10" "y" 1y-360
Loop %looptime%
{
	GuiControl, Move,  %A_Index%WB, % "x0" "y" %A_index%y-268
	GuiControl, Move,  %A_Index%DropWin,  % "x15" "y" %A_Index%y
}
}
return

~Down::
~WheelDown::
IfWinNotActive %wintitle%
	return
if clicksearch = true
	return
if resultnum = 1
	return
if onlyresult = 1
	return
rate = 50
if toscroll = item
{
if resultnum < 10
	looptime := resultnum
else
	looptime := 10
if (page = numberofpage)
{
	if %whatleft%y < 390
	return
}
if %looptime%y < 400
	return
Loop %looptime%
{
	%A_Index%y-=%rate%
}
GuiControl, Move, Sub, % "x10" "y" 1y-360
Loop %looptime%
{
	GuiControl, Move,  %A_Index%WB1, % "x0" "y" %A_index%y-282
	GuiControl, Move,  %A_Index%ItemWin,  % "x15" "y" %A_Index%y-59
}
}
if toscroll = mob
{
if resultnum < 10
	looptime := resultnum
else
	looptime := 10
if (page = numberofpage)
{
	if %whatleft%y < 390
	return
}
if %looptime%y < 400
	return
Loop %looptime%
{
	%A_Index%y-=%rate%
}
GuiControl, Move, Sub, % "x10" "y" 1y-360
Loop %looptime%
{
	GuiControl, Move,  %A_Index%WB, % "x0" "y" %A_index%y-268
	GuiControl, Move,  %A_Index%DropWin,  % "x15" "y" %A_Index%y
}
}
return

;===============================FUNCTIONS
addComma(localVar)
{
	global
	commaVar := %localVar%
	if Strlen(commaVar) > 12
		{
			StringRight, afterComma, commaVar, 12
			StringTrimRight, commaVar,commaVar,12
			commaVar = %commaVar%,%afterComma%
			%localVar% = %commaVar%
		}
	if Strlen(commaVar) > 9
		{
			StringRight, afterComma, commaVar, 9
			StringTrimRight, commaVar,commaVar,9
			commaVar = %commaVar%,%afterComma%
			%localVar% = %commaVar%
		}
	if Strlen(commaVar) > 6
		{
			StringRight, afterComma, commaVar, 6
			StringTrimRight, commaVar,commaVar,6
			commaVar = %commaVar%,%afterComma%
			%localVar% = %commaVar%
		}
	if Strlen(commaVar) > 3
		{
			StringRight, afterComma, commaVar, 3
			StringTrimRight, commaVar,commaVar,3
			commaVar = %commaVar%,%afterComma%
			%localVar% = %commaVar%
			return
		}
}
EmpArr(Unique123Var)
{
	global
	Unique123looptime := %Unique123Var%0
	%Unique123Var%0=
	Loop %Unique123looptime%
		%Unique123Var%%A_Index%=
}
repeatItemSearch()
{
global
	HideAll()
	GuiControl, Move, Sub, x10 y415
	GuiControl, Show, Sub
	AdOrder++
	if AdOrder = 1
		Sub.Navigate("http://textuploader.com/57kaf/raw")
	if AdOrder = 2
		Sub.Navigate("http://textuploader.com/57h82/raw")
	if AdOrder = 3
		Sub.Navigate("http://textuploader.com/57h8n/raw")
	if AdOrder = 4
		Sub.Navigate("http://textuploader.com/57h8w/raw")
	if AdOrder = 5
		Sub.Navigate("http://textuploader.com/57h8i/raw")
	if AdOrder = 6
		Sub.Navigate("http://textuploader.com/57h88/raw")
	if AdOrder = 7
		Sub.Navigate("http://textuploader.com/57xsd/raw")
	if AdOrder = 8
	{
		Sub.Navigate("http://textuploader.com/57xst/raw")
		AdOrder = 0
	}
	onlyresult = 1
	if renewal = 1
		IniRead, finditem, %A_ScriptDIr%\Data\RE\item_db.txt,Item, %1celldataXXX%
	else
		IniRead, finditem, %A_ScriptDIr%\Data\PRE\item_db.txt,Item, %1celldataXXX%
	StringSplit, iDetail_, finditem, `,,/
	tocompare = 
	ID := 1celldataXXX
	Name = (%iDetail_2%)
	Name1 := iDetail_3
	Buy := iDetail_5
	Sell := Round(Buy/2)
	addComma("Buy")
	addComma("Sell")
	RangeX := iDetail_10
	Slot := iDetail_11
	itemdesc := i%ID%
	StringReplace, itemdesc, itemdesc, `n,<br>, all
	if Slot > 0
		Slot1 = &nbsp;[%Slot%]
	else
		Slot1 =
	Name1 = %Name1%%Slot1%
	if renewal = 1
		ReOrPre = re_
	else
		ReOrPre = 
	if RangeX > 0
		itemdesc = %itemdesc%Range : <font color=0EAA0B>%RangeX%</font><br><br>Buy : %Buy%z<br>Sell : %Sell%z<br><br><a href="http://ratemyserver.net/index.php?iname=%ID%&page=%ReOrPre%item_db&quick=1&isearch=Search" target="_blank"> Ratemyserver</a><br><a href="http://db.irowiki.org/db/item-info/%ID%/" target="_blank"> iW Database</a>
	if RangeX =
		itemdesc = %itemdesc%<br>Buy : %Buy%z<br>Sell : %Sell%z<br><br><a href="http://ratemyserver.net/index.php?iname=%ID%&page=%ReOrPre%item_db&quick=1&isearch=Search" target="_blank"> Ratemyserver</a><br><a href="http://db.irowiki.org/db/item-info/%ID%/" target="_blank"> iW Database</a>
	IfInString, Name, Card)
		path = %A_ScriptDIr%\Image\Item\card.ico
	else
		path = %A_ScriptDIr%\Image\Item\%1celldataXXX%.gif
	;~ temp=
	IfInString, itemdesc, ^
	{
	StringSplit, tempo_, itemdesc, ^
	Loop %tempo_0%
	{
		if A_index = 1
			temp := temp tempo_%A_Index%
		else
		{
			temp := temp "^" tempo_%A_Index%
			StringLeft, Tcolor, tempo_%A_Index%, 6
			if Tcolor != 000000
				StringReplace, temp, temp, ^%Tcolor%, <font style="color:%Tcolor%"> 
			else
				StringReplace, temp, temp, ^000000, </font>
			
		}
	}
	Loop %tempo_0%
	{
		tempo_%A_Index%=
	}
	itemdesc := temp
	temp=
	}
GuiControl, -Hidden, 1WB1
GuiControl, -Hidden, 1ItemWin
GuiControl, Move, 1WB1,% "x0" "y" 40
GuiControl, Move, 1ItemWin,% "x15" "y" 263
clicksearch = true
1wb1.Navigate("about:blank")
sleep 50
html =
(
	<html>
	<body bgcolor="%Main_BG%" style="margin:15"/> 
	<table style="width:555;color:#ffffff  ;font-size:15" border = 1; cellspacing=0 ;cellpadding=3;  bordercolor="%Item_Border%">
	<tr>
	<td bgcolor="%Item_Header_BG%" valign='bottom'><img src='%path%'>&nbsp;<font color=%Item_Header_Text%><b>%Name1%</b> &nbsp;Item ID# %ID%&nbsp;%Name% </font></td>
	</tr>
	<tr>
	<td bgcolor="%Item_BG%"><div style="overflow: scroll;width: 550px;height: 150px;"><font style="color:Black;font-size:17">%itemdesc%</font></div></td>
	</tr>
	<tr>
	<td style=background-color:#%Item_Header_BG%; align='center'><font color=%Item_Header_Text%><b>Obtain &nbsp; from</b></font></td>
	</tr>
	</table> 
	</html>
)
1wb1.document.write(html)
html=
GuiControl,, loading, 100
mobfind = 0
if renewal = 1
	file2read = %A_ScriptDir%\Data\RE\mob_db.txt
else
	file2read = %A_ScriptDir%\Data\PRE\mob_db.txt
Loop, Read, %file2read%
{
	StringReplace, MobInfo, A_LoopReadLine, =,,
	StringSplit, mDetail1_, MobInfo, `,,/
	uniStr = ,%mDetail1_32%,%mDetail1_34%,%mDetail1_36%,%mDetail1_38%,%mDetail1_40%,%mDetail1_42%,%mDetail1_44%,%mDetail1_46%,%mDetail1_48%,%mDetail1_50%,%mDetail1_52%,%mDetail1_54%,%mDetail1_56%,
	IfInString, uniStr,`,%ID%`,
	{
		mobfind++
		mobline%mobfind% = %A_Index%
	}
}
if mobfind != 0
{
	Gui, ListView, 1ItemWin
	LV_Delete()
	Loop %mobfind%
	{
		line2look := mobline%A_Index%
		FileReadLine, lineinfo, %file2read%, %line2look%
		StringSplit, dropbyinfo_, lineinfo, `,
		lineinfo=
		startInfo = 32
		Loop 13
		{
			if (dropbyinfo_%startInfo% = ID)
			{
			startInfo++
			percentage := dropbyinfo_%startInfo%
			}
			startInfo+=2
		}
		StringTrimRight, dropbyinfo_1, dropbyinfo_1, 1
		IfInString, MVP, %dropbyinfo_1%
			mName := "[MVP]---" dropbyinfo_2
		else
			mName := dropbyinfo_2
		percentage :=  "("Round((percentage/100)*changerate,2)"%)"
		StringTrimLeft, percentage1, percentage, 1
		StringTrimRight, percentage1, percentage1, 2
		fildcontent := percentage1 A_Space mName  
		tocompare = %tocompare%%fildcontent%,
	}
	EmpArr("dropbyinfo_")
	StringTrimRight, tocompare, tocompare, 1
	Sort, tocompare, N R D,
	StringSplit, tocompare_, tocompare, `,
	Loop %tocompare_0%
	{
		StringSplit, tempstuff_, tocompare_%A_Index%, %A_Space%
		instring = %tempstuff_2%      (%tempstuff_1%`%)
		StringReplace, instring, instring, -,%A_Space%, all
		LV_Add("",instring)
	}
	
	If itembluebox contains %ID%
		LV_Add("","Obtainable from Blue Box")
	If itemgiftbox contains %ID%
		LV_Add("","Obtainable from Gift Box")
	If itemvioletbox contains %ID%
		LV_Add("","Obtainable from Violet Box")
	If itemcardalbum contains %ID%
		LV_Add("","Obtainable from Card Album")
	mercnum=0
	merc1=
	Loop %shop_0%
	{
		findmerc := shop_%A_Index%
		StringSplit, tempData_, findmerc, %A_Tab%
		StringTrimRight, npcInfo, tempData_1, 2
		itemtosell := tempData_4	
		sprPos := InStr(itemtosell,",",,1,1)
		temPos := sprPos-1
		StringLeft, npcSprID, itemtosell, %temPos%
		tempPos=
		StringTrimLeft, itemtosell, itemtosell, %sprPos%
		sprPos=
		itemtosell = ,%itemtosell%
		IfInString, itemtosell, ,%ID%:-1
		{
			mercnum++
			merc1 := merc1 "|" npcInfo
		}
	}
	EmpArr("tempData_")
	itemtosell=
	npcInfo=
	npcSprID=
	if mercnum > 0
	{
		StringSplit, merc1_,merc1,|
		LV_Add("","----LIST OF VENDERS----")
	}
}
}
makeTT(byref text,ByRef bg_color,byRef txt_color,byRef x,byref y)
{
	global
	StringSplit, new_, text, `n
	; new_0 = how many lines
	Loop %new_0%
	{
		leng%A_Index% := StrLen(new_%A_Index%)
		bigData := bigData "," leng%A_Index%
	}
	StringTrimLeft, bigData, bigData,1
	Sort bigData, N R D,
	StringSplit, longest_, bigData, `,
	TTwidth := (longest_1*8)-10
	TTheight := new_0*16
	Progress , 1:B1 x%x% y%y% h%TTheight% w%TTwidth%  CW%bg_color% c00 CT%txt_color% FM10 WM600 ZX0 ZY0 ZH0, ,%text%
	return
}
ItemTT()
{
	global
	if A_GuiEvent = Normal
	{
		SplashImage, off
	}
	if A_GuiEvent = RightClick
	{
		SplashImage, Off
		Gui, Listview, %winnum%ItemWin
		LV_GetText(1celldata1,A_EventInfo,1)
		if 1celldata1 = 1
			return
		IfInString, 1celldata1, Obtainable
			return
		IfInString, 1celldata1, LIST OF VENDERs
			return
		IfInString, 1celldata1, [MVP]
			StringTrimLeft, 1celldata1,1celldata1, 8
		StringSplit, randomxyz_, 1celldata1,%A_Space%
		MobX = %randomxyz_1%
	if renewal = 1
		filetoread = %A_ScriptDir%\Data\RE\mob_db.txt
	else
		filetoread = %A_ScriptDir%\Data\PRE\mob_db.txt
	Loop, Read, %filetoread%
	{
		StringSplit, line_,  A_LoopReadLine, `,
		line_2 = ,%line_2%,
		IfInString, line_2, `,%MobX%`,
		{
			splashImg := A_Index
			break
		}
	}
	Loop %line_0%
	{
		line_%A_Index%=
	}
	FileReadLine, randomdata, %filetoread%, %splashImg%
	StringSplit, randomdata_, randomdata,=
	randomdata=
	MouseGetPos, currXX, currYY
	currXX := currXX+20
	currYY := currYY+25
	SplashImage, %A_ScriptDIr%\Image\Mob\%randomdata_1%.gif,B1 x%currXX% y%currYY%
	EmpArr("randomdata_")
	return
	}
if A_GuiEvent = DoubleClick
{
	htmlcontent =
	shopitem =
	look4shop =
	
	Gui, Listview, %winnum%ItemWin
	LV_GetText(1celldata1,A_EventInfo,1)

	IfInString, 1celldata1, Blue Box
	{
		1celldataXXX = 603
		repeatitemSearch()
		return
	}
	IfInString, 1celldata1, Gift Box
	{
		1celldataXXX = 644
		repeatitemSearch()
		return
	}
	IfInString, 1celldata1, Violet Box
	{
		1celldataXXX = 617
		repeatitemSearch()
		return
	}
	IfInString, 1celldata1, Card Album
	{
		1celldataXXX = 616
		repeatitemSearch()
		return
	}
	IfInString, 1celldata1, LIST OF VENDERS
	{
		GuiControl,, loading, 100
		WinGetPos, dockX, dockY,,,%wintitle%
		dock1X := dockX+584
		dock1Y := dockY+144
		GuiControl, 3:-Hidden, npcLV
		GuiControl, 3:+Hidden, xwb
		GuiControl, 3:+Hidden, backButton
		Gui, 3:Show, w258 h385 x%dock1X% y%dock1Y%,xxx
		Gui, 3:Default
		Gui, Listview, npcLV
		LV_Delete()
		looptime := merc%winnum%_0
		Loop %looptime%
		{
			if merc%winnum%_%A_Index% !=
				LV_Add("",merc%winnum%_%A_Index%)
		}
		Gui, 1:Default
		return
	}
	else
	{
	toscroll = mob
	GuiControl,, loading, 0
	Gui, Listview, %winnum%ItemWin
	LV_GetText(celldatax,A_EventInfo,1)
	StringSplit, celldatax_, celldatax, (
	Mob = %celldatax_1%
	IfInString, Mob,[MVP]
		StringTrimLeft, Mob, Mob, 8
if resultnum != 0
{
	Loop %resultnum%
	{
		reset++
		result%reset% =
	}
}
resultnum = 0
startresult = 0
picresult = 0
reset = 0
if renewal = 1
	filetoread = %A_ScriptDir%\Data\RE\mob_db.txt
else
	filetoread = %A_ScriptDir%\Data\PRE\mob_db.txt
	Loop, Read, %filetoread%
{
	StringSplit, line_,  A_LoopReadLine, `,
	line_2 = ,%line_2%,
	IfInString, line_2, `,%Mob%`,
	{
		resultnum++
		result%resultnum% := A_Index
	}
}
Hideall()
onlyresult = 1
Update()
}
}
}
ItemSetInfo()
{
	global
	startresult++
	Result := result%startresult%
	FileReadline ,Iteminfo, %filetoread% ,%Result%
	StringReplace, Iteminfo, Iteminfo, =,,
	StringSplit, iDetail_, Iteminfo, `,,/
	ID := iDetail_1
	Name = (%iDetail_2%)
	Name1 := iDetail_3
	Buy := iDetail_5
	Sell := Round(Buy/2)
	addComma("Buy")
	addComma("Sell")
	RangeX := iDetail_10
	Slot := iDetail_11
	itemdesc := i%ID%
	StringReplace, itemdesc, itemdesc, `n,<br>, all
	if Slot > 0
		Slot1 = &nbsp;[%Slot%]
	else
		Slot1 =
	Name1 = %Name1%%Slot1%
	if renewal = 1
		ReOrPre = re_
	else
		ReOrPre = 
	if RangeX > 0
		itemdesc = %itemdesc%Range : <font color=0EAA0B>%RangeX%</font><br><br>Buy : %Buy%z<br>Sell : %Sell%z<br><br><a href="http://ratemyserver.net/index.php?iname=%ID%&page=%ReOrPre%item_db&quick=1&isearch=Search" target="_blank"> Ratemyserver</a><br><a href="http://db.irowiki.org/db/item-info/%ID%/" target="_blank"> iW Database</a>
	if RangeX =
		itemdesc = %itemdesc%<br>Buy : %Buy%z<br>Sell : %Sell%z<br><br><a href="http://ratemyserver.net/index.php?iname=%ID%&page=%ReOrPre%item_db&quick=1&isearch=Search" target="_blank"> Ratemyserver</a><br><a href="http://db.irowiki.org/db/item-info/%ID%/" target="_blank"> iW Database</a>
	EmpArr("iDetail_")
}
UpdateItem()
{
	global
	startY := 410
	page = 1
	whatleft := Mod(resultnum,10)
	if whatleft = 0
		whatleft = 10
	GuiControl, Move, Sub, x10 y50
	GuiControl, Show, Sub
	AdOrder++
	if AdOrder = 1
		Sub.Navigate("http://textuploader.com/57kaf/raw")
	if AdOrder = 2
		Sub.Navigate("http://textuploader.com/57h82/raw")
	if AdOrder = 3
		Sub.Navigate("http://textuploader.com/57h8n/raw")
	if AdOrder = 4
		Sub.Navigate("http://textuploader.com/57h8w/raw")
	if AdOrder = 5
		Sub.Navigate("http://textuploader.com/57h8i/raw")
	if AdOrder = 6
		Sub.Navigate("http://textuploader.com/57h88/raw")
	if AdOrder = 7
		Sub.Navigate("http://textuploader.com/57xsd/raw")
	if AdOrder = 8
	{
		Sub.Navigate("http://textuploader.com/57xst/raw")
		AdOrder = 0
	}
	1y := startY
	2y := 1y+374
	3y := 2y+374
	4y := 3y+374
	5y := 4y+374
	6y := 5y+374
	7y := 6y+374
	8y := 7y+374
	9y := 8y+374
	10y := 9y+374
	if resultnum < 10
		howtoprog := 100/resultnum
	else
		howtoprog = 10
	if onlyresult = 1
		howtoprog = 100
if resultnum < 10
	daloop = %resultnum%
else
	daloop = 10
if onlyresult = 1
	daloop = 1
GuiControl, Enable, Next
GuiControl, Disable, Prev
Loop %daloop%
{
	Simple()
	if onlyresult = 1
		break
}
EmpArr("picname_")
numberofpage := Ceil(resultnum/10)
SB_SetText("Found " . resultnum . " results," . numberofpage . " pages")
if onlyresult = 1
	numberofpage = 1
GuiControl,, pagestat, %page%/%numberofpage%
}
Simple()
{
	global
	ItemSetInfo()
	tocompare = 
	picresult++
	tolook := result%picresult%
	FileReadLine, PicInfo, %filetoread%, %tolook%
	StringReplace, PicInfo, PicInfo, =,,
	StringSplit, picname_, PicInfo, `,,/
	IfInString,Name, _Card)
		path = %A_ScriptDIr%\Image\Item\card.ico
	else
		path = %A_ScriptDIr%\Image\Item\%picname_1%.gif
	IfInString, itemdesc, ^
	{
		; COLOR HERE
	StringSplit, tempo_, itemdesc, ^
	Loop %tempo_0%
	{
		if A_index = 1
			temp := temp tempo_%A_Index%
		else
		{
			temp := temp "^" tempo_%A_Index%
			StringLeft, Tcolor, tempo_%A_Index%, 6
			if Tcolor != 000000
				StringReplace, temp, temp, ^%Tcolor%, <font style="color:%Tcolor%"> 
			else
				StringReplace, temp, temp, ^000000, </font>
			
		}
	}
	Loop %tempo_0%
	{
		tempo_%A_Index%=
	}
	itemdesc := temp
	temp=
	}
GuiControl,, loading, +%howtoprog%
GuiControl, -Hidden, %A_Index%WB1
GuiControl, -Hidden, %A_Index%ItemWin
GuiControl, Move, %A_index%WB1,% "x0" "y" startY-282
GuiControl, Move, %A_Index%ItemWin,% "x15" "y" startY-59
startY := startY+374
%A_Index%wb1.Navigate("about:blank")
sleep 0
html =
(
	<html>
	<body bgcolor="%Main_BG%" style="margin:15"/> 
	<table style="width:555;color:#ffffff  ;font-size:15" border = 1; cellspacing=0 ;cellpadding=3;  bordercolor="%Item_Border%">
	<tr>
	<td bgcolor="%Item_Header_BG%" valign='bottom'><img src='%path%'>&nbsp;<font color=%Item_Header_Text%><b>%Name1%</b> &nbsp;Item ID# %ID%&nbsp;%Name% </font></td>
	</tr>
	<tr>
	<td bgcolor="%Item_BG%"><div style="overflow: scroll;width: 550px;height: 150px;"><font style="color:Black;font-size:17">%itemdesc%</font></div></td>
	</tr>
	<tr>
	<td style=background-color:#%Item_Header_BG%; align='center'><font color=%Item_Header_Text%><b>Obtain &nbsp; from</b></font></td>
	</tr>
	</table> 
	</html>
)
%A_Index%wb1.document.write(html)
html=
mobfind = 0
if renewal = 1
	file2read = %A_ScriptDir%\Data\RE\mob_db.txt
else
	file2read = %A_ScriptDir%\Data\PRE\mob_db.txt
Loop, Read, %file2read%
{
	StringReplace, MobInfo, A_LoopReadLine, =,,
	StringSplit, mDetail1_, MobInfo, `,,/
	uniStr = ,%mDetail1_32%,%mDetail1_34%,%mDetail1_36%,%mDetail1_38%,%mDetail1_40%,%mDetail1_42%,%mDetail1_44%,%mDetail1_46%,%mDetail1_48%,%mDetail1_50%,%mDetail1_52%,%mDetail1_54%,%mDetail1_56%,
	IfInString, uniStr,`,%ID%`,
	{
		mobfind++
		mobline%mobfind% = %A_Index%
	}
}
if (mobfind != "0" or mobfind != "")
{
	Gui, ListView, %A_Index%ItemWin
	LV_Delete()
	Loop %mobfind%
	{
		line2look := mobline%A_Index%
		FileReadLine, lineinfo, %file2read%, %line2look%
		StringSplit, dropbyinfo_, lineinfo, `,
		lineinfo=
		startInfo = 32
		Loop 13
		{
			if (dropbyinfo_%startInfo% = ID)
			{
			startInfo++
			percentage := dropbyinfo_%startInfo%
			}
			startInfo+=2
		}
				StringTrimRight, dropbyinfo_1, dropbyinfo_1, 1
		IfInString, MVP, %dropbyinfo_1%
			mName := "[MVP]---" dropbyinfo_2
		else
			mName := dropbyinfo_2
		percentage := "("Round((percentage/100)*changerate,2)"%)"
		StringTrimLeft, percentage1, percentage, 1
		StringTrimRight, percentage1, percentage1, 2
		fildcontent := percentage1 A_Space mName  
		tocompare = %tocompare%%fildcontent%,
	}
	StringTrimRight, tocompare, tocompare, 1
	Sort, tocompare, N R D,
	StringSplit, tocompare_, tocompare, `,
	tocompare=
	Loop %tocompare_0%
	{
		StringSplit, tempstuff_, tocompare_%A_Index%, %A_Space%
		instring = %tempstuff_2%      (%tempstuff_1%`%)
		StringReplace, instring, instring, -,%A_Space%, all
		LV_Add("",instring)
	}
	If itembluebox contains %ID%
		LV_Add("","Obtainable from Blue Box")
	If itemgiftbox contains %ID%
		LV_Add("","Obtainable from Gift Box")
	If itemvioletbox contains %ID%
		LV_Add("","Obtainable from Violet Box")
	If itemcardalbum contains %ID%
		LV_Add("","Obtainable from Card Album")
	currIndex := A_Index
	mercnum=0
	merc%A_Index% =
	Loop %shop_0%
	{
		findmerc := shop_%A_Index%
		StringSplit, tempData_, findmerc, %A_Tab%
		StringTrimRight, npcInfo, tempData_1, 2
		itemtosell := tempData_4	
		sprPos := InStr(itemtosell,",",,1,1)
		temPos := sprPos-1
		StringLeft, npcSprID, itemtosell, %temPos%
		tempPos=
		StringTrimLeft, itemtosell, itemtosell, %sprPos%
		sprPos=
		IfInString, itemtosell, ,%ID%:-1
		{
			mercnum++
			merc%currIndex% := merc%currIndex% "|" npcInfo
		}
	}
	EmpArr("tempData_")
	itemtosell=
	npcInfo=
	npcSprID=
	if mercnum > 0
	{
		;~ StringReplace, merc%A_Index%, merc%A_Index%,`r`n,|,all
		StringSplit, merc%A_Index%_,merc%A_Index%,|
		LV_Add("","----LIST OF VENDERS----")
	}
}
SB_SetText("Found " . resultnum . " results," . numberofpage . " pages")
}
QuickTT()
{
	global
if A_GuiEvent = Normal
{
	StringSplit, HiddenVar%tablenum%_, HiddenVar%tablenum%, `,
	text := HiddenVar%tablenum%_%A_EventInfo%
	text := i%text%
	Progress, off
}
if A_GuiEvent = RightClick
{
MouseGetPos, nowTTx, nowTTy
nowTTx := nowTTx-50
nowTTy := nowTTy+25
StringSplit, HiddenVar%tablenum%_, HiddenVar%tablenum%, `,
text := HiddenVar%tablenum%_%A_EventInfo%
text := i%text%
	IfInString, text, ^
	{
	StringSplit, tempo_, text, ^
	Loop %tempo_0%
	{
		if A_index = 1
			temp := temp tempo_%A_Index%
		else
		{
			temp := temp "^" tempo_%A_Index%
			StringLeft, Tcolor, tempo_%A_Index%, 6
			StringReplace, temp, temp, ^%Tcolor%,, all
			StringReplace, temp, temp, ^000000,, all
		}
	}
	Loop %tempo_0%
	{
		tempo_%A_Index%=
	}
	text := temp
	temp=
	}
	if text =
		return
	makeTT(text,bg_color,txt_color,nowTTx,nowTTy)
}
if A_GuiEvent = DoubleClick
{
	onlyresult = 1
	1celldataXXX := HiddenVar%tablenum%_%A_EventInfo%
	repeatitemSearch()
}
}
Help(wParam, lParam, Msg) 
{
global MouseX, MouseY
MouseGetPos,MouseX,MouseY,, OutputVarControl
global ControlName := OutputVarControl
If ControlName not contains SysListView
{
	Progress, off
	SplashImage, Off
}
IfWinNotExist,  %wintitle%
	RestoreCursors()
}
SetSystemCursor()
{
	IDC_SIZEALL := 32646
	Cursor = %A_ScriptDir%\Image\Ragnarok Default.ani
	CursorHandle := DllCall( "LoadCursorFromFile", Str,Cursor )
	Cursors = 32512,32513,32514,32515,32516,32640,32641,32642,32643,32644,32645,32646,32648,32649,32650,32651
	Loop, Parse, Cursors, `,
	{
		DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_Loopfield )
	}
}
RestoreCursors() 
{
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
}
MakePrevNext()
{
	global
	Gui, Add, Button, x245 y485 vPrev gPrev , <
	Gui, Add, Text, xp+20 yp+5 vpagestat w65 +center, %page%/%numberofpage%
	Gui, Add, Button, xp+70 yp-5 vNext gNext , >
	GuiControl,Disable, Prev
	GuiControl,Disable, Next
}
Hideall()
{
	global
	Loop 10
	{
		Gui, 1:Default
		Gui, ListView, %A_Index%ItemWin
		LV_Delete()
		Gui, ListView, %A_Index%DropWin
		LV_Delete()
		%A_Index%wb.Navigate("about:blank")
		Sleep 0
		%A_Index%wb1.Navigate("about:blank")
		Sleep 0
		GuiControl, +Hidden, %A_Index%WB
		GuiControl, +Hidden, %A_Index%WB1
		GuiControl, +Hidden, %A_Index%ItemWIn
		GuiControl, Move, %A_Index%DropWin, x-500 y-500
	}
}
Update()
{
	global
	startY := 410
	page = 1
	whatleft := Mod(resultnum,10)
	if whatleft = 0
		whatleft = 10
	if whatleft = 1
		GuiControl, Move, Sub, x10 y415
	else
		GuiControl, Move, Sub, x10 y50
	GuiControl, Show, Sub
	AdOrder++
	if AdOrder = 1
		Sub.Navigate("http://textuploader.com/57kaf/raw")
	if AdOrder = 2
		Sub.Navigate("http://textuploader.com/57h82/raw")
	if AdOrder = 3
		Sub.Navigate("http://textuploader.com/57h8n/raw")
	if AdOrder = 4
		Sub.Navigate("http://textuploader.com/57h8w/raw")
	if AdOrder = 5
		Sub.Navigate("http://textuploader.com/57h8i/raw")
	if AdOrder = 6
		Sub.Navigate("http://textuploader.com/57h88/raw")
	if AdOrder = 7
		Sub.Navigate("http://textuploader.com/57xsd/raw")
	if AdOrder = 8
	{
		Sub.Navigate("http://textuploader.com/57xst/raw")
		AdOrder = 0
	}
	spaceBetween = 384
	1y := startY
	2y := 1y+spaceBetween
	3y := 2y+spaceBetween
	4y := 3y+spaceBetween
	5y := 4y+spaceBetween
	6y := 5y+spaceBetween
	7y := 6y+spaceBetween
	8y := 7y+spaceBetween
	9y := 8y+spaceBetween
	10y := 9y+spaceBetween
	if resultnum < 10
		howtoprog := 100/resultnum
	else
		howtoprog = 10
	if onlyresult = 1
		howtoprog = 100
if resultnum < 10
	daloop = %resultnum%
else
	daloop = 10
if onlyresult = 1
{
	GuiControl, Move, Sub, x10 y415
	GuiControl, Show, Sub
	if AdOrder = 1
		Sub.Navigate("http://textuploader.com/57kaf/raw")
	if AdOrder = 2
		Sub.Navigate("http://textuploader.com/57h82/raw")
	if AdOrder = 3
		Sub.Navigate("http://textuploader.com/57h8n/raw")
	if AdOrder = 4
		Sub.Navigate("http://textuploader.com/57h8w/raw")
	if AdOrder = 5
		Sub.Navigate("http://textuploader.com/57h8i/raw")
	if AdOrder = 6
		Sub.Navigate("http://textuploader.com/57h88/raw")
	if AdOrder = 7
		Sub.Navigate("http://textuploader.com/57xsd/raw")
	if AdOrder = 8
	{
		Sub.Navigate("http://textuploader.com/57xst/raw")
		AdOrder = 0
	}
	daloop = 1
}
if whatleft = 1
	startY = 315
GuiControl, Enable, Next
GuiControl, Disable, Prev
startresult=0
picresult=0
Loop %daloop%
{
	Simplize()
	if onlyresult = 1
		break
}
EmpArr("picname_")
numberofpage := Ceil(resultnum/10)
SB_SetText("Found " . resultnum . " results," . numberofpage . " pages")
if onlyresult = 1
	numberofpage = 1
if whatleft != 1
	GuiControl,, pagestat, %page%/%numberofpage%
}
Simplize()
{
	global
	SetInfo()
	picresult++
	tolook := result%picresult%
	FileReadLine, PicInfo, %filetoread%, %tolook%
	StringReplace, PicInfo, PicInfo, =,,
	StringSplit, picname_, PicInfo, `,,/
	PicInfo=
	path = %A_ScriptDIr%\Image\Mob\%picname_1%.gif
	Gui, 99:Add, Picture, x10 y10 vPic%A_Index% , %path%
	GuiControlGet, Pic%A_index%, 99:Pos
	Gui, 99:Destroy
	if (Pic%A_index%H  >  165 or Pic%A_index%W > 135)
		piclink = <img src = " %path% "  width="135" height="165">
	else
		piclink = <img src = " %path% ">
	m%picname% = 
	onmap1 := m%picname_1%
	StringReplace, onmap, onmap1,),)<br>, all
	onmap1=
	currIndex := A_Index
	HiddenVar%A_Index% =
	Loop 9
	{
		if drop%A_Index%p != 0
			HiddenVar%currIndex% := HiddenVar%currIndex% "," drop%A_Index%
	}
	if dropC != 0
		HiddenVar%A_Index% := HiddenVar%A_Index% "," dropC
	Loop 3
	{
		if mvp%A_index%p != 0
			HiddenVar%currIndex% := HiddenVar%currIndex% "," mvp%A_Index%
	}
	StringTrimLeft, HiddenVar%A_Index%, HiddenVar%A_Index%, 1
Gui, ListView, %A_Index%DropWin
LV_Delete()
IL_Destroy(%A_Index%ImageListID)
%A_Index%ImageListID := IL_Create(13)
LV_SetImageList(%A_Index%ImageListID)
currIndex := A_Index

Loop 9
{
	if drop%A_Index% != 0
		IL_Add(%currIndex%ImageListID, A_ScriptDir . "\Image\Item\" . drop%A_Index% . ".gif")
	else
		IL_Add(%currIndex%ImageListID, A_ScriptDir . "\Image\Item\noimg.gif")
}
if dropC != 0
	IL_Add(%A_Index%ImageListID, A_ScriptDir . "\Image\Item\card.ico")
else
	IL_Add(%A_Index%ImageListID, A_ScriptDir . "\Image\Item\noimg.gif")
Loop 3
{
	if mvp%A_Index%p != 0
		IL_Add(%currIndex%ImageListID, A_ScriptDir . "\Image\Item\" . mvp%A_Index% . ".gif")
	else
		IL_Add(%currIndex%ImageListID, A_ScriptDir . "\Image\Item\noimg.gif")
}
	Roundup()
	Rename()
Loop 9
{
	if drop%A_Index%p != 0
		LV_Add("Icon" . A_Index, drop%A_Index% . A_Space .  drop%A_Index%slot  . "   (" . drop%A_Index%p . "%)")
}
if dropC != 0
	LV_Add("Icon10" , dropC . "   (" . dropCp . "%)")
Loop 3
{
	if mvp%A_Index%p != 0
		LV_Add("Icon1" . A_Index, mvp%A_Index% . A_Space .  mvp%A_Index%slot . "   (" . mvp%A_Index%p . "%)")
}
GuiControl,, loading, +%howtoprog%
GuiControl, -Hidden, %A_Index%WB
GuiControl, Move, %A_index%WB,% "x0" "y" startY-266
GuiControl, Move, %A_Index%DropWin,% "x15" "y" startY +2
startY := startY+374
IfInString, miniMVP, %ID%
	MVPorNah =<td  rowspan = 1 colspan = 5  align='left' valign='middle' style="background-color:#%Mob_Header_BG%"><font color=%Mob_Header_Text%><b>%Name% &nbsp; (%SprName%) &nbsp; Mob-ID#%ID%</b></font><font color=%Mob_MVP_Type%><b>( Mini )</b></font></td>
else IfInString, MVP, %ID%
	MVPorNah =<td  rowspan = 1 colspan = 5  align='left' valign='middle' style="background-color:#%Mob_Header_BG%"><font color=%Mob_Header_Text%><b>%Name% &nbsp; (%SprName%) &nbsp; Mob-ID#%ID%</b></font><font color=%Mob_MVP_Type%><b>( MVP )</b></font></td>
else
	MVPorNah =<td  rowspan = 1 colspan = 5  align='left' valign='middle' style="background-color:#%Mob_Header_BG%"><font color=%Mob_Header_Text%><b>%Name% &nbsp; (%SprName%) &nbsp; Mob-ID#%ID%</b></font></td>
if renewal = 1
	ReOrPre = re_
else
	ReOrPre = 
If Speed >= 1000
	Speed = Immobile
else if Speed >= 400
	Speed = Very Slow
else if Speed >= 200
	Speed = Slow
else if Speed >= 170
	Speed = Average
else If Speed >= 135
	Speed = Fast
else if Speed <= 130
	Speed = Very Fast
StringReplace, RMSSearch, Name,%A_Space%,+,all
if Mob_OnMapBold = yes
	OnMapOrNah = <b>%onmap%</b>
else
	OnMapOrNah = %onmap%
%A_Index%wb.Navigate("about:blank")
sleep 0
html =
(
<html>
<body bgcolor="#%Main_BG%" style="margin:0; padding:0"/> 
<table style="width:555;color:#%Mob_Text%  ;font-size:14; text-align:center;" cellspacing="0" cellpadding="0"  align="center" border="1" bordercolor="%Mob_Border%" height="255">
	<tr>
	%MVPorNah%
	<td  align='center' valign='middle' style="background-color:#%Mob_Header_BG%"><font color=%Mob_Header_Text%><b>-:- On Maps -:-</b></font></td>
	</tr>
	
	<tr>
	<td bgcolor="%Mob_BG%" rowspan = 10 colspan = 1  align='center' valign='middle' width="135" height='165'>%piclink%</td>
	<td bgcolor="#%Mob_Main_Color%"><b>Hp</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%HP%</td> 
	<td bgcolor="#%Mob_Main_Color%"><b>Lv</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%LV%</td>
	<td bgcolor="#%Mob_Main_Color%"rowspan = 12 colspan = 1 cellpadding ='10' align='left' valign='middle'><div style="overflow: auto;height:226px;width:125;padding: 2px;">%OnMapOrNah%</div></td>
   </tr>
   
  <tr>
	<td bgcolor="#%Mob_Main_Color%"><b>Atk</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%ATK1%~%ATK2%</td> 
	<td bgcolor="#%Mob_Main_Color%"><b>Race</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%Race%</td>
   </tr>
   
	<tr>
	<td bgcolor="#%Mob_Main_Color%"><b>Exp</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%EXP%</td> 
	<td bgcolor="#%Mob_Main_Color%"><b>Property</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%Element%</td>
   </tr>
   
	<tr>
	<td bgcolor="#%Mob_Main_Color%"><b>jExp</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%jEXP%</td> 
	<td bgcolor="#%Mob_Main_Color%"><b>Size</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%Scale%</td>
   </tr>
   
	<tr>
	<td bgcolor="#%Mob_Main_Color%"><b>Def</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%Def% </td> 
	<td bgcolor="#%Mob_Main_Color%"><b>Range</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%Range%</td>
   </tr>
   
	<tr>
	<td bgcolor="#%Mob_Main_Color%"><b>mDef</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%mDef%</td> 
	<td bgcolor="#%Mob_Main_Color%"><b>Walk Spd</b></td>
	<td bgcolor="#%Mob_Sub_Color%">%Speed%</td>
   </tr>
   
   <tr>
   	<td rowspan = 1 colspan = 4  align='center' valign='middle' style="background-color:#%Mob_Header_BG%"><font color=%Mob_Header_Text%><b>Elements&nbsp;Effectiveness</b></font></td>
   </tr>
   
	<tr>
   <td bgcolor="#%Mob_Main_Color%"><b>Neutral</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tNeutral%</td>
   <td bgcolor="#%Mob_Main_Color%"><b>Poison</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tPoison%</td>
   </tr>
   
	<tr>
   <td bgcolor="#%Mob_Main_Color%"><b>Fire</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tFire%</td>
   <td bgcolor="#%Mob_Main_Color%"><b>Holy</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tHoly%</td>
   </tr>
   
	<tr>
   <td bgcolor="#%Mob_Main_Color%"><b>Earth</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tEarth%</td>
   <td bgcolor="#%Mob_Main_Color%"><b>Shadow</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tShadow%</td>
   </tr>
   
	<tr>
	<td bgcolor="#%Mob_Sub_Color%"><a href="http://ratemyserver.net/index.php?mob_name=%RMSSearch%&page=%ReOrPre%mob_db&f=1&mob_search=Search" target="_blank">Ratemyserver</a></td>
   <td bgcolor="#%Mob_Main_Color%"><b>Wind</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tWind%</td>
   <td bgcolor="#%Mob_Main_Color%"><b>Ghost</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tGhost%</td>
   </tr>
   
   	<tr>
	<td bgcolor="#%Mob_Sub_Color%"><a href="http://db.irowiki.org/db/monster-info/%ID%/" target="_blank">iW Database</a></td>
   <td bgcolor="#%Mob_Main_Color%"><b>Water</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tWater%</td>
   <td bgcolor="#%Mob_Main_Color%"><b>Undead</b></td>
   <td bgcolor="#%Mob_Sub_Color%">%tUndead%</td>
   </tr>
   
	<tr>
   	<td rowspan = 0 colspan = 6  align='center' valign='middle' style="background-color:#%Mob_Header_BG%"><font color=%Mob_Header_Text%><b>Drops</b></font></td>
   </tr>

</table> 
</html>
)
%A_Index%wb.document.write(html)
html=
}
Roundup()
{
	global
	Loop 9
	{
		drop%A_Index%p := Round((drop%A_Index%p/100)*changerate,2)
	}
	dropCp := Round((dropCp/100)*changerate,2)
	Loop 3
	{
		mvp%A_Index%p := Round((mvp%A_Index%p/100)*changerate,2)
	}
}
Rename()
{
	global
	Loop 9
	{
		LeItem := drop%A_Index%
		if renewal = 1
			IniRead, itemline, %A_ScriptDir%\Data\RE\item_db.txt,Item, %LeItem%
		else
			IniRead, itemline, %A_ScriptDir%\Data\PRE\item_db.txt,Item, %LeItem%
		StringSplit, iline_,  itemline, `,
		itemline=
		drop%A_Index% := iline_3
		drop%A_Index%slot = [%iline_11%]
	}
	if dropC != 0
	{
		if renewal = 1
			IniRead, itemline, %A_ScriptDir%\Data\RE\item_db.txt,Item, %dropC%
		else
			IniRead, itemline, %A_ScriptDir%\Data\PRE\item_db.txt,Item, %dropC%
		StringSplit, iline_,  itemline, `,
		itemline=
		dropC := iline_3
	}
	Loop 3
	{
		mvpItem := mvp%A_Index%
		if renewal = 1
			IniRead, itemline, %A_ScriptDir%\Data\RE\item_db.txt,Item, %mvpItem%
		else
			IniRead, itemline, %A_ScriptDir%\Data\PRE\item_db.txt,Item, %mvpItem%
		StringSplit, iline_,  itemline, `,
		itemline=
		mvp%A_Index% := iline_3
		mvp%A_Index%slot =  [%iline_11%]
	}
	; CLEAR EMPT SLOTS
	Loop 9
	{
	if (drop%A_Index%slot = "[]" or drop%A_Index%slot = "[0]")
		drop%A_Index%slot =
	}
	Loop 3
	{
	if (mvp%A_index%slot = "[]" or mvp%A_index%slot = "[0]")
		mvp%A_index%slot =	
	}
}
GetInfo()
{
	global
 ; SETTING MOB ON-MAPS
FileRead, onmapfile, %A_ScriptDir%\Data\PRE\Onmap.txt
StringSplit, onmapfile_, onmapfile, #
onmapfile=
num=0
Loop %onmapfile_0%
{
num++
xID := onmapfile_%num%
StringReplace, xID, xID, `r`n,,all
StringReplace, xID, xID, %A_Space%,,all
num++
descX := onmapfile_%num%
lastone := 
StringReplace, descX, descX, `r`n,,
m%xID% := descX
onmapfile_%A_Index%=
}
xID=
descX=

; SETTING ITEM DESCRIBTIONS FIXINGX
FileRead, data, %A_ScriptDir%\Data\itemInfo.lub
StringReplace, data, data, ClassNum,#,all
Loop, parse, data, #
{
	StringSplit, tempData_,A_Loopfield, =
	StringReplace, DescInfo, tempData_9, "`,,,all
	StringReplace, DescInfo, DescInfo, ",,all
	StringReplace, DescInfo, DescInfo, %A_Tab%,,all
	StringReplace, DescInfo, DescInfo,slotCount,,all
	StringTrimLeft, DescInfo, DescInfo,4
	StringTrimRight, DescInfo, DescInfo,6
	StringSplit, itemID_, tempData_2,[
	StringTrimRight, itemID, itemID_2,2
	if itemID is number
		i%itemID% = %DescInfo%<br>
}
EmpArr("tempData_")
EmpArr("itemID_")
data=
;~ FileRead, identify, %A_ScriptDir%\Data\idnum2itemdesctable.txt
;~ StringSplit, identify_, identify, #
;~ identify=
;~ num=0
;~ Loop %identify_0%
;~ {
;~ num++
;~ xID := identify_%num%
;~ StringReplace, xID, xID, `r`n,,all
;~ StringReplace, xID, xID, %A_Space%,,all
;~ num++
;~ descX := identify_%num%
;~ lastone := 
;~ StringReplace, descX, descX, `r`n,,
;~ i%xID% := descX
;~ identify_%A_Index%=
;~ }
;~ xID=
;~ descX=

wintitle = Ragindex
FileRead, shops, %A_ScriptDir%\Data\PRE\shops.txt
StringSplit, shop_, shops,`n
shops=
FileRead, itembluebox, %A_ScriptDir%\Data\item_bluebox.txt
FileRead, itemcardalbum,%A_ScriptDir%\Data\item_cardalbum.txt
FileRead, itemgiftbox, %A_ScriptDir%\Data\item_giftbox.txt
FileRead, itemvioletbox, %A_ScriptDir%\Data\item_violetbox.txt
FileRead, MVP, %A_ScriptDir%\Data\MVP.txt
FileRead, miniMVP, %A_ScriptDir%\Data\miniMVP.txt

IniRead, closeX, %A_ScriptDir%\Data\ragindex.ini,Pos,winX
IniRead, closeY, %A_ScriptDir%\Data\ragindex.ini,Pos,winY
IniRead, changerate, %A_ScriptDir%\Data\ragindex.ini, Rate, droprate
IniRead, bexprate, %A_ScriptDir%\Data\ragindex.ini, Rate, bexprate
IniRead, jexprate, %A_ScriptDir%\Data\ragindex.ini, Rate, jexprate
IniRead, daHotkey, %A_ScriptDir%\Data\ragindex.ini, Hotkey, hotkey
Hotkey, %daHotkey%, theToggle
}
GetEleInfo()
{
global
; ELEMENTAL STUFF
IniRead, tNeutral1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Neutral
IniRead, tWater1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Water
Iniread, tEarth1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Earth
Iniread, tFire1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Fire
Iniread, tWind1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Wind
Iniread, tPoison1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Poison
Iniread, tHoly1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Holy
IniRead, tShadow1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Shadow
IniRead, tGhost1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Ghost
IniRead, tUndead1, %A_ScriptDir%\Data\ElementTable.ini,Level1,Undead
StringSplit, tNeutral1_, tNeutral1, %A_Tab%, %A_Space%
StringSplit, tWater1_, tWater1, %A_Tab%, %A_Space%
StringSplit, tEarth1_, tEarth1, %A_Tab%, %A_Space%
StringSplit, tFire1_, tFire1, %A_Tab%, %A_Space%
StringSplit, tWind1_, tWind1, %A_Tab%, %A_Space%
StringSplit, tPoison1_, tPoison1, %A_Tab%, %A_Space%
StringSplit, tHoly1_, tHoly1, %A_Tab%, %A_Space%
StringSplit, tShadow1_, tShadow1, %A_Tab%, %A_Space%
StringSplit, tGhost1_, tGhost1, %A_Tab%, %A_Space%
StringSplit, tUndead1_, tUndead1, %A_Tab%, %A_Space%

IniRead, tNeutral2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Neutral
IniRead, tWater2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Water
Iniread, tEarth2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Earth
Iniread, tFire2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Fire
Iniread, tWind2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Wind
Iniread, tPoison2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Poison
Iniread, tHoly2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Holy
IniRead, tShadow2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Shadow
IniRead, tGhost2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Ghost
IniRead, tUndead2, %A_ScriptDir%\Data\ElementTable.ini,Level2,Undead
StringSplit, tNeutral2_, tNeutral2, %A_Tab%, %A_Space%
StringSplit, tWater2_, tWater2, %A_Tab%, %A_Space%
StringSplit, tEarth2_, tEarth2, %A_Tab%, %A_Space%
StringSplit, tFire2_, tFire2, %A_Tab%, %A_Space%
StringSplit, tWind2_, tWind2, %A_Tab%, %A_Space%
StringSplit, tPoison2_, tPoison2, %A_Tab%, %A_Space%
StringSplit, tHoly2_, tHoly2, %A_Tab%, %A_Space%
StringSplit, tShadow2_, tShadow2, %A_Tab%, %A_Space%
StringSplit, tGhost2_, tGhost2, %A_Tab%, %A_Space%
StringSplit, tUndead2_, tUndead2, %A_Tab%, %A_Space%

IniRead, tNeutral3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Neutral
IniRead, tWater3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Water
Iniread, tEarth3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Earth
Iniread, tFire3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Fire
Iniread, tWind3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Wind
Iniread, tPoison3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Poison
Iniread, tHoly3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Holy
IniRead, tShadow3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Shadow
IniRead, tGhost3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Ghost
IniRead, tUndead3, %A_ScriptDir%\Data\ElementTable.ini,Level3,Undead
StringSplit, tNeutral3_, tNeutral3, %A_Tab%, %A_Space%
StringSplit, tWater3_, tWater3, %A_Tab%, %A_Space%
StringSplit, tEarth3_, tEarth3, %A_Tab%, %A_Space%
StringSplit, tFire3_, tFire3, %A_Tab%, %A_Space%
StringSplit, tWind3_, tWind3, %A_Tab%, %A_Space%
StringSplit, tPoison3_, tPoison3, %A_Tab%, %A_Space%
StringSplit, tHoly3_, tHoly3, %A_Tab%, %A_Space%
StringSplit, tShadow3_, tShadow3, %A_Tab%, %A_Space%
StringSplit, tGhost3_, tGhost3, %A_Tab%, %A_Space%
StringSplit, tUndead3_, tUndead3, %A_Tab%, %A_Space%

IniRead, tNeutral4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Neutral
IniRead, tWater4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Water
Iniread, tEarth4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Earth
Iniread, tFire4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Fire
Iniread, tWind4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Wind
Iniread, tPoison4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Poison
Iniread, tHoly4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Holy
IniRead, tShadow4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Shadow
IniRead, tGhost4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Ghost
IniRead, tUndead4, %A_ScriptDir%\Data\ElementTable.ini,Level4,Undead
StringSplit, tNeutral4_, tNeutral4, %A_Tab%, %A_Space%
StringSplit, tWater4_, tWater4, %A_Tab%, %A_Space%
StringSplit, tEarth4_, tEarth4, %A_Tab%, %A_Space%
StringSplit, tFire4_, tFire4, %A_Tab%, %A_Space%
StringSplit, tWind4_, tWind4, %A_Tab%, %A_Space%
StringSplit, tPoison4_, tPoison4, %A_Tab%, %A_Space%
StringSplit, tHoly4_, tHoly4, %A_Tab%, %A_Space%
StringSplit, tShadow4_, tShadow4, %A_Tab%, %A_Space%
StringSplit, tGhost4_, tGhost4, %A_Tab%, %A_Space%
StringSplit, tUndead4_, tUndead4, %A_Tab%, %A_Space%
Loop 4
{
tNeutral%A_Index%= 
tWater%A_Index%=
tEarth%A_Index%=
tFire%A_Index%=
tWind%A_Index%=
tPoison%A_Index%=
tHoly%A_Index%=
tShadow%A_Index%=
tGhost%A_Index%=
tUndead%A_Index%=
}
}
SetInfo()
{
	global
	startresult++
	Result := result%startresult%
	FileReadline ,MobInfo, %filetoread% ,%Result%
	StringReplace, MobInfo, MobInfo, =,,
	StringSplit, mDetail_, MobInfo, `,,/
	ID := mDetail_1
	SprName := mDetail_2
	Name := mDetail_4
	HP := mDetail_6
	LV := mDetail_5
	ATK1 := mDetail_11
	ATK2 := mDetail_12
	Race := mDetail_24
	Exp := mDetail_8*Bexprate
	jExp := mDetail_9*Jexprate
	addComma("HP")
	addComma("ATK1")
	addComma("ATK2")
	addComma("Exp")
	addComma("jExp")
	Element := mDetail_25
	Scale := mDetail_23
	Def := mDetail_13
	mDef := mDetail_14
	Speed := mDetail_27
	Range := mDetail_10
	drop1 := mDetail_38
	drop1p := mDetail_39
	drop2 := mDetail_40
	drop2p := mDetail_41
	drop3 := mDetail_42
	drop3p := mDetail_43
	drop4 := mDetail_44
	drop4p := mDetail_45
	drop5 := mDetail_46
	drop5p := mDetail_47
	drop6 := mDetail_48
	drop6p := mDetail_49
	drop7 := mDetail_50
	drop7p := mDetail_51
	drop8 := mDetail_52
	drop8p := mDetail_53
	drop9 := mDetail_54
	drop9p := mDetail_55
	dropC := mDetail_56
	dropCp := mDetail_57
	mvp1 := mDetail_32
	mvp1p := mDetail_33
	mvp2 := mDetail_34
	mvp2p := mDetail_35
	mvp3 := mDetail_36
	mvp3p := mDetail_37
if Scale = 0
	Scale = Small
if Scale = 1
	Scale = Medium
if Scale = 2
	Scale = Large
if Race = 0
	Race = Formless
if Race = 1  
	Race = Undead
if Race = 2  
	Race = Brute
if Race = 3  
	Race = Plant
if Race = 4  
	Race = Insect
if Race = 5  
	Race = Fish
if Race = 6  
	Race = Demon
if Race = 7  
	Race = Demi-Human
if Race = 8 
	Race = Angel
if Race = 9
	Race = Dragon
if Element = 20
	Element = Neutral Lv 1
if Element = 21
	Element = Water Lv 1
if Element = 22
	Element = Earth Lv 1
if Element = 23
	Element = Fire Lv 1
if Element = 24
	Element = Wind Lv 1
if Element = 25
	Element = Poison Lv 1
if Element = 26
	Element = Holy Lv 1
if Element = 27
	Element = Shadow Lv 1
if Element = 28
	Element = Ghost Lv 1
if Element = 29
	Element = Undead Lv 1
if Element = 60
	Element = Neutral Lv 3
if Element = 61
	Element = Water Lv 3
if Element = 62
	Element = Earth Lv 3
if Element = 63
	Element = Fire Lv 3
if Element = 64
	Element = Wind Lv 3
if Element = 65
	Element = Poison Lv 3
if Element = 66
	Element = Holy Lv 3
if Element = 67
	Element = Shadow Lv 3
if Element = 68
	Element = Ghost Lv 3
if Element = 69
	Element = Undead Lv 3
if Element = 40
	Element = Neutral Lv 2
if Element = 41
	Element = Water Lv 2
if Element = 42
	Element = Earth Lv 2
if Element = 43
	Element = Fire Lv 2
if Element = 44
	Element = Wind Lv 2
if Element = 45
	Element = Poison Lv 2
if Element = 46
	Element = Holy Lv 2
if Element = 47
	Element = Shadow Lv 2
if Element = 48
	Element = Ghost Lv 2
if Element = 49
	Element = Undead Lv 2
if Element = 80
	Element = Neutral Lv 4
if Element = 81
	Element = Water Lv 4
if Element = 82
	Element = Earth Lv 4
if Element = 83
	Element = Fire Lv 4
if Element = 84
	Element = Wind Lv 4
if Element = 85
	Element = Poison Lv 4
if Element = 86
	Element = Holy Lv 4
if Element = 87
	Element = Shadow Lv 4
if Element = 88
	Element = Ghost Lv 4
if Element = 89
	Element = Undead Lv 4
If Element = Neutral Lv 1
{
	tNeutral := tNeutral1_1
	tWater := tWater1_1
	tEarth := tEarth1_1
	tFire := tFire1_1
	tWind := tWind1_1
	tPoison := tPoison1_1
	tHoly := tHoly1_1
	tShadow := tShadow1_1
	tGhost = <font color="%Element_Weak%">%tGhost1_1%</font>
	tUndead := tUndead1_1
}
If Element = Water Lv 1
{
	tNeutral := tNeutral1_2
	tWater = <font color="%Element_Weak%">%tWater1_2%</font>
	tEarth := tEarth1_2
	tFire := tFire1_2
	tWind = <font color="%Element_Strong%"><b>%tWind1_2%<b></font>
	tPoison := tPoison1_2
	tHoly := tHoly1_2
	tShadow := tShadow1_2
	tGhost := tGhost1_2
	tUndead := tUndead1_2
}
If Element = Earth Lv 1
{
	tNeutral := tNeutral1_3
	tWater := tWater1_3
	tEarth := tEarth1_3
	tFire = <font color="%Element_Strong%"><b>%tFire1_3%</b></font>
	tWind = <font color="%Element_Weak%">%tWind1_3%</font>
	tPoison = <font color="%Element_Neutral%">%tPoison1_3%</font>
	tHoly := tHoly1_3
	tShadow := tShadow1_3
	tGhost := tGhost1_3
	tUndead := tUndead1_3
}
If Element = Fire Lv 1
{
	tNeutral := tNeutral1_4
	tWater = <font color="%Element_Strong%"><b>%tWater1_4%</b></font>
	tEarth := tEarth1_4
	tFire = <font color="%Element_Weak%">%tFire1_4%</font>
	tWind := tWind1_4
	tPoison = <font color="%Element_Neutral%">%tPoison1_4%</font>
	tHoly := tHoly1_4
	tShadow := tShadow1_4
	tGhost := tGhost1_4
	tUndead := tUndead1_4
}
If Element = Wind Lv 1
{
	tNeutral := tNeutral1_5
	tWater := tWater1_5
	tEarth = <font color="%Element_Strong%"><b>%tEarth1_5%</b></font>
	tFire := tFire1_5
	tWind = <font color="%Element_Weak%">%tWind1_5%</font>
	tPoison = <font color="%Element_Neutral%">%tPoison1_5%</font>
	tHoly := tHoly1_5
	tShadow := tShadow1_5
	tGhost := tGhost1_5
	tUndead := tUndead1_5
}
If Element = Poison Lv 1
{
	tNeutral := tNeutral1_6
	tWater := tWater1_6
	tEarth := tEarth1_6
	tFire := tFire1_6
	tWind := tWind1_6
	tPoison = <font color="%Element_Weak%">%tPoison1_6%</font>
	tHoly := tHoly1_6
	tShadow := tShadow1_6
	tGhost := tGhost1_6
	tUndead := tUndead1_6
}
If Element = Holy Lv 1
{
	tNeutral = <font color="%Element_Neutral%">%tNeutral1_7%</font>
	tWater := tWater1_7
	tEarth := tEarth1_7
	tFire := tFire1_7
	tWind := tWind1_7
	tPoison := tPoison1_7
	tHoly = <font color="%Element_Weak%">%tHoly1_7%</font>
	tShadow = <font color="%Element_Strong%"><b>%tShadow1_7%</b></font>
	tGhost := tGhost1_7
	tUndead = <font color="%Element_Neutral%">%tUndead1_7%</font>
}
If Element = Shadow Lv 1
{
	tNeutral := tNeutral1_8
	tWater := tWater1_8
	tEarth := tEarth1_8
	tFire := tFire1_8
	tWind := tWind1_8
	tPoison := tPoison1_8
	tHoly = <font color="%Element_Strong%"><b>%tHoly1_8%</b></font>
	tShadow = <font color="%Element_Weak%">%tShadow1_8%</font>
	tGhost := tGhost1_8
	tUndead = <font color="%Element_Weak%">%tUndead1_8%</font>
}
If Element = Ghost Lv 1
{
	tNeutral = <font color="%Element_Weak%">%tNeutral1_9%</font>
	tWater := tWater1_9
	tEarth := tEarth1_9
	tFire := tFire1_9
	tWind := tWind1_9
	tPoison := tPoison1_9
	tHoly := tHoly1_9
	tShadow := tShadow1_9
	tGhost = <font color="%Element_Strong%"><b>%tGhost1_9%</b></font>
	tUndead := tUndead1_9
}
If Element = Undead Lv 1
{
	tNeutral := tNeutral1_10
	tWater := tWater1_10
	tEarth := tEarth1_10
	tFire = <font color="%Element_Neutral%">%tFire1_10%</font>
	tWind := tWind1_10
	tPoison = <font color="%Element_Weak%">%tPoison1_10%</font>
	tHoly = <font color="%Element_Strong%"><b>%tHoly1_10%</b></font>
	tShadow = <font color="%Element_Weak%"> %tShadow1_10%</font>
	tGhost := tGhost1_10
	tUndead := tUndead1_10
}
If Element = Neutral Lv 2
{
	tNeutral := tNeutral2_1
	tWater := tWater2_1
	tEarth := tEarth2_1
	tFire := tFire2_1
	tWind := tWind2_1
	tPoison := tPoison2_1
	tHoly := tHoly2_1
	tShadow := tShadow2_1
	tGhost = <font color="%Element_Weak%">%tGhost2_1%</font>
	tUndead := tUndead2_1
}
If Element = Water Lv 2
{
	tNeutral := tNeutral2_2
	tWater = <font color="%Element_Weak%">%tWater2_2%</font>
	tEarth := tEarth2_2
	tFire := tFire2_2
	tWind = <font color="%Element_Strong%"><b>%tWind2_2%</b></font>
	tPoison := tPoison2_2
	tHoly := tHoly2_2
	tShadow := tShadow2_2
	tGhost := tGhost2_2
	tUndead := tUndead2_2
}
If Element = Earth Lv 2
{
	tNeutral := tNeutral2_3
	tWater := tWater2_3
	tEarth := tEarth2_3
	tFire = <font color="%Element_Strong%"><b>%tFire2_3%</b></font>
	tWind = <font color="%Element_Weak%">%tWind2_3%</font>
	tPoison = <font color="%Element_Neutral%">%tPoison2_3%</font>
	tHoly := tHoly2_3
	tShadow := tShadow2_3
	tGhost := tGhost2_3
	tUndead := tUndead2_3
}
If Element = Fire Lv 2
{
	tNeutral := tNeutral2_4
	tWater = <font color="%Element_Strong%"><b>%tWater2_4%</b></font>
	tEarth := tEarth2_4
	tFire = <font color="%Element_Weak%">%tFire2_4%</font>
	tWind := tWind2_4
	tPoison = <font color="%Element_Neutral%">%tPoison2_4%</font>
	tHoly := tHoly2_4
	tShadow := tShadow2_4
	tGhost := tGhost2_4
	tUndead := tUndead2_4
}
If Element = Wind Lv 2
{
	tNeutral := tNeutral2_5
	tWater := tWater2_5
	tEarth = <font color="%Element_Strong%"><b>%tEarth2_5%</b></font>
	tFire := tFire2_5
	tWind = <font color="%Element_Weak%">%tWind2_5%</font>
	tPoison = <font color="%Element_Neutral%">%tPoison2_5%</font>
	tHoly := tHoly2_5
	tShadow := tShadow2_5
	tGhost := tGhost2_5
	tUndead := tUndead2_5
}
If Element = Poison Lv 2
{
	tNeutral := tNeutral2_6
	tWater := tWater2_6
	tEarth := tEarth2_6
	tFire := tFire2_6
	tWind := tWind2_6
	tPoison = <font color="%Element_Weak%">%tPoison2_6%</font>
	tHoly := tHoly2_6
	tShadow := tShadow2_6
	tGhost := tGhost2_6
	tUndead := tUndead2_6
}
If Element = Holy Lv 2
{
	tNeutral := tNeutral2_7
	tWater := tWater2_7
	tEarth := tEarth2_7
	tFire := tFire2_7
	tWind := tWind2_7
	tPoison := tPoison2_7
	tHoly = <font color="%Element_Weak%">%tHoly2_7%</font>
	tShadow = <font color="%Element_Strong%"><b>%tShadow2_7%</b></font>
	tGhost := tGhost2_7
	tUndead = <font color="%Element_Neutral%">%tUndead2_7%</font>
}
If Element = Shadow Lv 2
{
	tNeutral = <font color="%Element_Neutral%">%tNeutral2_8%</font>
	tWater := tWater2_8
	tEarth := tEarth2_8
	tFire := tFire2_8
	tWind := tWind2_8
	tPoison := tPoison2_8
	tHoly = <font color="%Element_Strong%"><b>%tHoly2_8%</b></font>
	tShadow = <font color="%Element_Weak%">%tShadow2_8%</font>
	tGhost := tGhost2_8
	tUndead := tUndead2_8
}
If Element = Ghost Lv 2
{
	tNeutral = <font color="%Element_Weak%">%tNeutral2_9%</font>
	tWater := tWater2_9
	tEarth := tEarth2_9
	tFire := tFire2_9
	tWind := tWind2_9
	tPoison := tPoison2_9
	tHoly := tHoly2_9
	tShadow := tShadow2_9
	tGhost = <font color="%Element_Strong%"><b>%tGhost2_9%</b></font>
	tUndead := tUndead2_9
}
If Element = Undead Lv 2
{
	tNeutral := tNeutral2_10
	tWater := tWater2_10
	tEarth := tEarth2_10
	tFire = <font color="%Element_Neutral%">%tFire2_10%</font>
	tWind := tWind2_10
	tPoison = <font color="%Element_Weak%">%tPoison2_10%</font>
	tHoly = <font color="%Element_Strong%"><b>%tHoly2_10%</b></font>
	tShadow = <font color="%Element_Weak%">%tShadow2_10%</font>
	tGhost := tGhost2_10
	tUndead := tUndead2_10
}
If Element = Neutral Lv 3
{
	tNeutral := tNeutral3_1
	tWater := tWater3_1
	tEarth := tEarth3_1
	tFire := tFire3_1
	tWind := tWind3_1
	tPoison := tPoison3_1
	tHoly := tHoly3_1
	tShadow := tShadow3_1
	tGhost = <font color="%Element_Weak%">%tGhost3_1%</font>
	tUndead := tUndead3_1
}
If Element = Water Lv 3
{	
	tNeutral := tNeutral3_2
	tWater = <font color="%Element_Weak%">%tWater3_2%</font>
	tEarth := tEarth3_2
	tFire := tFire3_2
	tWind = <font color="%Element_Strong%"><b>%tWind3_2%</b></font>
	tPoison := tPoison3_2
	tHoly := tHoly3_2
	tShadow := tShadow3_2
	tGhost := tGhost3_2
	tUndead := tUndead3_2
}
If Element = Earth Lv 3
{
	tNeutral := tNeutral3_3
	tWater := tWater3_3
	tEarth = <font color="%Element_Weak%">%tEarth3_3%</font>
	tFire = <font color="%Element_Strong%"><b>%tFire3_3%</b></font>
	tWind = <font color="%Element_Weak%">%tWind3_3%</font>
	tPoison := tPoison3_3
	tHoly := tHoly3_3
	tShadow := tShadow3_3
	tGhost := tGhost3_3
	tUndead := tUndead3_3
}
If Element = Fire Lv 3
{
	tNeutral := tNeutral3_4
	tWater = <font color="%Element_Strong%"><b>%tWater3_4%</b></font>
	tEarth := tEarth3_4
	tFire = <font color="%Element_Weak%">%tFire3_4%</font>
	tWind := tWind3_4
	tPoison := tPoison3_4
	tHoly := tHoly3_4
	tShadow := tShadow3_4
	tGhost := tGhost3_4
	tUndead := tUndead3_4
}
If Element = Wind Lv 3
{
	tNeutral := tNeutral3_5
	tWater := tWater3_5
	tEarth = <font color="%Element_Strong%"><b>%tEarth3_5%</b></font>
	tFire := tFire3_5
	tWind = <font color="%Element_Weak%">%tWind3_5%</font>
	tPoison := tPoison3_5
	tHoly := tHoly3_5
	tShadow := tShadow3_5
	tGhost := tGhost3_5
	tUndead := tUndead3_5
}
If Element = Poison Lv 3
{
	tNeutral := tNeutral3_6
	tWater := tWater3_6
	tEarth := tEarth3_6
	tFire := tFire3_6
	tWind := tWind3_6
	tPoison = <font color="%Element_Weak%">%tPoison3_6%</font>
	tHoly = <font color="%Element_Strong%"><b>%tHoly3_6%</b></font>
	tShadow = <font color="%Element_Weak%">%tShadow3_6%</font>
	tGhost := tGhost3_6
	tUndead = <font color="%Element_Weak%">%tUndead3_6%</font>
}
If Element = Holy Lv 3
{
	tNeutral := tNeutral3_7
	tWater := tWater3_7
	tEarth := tEarth3_7
	tFire := tFire3_7
	tWind := tWind3_7
	tPoison := tPoison3_7
	tHoly = <font color="%Element_Weak%">%tHoly3_7%</font>
	tShadow = <font color="%Element_Strong%"><b>%tShadow3_7%</b></font>
	tGhost := tGhost3_7
	tUndead = <font color="%Element_Neutral%">%tUndead3_7%</font>
}
If Element = Shadow Lv 3
{
	tNeutral = <font color="%Element_Neutral%">%tNeutral3_8%</font>
	tWater := tWater3_8
	tEarth := tEarth3_8
	tFire := tFire3_8
	tWind := tWind3_8
	tPoison := tPoison3_8
	tHoly = <font color="%Element_Strong%"><b>%tHoly3_8%</b></font>
	tShadow = <font color="%Element_Weak%">%tShadow3_8%</font>
	tGhost := tGhost3_8
	tUndead := tUndead3_8
}
If Element = Ghost Lv 3
{
	tNeutral = <font color="%Element_Weak%">%tNeutral3_9%</font>
	tWater := tWater3_9
	tEarth := tEarth3_9
	tFire := tFire3_9
	tWind := tWind3_9
	tPoison := tPoison3_9
	tHoly := tHoly3_9
	tShadow := tShadow3_9
	tGhost = <font color="%Element_Strong%"><b>%tGhost3_9%</b></font>
	tUndead := tUndead3_9
}
If Element = Undead Lv 3
{
	tNeutral := tNeutral3_10
	tWater := tWater3_10
	tEarth := tEarth3_10
	tFire = <font color="%Element_Neutral%">%tFire3_10%</font>
	tWind := tWind3_10
	tPoison = <font color="%Element_Weak%">%tPoison3_10%</font>
	tHoly = <font color="%Element_Strong%"><b>%tHoly3_10%</b></font>
	tShadow = <font color="%Element_Weak%">%tShadow3_10%</font>
	tGhost := tGhost3_10
	tUndead := tUndead3_10
}
If Element = Neutral Lv 4
{
	tNeutral := tNeutral4_1
	tWater := tWater4_1
	tEarth := tEarth4_1
	tFire := tFire4_1
	tWind := tWind4_1
	tPoison := tPoison4_1
	tHoly := tHoly4_1
	tShadow := tShadow4_1
	tGhost = <font color="%Element_Weak%">%tGhost4_1%</font>
	tUndead := tUndead4_1
}
If Element = Water Lv 4
{
	tNeutral = <font color="%Element_Neutral%">%tNeutral4_2%</font>
	tWater = <font color="%Element_Weak%">%tWater4_2%</font>
	tEarth = <font color="%Element_Neutral%">%tEarth4_2%</font>
	tFire := tFire4_2
	tWind = <font color="%Element_Strong%"><b>%tWind4_2%</b></font>
	tPoison := tPoison4_2
	tHoly := tHoly4_2
	tShadow := tShadow4_2
	tGhost := tGhost4_2
	tUndead := tUndead4_2
}
If Element = Earth Lv 4
{
	tNeutral = <font color="%Element_Neutral%">%tNeutral4_3%</font>
	tWater = <font color="%Element_Neutral%">%tWater4_3%</font>
	tEarth = <font color="%Element_Weak%">%tEarth4_3%</font>
	tFire = <font color="%Element_Strong%"><b>%tFire4_3%</b></font>
	tWind := tWind4_3
	tPoison := tPoison4_3
	tHoly := tHoly4_3
	tShadow := tShadow4_3
	tGhost := tGhost4_3
	tUndead := tUndead4_3
}
If Element = Fire Lv 4
{
	tNeutral = <font color="%Element_Neutral%">%tNeutral4_4%</font>
	tWater = <font color="%Element_Strong%"><b>%tWater4_4%</b></font>
	tEarth := tEarth4_4
	tFire = <font color="%Element_Weak%">%tFire4_4%</font>
	tWind = <font color="%Element_Neutral%">%tWind4_4%</font>
	tPoison := tPoison4_4
	tHoly := tHoly4_4
	tShadow := tShadow4_4
	tGhost := tGhost4_4
	tUndead := tUndead4_4
}
If Element = Wind Lv 4
{
	tNeutral = <font color="%Element_Neutral%">%tNeutral4_5%</font>
	tWater := tWater4_5
	tEarth = <font color="%Element_Strong%"><b>%tEarth4_5%</b></font>
	tFire = <font color="%Element_Neutral%">%tFire4_5%</font>
	tWind = <font color="%Element_Weak%">%tWind4_5%</font>
	tPoison := tPoison4_5
	tHoly := tHoly4_5
	tShadow := tShadow4_5
	tGhost := tGhost4_5
	tUndead := tUndead4_5
}
If Element = Poison Lv 4
{
	tNeutral = <font color="%Element_Neutral%">%tNeutral4_6%</font>
	tWater := tWater4_6
	tEarth := tEarth4_6
	tFire := tFire4_6
	tWind := tWind4_6
	tPoison := tPoison4_6
	tHoly = <font color="%Element_Strong%"><b>%tHoly4_6%</b></font>
	tShadow = <font color="%Element_Weak%">%tShadow4_6%</font>
	tGhost := tGhost4_6
	tUndead = <font color="%Element_Weak%">%tUndead4_6%</font>
}
If Element = Holy Lv 4
{
	tNeutral := tNeutral4_7
	tWater := tWater4_7
	tEarth := tEarth4_7
	tFire := tFire4_7
	tWind := tWind4_7
	tPoison := tPoison4_7
	tHoly = <font color="%Element_Weak%">%tHoly4_7%</font>
	tShadow = <font color="%Element_Strong%"><b>%tShadow4_7%</b></font>
	tGhost := tGhost4_7
	tUndead = <font color="%Element_Neutral%">%tUndead4_7%</font>
}
If Element = Shadow Lv 4
{
	tNeutral = <font color="%Element_Neutral%">%tNeutral4_8%</font>
	tWater := tWater4_8
	tEarth := tEarth4_8
	tFire := tFire4_8
	tWind := tWind4_8
	tPoison = <font color="%Element_Weak%">%tPoison4_8%</font>
	tHoly = <font color="%Element_Strong%"><b>%tHoly4_8%</b></font>
	tShadow = <font color="%Element_Weak%">%tShadow4_8%</font>
	tGhost := tGhost4_8
	tUndead := tUndead4_8
}
If Element = Ghost Lv 4
{
	tNeutral = <font color="%Element_Weak%">%tNeutral4_9%</font>
	tWater := tWater4_9
	tEarth := tEarth4_9
	tFire := tFire4_9
	tWind := tWind4_9
	tPoison := tPoison4_9
	tHoly := tHoly4_9
	tShadow := tShadow4_9
	tGhost = <font color="%Element_Strong%"><b>%tGhost4_9%</b></font>
	tUndead := tUndead4_9
}
If Element = Undead Lv 4
{
	tNeutral := tNeutral4_10
	tWater := tWater4_10
	tEarth := tEarth4_10
	tFire = <font color="%Element_Strong%"><b>%tFire4_10%</b></font>
	tWind := tWind4_10
	tPoison = <font color="%Element_Weak%">%tPoison4_10%</font>
	tHoly = <font color="%Element_Strong%"><b>%tHoly4_10%</b></font>
	tShadow = <font color="%Element_Weak%">%tShadow4_10%</font>
	tGhost = <font color="%Element_Neutral%">%tGhost4_10%</font
	tUndead := tUndead4_10
}
}
MakeSrcBar()
{
	global
	Gui, Add, Button,x303 y22 h20 w130 vsrcitemdes gsrcitemdes, Search Item Descriptions
	
	Gui, Add, Progress, x-1 y-1 w610 h20 Background%Title_BG% Disabled hwndHPROG
	Gui, Add, Listview, x0 y17 w610 h2 Background000000
	
	;Gui, Add, Picture,x1 y0 w565 gTopbar,%A_ScriptDir%\Image\Skin\titlebar_fix.bmp
	;Gui, Add, Picture,x563 y0 gGuiClose,%A_ScriptDir%\Image\Skin\sys_close_on.bmp
	Gui, Font, s10 w1000
	Gui, Add, Text, x565 y0 w14 h10 r1 +Center gGuiClose cRed, X
	Gui, Add, Text,x0 y0 w585 h20 BackgroundTrans +Center vdaTitle c%Title_Text% gTopbar,%wintitle%
	
	Gui, Font, s8 w0
	Gui, Add, Button, x435 y22 w70 h20 vFreeMemory gFreeMemory, Free Memory
	Gui, Add, CheckBox, x10 y25 vrenewal grenewal, Renewal
	Gui, Font, w600
	Gui, Add, Text, xp+70 yp, MOB
	Gui, Font, w0
	Gui, Add, Edit, xp+30 yp-3 w70 h20 gMobSrc vMob cBlack
	GuiControl, Focus, Mob
	Gui, Font, w600
	Gui, Add, Text, xp+80 yp+3, ITEM
	Gui, Font, w0
	Gui, Add, Edit, xp+33 yp-3 w70 h20 gItemSrc vItem cBlack
	Gui, Add, Progress, xp+195 yp-18 h8 -Smooth vloading c00568A BackgroundD2EDFF , 
	Gui, Add, StatusBar,,
	Gui, Add, Button,  xp+89  yp+18 h20 w70 gSetting, Setting
	Gui, Add, Button,  Hidden gSrcMob,SearchMob
	Gui, Add, Button,  Hidden gSrcItem,SearchItem
	Gui, Add, Listview,x0 y506 w585 h25,
	Gui, Add, Picture, x133 y22 w22 h20 -Background vMobSym, %A_ScriptDIr%\Image\mob.gif
	Gui, Add, Picture, x248 y22 w20 h20  -Background vItemSym, %A_ScriptDIr%\Image\item.gif
}
MakeTable()
{
global
NewY := 18
Gui, Font,s10 w1000, 
Loop 10
{
	Gui, Add, Listview, +List x-500 y-500 w555 r5 -Hdr  altsubmit v%A_Index%DropWin gTable%A_Index% c%Mob_Text% Background%Mob_Sub_Color%,1
	Gui, Add, ActiveX, Hidden -Disabled w585 h364 v%A_Index%WB x0 y%NewY% , Shell Explorer
	%A_Index%wb.Navigate("about:blank")
	NewY := NewY+374
}
NewY := 40
Gui, Font,s8 w1000, 
Loop 10
{
	editY := NewY+222
	Gui, Add, Listview, +Hidden +List x10 y%editY% w556 h150 -Hdr  altsubmit v%A_Index%ItemWin gItemWin%A_Index% c%Item_Text% Background%Item_BG%,1
	Gui, Add, ActiveX, +Hidden -Disabled w585 h374 v%A_Index%WB1 x0 y0 , Shell Explorer
	%A_Index%wb1.Navigate("about:blank")
	NewY := NewY+374
}
Gui, 2:Add, Progress,x-1 y-1 h20 w200 Background%Title_BG% Disabled hwndHPROG
Gui, 2:Add, Listview, x0 y17 w610 h2 Background000000
Gui, 2:font, w1000
Gui, 2:Add, Text,x80 y2 w100 h50 BackgroundTrans c%Title_Text%,Setting
Gui, 2:font, w0
Gui, 2:Add, Edit, vdummy w0 h0,
Gui, 2:Add, Hotkey, vChosenHotkey h20 x65 y23 w75 Limit3 gHotkey ,%DaHotkey%
Gui, 2:Add, Text, x0 y26, Hide-Hotkey
Gui, 2:Add, GroupBox, x5 y50 w185 h40, Rates
Gui, 2:Add, Text,x13 y68 w50 h20, B-exp:
Gui, 2:Add, Text,xp+60 yp wp hp, J-exp:
Gui, 2:Add, Text,xp+60 yp wp hp, Drops:
Gui, 2:Add, Edit, Number x45 y62 h20 w20  gbexprate1 vbexprate, %bexprate%
Gui, 2:Add, Edit, Number xp+60 yp hp wp gjexprate1 vjexprate, %jexprate%
Gui, 2:Add, Edit, Number xp+60 yp hp wp gdroprate1 vchangerate, %changerate%
Gui, 2:Add, Groupbox, x5 y85 w185 h40, Custom Mob 'n Item
Gui, 2:Add, Button, x40 y100 w50 h20 gAddMob, Add Mob
Gui, 2:Add, Button, xp+70 yp w50 h20 gAddItem, Add Item
Gui, 2:Add, Text, x18 yp+28 w180 h20 , -:- Made By : Recca a.k.a Pyan -:-
Gui, 2:Add, Button, x145 y23 w40 h20 gHelp, Help !!
Gui, 3:Add, Button, x10 y20 vbackButton gbackButton h20 w80, Back To LIST
Gui, 3:Add, ActiveX, Hidden w250 h367 vXWB x0 y20 , Shell . Explorer
xwb.navigate("about:blank")
Sleep 0
Gui, 3:Font, s10 w1000
Gui, 3:Add, Listview, Hidden x10 y25 w237 h350 -Hdr vnpcLV  gnpcLV c%Shop_List_Text% Background%Shop_List_BG% Grid,1
;Gui, 3:Add, Picture,x1 y0 w540 ,%A_ScriptDir%\Image\Skin\titlebar_fix.bmp

Gui, 3:Add, Progress,x-1 y-1 h20 w540 Background%Title_BG% Disabled hwndHPROG
Gui, 3:Add, Listview, x0 y17 w610 h2 Background000000

Gui, 3:Add, Text,x105 y2 w100 h50 BackgroundTrans c%Title_Text%,NPC Info
Gui, 3:Add, Text, x242 y0 w14 h10 r1 +Center gGuiClose1 cRed, X
;Gui, 3:Add, Picture,x238 y0 gGuiClose1,%A_ScriptDir%\Image\Skin\sys_close_on.bmp
Gui, 3: +ToolWindow +AlwaysOnTop -border +Theme -caption 

;~ Gui, 4:Add, Picture,x1 y0 w555 gTopbar,%A_ScriptDir%\Image\Skin\titlebar_fix.bmp
;~ Gui, 4:Add, GroupBox, x10 y20 w185 h100, Add Mob
;~ Gui, 4: +ToolWindow +AlwaysOnTop -border +Theme -caption 

;~ Gui, 5:Add, Picture,x1 y0 w540 gTopbar,%A_ScriptDir%\Image\Skin\titlebar_fix.bmp
;~ Gui, 5:Add, Text,x233 y2 w100 h50 BackgroundTrans,- Add Item -
;~ Gui, 5: +ToolWindow +AlwaysOnTop -border +Theme -caption 
}
