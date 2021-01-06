echo compile Win Masm 
del helloWinMasm.obj
del helloWinMasm.exe

set MY_MASM32_COMPILE="C:\masm32\bin\ml.exe"
set MY_MASM32_LINK="C:\masm32\bin\PoLink.exe"

%MY_MASM32_COMPILE% /c /coff "helloWinMasm.asm"
%MY_MASM32_LINK% /subsystem:console "helloWinMasm.obj"

helloWinMasm.exe