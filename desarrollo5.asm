ORG 100h

SECTION .data
    msgMayor DB 'El digito es mayor que 5$'
    msgMenor DB 'El digito es menor que 5$'
    msgIgual DB 'El digito es igual que 5$'
    msgFin DB 'Fin del programa...$'
    ;lenght dv 4d <- variable numerica
    ;colors db 2Eh, 3Eh, 4Eh, 5Eh  <- definimos los colores
    ;MOC SI, 0d
    ;[colors+SI]

SECTION .text
 
    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX

main:
    ;iniciar modo texto
    CALL IniciarModoTexto

    ;Centrar cursor
    MOV BH, 0d ;pagina de video
    CALL CentrarCursor

    ;Mostrar resultado de comparacion
    CALL CompararNumero

    ;Esperar tecla
    CALL EsperarTecla

    ;Cambiar a la pagina 1
    MOV AL, 01h
    CALL CambiarPagina

    ;Centrar cursor en pagina 1
    MOV BH, 1h
    CALL CentrarCursor

    ;Imprimir mensaje de fin
    CALL ImprimirFin

    ;Esperar tecla para salir
    CALL EsperarTecla


    INT 20h

ImprimirFin: ;21h/ 09h
    MOV AH, 09h
    MOV DX, msgFin
    INT 21h
    RET

IniciarModoTexto: ;INT 10h / 00h
    MOV AH, 00h
    MOV AL, 03h ;modo texto 80x25
    INT 10h
    RET

CentrarCursor: ;10h/ 02h
    MOV AH, 02h
    MOV DH, 12d 
    MOV DL, 30d
    INT 10h
    RET

CompararNumero:
    MOV AL, 12d
    CMP AL, 5d
    JA mayor
    JB menor
    JE igual

mayor: ;21h/09h
    MOV AH, 09h
    MOV DX, msgMayor
    INT 21h
    RET

menor: ;21h/09h
    MOV AH, 09h
    MOV DX, msgMenor
    INT 21h
    RET

igual: ;21h/09h
    MOV AH, 09h
    MOV DX, msgIgual
    INT 21h
    RET

EsperarTecla: ;16h/ 00h
    MOV AH, 00h
    INT 16h
    CMP AL, 'S'
    JNE EsperarTecla
    RET

CambiarPagina: ;10h/ 05h
    MOV AH, 05h
    INT 10h
    RET