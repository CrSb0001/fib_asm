section .data
    msg db "The nth Fibonacci number is: ", 0
    msg_len equ $-msg
    fmt db "%d", 10, 0
    input_fmt db "%d", 0

section .bss
    n resd 1
    sum resd 1

section .text
    global _start
    extern printf, scanf, exit

_start:

    extern __libc_start_main
    call __libc_start_main

    push n
    push input_fmt
    call scanf
    add esp, 8

    mov ecx, [n]
    cmp ecx, 1
    jle .print_fib

    mov eax, 0
    mov ebx, 1

    sub ecx, 1
.calc_fib:
    add eax, ebx
    xchg eax, ebx
    loop .calc_fib

.print_fib:

    push eax
    push fmt
    call printf
    add esp, 8

    push 0
    call exit
