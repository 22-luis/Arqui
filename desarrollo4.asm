ORG 100h              ; Programa tipo .COM que inicia en la dirección 100h

SECTION .text         ; Comienza la sección de código

; Inicializar registros con XOR (técnica común para ponerlos en 0)
XOR AX, AX            ; Pone AX en 0 (AX = 0)
XOR BX, BX            ; Pone BX en 0

; Asignar valores a AX y BX
MOV AX, 5d            ; AX = 5 (valor base)
MOV BX, 13d           ; BX = 13 (valor a sumar)

main:
    CALL addition     ; Llama a la subrutina que suma AX + BX
    CALL comparation  ; Llama a subrutina que sigue sumando de 5 en 5 hasta que AX > 20
    INT 20h           ; Finaliza el programa en DOS

; -------------------------
; Subrutina comparation
; Compara AX con 20 y si es menor o igual, suma 5 y repite
comparation:
    CMP AX, 20d       ; Compara AX con 20 decimal
    JA end            ; Si AX > 20, salta a 'end'
    CALL addfive      ; Si no, llama a la subrutina que suma 5
    JMP comparation   ; Vuelve a comparar (ciclo)
    RET               ; Esta línea no se ejecuta, porque JMP no regresa aquí

; -------------------------
; Subrutina addfive
; Suma 5 al valor actual de AX
addfive:
    ADD AX, 5d        ; AX = AX + 5
    RET

; -------------------------
; Subrutina addition
; Suma los valores originales AX y BX
addition:
    ADD AX, BX        ; AX = AX + BX (AX = 5 + 13 = 18 inicialmente)
    RET

; -------------------------
; Subrutina end
; Escribe "end" en memoria a partir de la dirección 200h
end:
    MOV byte[200h], 'e' ; Guarda la letra 'e' en dirección 200h
    MOV byte[201h], 'n' ; Guarda la letra 'n' en 201h
    MOV byte[202h], 'd' ; Guarda la letra 'd' en 202h
    RET                 ; Regresa (aunque ya no se usa después)
