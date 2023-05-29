; count.asm

; count to one billion using a loop.
; intel x86-64 assembly language for macos.

global _main

section .text

_main:
    ; allocate space on the stack for our local variables.
    ; we need 16 bytes for the return address, 8 bytes for the count, and 8
    ; bytes for the loop counter.
    sub rsp, 32

    ; initialize the count to 0.
    mov rdi, 0

    ; initialize the loop counter to 1000000000.
    mov rcx, 1000000000

    ; loop until the loop counter is equal to 1000000000.
    count:
        ; increment the count.
        inc rdi

        ; jump back to the beginning of the loop.
        loop count
        align 8

    end_loop:
        ; exit the program.
        mov rax, 0x2000001
        mov rdi, 0
        syscall

; build - macOS 13.2.1 Ventura (requires yasm)
; yasm -f macho64 main.asm -o main_asm.o
; ld main_asm.o -o main_asm -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem
