.MODEL small
.STACK 100h

.DATA
array DW 2 10 0 -2
count DW 4
oneChar DB ?
R DB ?                        ; Остача від ділення
Q DB ?                        ; Ціла частина від ділення
sum DW 0                     ; Сума елементів масиву для розрахунку середнього значення
buffer DB 6 DUP('$')        ; Буфер для конвертації числа в рядок
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
    lea si, array               ; Вказівник на початок масиву
    mov cx, count               ; Кількість елементів для обчислення
    xor dx, dx                  ; Очистка DX для використання в DIV
    xor ax, ax                  ; Очистка AX
sumLoop:
    mov ax, [si]                ; Додавання значення елемента до суми
    add sum, ax                 
    add si, 2                   ; Перехід до наступного елемента масиву
    loop sumLoop                ; Повторення циклу для всіх елементів

    div count                   ; AX / count, результат в AL, остача в AH
    mov Q, al                 ; Зберігання цілої частини
    mov R, ah                 ; Зберігання остачі

    ; Конвертація та виведення середнього значення
    mov ax, 0                 ; Очищення AX
    mov al, Q                 ; Завантаження цілої частини середнього значення
    mov bx, 10                ; Основа для конвертації
    mov cx, 0                 ; Лічильник цифр
    mov di, offset buffer + 5 ; DI вказує на кінець буфера
    mov byte ptr [di], '$'    ; Закінчуємо строку символом '$'
    convert_loop:
    dec di                    ; Зсув назад у буфері
    xor dx, dx                ; Очистка DX
    div bx                    ; Ділення AX на BX
    add dl, '0'               ; Конвертація остачі в ASCII
    mov [di], dl              ; Збереження символу
    inc cx                    ; Інкремент лічильника цифр
    test ax, ax               ; Перевірка, чи ще є цифри
    jnz convert_loop          ; Якщо так, продовжувати конвертацію

    ; Виведення рядка
    mov ah, 09h
    mov dx, di                ; Адреса початку числа для виведення
    int 21h                   ; Виводить число

    mov ax, sum
    cwd                      ; Конвертує слово в декс
    idiv count               ; Ділить AX на count, результат в AX, остача в DX

    mov Q, al                ; Зберігає цілу частину
    mov R, ah                ; Зберігає остачу

mov ax, 4c00h           ;вихід з програми
    int 21h
MAIN ENDP
END MAIN