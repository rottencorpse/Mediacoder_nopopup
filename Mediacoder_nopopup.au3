#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=mediacoder.ico
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Opt("MustDeclareVars", 1)

Global Const $WinTitle = "Continue in 1"
Global Const $EquationRegEx = ".* ([0-9]+ [\+-] [0-9]+) .*"


ShellExecute("MediaCoder.exe")

Mutex("MediaCoder-nopopup")

While ProcessExists("MediaCoder.exe")
   If WinExists($WinTitle) Then
      ControlSetText($WinTitle, "", 1314, Execute(StringRegExpReplace(ControlGetText($WinTitle, "", 1313), $EquationRegEx, "\1")))
      ControlClick($WinTitle, "", 2)
   EndIf
   Sleep(1000)
WEnd

Func Mutex($sMutexName)
   DllCall('kernel32.dll', 'handle', 'CreateMutexW', 'struct*', 0, 'bool', True, 'wstr', $sMutexName)
   If (DllCall("kernel32.dll", "dword", "GetLastError"))[0] = 183 Then Exit
EndFunc

