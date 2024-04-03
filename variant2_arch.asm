.MODEL small
.STACK 100h

.DATA
array DW 2 10 0 -2
count DW 4
oneChar DB ?
R DB ?                        ; Остача від ділення
Q DB ?                        ; Ціла частина від ділення
sum DW 0                     ; Сума елементів масиву для розрахунку середнього значення
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
checkLoop:
    ; Перевірка на переповнення для кожного числа
    mov ax, [si]         ; Завантажує поточне число для перевірки
    cmp ax, 32767
    jle noOverflow       ; Якщо число <= 32767, переповнення немає
    mov [si], 32767      ; Встановлює максимально можливе значення
    jmp checkNext
noOverflow:
    cmp ax, -32768
    jge checkNext        ; Якщо число >= -32768, переповнення немає
    mov [si], -32768     ; Встановлює мінімально можливе значення

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

    ; Розрахунок середнього значення
    lea si, array
    mov cx, count
sumLoop:
    mov ax, [si]
    add sum, ax
    add si, 2
    loop sumLoop

    mov ax, sum
    cwd                      ; Конвертує слово в декс
    idiv count               ; Ділить AX на count, результат в AX, остача в DX

    mov Q, al                ; Зберігає цілу частину
    mov R, ah                ; Зберігає остачу

mov ax, 4c00h           ;вихід з програми
    int 21h
MAIN ENDP
END MAIN