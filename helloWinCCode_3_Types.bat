echo compile Win C Code 
del helloWinCCode.obj
del helloWinCCode.exe
del helloWinCCode_WinAPI.obj
del helloWinCCode_WinAPI.exe
del helloWinCCode_PureC.obj
del helloWinCCode_PureC.exe

set MY_MSVC_LINK="C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Tools\MSVC\14.27.29110\bin\Hostx86\x86\link.exe"
set MY_KERNEL32_LIB="C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\um\x86\kernel32.lib"

::  this is for asm in C code
clang -c -fno-builtin -D WIN_X86 hello.c -m32 -o helloWinCCode_asm.obj
%MY_MSVC_LINK% /subsystem:console /defaultlib:%MY_KERNEL32_LIB% /entry:mymain helloWinCCode_asm.obj
:: run the application
helloWinCCode_asm.exe

::  this is for Windows API C code
clang -c -fno-builtin -D WIN_X86_WINDOWS_C hello.c -m32 -o helloWinCCode_WinAPI.obj
%MY_MSVC_LINK% /subsystem:console /defaultlib:%MY_KERNEL32_LIB% /entry:mymain helloWinCCode_WinAPI.obj
:: run the application
helloWinCCode_WinAPI.exe

::  this is for pure C code
clang -c -fno-builtin -D WIN_X86_PURE_C hello.c -m32 -o helloWinCCode_PureC.obj

%MY_MSVC_LINK% /subsystem:console /defaultlib:%MY_KERNEL32_LIB% /entry:mymain helloWinCCode_PureC.obj
:: run the application
helloWinCCode_PureC.exe