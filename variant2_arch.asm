.model small
.stack 100h
.code
    start:
          mov ah, 4Ch    ; функція DOS для завершення програми
          mov al, 0      ; код повернення 0
          int 21h        ; виклик DOS інтерапту для завершення програми
    end start