ORG 100h               ; Indica que es un programa .COM, empieza en 100h

SECTION .text

main:
    CALL SetVideoMode  ; Cambia al modo gráfico 640x480x16 colores (modo 12h)
    CALL SetParams     ; Inicializa parámetros de dibujo
    CALL MakeTriangle  ; Dibuja el triángulo línea por línea
    INT 20h            ; Finaliza el programa en DOS

; --------------------------
SetVideoMode:
    MOV AH, 00h        ; Función 00h: cambiar modo de video
    MOV AL, 12h        ; Modo 12h: 640x480, 16 colores
    INT 10h
    RET

; --------------------------
SetParams:
    MOV CX, 60d        ; CX = fila de inicio (Y = 60)
    MOV DX, 60d        ; DX = columna de inicio (X = 60)
    MOV DI, 120d       ; DI = columna final (X = 120)
    RET

; --------------------------
MakeTriangle:
    MOV CX, 60d        ; Reinicia fila de inicio (X = 60)

    INC DX             ; DX: avanzar 1 fila abajo (Y++)
    DEC DI             ; DI: disminuir columna final (para crear forma triangular)

    CMP DX, 120d       ; Si la fila (Y) llega a 120 → terminamos
    JE end

    CALL DrawLine      ; Dibuja una línea horizontal de píxeles

    JNE MakeTriangle   ; Si aún no llegamos a 120, repetir

; --------------------------
DrawLine:
    CALL ColorPixel    ; Dibuja un solo píxel en (CX, DX)

    INC CX             ; Avanza una columna (X++)
    CMP CX, DI         ; ¿Ya llegamos a la columna final?
    JE MakeTriangle    ; Si sí, ir a la siguiente línea

    CALL DrawLine      ; Si no, seguir dibujando esta fila
    RET

; --------------------------
ColorPixel:
    MOV AH, 0Ch        ; Función para poner un píxel en modo gráfico
    MOV AL, 0Fh        ; AL = color (0Fh = blanco)
    MOV BH, 00h        ; Página de video 0
    ; CX = columna (X)
    ; DX = fila (Y)
    INT 10h
    RET

; --------------------------
end:
    INT 20h            ; Termina el programa
