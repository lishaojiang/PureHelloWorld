#Linux compile

# hello.c X86
clang -c -fno-builtin -m32 -D LINUX_X86 hello.c
ld -static -m elf_i386 -e mymain -o helloX86 hello.o


# hello.c X64
clang -c -fno-builtin -m64 -D LINUX_X64 hello.c
ld -static -e mymain -o helloX64 hello.o
