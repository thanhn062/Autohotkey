#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, Add, ActiveX, vWB x10 y10 w242 h200, Shell.Explorer
WB.Navigate("about:blank")
Sleep 10
html =
(Ltrim
<!DOCTYPE html>
<html>
<head>
<style>
body {
background-color: #000000;
}
img {
	width: 65px;
    position: absolute;
	-ms-interpolation-mode: nearest-neighbor; 
    clip: rect(3146px,0px,3388px,0px);
}
</style>
</head>
<body>

<img src="%A_ScriptDir%\images\extra\rune_base_small.png" width="242">

</body>
</html>
)
WB.Document.Write(html)
Gui, Show
return

GuiClose:
ExitApp