 #Requires AutoHotkey v2.0
; Load DLL
DllCall("LoadLibrary", "Str", A_ScriptDir "\VirtualDesktopAccessor.dll", "Ptr")

; Create 10 desktops on startup using Windows 10 method
CreateDesktopsWin10()

; Hotkeys for Win+1 through Win+0 (desktop 10)
#1:: GoToDesktopNumber(1)
#2:: GoToDesktopNumber(2)
#3:: GoToDesktopNumber(3)
#4:: GoToDesktopNumber(4)
#5:: GoToDesktopNumber(5)
#6:: GoToDesktopNumber(6)
#7:: GoToDesktopNumber(7)
#8:: GoToDesktopNumber(8)
#9:: GoToDesktopNumber(9)
#0:: GoToDesktopNumber(10)  ; Win+0 for desktop 10

CreateDesktopsWin10() {
    ; Get current desktop count
    desktopCount := DllCall("VirtualDesktopAccessor\GetDesktopCount", "Int")
    
    ; Use Windows key combinations to create new desktops
    ; Ctrl+Win+D creates a new desktop in Windows 10
    while (desktopCount < 10) {
        Send("^#{d}")  ; Ctrl+Win+D to create new desktop
        Sleep(200)     ; Wait for desktop creation
        desktopCount := DllCall("VirtualDesktopAccessor\GetDesktopCount", "Int")
        
        ; Safety check to prevent infinite loop
        if (A_Index > 15) {
            break
        }
    }
    
    ; Go back to first desktop
    GoToDesktopNumber(1)
    
    ; Show confirmation
    finalCount := DllCall("VirtualDesktopAccessor\GetDesktopCount", "Int")
    ToolTip("Created " . finalCount . " virtual desktops")
    SetTimer(() => ToolTip(), -2000)  ; Hide tooltip after 2 seconds
}

GoToDesktopNumber(n) {
    current := DllCall("VirtualDesktopAccessor\GetCurrentDesktopNumber", "Int")
    if (current < 0)
        return
    
    ; Direct navigation to desktop n-1 (0-indexed)
    DllCall("VirtualDesktopAccessor\GoToDesktopNumber", "Int", n - 1)

    ; Wait for the switch to finish (adjust delay as needed)
    Sleep(200)

    ; Simulate Alt+Tab
    Send "{Alt down}{Tab}{Alt up}"
}
