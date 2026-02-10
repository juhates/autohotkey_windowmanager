#Requires AutoHotkey v2.0

; Only run this script when Chrome is the active window
#HotIf WinActive("ahk_exe chrome.exe")
#HotIf WinActive("ahk_exe firefox.exe")

; Remap Alt + 1 to Previous Tab (Ctrl + Shift + Tab)
!1::Send "^+{Tab}"

; Remap Alt + 2 to Next Tab (Ctrl + Tab)
!2::Send "^{Tab}"

#HotIf