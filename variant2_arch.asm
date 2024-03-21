.MODEL small
.STACK 100h

.DATA
oneChar DB ? ; Визначення змінної для зберігання одного символу

.CODE
MAIN PROC
;stdin
read_next:
    mov ah, 3Fh          ; Функція DOS для читання з файла
    mov bx, 0            ; Дескриптор stdin
    mov cx, 1            ; Читати 1 байт
    lea dx, oneChar      ; Вказівник на буфер для читання
    int 21h              ; Виклик DOS

    ; Перевірка на кінець файла або помилку
    or ax, ax
    jz finish            ; Якщо ax=0, кінець файла або помилка, завершуємо


    jmp read_next        ; Повторення циклу

finish:
    ; Завершення програми і повернення в DOS
    mov ax, 4C00h
    int 21h

MAIN ENDP
END MAIN