;rayhunterli
;2021/01/06


SECTION .data
msg: db "helloworld!",0x0a
len: equ $-msg


SECTION .text
global mymain

mymain:
	mov rax,0x2000004				;write 
	mov rdi,1						;cmd
	mov rsi,msg						;string symbol for syscall
	mov rdx,len						;length for string
	syscall


	mov rax,0x2000001				;exit
	mov rdi,0						;exit number
	syscall




;#include <sys/appleapiopts.h>
;#ifdef __APPLE_API_PRIVATE
;#define SYS_syscall        0
;#define SYS_exit           1
;#define SYS_fork           2
;#define SYS_read           3
;#define SYS_write          4
;#define SYS_open           5
;#define SYS_close          6
;#define SYS_wait4          7

;real sysall = 0x2000000 + unix syscall#
;write = 0x2000000 + 4 = 0x2000004