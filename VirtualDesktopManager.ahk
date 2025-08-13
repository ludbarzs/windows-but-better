#Requires AutoHotkey v2.0

; Load DLL
DllCall("LoadLibrary", "Str", A_ScriptDir "\VirtualDesktopAccessor.dll", "Ptr")

; Win+1 -> Desktop 1
#1:: GoToDesktopNumber(1)

; Win+2 -> Desktop 2
#2:: GoToDesktopNumber(2)

GoToDesktopNumber(n) {
    current := DllCall("VirtualDesktopAccessor\GetCurrentDesktopNumber", "Int")
    if (current < 0)
        return
    while (current < n - 1) {
        DllCall("VirtualDesktopAccessor\GoToDesktopNumber", "Int", current + 1)
        current++
    }
    while (current > n - 1) {
        DllCall("VirtualDesktopAccessor\GoToDesktopNumber", "Int", current - 1)
        current--
    }
}
