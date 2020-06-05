#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^+!c::Run chrome.exe

^+!f::Run, foobar2000.exe

^+!t::Run, c:\Users\voman\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\TOTALCMD64

^+!v::Run, C:\Users\voman\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code

^+!u::Run, ubuntu 


;#l::#Right
;#h::#Left
;#k::#Up
;#j::#Down

