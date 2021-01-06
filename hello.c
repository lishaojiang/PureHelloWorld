// rayhunterli
// 2021/01/06

char* str = "Hello World!\n";

#ifdef LINUX_X86
//-------------------------------begin---------------------------
void asmprint()
{
    asm("movl $13, %%edx \n\t"
        "movl  %0,%%ecx \n\t"
        "movl $0,%%ebx \n\t"
        "movl $4,%%eax \n\t"
        "int $0x80  \n\t"
        ::"r"(str):"edx","ecx","ebx");
}

void asmexit()
{
    asm("movl $42,%ebx \n\t"
        "movl $1,%eax \n\t"
        "int $0x80 \n\t");
}
//-------------------------------end-----------------------------

#elif LINUX_X64
//-------------------------------begin---------------------------
void asmprint()
{
    asm (
        "movq $13, %%rdx \n\t"
        "movq %0, %%rsi  \n\t"
        "movq $1, %%rdi  \n\t"
        "movq $1, %%rax  \n\t"
        "syscall      \n\t"
        ::"r"(str):"rdx","rsi","rdi");
}

void asmexit()
{
    asm (
        "movq $42, %rdi \n\t"
        "movq $60, %rax \n\t"
        "syscall        \n\t ");

}
//-------------------------------end-----------------------------

#elif MAC_X64
//-------------------------------begin---------------------------
void asmprint()
{
    asm (
        "movq $13, %%rdx \n\t"
        "movq %0, %%rsi  \n\t"
        "movq $1, %%rdi  \n\t"
        "movq $0x2000004, %%rax  \n\t"
        "syscall      \n\t"
        ::"r"(str));
}

void asmexit()
{
    asm (
        "movq $0, %rdi \n\t"
        "movq $0x2000001, %rax \n\t"
        "syscall        \n\t ");
}
//-------------------------------end-----------------------------

#elif WIN_X86
//-------------------------------begin---------------------------
void asmprint()
{
	asm (
		"push $-11 \n\t"
		"call _GetStdHandle@4 \n\t"
		"push $0 \n\t"
		"push $0 \n\t"  // this must be 0,other it is wrong
		"push $13 \n\t"
		"push %%edx \n\t"
		"push %%eax \n\t"
		"call _WriteFile@20 \n\t"
		::"d"(str));
}

void asmexit()
{
    asm (
        "push $0 \n\t"
        "call _ExitProcess@4 \n\t");
}
//-------------------------------end-----------------------------

#elif WIN_X86_WINDOWS_C
//-------------------------------begin---------------------------
#include <windows.h>
void asmprint()
{
    HANDLE hHandle = GetStdHandle(STD_OUTPUT_HANDLE);
    WriteFile(hHandle,str,13,0,0);
}

void asmexit()
{
    ExitProcess(0);
}
//-------------------------------end-----------------------------

#elif WIN_X86_PURE_C
//-------------------------------begin---------------------------
//C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\um\processenv.h
// WINBASEAPI HANDLE WINAPI GetStdHandle(
//     _In_ DWORD nStdHandle
//     );

//C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\um\fileapi.h
// WINBASEAPI BOOL WINAPI WriteFile(
//     _In_ HANDLE hFile,
//     _In_reads_bytes_opt_(nNumberOfBytesToWrite) LPCVOID lpBuffer,
//     _In_ DWORD nNumberOfBytesToWrite,
//     _Out_opt_ LPDWORD lpNumberOfBytesWritten,
//     _Inout_opt_ LPOVERLAPPED lpOverlapped
//     );


//C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\um\processthreadsapi.h
// WINBASEAPI DECLSPEC_NORETURN VOID WINAPI ExitProcess(
//     _In_ UINT uExitCode
//     );

// STD_INPUT_HANDLE (DWORD) -10	The standard input device. Initially, this is the console input buffer, CONIN$.
// STD_OUTPUT_HANDLE (DWORD) -11	The standard output device. Initially, this is the active console screen buffer, CONOUT$.
// STD_ERROR_HANDLE (DWORD) -12	The standard error device. Initially, this is the active console screen buffer, CONOUT$.

// typedef unsigned long       DWORD;
// typedef int                 BOOL;
// typedef int                 INT;
// typedef unsigned int        UINT;
// typedef CONST void far      *LPCVOID;
// typedef DWORD far           *LPDWORD;
// typedef struct _OVERLAPPED *LPOVERLAPPED;

__declspec(dllimport) void* __stdcall GetStdHandle(unsigned long);
__declspec(dllimport) int __stdcall WriteFile(void*,const void*,unsigned long,unsigned long ,void*);
__declspec(dllimport) __declspec(noreturn) void __stdcall ExitProcess(unsigned int);

void asmprint()
{
    void* hHandle = GetStdHandle(-11);
    WriteFile(hHandle,str,13,0,0);
}

void asmexit()
{
    ExitProcess(0);
}
//-------------------------------end-----------------------------

#endif



void mymain()
{
    asmprint();
    asmexit();
}