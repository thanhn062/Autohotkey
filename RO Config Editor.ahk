; *.conf editor for Ragnarok Online Private Server

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
OnExit,OnExit
MYAPP_PROTOCOL:="myapp"
Note_1 = Value is a config switch (on/off, yes/no or 1/0)
Note_2 = Value is in percents (100 means 100`%)
Note_3 = Value is a bit field. If no description is given, assume unit<br>types (1: Pc, 2: Mob, 4: Pet, 8: Homun,16: Mercenary)
HTML_header =
( Ltrim Join
<!DOCTYPE html>
<html>
	<head>
		<style>
			body {
				background-color: #ccddff;
			}
		/* TOOL TIP*/
.tooltip {
    position: relative;
    display: inline-block;
    border-bottom: 2px dotted black;
}

.tooltip .tooltiptext {
    visibility: hidden;
    width: 300px;
    background-color: #4F4D50;
    color: #fff;
    text-align: left;
    border-radius: 6px;
    padding: 10px 10px;

    /* Position the tooltip */
    position: absolute;
    z-index: 1;
}

.tooltip:hover .tooltiptext {
    visibility: visible;
}
		</style>
	</head>
	<body>
)
HTML_footer =
( Ltrim Join
	</body>
</html>
)

Gui, Add, Text, x10 y15, Config path
Gui, Add, Edit, yp-2 xp+60 w400 h20 +ReadOnly vpath
Gui, Add, Button, xp+410 yp w70 h20 gBrowse, Browse
Gui, Add, Button, xp+75 yp wp h20 gOpen, Open
Gui, Add, Button, x20 y710 w660 h30 gUpdate, UPDATE
Gui Add, ActiveX, x0 y50 w700 h650 vWB, Shell.Explorer  ; The final parameter is the name of the ActiveX component.
WB.silent := true ;Surpress JS Error boxese)

Gui, +Alwaysontop
Gui Show, w700 h750
return

Open:
Run %path%
return

Browse:
Gui, +OwnDialogs
FileSelectFile, path, 
If ErrorLevel
	return
GuiControl,, path, %path%
StringSplit, temp_, path, \
filename := temp_%temp_0%
Load_Conf(path,filename)
Display(WB,HTML_page)
while WB.readystate != 4 or WB.busy
	sleep 10
;Update := wb.document.getElementById("Update")
;ComObjConnect(Update, "Update_")
return

GuiClose:
ExitApp

OnExit: 
	FileDelete,%A_Temp%\*.DELETEME.html ;clean tmp file
ExitApp
return

Update:
Update_OnClick()
return

Update_OnClick() {
	global var_ToContent, wb, path
    Gui, submit, nohide
    ;FileRead, FileData,%path%
    Gui, +OwnDialogs
	Loop, read, %path%
	{
		found = 0
		Loop, parse, var_ToContent, |
		{
			;MsgBox % A_LoopField
			StringSplit, var_Temp_, A_LoopField, `,
			IfInString, A_LoopReadLine, %A_Tab%%var_Temp_2%:
			{
				var_Temp_3 := wb.Document.getElementById("conf_" var_Temp_1).Value
				found = 1
				StringSplit, temp_Line_, A_LoopReadLine, :
				FileData = %FileData%%temp_Line_1%: %var_Temp_3%`n
				break
			}
		}
		if found = 0
			FileData = %FileData%%A_LoopReadLine%`n
	}
	;Loop, parse, var_ToContent, |
	;{
	;	StringSplit, var_Temp_, A_LoopField, `,
       ;MsgBox % var_Temp_2
		;var_Temp_3 := wb.Document.getElementById("conf_" var_Temp_1).Value
     ;   StringSplit, tempo_, var_Temp_2, :
		;conf_%var_Temp_1% = %tempo_1%: %var_Temp_3%
		;Gui, +OwnDialogs
		;MsgBox, % conf_%A_Index%
      ;  MsgBox StringReplace, FileData, FileData, %var_Temp_2%, %tempo_1%: %var_Temp_3%
	;}
    FileDelete, %path%
    FileAppend, %FileData%, %path%
	MsgBox, 64, Update, Done !
}

Load_Conf(path,header) {
	global HTML_page,HTML_header,HTML_footer,var_ToContent, path_trunk, Note_1, Note_2,Note_3
	var_ToContent=
	HTML_body =
	(Ltrim Join
		<table BORDER=4 CELLSPACING=4 CELLPADDING=4 style="border: 1px solid black; width: 200px;"  bgcolor="ffffff">
		<tr>
			<th colspan="2">%header%</th>
		</tr>
	)

	Loop, read, %path%
	{
		; LINES TO SKIP
		IfInString, A_LoopReadLine, import
            continue
		IfInString, A_LoopReadLine, %A_Tab%amount:
			continue
		IfInString, A_LoopReadLine, %A_Tab%loc:
			continue
		IfInString, A_LoopReadLine, %A_tab%id:
			continue
		IfInString, A_LoopReadLine, %A_Tab%stackable:
			continue
		IfInString, A_LoopReadLine, player: `{
			continue
		IfInString, A_LoopReadLine, new: `{
			continue
		; SUB-HEADER
		IfInString, A_LoopReadLine,:%A_Space%`{
		{
			StringTrimRight, LoopReadLine, A_LoopReadLine, 3
			HTML_body =
			( Ltrim Join
			%HTML_body%
			<tr>
				<td colspan="2">%LoopReadLine%</th>
			</tr>
			)
		}
		StringReplace, LoopReadLine, A_LoopReadLine, %A_Tab%,,all
		StringLeft, temp_Line, LoopReadLine, 2
        ; IF LINE START WITH //
		if (temp_Line != "//")
			IfNotInString, A_LoopReadLine, `{
				IfNotInString, A_LoopReadLine, (
					IfInString, A_LoopReadLine, :%A_Space%
					{
						var_Index++
						A_CurrLine := A_index
						line_count := A_Index -1
						Loop
						{
							FileReadLine, line_data, %path%, line_count
							; EXCEPTION
							IfInString, line_data, //
								line_count--
							else IfInString, line_data, start_point
								line_count--
							else IfInString, line_data, fame
								line_count--
							else
								break
						}
						Loop
						{
							FileReadLine, line_data, %path%, %line_count%
							line_count++
							IfInString, line_data, //
								Temp_content = %temp_content%%line_data%`n
							if (line_count = A_CurrLine)
								break
						}
						StringReplace, Temp_content, Temp_content, %A_Tab%,,all
						StringReplace, Temp_content, Temp_content, /,,all
						;StringReplace, Temp_content, Temp_content,%A_Space%,,
						StringReplace, Temp_content, Temp_content,`n,<br>,all
						StringReplace, Temp_content, Temp_content,`",&#34;,all
						
						StringReplace, B_LoopReadLine, A_LoopReadLine, %A_TAb%,,all
						StringSplit, value_, B_LoopReadLine, :
                        var_ToContent = %var_ToContent%%var_Index%,%value_1%|
						StringReplace, value_2, value_2, `",&#34;,all
						StringReplace, value_2, value_2, %A_space%,,
						StringReplace, Temp_content,Temp_content, (Note 1), <br>(Note 1: %Note_1%
						StringReplace, Temp_content,Temp_content, (Note 2), <br>(Note 2: %Note_2%
						StringReplace, Temp_content,Temp_content, (Note 3), <br>(Note 3): %Note_3%
						if Temp_content !=
						{
							HTML_body =
							(	Ltrim Join
							%HTML_body%
							<tr>
							<td bgcolor="#4F4D50"><font color="#FFFFFF">%value_1%</font></td>
							<td><div class="tooltip"><input type="textarea" id="conf_%var_Index%" value="%value_2%"/><span class="tooltiptext">%Temp_content%</span></div></td>
							</tr>
							)
						}
						else
						{
							HTML_body =
							(	Ltrim Join
							%HTML_body%
							<tr>
							<td bgcolor="#4F4D50"><font color="#FFFFFF">%value_1%</font></td>
							<td><input type="textarea" id="conf_%var_Index%" value="%value_2%"/>%Temp_content%</td>
							</tr>
							)
						}
						Temp_content=
					}
	}
					HTML_page = %HTML_header%`n%HTML_body%`n%HTML_footer%
					StringTrimRight, var_ToContent, var_ToContent, 1
}

Display(WB,html_str) {
	Count:=0
	while % FileExist(f:=A_Temp "\" A_TickCount A_NowUTC "-tmp" Count ".DELETEME.html")
		Count+=1
	FileAppend,%html_str%,%f%
	WB.Navigate("file://" . f)
}

Esc::ExitApp