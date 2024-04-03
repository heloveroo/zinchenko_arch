.MODEL small
.STACK 100h

.DATA
array DW 2 10 0 -2
count DW 4
oneChar DB ?
.CODE
MAIN PROC
    mov ah, 02h
    mov dl, '0'
    int 21        ;виведення символів в stdin
    read_next:
    mov ah, 3Fh
    mov bx, 0h  ; stdin 
    mov cx, 1   ; 1 байт на читання
    lea dx, oneChar   ; читання  ds:dx 
    int 21h   ;  ax = число прочитаних байтів
    or ax,ax
    jnz read_next   ;повторити якщо було прочитано символ

checkOverflow:
    mov cx, count        ; Кількість чисел для перевірки
    lea si, array        ; Вказівник на початок масиву 
;початок бабл сорту
    mov cx, word ptr count; Завантажує кількість елементів у масиві до CX
    dec cx                ; Зменшує CX на 1

outerLoop:
    push cx               ; Зберігає значення CX на стеку
    lea si, array         ; Встановлює SI на початок масиву

innerLoop:
    mov ax, [si]
    cmp ax, [si+2]
    jl nextStep
    xchg ax, [si+2]
    mov [si], ax

nextStep:
    add si, 2
    loop innerLoop

    pop cx
    loop outerLoops

mov ax, 4c00h           ;вихід з програми
    int 21h
MAIN ENDP
END MAIN