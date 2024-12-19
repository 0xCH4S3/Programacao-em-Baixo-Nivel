section .data
    message: db 'hello, world!', 10 

section .text
    global _start

_start:
    mov rax, 1          ; Número do syscall para 'write'
    mov rdi, 1          ; Descritor de saída: 1 para stdout
    mov rsi, message    ; Endereço da string
    mov rdx, 14         ; Comprimento da string em bytes
    syscall             

    mov rax, 60         ; Número do syscall para 'exit'
    xor rdi, rdi        
    syscall             
