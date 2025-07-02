ORG 100h

SECTION .text

main:
    CALL SetVideoMode
    CALL DrawHelloKitty
    CALL WaitKey
    INT 20h

SetVideoMode:
    MOV AH, 0
    MOV AL, 12h    ; 640x480 16 colores
    INT 10h
    RET

WaitKey:
    MOV AH, 0
    INT 16h
    RET

; Dibujar Hello Kitty pixel a pixel usando un arreglo (x,y,color)
DrawHelloKitty:
    MOV SI, HelloKittyData
    MOV CX, HelloKittyCount

DrawLoop:
    PUSH CX
    MOV AL, [SI]       ; X
    MOV AH, [SI+1]     ; Y
    MOV BL, [SI+2]     ; Color
    CALL DrawPixelXY
    ADD SI, 3
    POP CX
    LOOP DrawLoop
    RET

; Dibuja un pixel en (AL, AH) con color BL
DrawPixelXY:
    MOV CX, AX         ; CX = (AL,AH) para facilitar guardar
    MOV DX, AH         ; DX = Y
    MOV AH, 0Ch
    MOV AL, BL
    MOV BH, 0
    INT 10h
    RET

; Datos: X, Y, color
HelloKittyData:
    DB 310, 100, 15   ; Ojo izquierdo blanco (ejemplo)
    DB 330, 100, 15   ; Ojo derecho blanco
    DB 320, 120, 14   ; Nariz amarilla
    ; Añade más píxeles aquí para formar la figura
HelloKittyCount EQU ($ - HelloKittyData)/3
