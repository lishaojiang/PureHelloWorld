;rayhunterli
;2021/01/06


.386
.model flat,stdcall
option casemap:none


include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc


includelib C:\masm32\lib\kernel32.lib


.data
    hellotext db "Hello World",0
    dwCharWrite dd 0


.code

START:
    invoke GetStdHandle,STD_OUTPUT_HANDLE
    invoke WriteConsole,eax,offset hellotext,sizeof hellotext,offset dwCharWrite,NULL
end START