org 100h         ; Inicio del programa .COM

mov cx, 11       ; Repetir 10 veces
mov bl, 1        ; Número a sumar (de 1 a 10)
mov ax, 0        ; Acumulador para la suma

suma:
    add ax, bx   ; Suma acumulada += bl
    inc bl       ; Aumentar el número a sumar (1, 2, 3, ...)
    loop suma    ; CX-- y salta si CX ≠ 0

; Guardar el resultado de AX en memoria: 0200h = AL, 0201h = AH
mov [0200h], al   ; Byte bajo de la suma
mov [0201h], ah   ; Byte alto de la suma

int 20h
