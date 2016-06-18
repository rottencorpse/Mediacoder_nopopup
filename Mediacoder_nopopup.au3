#NoTrayIcon
Opt("MustDeclareVars", 1)

Global Const $WinTitle = "Continue in 1"
Global Const $EquationRegEx = ".* ([0-9]+ [\+-] [0-9]+) .*"

ShellExecute("MediaCoder.exe")
Mutex("MediaCoder_nopopup")
Sleep(1000)

While ProcessExists("MediaCoder.exe")
   If WinExists($WinTitle) Then
		ControlSetText($WinTitle, "", 1314, Execute(StringRegExpReplace(ControlGetText($WinTitle, "", 1313), $EquationRegEx, "\1")))
		ControlClick($WinTitle, "", 2)
	EndIf
	Sleep(1000)
WEnd


Func Mutex($sMutexName, $Exits = 1)
	Local $aHandle = DllCall('kernel32.dll', 'handle', 'CreateMutexW', 'struct*', 0, 'bool', True, 'wstr', $sMutexName)
	If (DllCall("kernel32.dll", "dword", "GetLastError"))[0] = 183 Then
      If $Exits = 1 Then Exit -1
      DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $aHandle[0])
      Return -1
   EndIf
   Return 0
EndFunc

