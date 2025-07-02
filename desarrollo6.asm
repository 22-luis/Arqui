ORG 100h
 
SECTION .text
setup:
  XOR AX, AX
  XOR BX, BX
  XOR CX, CX
  XOR DX, DX
 
  MOV SI, 90d ; columna -> x
  MOV DI, 70d ; fila -> y
main:
  CALL IniciarModoVideo
  CALL DibujarRectangulo
  CALL EsperarTecla
  INT 20h
 
EsperarTecla:
  MOV AH, 00h
  INT 16h
  RET
 
IniciarModoVideo:       ;int 10h / 00h
;Argumentos de entrada:
;AH:	00h
;AL:  04H -> Modo gráfico. 320p x 200p. 4 colores
;     0DH -> Modo gráfico. 320p x 200p. 16 colores
;     0EH -> Modo gráfico. 640p x 200p. 16 colores
;     10H -> Modo gráfico. 640p x 350p. 16 colores
;     11H -> Modo gráfico. 640p x 480p. 2 colores
;     12H -> Modo gráfico. 640p x 480p. 16 colores
;     13h → Modo gráfico. 40 columnas por 25 filas. 256 colores. 320p x 200p.
  MOV     AH, 0h
  MOV     AL, 12h
  INT     10h
  RET
 
DibujarRectangulo: 
  MOV AH, 0Ch ; interrupcion para encender un pixel
  MOV AL, 04d ; color rojo
  MOV BH, 0d  ; pagina 0
  MOV CX, SI   ; coordenada x
  MOV DX, DI  ; coordenada y
  INT 10h
 
  INC SI ;incrementar la columna
  CMP SI, 190d ; verificar si llegó al limite de columnas
  JNE DibujarRectangulo
 
  INC DI ;incrementar la fila
  MOV SI, 90d ; reiniciar columna inicial
  CMP DI, 120d ; verificar si llegó al limite de filas
  JNE DibujarRectangulo
 
  RET