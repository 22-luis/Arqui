ORG 100h              ; Indica que el programa es .COM y empieza en dirección 100h

SECTION .text

setup:
    ; Limpieza de registros
    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX

    MOV SI, 160       ; Coordenada X central (mitad de 320 px de ancho útil del triángulo)
    MOV DI, 50        ; Coordenada Y inicial (fila superior del triángulo)

main:
    CALL IniciarModoVideo   ; Cambiar a modo gráfico 640x480 16 colores (modo 12h)
    CALL DibujarTriangulo   ; Llamar a la rutina que dibuja el triángulo
    CALL EsperarTecla       ; Esperar que el usuario presione una tecla
    INT 20h                 ; Salir del programa

; -------------------------------
EsperarTecla:
    MOV AH, 00h             ; Función 0 de INT 16h: esperar tecla
    INT 16h
    RET

; -------------------------------
IniciarModoVideo:
    MOV AH, 0h              ; Función 0 de video: cambiar modo
    MOV AL, 12h             ; Modo 12h = 640x480 16 colores
    INT 10h
    RET

; -------------------------------
DibujarTriangulo:
    MOV BP, 50              ; Ancho inicial del triángulo (media base)
                            ; Empieza dibujando desde -50 a +50 respecto al centro (total 100 px)

sig:                        ; Etiqueta para cada fila del triángulo
    MOV CX, SI              ; CX = centro horizontal
    SUB CX, BP              ; CX = coordenada X inicial para esta fila
                            ; Desde el lado izquierdo de la fila

    MOV BX, BP              ; BX controla cuántos píxeles dibujar hacia la derecha

fila:                       ; Bucle para dibujar una fila horizontal de color
    MOV AH, 0Ch             ; Función 0Ch: poner un píxel en pantalla
    MOV AL, 04h             ; AL = color (rojo)
    MOV BH, 0               ; Página de video
    MOV DX, DI              ; DX = coordenada Y (fila actual)
    INT 10h                 ; Dibujar píxel en (CX, DX)

    INC CX                  ; Avanza a la siguiente columna (derecha)
    DEC BX                  ; Decrementa contador de píxeles
    JNS fila                ; JNS = Jump if No Sign (BX >= 0), sigue dibujando fila

    INC DI                  ; Baja a la siguiente fila (vertical)
    DEC BP                  ; Reduce la anchura del triángulo
    CMP BP, 0               ; ¿Ya se acabó el ancho?
    JNS sig                 ; Si BP ≥ 0, sigue con la siguiente fila

    RET
