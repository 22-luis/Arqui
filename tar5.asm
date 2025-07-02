ORG 100h               ; Indica que es un programa .COM (inicia en 100h)

SECTION .text          ; Sección de código del programa

main:
    CALL IniciarModoTexto  ; Cambiar a modo texto 80x25 (pantalla estándar de texto)

    ; A continuación, vamos a centrar el cursor en distintas líneas
    ; y escribir una letra en cada una (l, u, i, s), formando "luis"

    ; Página de video = 0 (por defecto)
    MOV BH, 0d           

    ; Línea 30 de la pantalla (eje vertical Y)
    MOV DL, 30d
    CALL CentrarCursor

    ; Mostrar letra 'l'
    MOV AL, 'l'
    call writeText

    ; Línea 31
    MOV DL, 31d
    CALL CentrarCursor
    MOV AL, 'u'
    call writeText

    ; Línea 32
    MOV DL, 32d
    CALL CentrarCursor
    MOV AL, 'i'
    call writeText

    ; Línea 33
    MOV DL, 33d
    CALL CentrarCursor
    MOV AL, 's'
    call writeText

    ; Salir del programa
    INT 20h              ; Interrupción de DOS para terminar el programa

; -----------------------------
; Subrutina: IniciarModoTexto
; Pone la pantalla en modo texto 80x25 (modo 3)
IniciarModoTexto:
    MOV AH, 00h          ; Función 0 de video: cambiar modo
    MOV AL, 03h          ; Modo 3 = texto 80 columnas, 25 filas
    INT 10h              ; Interrupción de video BIOS
    RET

; -----------------------------
; Subrutina: CentrarCursor
; Pone el cursor en el centro horizontal (columna 40), y fila en DL
CentrarCursor:
    MOV AH, 02h          ; Función 2 de video: mover cursor
    MOV DH, 12d          ; DH = fila (Y), aquí se fuerza a 18 (esto podría ser error)
                         ; DL ya debe tener la columna
    INT 10h              ; Llama a BIOS para mover el cursor
    RET

; -----------------------------
; Subrutina: writeText
; Escribe el carácter que está en AL en la posición actual
writeText:
    MOV AH, 09h          ; Función 9: imprimir carácter con atributo
    MOV BH, 00h          ; Página de video 0
    MOV CX, 01h          ; Repetir 1 vez
    ADD BL, 12h          ; Modifica el atributo de color (esto parece un intento de poner color)
                         ; BL debería ser un atributo como 0x07 (blanco sobre negro), pero aquí no está claro
    INT 10h              ; Llamada a BIOS para imprimir el carácter
    INC BP               ; Aumenta BP, aunque no se usa luego (parece sobrante)
    RET
