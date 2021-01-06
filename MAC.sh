#MAC compile

# hello.c 
clang -c -fno-builtin -D MAC_X64 hello.c
ld -static -e _mymain hello.o -o hello

# helloeasyMAC.asm
nasm -f macho64 helloeasyMAC.asm -o hello.o
ld -o hello -e _mymain -static hello.o