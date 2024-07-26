section .data
    message db 'Stack Pop: %d', 10, 0  ; Format string untuk output

section .bss
    num resq 1  ; Reserve space for a number (64-bit)

section .text
    global main
    extern printf
    extern exit

main:
    ; Push angka ke dalam stack
    mov rax, 10  ; Angka yang akan dipush
    push rax     ; Push ke stack

    mov rax, 20  ; Angka lain yang akan dipush
    push rax     ; Push ke stack

    ; Pop angka dari stack
    pop rax     ; Pop angka terakhir (20) ke rax
    mov [num], rax  ; Simpan ke variabel num

    ; Menampilkan hasil
    mov rdi, message  ; Push format string ke rdi
    mov rsi, [num]    ; Push nilai yang dipop ke rsi
    xor rax, rax      ; Clear rax (untuk memanggil printf)
    call printf      ; Panggil printf

    ; Keluar dari program
    mov eax, 60  ; syscall: exit
    xor edi, edi  ; status: 0
    syscall      ; panggil kernel
