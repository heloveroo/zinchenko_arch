.MODEL small
.STACK 100h

.DATA
sourceFilename  DB 'array.txt',0       ; Назва файлу-джерела
targetFilename  DB 'resultreadingasm.txt',0       ; Назва цільового файлу
buffer          DB 100 DUP (?)          ; Буфер для зберігання даних
readBytes       DW ?                    ; Кількість байтів, які було прочитано
sourceHandle    DW ?                    ; Дескриптор файлу-джерела
targetHandle    DW ?                    ; Дескриптор цільового файлу
error           DB "Error", '$'

.CODE
MAIN PROC
    ; Відкриття файлу-джерела
    mov ah, 3Dh
    mov al, 0                       ; Режим читання
    lea dx, sourceFilename
    int 21h
    mov sourceHandle, ax            ; Зберігання дескриптора файлу-джерела

    ; Створення або відкриття цільового файлу
    mov ah, 3Ch
    mov cx, 0                       ; Атрибути файлу
    lea dx, targetFilename
    int 21h
    mov targetHandle, ax            ; Зберігання дескриптора цільового файлу

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