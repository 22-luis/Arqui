ORG 100h

SECTION .text

main:
    CALL SetVideoMode

    ; ----- Triángulo inferior (grande) -----
    MOV SI, 320       ; Centro en X
    MOV DI, 120       ; Fila inicial (Y)
    MOV BP, 60        ; Ancho (media base)
    MOV AL, 2         ; Color verde oscuro
    CALL DrawTriangle

    ; ----- Triángulo medio -----
    MOV SI, 320
    MOV DI, 90
    MOV BP, 40
    MOV AL, 2
    CALL DrawTriangle

    ; ----- Triángulo superior (pequeño) -----
    MOV SI, 320
    MOV DI, 65
    MOV BP, 25
    MOV AL, 2
    CALL DrawTriangle

    ; ----- Tronco (rectángulo marrón) -----
    MOV DX, 150       ; Fila inicial
    MOV CX, 300       ; Columna inicial
    MOV DI, 340       ; Columna final
    MOV AL, 6         ; Color marrón
    CALL DrawRectangle

    ; Esperar tecla antes de salir
    CALL WaitKey
    INT 20h


; ---------------------------
SetVideoMode:
    MOV AH, 00h
    MOV AL, 12h       ; Modo gráfico 640x480 16 colores
    INT 10h
    RET

; ---------------------------
WaitKey:
    MOV AH, 00h
    INT 16h
    RET

; ---------------------------
; Dibuja triángulo centrado en SI (X), desde DI (Y), ancho inicial BP
; Usa AL como color
DrawTriangle:
.triangle_loop:
    MOV CX, SI        ; CX = centro
    SUB CX, BP        ; CX = inicio de fila a la izquierda
    MOV BX, BP        ; BX = ancho hacia la derecha

.draw_line:
    MOV AH, 0Ch
    ; AL ya tiene el color
    MOV BH, 0
    MOV DX, DI        ; Y
    INT 10h
    INC CX
    DEC BX
    JNS .draw_line    ; Mientras BX >= 0

    INC DI            ; Y++
    DEC BP            ; Disminuye el ancho
    CMP BP, 0
    JNS .triangle_loop
    RET

; ---------------------------
; Dibuja rectángulo horizontal desde (CX, DX) hasta (DI, DX+30)
; AL contiene el color
DrawRectangle:
    MOV BX, DX        ; Guardar fila inicial

.rect_loop:
    MOV SI, CX        ; Columna inicial
.pixel_loop:
    MOV AH, 0Ch
    ; AL ya tiene color
    MOV BH, 0
    MOV DX, BX
    MOV CX, SI
    INT 10h
    INC SI
    CMP SI, DI
    JL .pixel_loop

    INC BX            ; Y++
    CMP BX, DX + 30   ; Alto del tronco: 30 píxeles
    JL .rect_loop
    RET
