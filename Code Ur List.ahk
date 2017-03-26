#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Gui, +LastFound
WinSet, Transparent, 255
act_W := 280
act_H := 370
Gui, Add, Progress, x-1 y-1 w300 h31 BackgroundE5DED6 Disabled hwndHPROG
;~ Gui, Add, Text, x260 y8 w14 h14 r1 +0x4000 vTX +Center gGuiClose, X

Gui, font, s15
Gui, Add, Text, x10 y2 w26 h26 +0x4000 +Center +border gMenu, ⋮≡
Gui, Add, Text, x245 y2 w26 h26 +0x4000 +Center +border gAddList, +
Gui, Font, s20
Gui, Add, Text, x0 y0 w%act_W% h30 BackgroundTrans Center 0x200 gGuiMove vCaption, Home

Gui, Add, ActiveX, x0 y30 w300 h%act_H% vWB, Shell.Explorer
WB.silent := true
WB.Navigate("about:blank")
html = 
(Join Ltrim
<html>
	<head>
		<style>
		* {
		  box-sizing: border-box;
		}
		body {
			font-family: "Verdana", Times, serif;
			margin: 0;
			background-color: white;
		}
		#list_container {
			width: 98`%;
			background-color: white;
		}
		.shadow1 {
			margin: 5px 10px 5px 10px;
			background-color: rgb(68,68,68); /* Needed for IEs */
			-moz-box-shadow: 5px 5px 5px rgba(68,68,68,0.6);
			-webkit-box-shadow: 5px 5px 5px rgba(68,68,68,0.6);
			box-shadow: 5px 5px 5px rgba(68,68,68,0.6);
			filter: progid:DXImageTransform.Microsoft.Blur(PixelRadius=3,MakeShadow=true,ShadowOpacity=0.30);
			-ms-filter: "progid:DXImageTransform.Microsoft.Blur(PixelRadius=3,MakeShadow=true,ShadowOpacity=0.30)";
			zoom: 1;
		}
		.shadow1 .list_item {
			position: relative; /* This protects the inner element from being blurred */
			/* padding: 5px; */
			padding-left: 5px;
			background-color: #FA9497;
			/* border: 1px solid black; */
		}
		
		.list_item {
			overflow: hidden;
			position: relative;
			width: 100`%;
			height: 100`%;
			color:black;
			background-color: pink;
			min-height:100px;
		}
		.list_item_left {
			font-size: 18px;
			padding: 10px;
			width: 70`%;
		}
		.list_item_div {
			position: absolute;
			left: 0;
			top: 0;
			background-color: black;
			width: 2px;
			height: 100`%;
			background:transparent;
			filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#50990000,endColorstr=#50990000); 
			zoom: 1;
		}
		.list_item_right {
		
			/* border-left:  2px solid black; */
			padding: 10px 0px 0px 10px;
			height: 100`%;
			width: 30`%;
			position: absolute;
			right: 0;
			top: 0;
			font-size: 15px;
			color: #606060;
		}
		.list_item_date {
			font-size: 28px;
		}
		.list_item_info {
			font-size: 12px;
			margin-top: 10px;
			color: white;
			padding: 2px 5px 2px 5px;
			background-color: black;
			background:transparent;
			filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#50990000,endColorstr=#50990000); 
			zoom: 1;
		}
		#arrow-up {
			position: relative;
			width: 0; 
			height: 0; 
			border-left: 8px solid transparent;
			border-right: 8px solid transparent;
			left: 21px;
			top: -20px;
			border-bottom: 8px solid black;
		}
		#menu {
			border: solid 1px black;
			position: relative;
			top: -30px;
			width: 100`%;
			margin: 10px 10px -30px 10px;
			padding: 10px;
		}
		#menu ul {
			list-style-type: none;
			margin: 0;
		}
		#menu ul li {
			border: 1px dotted black;
		}
		</style>
	</head>
	<body>
		<div id="arrow-up" style="display: none"></div>
			<div id="menu" style="display: none">
				<div id="menu-content" style="display: none">
				<span style="font-weight: 900;">List Catagory <button style="width: 35px; font-size: 20px; margin-left: 20px">+</button></span><hr>
					<ul style="width: 100`%; height: 200px; overflow: auto;">
						<li >Home</li>
						<li>School</li>
						<li>Programming</li>
					</ul>
				</div>
			</div>
		<!-- ------------------------------------------------- -->
		<div id="list_container">
			<div class="shadow1">
				<div class="list_item" oncontextmenu="javascript:alert(this.innerHTML);return false;">
					<div class="list_item_left 1">sssssssssssssss sssssssssssssss sssssssssssssss
					<span>&#9955; <span style="position: relative; left: -18; top: -4; font-size: 12px;">&#8735;</span></span>
					<br><span class="list_item_info"><span style="font-size: 20px;">&#8635;</span> Due Today</span></div>
					<div class="list_item_right"><div class="list_item_div"></div>
					<span class="list_item_date">05</span> May<div style="position: absolute; bottom: 10; left: 10">04:20 pm</div></div>
				</div>
			</div>
			<div class="shadow1">
				<div class="list_item" oncontextmenu="javascript:alert(this.p);return false;">
					<p style="display: none">2</p>
					<div class="list_item_left 1">sssssssssssssss sssssssssssssss sssssssssssssss
					<span>&#9955; <span style="position: relative; left: -18; top: -4; font-size: 12px;">&#8735;</span></span>
					<br><span class="list_item_info"><span style="font-size: 20px;">&#8635;</span> Due Today</span></div>
					<div class="list_item_right"><div class="list_item_div"></div>
					<span class="list_item_date">05</span> May<div style="position: absolute; bottom: 10; left: 10">04:20 pm</div></div>
				</div>
			</div>
			<div class="shadow1">
				<div class="list_item">sssssssssssssss</div>
			</div>
		</div>
	</body>
</html>
)
WB.Document.Write(html)

Gui, +ToolWindow +AlwaysOnTop -border -Theme -caption
win_W := act_W+70
win_H := act_H+132
WinSet, Region, 0-0 w%win_W% h%win_H% r6-6
Gui, Show, w%win_W% h%win_H%, CURL
WinSet, AlwaysOnTop, On
return

GuiClose:
ExitApp
return

GuiMove:
PostMessage, 0xA1, 2
return

Menu:
menu_toggle := !menu_toggle
; Show 
if menu_toggle 	{
	WB.document.getElementById("arrow-up").style.display := ""
	WB.document.getElementById("menu").style.display := ""
	animate = 0
	Loop
	{
		if animate >= 263
			break
		WB.document.getElementById("menu").style.height := animate . "px"
		Sleep 1
		animate+=19
	}
	WB.document.getElementById("menu").style.height := "263px"
	WB.document.getElementById("menu-content").style.display := ""
}
; Hide
else {
	WB.document.getElementById("menu-content").style.display := "none"
	animate = 263
	Loop
	{
		if animate <= 0
			break
		WB.document.getElementById("menu").style.height := animate . "px"
		Sleep 1
		animate-=19
	}
	WB.document.getElementById("menu").style.display := "none"
	WB.document.getElementById("arrow-up").style.display := "none"
}
return

AddList:
return