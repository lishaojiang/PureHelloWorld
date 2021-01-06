echo compile Win Nasm 
del helloWinNasm.obj
del helloWinNasm.exe

set MY_MSVC_LINK="C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Tools\MSVC\14.27.29110\bin\Hostx86\x86\link.exe"
set MY_KERNEL32_LIB="C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\um\x86\kernel32.lib"

nasm -f win32 helloWinNasm.asm
%MY_MSVC_LINK% /subsystem:console /defaultlib:%MY_KERNEL32_LIB% /entry:mymain helloWinNasm.obj
helloWinNasm.exe