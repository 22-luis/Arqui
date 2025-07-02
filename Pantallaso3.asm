ORG 100h               ; Indica que el programa .COM empieza en la dirección 100h

SECTION .text          ; Comienza la sección de código ejecutable

; Limpieza de registros (no todos son necesarios aquí)
XOR AX, AX             ; AX = 0
XOR BX, BX             ; BX = 0
XOR AX, AX             ; Redundante: AX ya fue puesto a 0
XOR DX, DX             ; DX = 0

; Inicializar modo video y dirección del texto
call setVideo          ; Cambia a modo texto 80x25
CALL setText           ; BP = dirección donde empieza el texto

; Configurar posición de texto inicial
MOV DL, 35D            ; DL = 35 (columna inicial)
MOV BL, 72H            ; BL = 0x72 → atributo de color

CALL writeName         ; Llamamos a la rutina que imprimirá el texto

INT 20H                ; Termina el programa en DOS

; --------------------------------------
setText:               ; Inicializa puntero base al texto
    MOV BP, 200H       ; Dirección donde estará el texto a mostrar
    RET

; --------------------------------------
setVideo:              ; Cambia a modo video de texto (modo 3)
    MOV AH, 00H        ; Función 0 de video BIOS
    MOV AL, 03H        ; Modo 3 = texto 80x25
    INT 10H
    RET

; --------------------------------------
writeText:             ; Escribe un carácter desde [BP] en pantalla
    MOV AH, 09H        ; Función 9: escribir carácter con atributo
    MOV AL, [BP]       ; AL = carácter en la dirección actual de BP
    MOV BH, 00H        ; Página 0 de video
    MOV CX, 01H        ; Solo imprimir una vez
    INC BL             ; Incrementa color (BL) para cambiar el atributo
    INT 10H            ; Llamada a BIOS para imprimir
    INC BP             ; Avanzar al siguiente carácter
    RET

; --------------------------------------
positionText:          ; Mueve el cursor a la posición deseada
    MOV AH, 02H        ; Función 2: colocar cursor
    MOV BH, 00H        ; Página 0
    MOV DH, 10D        ; Fila fija: línea 10
    INT 10h
    INC DL             ; Avanza la columna (horizontalmente)
    RET

; --------------------------------------
writeName:             ; Imprime una cadena carácter por carácter
    call positionText  ; Mueve el cursor a la posición actual
    call writeText     ; Imprime el carácter desde [BP]

    ; Comparar si llegamos al final del texto (busca NULL)
    MOV CX, 00H
    CMP [BP-1], CX     ; Compara el carácter anterior con 0 (fin de cadena)
    JE end             ; Si es 0, terminamos

    ; Guardar el conteo en [199h]
    MOV CL, 01D
    MOV CH, [199H]     ; CH = cantidad parcial
    ADD CH, CL         ; CH += 1
    MOV [199H], CH     ; Guardar nuevo valor

    CALL writeName     ; Llamada recursiva para el siguiente carácter

; --------------------------------------
end:
    MOV BP, 200H       ; Regresar a inicio del texto
    MOV CX, [199H]     ; Recuperar cantidad de letras leídas

    CALL reset         ; Borra los datos de la cadena
    INT 20H            ; Terminar

; --------------------------------------
reset:
    MOV byte[BP], 00H  ; Borra el carácter en BP
    INC BP             ; Avanza a siguiente byte
    LOOP reset         ; Repite hasta que CX llegue a 0
    RET
