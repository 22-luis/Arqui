ORG 100h
SECTION .text

main:
    CALL SetVideoMode

    ; Triángulo grande (inferior)
    MOV SI, 320      ; Centro horizontal
    MOV DI, 120      ; Fila inicial
    MOV BP, 60       ; Ancho (media base)
    MOV AL, 2        ; Color verde
    CALL DrawTriangle

    ; Triángulo mediano (medio)
    MOV SI, 320
    MOV DI, 90       ; Más arriba
    MOV BP, 40
    MOV AL, 2
    CALL DrawTriangle

    ; Triángulo pequeño (superior)
    MOV SI, 320
    MOV DI, 65
    MOV BP, 25
    MOV AL, 2
    CALL DrawTriangle

    CALL WaitKey
    INT 20h

SetVideoMode:
    MOV AH, 00h
    MOV AL, 12h
    INT 10h
    RET

WaitKey:
    MOV AH, 00h
    INT 16h
    RET

DrawTriangle:
TriangleLoop:
    MOV CX, SI
    SUB CX, BP        ; Posición inicio fila (izquierda)
    MOV BX, BP        ; Ancho hacia derecha

DrawLine:
    MOV AH, 0Ch
    MOV BH, 0
    MOV DX, DI
    INT 10h
    INC CX
    DEC BX
    JNS DrawLine      ; Mientras BX >= 0

    INC DI            ; Baja a la siguiente fila
    DEC BP            ; Disminuye el ancho
    CMP BP, 0
    JNS TriangleLoop
    RET
