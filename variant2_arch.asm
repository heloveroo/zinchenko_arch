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
    

MAIN ENDP
END MAIN