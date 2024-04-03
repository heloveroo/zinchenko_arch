.MODEL small
.STACK 100h

.DATA
array DW 2 10 0 -2
count DW 4
.CODE
MAIN PROC
    mov ah, 02h
    mov dl, '0'
    int 21        ;виведення символів в stdin
    read_next:
    mov ah, 3Fh
    mov bx, 0h  ; stdin 
    mov cx, 1   ; 1 байт на читання
    mov dx, offset oneChar   ; читання  ds:dx 
    int 21h   ;  ax = число прочитаних байтів
    or ax,ax
    jnz read_next



MAIN ENDP
END MAIN