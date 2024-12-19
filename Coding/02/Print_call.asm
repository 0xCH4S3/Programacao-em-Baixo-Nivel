section .data
    newline_char: db 10          ; Caractere de nova linha
    codes: db '0123456789abcdef' ; Tabela de caracteres hexadecimais

section .text
    global _start

print_newline:
    mov rax, 1                   ; Identificador do syscall 'write'
    mov rdi, 1                   ; Descritor de arquivo para stdout
    mov rsi, newline_char        ; De onde pegamos os dados
    mov rdx, 1                   ; Quantidade de bytes a escrever
    syscall
    ret

print_hex:
    mov rax, rdi
    mov rdi, 1
    mov rdx, 1
    mov rcx, 64
iterate:
    push rax
    sub rcx, 4
    sar rax, cl                  ; Quanto estamos deslocando rax?
    and rax, 0xf                 ; Limpa todos os bits, exceto os mais baixos
    lea rsi, [codes + rax]       ; Obter o código do caractere hexadecimal
    mov rax, 1
    push rcx
    syscall
    pop rcx
    pop rax
    test rcx, rcx                ; rcx = 0 quando todos os dígitos forem exibidos
    jnz iterate
    ret

_start:
    mov rdi, 0x1122334455667788
    call print_hex
    call print_newline
    mov rax, 60
    xor rdi, rdi
    syscall
