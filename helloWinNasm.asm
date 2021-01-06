;rayhunterli
;2021/01/06

extern _GetStdHandle@4
extern _WriteFile@20
extern _ExitProcess@4

section .data
    msg db "hello world!", 0
    msglen equ $ - msg
    bytes_written resd 1

    
section .text
global _mymain
_mymain:
    push -11
    call _GetStdHandle@4

    push 0
    push bytes_written
    push msglen
    push msg
    push eax

    call _WriteFile@20

    push 0
    call _ExitProcess@4
