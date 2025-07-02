ORG 100h              ; Indica que el código comienza en 100h (programa .COM)

SECTION .text         ; Sección de código ejecutable

; Inicializamos registros AX y BX con cero
XOR AX, AX            ; AX = 0 (borrar contenido previo)
XOR BX, BX            ; BX = 0

MOV AX, 1d            ; AX = 1 (valor inicial para factorial acumulado)
MOV BX, 3d            ; BX = 3 (calcularemos 3! = 3 * 2 * 1)

main:
    CALL fact         ; Llamamos a la subrutina fact (factorial)
    INT 20h           ; Finaliza el programa en DOS

; -------------------------------
; Subrutina fact
; Multiplica AX por BX y luego llama a comparation
fact:
    MUL BX            ; AX = AX * BX (inicialmente AX = 1, BX = 3 → AX = 3)
    CALL comparation  ; Verifica si ya terminamos o seguimos
    RET

; -------------------------------
; Subrutina comparation
; Compara BX con 1. Si BX == 1, termina. Si no, decrementa y repite.
comparation:
    CMP BX, 1         ; ¿BX == 1?
    JE end            ; Si sí, saltamos a la subrutina end
    CALL decre        ; Si no, decrementamos BX (ej: 3 → 2)
    JMP fact          ; Repetimos el proceso de multiplicar
    RET               ; No se alcanza por el JMP, pero se deja por claridad

; -------------------------------
; Subrutina decre
; Decrementa el valor de BX en 1
decre:
    DEC BX            ; BX = BX - 1
    RET

; -------------------------------
; Subrutina end
; Guarda el resultado final del factorial en la dirección de memoria 0200h
end:
    MOV [0200h], AX   ; Guarda el resultado del factorial en la memoria (offset 200h)
    RET
