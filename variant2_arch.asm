.MODEL small
.STACK 100h

.DATA
array DW 2 10 0 -2
count DW 4

.CODE
MAIN PROC
    ; Відкриття файлу-джерела
    mov ah, 02h
    mov dl, '0'
    int 21h
    mov ah, 3Fh
    mov bx, 0h  ; stdin handle
    mov cx, 1   ; 1 byte to read
    mov dx, offset oneChar   ; read to ds:dx 
    int 21h   ;  ax = number of bytes read
    ; do something with [oneChar]
    or ax,ax
    jnz read_next
    ; Створення або відкриття цільового файлу
    mov ah, 3Ch
    mov cx, 0                       ; Атрибути файлу
    lea dx, targetFilename
    int 21h
    mov targetHandle, ax            ; Зберігання дескриптора цільового файлу
    mov ax, 7FFFh
    add ax, 0FFFh
    ;середнє значення 16біт 
    xor dx,dx       ; DX - 32-bit hi-word
    mov ax, 7FFFh   ; AX - 32-bit lo-word
    add ax, 7FFFh   ; add 16bit signed value
    adc dx, 0       ; note that OF=0! 
    ; Читання з файлу-джерела і запис у цільовий файл
    
read_loop:
    mov ah, 3Fh
    mov bx, sourceHandle
    lea dx, buffer
    mov cx, 100
    int 21h
    mov readBytes, ax               ; Кількість прочитаних байтів
    or ax, ax
    jz close_files                  ; Закриття файлів, якщо досягнуто кінця файлу або помилка

    ; Запис у цільовий файл
    mov ah, 40h
    mov bx, targetHandle
    lea dx, buffer
    mov cx, readBytes
    int 21h
    jmp read_loop                   ; Продовження читання і запису
    ; Перевірка, чи число більше 32767
    cmp ax, 32767
    jg set_max
    cmp ax, -32768
    jl set_min
    jmp next_part
    set_max:
    mov ax, 32767
    jmp next_part
    set_min:
    mov ax, -32768
    next_part:

close_files:
    ; Закриття файлу-джерела
    mov ah, 3Eh
    mov bx, sourceHandle
    int 21h

    ; Закриття цільового файлу
    mov ah, 3Eh
    mov bx, targetHandle
    int 21h
    ; Завершення програми і повернення в DOS
    mov ax, 4C00h
    int 21h

MAIN ENDP
END MAIN