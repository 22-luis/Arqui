; Programa en modo gráfico 640x480, 16 colores (modo 12h)
; Dibuja un rectángulo blanco desde (320,240) hasta (490,290)

ORG 100h               ; Dirección base para programas .COM

SECTION .text

main:
    CALL SetVideoMode  ; Cambiar a modo gráfico 640x480x16 colores
    CALL SetLength     ; Inicializar el ancho del rectángulo

    MOV DX, 240D       ; Fila de inicio (Y inicial)
    MOV CX, 320D       ; Columna de inicio (X inicial)
    CALL MakeRectangle ; Llama a la función recursiva para dibujar

    INT 20h            ; Finaliza el programa

; -------------------------------
SetVideoMode:
    MOV AH, 00h        ; Función 0: cambiar modo de video
    MOV AL, 12h        ; Modo 12h: 640x480, 16 colores
    INT 10h
    RET

; -------------------------------
SetLength:
    MOV DI, 490D       ; DI = X final (ancho del rectángulo)
    RET

; -------------------------------
MakeRectangle:
    INC DX             ; Avanza una fila hacia abajo (Y++)
    CMP DX, 290D       ; Si llegamos a la fila 290, terminar
    JE end

    CALL SetLength     ; Restablece DI (ancho final en X)
    MOV CX, 320D       ; Reinicia CX (X inicial)

    CALL MakeLine      ; Dibuja una línea horizontal (una fila)
    CALL MakeRectangle ; Repite para la siguiente fila

    RET

; -------------------------------
MakeLine:
    INC CX             ; Avanza en la columna (X++)
    CALL ColorPixel    ; Dibuja un píxel en (CX, DX)
    CMP CX, DI         ; ¿Llegamos al final de la línea?
    JE RET_LINE
    CALL MakeLine      ; Si no, sigue dibujando la línea
RET_LINE:
    RET

; -------------------------------
ColorPixel:
    MOV AH, 0Ch        ; Función: dibujar píxel
    MOV AL, 0Fh        ; Color blanco (15)
    MOV BH, 00h        ; Página de video 0
    ; CX = coordenada X
    ; DX = coordenada Y
    INT 10h
    RET

; -------------------------------
end:
    INT 20h            ; Termina el programa
