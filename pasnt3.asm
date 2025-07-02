ORG 100h              ; Inicio de un programa .COM

SECTION .text

start:
    call setVideo     ; Cambiar a modo texto 80x25
    call clearScreen  ; (opcional) limpia pantalla
    
    MOV CX, 10        ; Cantidad de letras a imprimir (A a J)
    MOV AL, 'A'       ; Empezar con la letra 'A'
    MOV DH, 5         ; Empezar desde la fila 5
    MOV DL, 35        ; Columna donde imprimir (centrado)

print_loop:
    call setCursor    ; Colocar cursor en (DH, DL)
    call printChar    ; Imprimir letra actual

    INC AL            ; Pasar a siguiente letra
    INC DH            ; Mover cursor a fila siguiente
    LOOP print_loop   ; Repetir hasta que CX llegue a 0

    INT 20h           ; Terminar programa DOS

; ---------------------------
setVideo:             ; Modo texto 80x25
    MOV AH, 0
    MOV AL, 3
    INT 10h
    RET

; ---------------------------
clearScreen:
    MOV AH, 0
    MOV AL, 3
    INT 10h
    RET

; ---------------------------
setCursor:            ; Posiciona el cursor en (DH, DL)
    MOV AH, 2
    MOV BH, 0
    INT 10h
    RET

; ---------------------------
printChar:            ; Imprime AL en pantalla con color fijo
    MOV AH, 9
    MOV BH, 0
    MOV BL, 0x1F       ; Color: blanco brillante sobre azul
    MOV CX, 1
    INT 10h
    RET
