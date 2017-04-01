${SegmentFile}

${Segment.OnInit}
	; Borrowed the following from PAL 2.2, Remove on release of PAL 2.2
		; Work out if it's 64-bit or 32-bit
	System::Call kernel32::GetCurrentProcess()i.s
	System::Call kernel32::IsWow64Process(is,*i.r0)
	${If} $0 == 0
		StrCpy $Bits 32
	${Else}
		StrCpy $Bits 64
	${EndIf}
!macroend

${SegmentPrePrimary}
	;Check for the uninstall key and back up
	${If} $Bits = 64
		SetRegView 64
	${EndIf}
	
    ${registry::KeyExists} "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView" $0
	${If} $0 == 0
		${registry::MoveKey} "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView" "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView-BackupByIrfanViewPortable" $1
	${EndIf}
	
	${If} $Bits = 64
		SetRegView 32
	${EndIf}

	ReadINIStr $0 "$EXEDIR\Data\IrfanView\license.ini" "Registration" "Name"
	${If} $0 != ""
		WriteINIStr "$EXEDIR\App\IrfanView\i_view32.ini" "Registration" "Name" $0
		ReadINIStr $0 "$EXEDIR\Data\IrfanView\license.ini" "Registration" "Code"
		WriteINIStr "$EXEDIR\App\IrfanView\i_view32.ini" "Registration" "Code" $0
	${EndIf}
!macroend

${SegmentPostPrimary}
	DeleteINISec "$EXEDIR\App\IrfanView\i_view32.ini" "Registration"
	
	;Remove uninstall key if added
	${If} $Bits = 64
		SetRegView 64
	${EndIf}
	
	${registry::KeyExists} "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView" $0
	${If} $0 == 0
		${registry::DeleteKey} "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView" $1
	${EndIf}
	${registry::KeyExists} "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView-BackupByIrfanViewPortable" $0
	${If} $0 == 0
		${registry::MoveKey} "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView-BackupByIrfanViewPortable" "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView" $1
	${EndIf}
	
	${If} $Bits = 64
		SetRegView 32
	${EndIf}
!macroend
