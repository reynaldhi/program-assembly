section .data
    num1 db 3              ; Angka pertama
    num2 db 3               ; Angka kedua
    result db 0             ; Tempat untuk menyimpan hasil
    msg db "Hasil: ", 0     ; Pesan untuk output
    newline db 10, 0        ; Karakter newline

section .text
    global _start

_start:
    ; Penjumlahan
    mov al, [num1]          ; Memuat num1 ke register AL
    add al, [num2]          ; Menambahkan num2 ke AL
    mov [result], al        ; Menyimpan hasil penjumlahan
    call print_result        ; Menampilkan hasil penjumlahan

    ; Pengurangan
    mov al, [num1]          ; Memuat num1 ke register AL
    sub al, [num2]          ; Mengurangi num2 dari AL
    mov [result], al        ; Menyimpan hasil pengurangan
    call print_result        ; Menampilkan hasil pengurangan

    ; Perkalian
    mov al, [num1]          ; Memuat num1 ke register AL
    mov bl, [num2]          ; Memuat num2 ke register BL
    mul bl                  ; Mengalikan AL dengan BL, hasil di AL
    mov [result], al        ; Menyimpan hasil perkalian
    call print_result        ; Menampilkan hasil perkalian

    ; Pembagian
    mov al, [num1]          ; Memuat num1 ke register AL
    mov bl, [num2]          ; Memuat num2 ke register BL
    xor ah, ah              ; Mengatur AH ke 0 untuk pembagian
    div bl                  ; Membagi AX dengan BL, hasil di AL
    mov [result], al        ; Menyimpan hasil pembagian
    call print_result        ; Menampilkan hasil pembagian

    ; Keluar dari program
    mov eax, 1              ; Sistem panggilan untuk keluar
    xor ebx, ebx            ; Kode keluar 0
    int 0x80                ; Memanggil kernel

print_result:
    ; Menampilkan hasil
    mov eax, 4              ; syscall: write
    mov ebx, 1              ; file descriptor: stdout
    mov ecx, msg            ; pointer ke pesan
    mov edx, 8              ; panjang pesan
    int 0x80                ; panggil kernel

    ; Mengonversi hasil ke string
    mov al, [result]        ; Memuat hasil ke AL
    add al, '0'             ; Mengonversi ke karakter ASCII
    mov [result], al        ; Menyimpan karakter hasil

    ; Menampilkan hasil
    mov eax, 4              ; syscall: write
    mov ebx, 1              ; file descriptor: stdout
    mov ecx, result         ; pointer ke hasil
    mov edx, 1              ; panjang hasil (1 karakter)
    int 0x80                ; panggil kernel

    ; Menampilkan newline
    mov eax, 4              ; syscall: write
    mov ebx, 1              ; file descriptor: stdout
    mov ecx, newline        ; pointer ke newline
    mov edx, 1              ; panjang newline (1 karakter)
    int 0x80                ; panggil kernel

    ret                      ; Kembali dari fungsi