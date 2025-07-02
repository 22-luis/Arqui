ORG 100h

SECTION .text

setup:
    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX

    MOV SI, 160     ; Centro horizontal (x)
    MOV DI, 50      ; Fila inicial (parte superior del triángulo)
main:
    CALL IniciarModoVideo
    CALL DibujarTriangulo
    CALL EsperarTecla
    INT 20h

EsperarTecla:
    MOV AH, 00h
    INT 16h
    RET

IniciarModoVideo:
    MOV AH, 0h
    MOV AL, 12h     ; Modo gráfico 640x480 16 colores
    INT 10h
    RET

DibujarTriangulo:
    MOV BP, 50      ; Ancho inicial del triángulo (la mitad de la base total)
sig:
    MOV CX, SI
    SUB CX, BP      ; columna izquierda
    MOV BX, BP      ; ancho hacia la derecha

fila:
    MOV AH, 0Ch
    MOV AL, 04h     ; color rojo
    MOV BH, 0
    MOV DX, DI
    INT 10h
    INC CX
    DEC BX
    JNS fila   ; dibujar hasta que BX < 0

    INC DI          ; siguiente fila
    DEC BP          ; disminuir ancho
    CMP BP, 0
    JNS sig   ; seguir mientras BP >= 0

    RET
