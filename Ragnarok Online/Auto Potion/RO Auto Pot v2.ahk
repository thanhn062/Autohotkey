#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}
IfNotExist, ROAPscreenCapture.exe
{
batScript =
(
// 2>nul||@goto :batch
/*
:batch
@echo off
setlocal

:: find csc.exe
set "csc="
for /r "`%SystemRoot`%\Microsoft.NET\Framework\" `%`%# in ("*csc.exe") do  set "csc=`%`%#"

if not exist "`%csc`%" (
   echo no .net framework installed
   exit /b 10
`)

if not exist "`%~n0.exe" (
   call `%csc`% /nologo /r:"Microsoft.VisualBasic.dll" /out:"`%~n0.exe" "`%~dpsfnx0" || (
      exit /b `%errorlevel`% 
   `)
`)
`%~n0.exe `%*
endlocal & exit /b `%errorlevel`%

*/

// reference  
// https://gallery.technet.microsoft.com/scriptcenter/eeff544a-f690-4f6b-a586-11eea6fc5eb8

using System;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
using Microsoft.VisualBasic;


/// Provides functions to capture the entire screen, or a particular window, and save it to a file. 

public class ScreenCapture
{

    /// Creates an Image object containing a screen shot the active window 

    public Image CaptureActiveWindow()
    {
        return CaptureWindow(User32.GetForegroundWindow());
    }

    /// Creates an Image object containing a screen shot of the entire desktop 

    public Image CaptureScreen()
    {
        return CaptureWindow(User32.GetDesktopWindow());
    }

    /// Creates an Image object containing a screen shot of a specific window 

    private Image CaptureWindow(IntPtr handle)
    {
        // get te hDC of the target window 
        IntPtr hdcSrc = User32.GetWindowDC(handle);
        // get the size 
        User32.RECT windowRect = new User32.RECT();
        User32.GetWindowRect(handle, ref windowRect);
        int width = windowRect.right - windowRect.left;
        int height = windowRect.bottom - windowRect.top;
        // create a device context we can copy to 
        IntPtr hdcDest = GDI32.CreateCompatibleDC(hdcSrc);
        // create a bitmap we can copy it to, 
        // using GetDeviceCaps to get the width/height 
        IntPtr hBitmap = GDI32.CreateCompatibleBitmap(hdcSrc, width, height);
        // select the bitmap object 
        IntPtr hOld = GDI32.SelectObject(hdcDest, hBitmap);
        // bitblt over 
        GDI32.BitBlt(hdcDest, 0, 0, width, height, hdcSrc, 0, 0, GDI32.SRCCOPY);
        // restore selection 
        GDI32.SelectObject(hdcDest, hOld);
        // clean up 
        GDI32.DeleteDC(hdcDest);
        User32.ReleaseDC(handle, hdcSrc);
        // get a .NET image object for it 
        Image img = Image.FromHbitmap(hBitmap);
        // free up the Bitmap object 
        GDI32.DeleteObject(hBitmap);
        return img;
    }

    public void CaptureActiveWindowToFile(string filename, ImageFormat format)
    {
        Image img = CaptureActiveWindow();
        img.Save(filename, format);
    }

    public void CaptureScreenToFile(string filename, ImageFormat format)
    {
        Image img = CaptureScreen();
        img.Save(filename, format);
    }

    static bool fullscreen = true;
    static String file = "screenshot.bmp";
    static System.Drawing.Imaging.ImageFormat format = System.Drawing.Imaging.ImageFormat.Bmp;
    static String windowTitle = "";

    static void parseArguments()
    {
        String[] arguments = Environment.GetCommandLineArgs();
        if (arguments.Length == 1)
        {
            printHelp();
            Environment.Exit(0);
        }
        if (arguments[1].ToLower().Equals("/h") || arguments[1].ToLower().Equals("/help"))
        {
            printHelp();
            Environment.Exit(0);
        }

        file = arguments[1];
        Dictionary<String, System.Drawing.Imaging.ImageFormat> formats =
        new Dictionary<String, System.Drawing.Imaging.ImageFormat>();

        formats.Add("bmp", System.Drawing.Imaging.ImageFormat.Bmp);
        formats.Add("emf", System.Drawing.Imaging.ImageFormat.Emf);
        formats.Add("exif", System.Drawing.Imaging.ImageFormat.Exif);
        formats.Add("jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
        formats.Add("jpeg", System.Drawing.Imaging.ImageFormat.Jpeg);
        formats.Add("gif", System.Drawing.Imaging.ImageFormat.Gif);
        formats.Add("png", System.Drawing.Imaging.ImageFormat.Png);
        formats.Add("tiff", System.Drawing.Imaging.ImageFormat.Tiff);
        formats.Add("wmf", System.Drawing.Imaging.ImageFormat.Wmf);


        String ext = "";
        if (file.LastIndexOf('.') > -1)
        {
            ext = file.ToLower().Substring(file.LastIndexOf('.') + 1, file.Length - file.LastIndexOf('.') - 1);
        }
        else
        {
            Console.WriteLine("Invalid file name - no extension");
            Environment.Exit(7);
        }

        try
        {
            format = formats[ext];
        }
        catch (Exception e)
        {
            Console.WriteLine("Probably wrong file format:" + ext);
            Console.WriteLine(e.ToString());
            Environment.Exit(8);
        }


        if (arguments.Length > 2)
        {
            windowTitle = arguments[2];
            fullscreen = false;
        }

    }

    static void printHelp()
    {
        //clears the extension from the script name
        String scriptName = Environment.GetCommandLineArgs()[0];
        scriptName = scriptName.Substring(0, scriptName.Length);
        Console.WriteLine(scriptName + " captures the screen or the active window and saves it to a file.");
        Console.WriteLine("");
        Console.WriteLine("Usage:");
        Console.WriteLine(" " + scriptName + " filename  [WindowTitle]");
        Console.WriteLine("");
        Console.WriteLine("finename - the file where the screen capture will be saved");
        Console.WriteLine("     allowed file extensions are - Bmp,Emf,Exif,Gif,Icon,Jpeg,Png,Tiff,Wmf.");
        Console.WriteLine("WindowTitle - instead of capture whole screen you can point to a window ");
        Console.WriteLine("     with a title which will put on focus and captuted.");
        Console.WriteLine("     For WindowTitle you can pass only the first few characters.");
        Console.WriteLine("     If don't want to change the current active window pass only \"\"");
    }

    public static void Main()
    {
        parseArguments();
        ScreenCapture sc = new ScreenCapture();
        if (!fullscreen && !windowTitle.Equals(""))
        {
            try
            {

                Interaction.AppActivate(windowTitle);
                Console.WriteLine("setting " + windowTitle + " on focus");
            }
            catch (Exception e)
            {
                Console.WriteLine("Probably there's no window like " + windowTitle);
                Console.WriteLine(e.ToString());
                Environment.Exit(9);
            }


        }
        try
        {
            if (fullscreen)
            {
                Console.WriteLine("Taking a capture of the whole screen to " + file);
                sc.CaptureScreenToFile(file, format);
            }
            else
            {
                Console.WriteLine("Taking a capture of the active window to " + file);
                sc.CaptureActiveWindowToFile(file, format);
            }
        }
        catch (Exception e)
        {
            Console.WriteLine("Check if file path is valid " + file);
            Console.WriteLine(e.ToString());
        }
    }

    /// Helper class containing Gdi32 API functions 

    private class GDI32
    {

        public const int SRCCOPY = 0x00CC0020; // BitBlt dwRop parameter 
        [DllImport("gdi32.dll")]
        public static extern bool BitBlt(IntPtr hObject, int nXDest, int nYDest,
          int nWidth, int nHeight, IntPtr hObjectSource,
          int nXSrc, int nYSrc, int dwRop);
        [DllImport("gdi32.dll")]
        public static extern IntPtr CreateCompatibleBitmap(IntPtr hDC, int nWidth,
          int nHeight);
        [DllImport("gdi32.dll")]
        public static extern IntPtr CreateCompatibleDC(IntPtr hDC);
        [DllImport("gdi32.dll")]
        public static extern bool DeleteDC(IntPtr hDC);
        [DllImport("gdi32.dll")]
        public static extern bool DeleteObject(IntPtr hObject);
        [DllImport("gdi32.dll")]
        public static extern IntPtr SelectObject(IntPtr hDC, IntPtr hObject);
    }


    /// Helper class containing User32 API functions 

    private class User32
    {
        [StructLayout(LayoutKind.Sequential)]
        public struct RECT
        {
            public int left;
            public int top;
            public int right;
            public int bottom;
        }
        [DllImport("user32.dll")]
        public static extern IntPtr GetDesktopWindow();
        [DllImport("user32.dll")]
        public static extern IntPtr GetWindowDC(IntPtr hWnd);
        [DllImport("user32.dll")]
        public static extern IntPtr ReleaseDC(IntPtr hWnd, IntPtr hDC);
        [DllImport("user32.dll")]
        public static extern IntPtr GetWindowRect(IntPtr hWnd, ref RECT rect);
        [DllImport("user32.dll")]
        public static extern IntPtr GetForegroundWindow();
    }
}
)
FileAppend, %batScript%, ROAPscreenCapture.bat
Run, %comspec% /c ROAPscreenCapture.bat ,,Hide,cmdPID 
while !FileExist("ROAPscreenCapture.exe")
    Sleep 10
FileDelete, ROAPscreenCapture.bat
screenCapture_check := 1
}
else
    screenCapture_check := 1
;~ SetBatchLines -1
ListLines Off
; LOAD INI
IniRead, HP_Button, ROAP.ini, Hotkey, HP
IniRead, SP_Button, ROAP.ini, Hotkey, SP
IniRead, sendMode, ROAP.ini, Hotkey, SendMode
IfInString, sendMode, control
    sendMode = 1
else
    sendMode = 2
IniRead, HP, ROAP.ini, Trigger, HP
IniRead, SP, ROAP.ini, Trigger, SP
IniRead, HP_Delay, ROAP.ini, Delay, HP
IniRead, SP_Delay, ROAP.ini, Delay, SP
IniRead, auto_HP, ROAP.ini, Checkbox, HP
IniRead, auto_SP, ROAP.ini, Checkbox, SP

Gui, Color, 2b2b2b
Gui, Font, cWhite
Gui, Add, Text, x10 y15 vProcess w500, No process selected
Gui, Add, ActiveX, xp y40 w350 h150 vWB +ReadOnly, Shell.Explorer
WB.Navigate("about:blank")
WB.silent := true
Gui, Add, Groupbox, cBlue xp yp+160 w350 h80 vGroupbox

Gui, font, w1000
if auto_HP
    Gui, Add, Checkbox, xp+45 yp+25 +Checked c00FF00 vauto_HP, Auto HP
else
    Gui, Add, Checkbox, xp+45 yp+25 c00FF00 vauto_HP, Auto HP
Gui, font, w8
Gui, Add, Text, xp+80 yp, Press:
StringRight, temp, HP_Button, 1
Gui, Add, DropdownList, xp+38 yp-3 w50 +Choose%temp% vHP_Button,F1|F2|F3|F4|F5|F6|F7|F8|F9
Gui, Add, Text, xp+58 yp+3, if HP <
Gui, Add, Edit, xp+40 yp-3 vHP w40 cBlack +Number Limit2, 
Gui, Add, Updown, Range20-99, %HP%
Gui, Add, Text, xp+45 yp+3, `%

Gui, font, w1000
if auto_SP
    Gui, Add, Checkbox, x55 yp+27 +Checked c00FFFF vauto_SP, Auto SP
else
    Gui, Add, Checkbox, x55 yp+27 c00FFFF vauto_SP, Auto SP
Gui, font, w8
Gui, Add, Text, xp+80 yp, Press:
StringRight, temp, SP_Button, 1
Gui, Add, DropdownList, xp+38 yp-3 w50 +Choose%temp% vSP_Button,F1|F2|F3|F4|F5|F6|F7|F8|F9
Gui, Add, Text, xp+58 yp+3, if SP <
Gui, Add, Edit, xp+40 yp-3 vSP w40 cBlack +Number Limit2, 
Gui, Add, Updown, Range20-99, %SP%
Gui, Add, Text, xp+45 yp+3, `%

Gui, Add, Text,x246 y288 c00FF00 , HP-Delay:
Gui, Add, Edit, xp+55 yp-4 +number w60 cBlack vHP_Delay, %HP_Delay%
Gui, Add, Text,x246 y310 c00FFFF , SP-Delay:
Gui, Add, Edit, xp+55 yp-4 +number w60 cBlack vSP_Delay, %SP_Delay%

Gui, Add, Text, x10 y310 +BackgroundTrans, CTRL + F1 - to select client`nCTRL + F5 - to start/stop auto potion
Gui, Add, Link, xp yp+40 cBlack +BackgroundTrans, Credit / About:`nThis was made based on "Ragnarok Auto Potion" from `n<a href="http://www.garenathai.com">http://www.garenathai.com</a>

Gui, Add, Button, x280 y330 w80 h60 vstart gstart, Start`n(Ctrl+F5)
Gui, Add, ActiveX, vAD x10 y395 w350 h100, Shell.Explorer
AD.Navigate("http://textuploader.com/dd0f6/raw")
AD.silent := true

Gui, +Resize
guiW = 370
guiH = 500

Gui, Show, w%guiW% h%guiH%, RO Auto Pot ( AHK Re-made) - http://ragindex.blogspot.com
return

~LButton::placeArrow("HP")
~RButton::placeArrow("SP")
^F1::
if !screenCapture_check
{
    ToolTip, Making screenCapture.exe`, please wait.
    SetTimer, removeTT, 500
    return
}
FileDelete, ROAP.bmp
WinGetActiveTitle, ActiveTitle
GuiControl,, Process, %ActiveTitle%
Run, %comspec% /c ROAPscreenCapture ROAP.bmp "%ActiveTitle%" ,,Hide,cmdPID 
html =
(Ltrim Join
<!doctype html>
<html>
<head>
    <style>
        body {
            background-color: #2b2b2b;
            margin: 0;
            padding: 0;
        }
        img {
          -moz-user-select: none;
          -webkit-user-select: none;
          -ms-user-select: none;
          user-select: none;
          -webkit-user-drag: none;
          user-drag: none;
          -webkit-touch-callout: none;
        }
        /* ========== Health Point -> Arrow  ==========*/
        #arrow-HP1 {
            position: absolute;
            top: -100px;
            left: -100px;
            z-index: 999;
            width: 0; 
            height: 0; 
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid red;
        }
        #arrow-HP2 {
            position: absolute;
            top: -100px;
            left: -100px;
            z-index: 999;
            width: 20px; 
            height: 0px; 
            border: 1px solid red;
        }
        #arrow-HP3 {
            position: absolute;
            top: -100px;
            left: -100px;
            z-index: 999;
            width: 0; 
            height: 0; 
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-left: 5px solid red;
        }
        
        /* ========== Mana Point -> Arrow  ==========*/
        #arrow-SP1 {
            position: absolute;
            top: -100px;
            left: -100px;
            z-index: 999;
            width: 0; 
            height: 0; 
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid blue;
        }
        #arrow-SP2 {
            position: absolute;
            top: -100px;
            left: -100px;
            z-index: 999;
            width: 20px; 
            height: 0px; 
            border: 1px solid blue;
        }
        #arrow-SP3 {
            position: absolute;
            top: -100px;
            left: -100px;
            z-index: 999;
            width: 0; 
            height: 0; 
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-left: 5px solid blue;
        }
    </style>
    
    <script type="text/javascript">
      function nocontext(e) {
        var clickedTag = (e==null) ? event.srcElement.tagName : e.target.tagName;
        if (clickedTag == "IMG")
          return false;
      }
      document.oncontextmenu = nocontext;
    </script>
</head>

<body onmousemove ="showCoor(event)"onmouseout="clearCoor()">

<!-- HP / SP-->
<div id="arrow-HP1"></div>
<div id="arrow-HP2"></div>
<div id="arrow-HP3"></div>

<div id="arrow-SP1"></div>
<div id="arrow-SP2"></div>
<div id="arrow-SP3"></div>

<!-- Info -->
<p id="Coordinate" style="display: none;"></p>

<script>
    function showCoor(event) {
        var x, y;
        if (event.pageX || event.pageY) { 
            x = event.pageX;
            y = event.pageY;
        }
        else {
            x = event.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
            y = event.clientY + document.body.scrollTop + document.documentElement.scrollTop;
        }
        var coor = x + "," + y;
        document.getElementById("Coordinate").innerHTML = coor;
    }
    function clearCoor() {
        document.getElementById("Coordinate").innerHTML = "";
    }
</script>

<img src="%A_ScriptDir%\ROAP.bmp" draggable="false">
</body>
</html>
)
while !FileExist("ROAP.bmp")
    Sleep 20
WB.Navigate("about:blank")
Sleep 50
WB.Document.Write(html)
html=
return
^F5::
start:
if !ActiveTitle
{
    MsgBox, 262160, ERROR, No process selected
    return
}
start := !start
Gui, submit, nohide
if start
{
    GuiControl,, start, Stop`n(Ctrl+F5)
    ToolTip, STARTED
    SetTimer, removeTT, On
    WinGetPos, winX, winY,,, %ActiveTitle%
    setMark("HP",HP)
    setMark("SP",SP)
    ; Identify white cell to  determine if @jump @refresh
    whiteY := HP_Y
    Loop
    {
        whiteY--
        CoordMode, pixel, screen
        PixelGetColor, whiteColor, HP_EndX, whiteY, RGB
        if (whiteColor = "0xFFFFFF")
            break
    }
    if auto_HP
        SetTimer, HP_Watch, %HP_Delay%
    if auto_SP
        SetTimer, SP_Watch, %SP_Delay%
}
else
{
    GuiControl,, start, Start`n(Ctrl+F5)
    ToolTip, STOPPED
    SetTimer, removeTT, On
    SetTimer, HP_Watch, Off
    SetTimer, SP_Watch, Off
}
return

HP_Watch:
IfWinNotActive, %ActiveTitle%
    return
CoordMode, pixel, screen
PixelGetColor, HP_new_color, HP_WatchX, HP_WatchY, RGB
PixelGetColor, whiteColor, HP_EndX, whiteY, RGB
if (whiteColor != "0xFFFFFF")
{
    Sleep 1100
    return
}
if (HP_new_color = "0x000000")
{
    Sleep 1100
    return
}
else if (HP_new_color != HP_base_color)
    if sendMode = 1
        ControlSend,, {%HP_Button%}, %ActiveTitle%
    else
        Send, {%HP_Button%}
return

SP_Watch:
IfWinNotActive, %ActiveTitle%
    return
CoordMode, pixel, screen
PixelGetColor, SP_new_color, SP_WatchX, SP_WatchY, RGB
PixelGetColor, whiteColor, HP_EndX, whiteY, RGB
if (whiteColor != "0xFFFFFF")
{
    Sleep 1100
    return
}
if (SP_new_color = "0x000000")
{
    Sleep 1100
    return
}
else if (SP_new_color != SP_base_color)
    if sendMode = 1
        ControlSend,, {%SP_Button%}, %ActiveTitle%
    else
        Send, {%SP_Button%}
return

removeTT:
Sleep 500
ToolTip
SetTimer, removeTT, Off
return

GuiSize:
WB_w := A_GuiWidth - 20
GuiControl, Move, WB, x10 y40 w%WB_w%
GuiControl, Move, Groupbox, x10 y200 w%WB_w%
return

GuiClose:
FileDelete, ROAP.bmp
Gui, submit, nohide
IniWrite, %HP_Button%, ROAP.ini, Hotkey, HP
IniWrite, %SP_Button%, ROAP.ini, Hotkey, SP
IniWrite, %HP%, ROAP.ini, Trigger, HP
IniWrite, %SP%, ROAP.ini, Trigger, SP
IniWrite, %HP_Delay%, ROAP.ini, Delay, HP
IniWrite, %SP_Delay%, ROAP.ini, Delay, SP
IniWrite, %auto_HP%, ROAP.ini, Checkbox, HP
IniWrite, %auto_SP%, ROAP.ini, Checkbox, SP
ExitApp
;============= FUNCTION
setMark(HP_SP,mark) {
    global
    %HP_SP%_mark := Round(((%HP_SP%_EndX - %HP_SP%_StartX) / 100)*mark,0)
    %HP_SP%_WatchX := winX + %HP_SP%_StartX + %HP_SP%_mark
    %HP_SP%_WatchY := winY + %HP_SP%_Y
    ; Check if mark is 0x000000 if so move over to right
    PixelGetColor, check_mark, %HP_SP%_WatchX, %HP_SP%_WatchY, RGB
    Loop
        if (check_mark = "0x000000")
            %HP_SP%_WatchX++
        else
            break
}
placeArrow(HP_SP) {
    global wb, HP_StartX, HP_EndX, SP_StartX, SP_EndX, HP_base_color, SP_base_color, HP_Y, SP_Y
    if wb.document.getElementById("Coordinate").innerHTML
    {
        ; store Coordinate
        pageCoor := wb.document.getElementById("Coordinate").innerHTML
        StringSplit, coor_, pageCoor, `,
        
        MouseGetPos, MouseX, MouseY
        ; Move the arrow out of the way
        WB.document.getElementById("arrow-" HP_SP "1").style.left := -100
        WB.document.getElementById("arrow-" HP_SP "1").style.top := -100
        WB.document.getElementById("arrow-" HP_SP "2").style.left := -100
        WB.document.getElementById("arrow-" HP_SP "2").style.top := -100
        WB.document.getElementById("arrow-" HP_SP "3").style.left := -100
        WB.document.getElementById("arrow-" HP_SP "3").style.top := -100
        
        Sleep 50
        PixelGetColor, %HP_SP%_base_color, %MouseX%, %MouseY%, RGB
        ToolTip identifying %HP_SP% bar ...
        if !ErrorLevel
        {
            ; Loop to the LEFT
            tempX := MouseX
            Loop
            {
                tempX--
                PixelGetColor, color, %tempX%, %MouseY%, RGB
                if (color = "0x000000")
                    continue
                if (%HP_SP%_base_color != color)
                    break
            }
            ; Loop to the RIGHT
            tempX1 := MouseX
            Loop
            {
                tempX1++
                PixelGetColor, color, %tempX1%, %MouseY%, RGB
                if (color = "0x000000")
                    continue
                if (%HP_SP%_base_color != color)
                    break
            }
            %HP_SP%_StartX := coor_1 - (MouseX - tempX)
            %HP_SP%_EndX := %HP_SP%_StartX + (tempX1 - tempX)
            %HP_SP%_Y :=  coor_2
            ; Move arrow to coor
            WB.document.getElementById("arrow-" HP_SP "1").style.left := coor_1 - (MouseX - tempX)
            WB.document.getElementById("arrow-" HP_SP "1").style.top := coor_2 - 5
            
            WB.document.getElementById("arrow-" HP_SP "2").style.left := coor_1 - (MouseX - tempX)
            WB.document.getElementById("arrow-" HP_SP "2").style.top := coor_2 - 1
            WB.document.getElementById("arrow-" HP_SP "2").style.width := tempX1 - tempX
            
            WB.document.getElementById("arrow-" HP_SP "3").style.left := coor_1 + (tempX1 - MouseX)-4
            WB.document.getElementById("arrow-" HP_SP "3").style.top := coor_2 - 5
            ToolTip
        }
    }
}