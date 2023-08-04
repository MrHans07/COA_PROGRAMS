
;JOURNAL PROGRAM

;BCD Addition : To perform addition of two 8-bit BCD numbers.


DISPLAY MACRO MSG     
    LEA DX,MSG
    MOV AH,09H
    INT 21H
ENDM

DATA SEGMENT
    BUFFER        DB 04 DUP(0)
    MSG1          DB 10,13,"Enter first number :-  $"
    MSG2          DB 10,13,"Enter second number:-  $"
    MSG3          DB 10,13,"Addition is........:- $"
    MSG4          DB 10,13,"Invalid input.......$"
    CHART         DB '0123456789'
    STORE_RESULT  DB ?
    TEMP1         DB ?
    TEMP2         DB ?
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
    MOV AX,DATA
    MOV DS,AX

    DISPLAY MSG1
    MOV BX,00H
    CALL KBD_INPUT      ;To read most significant digit of first input number
    CALL KBD_INPUT      ;To read least significant digit of first input number

    DISPLAY MSG2
    CALL KBD_INPUT      ;To read most significant digit of second input number
    CALL KBD_INPUT      ;To read least significant digit of second input number

    MOV BX,00           ;Preparing first input
    MOV AL,BUFFER[BX]
    MOV CL,04
    ROR AL,CL
    MOV TEMP1,AL

    MOV DH,BUFFER[BX+1]
    ADD DH,TEMP1
    
    MOV AL,BUFFER[BX+2]   ;Preparing second input
    MOV CL,04
    ROR AL,CL
    MOV TEMP2,AL

    MOV AL,BUFFER[BX+3]
    ADD AL,TEMP2

    ADD AL,DH             ;Add two BCD inputs
    
    DAA                   ;Decimal Adjustment after Addition

    MOV STORE_RESULT,AL
    MOV CH,00H
    ADC CH,00H            ;Add carry 

    DISPLAY MSG3

    MOV AL,CH
    CALL DISP_CHAR        ;Call near procedure to display a carry

    MOV AL,STORE_RESULT
    MOV CL,04H
    AND AL,0F0H
    ROR AL,CL
    CALL DISP_CHAR        ;Call near procedure to display M.S. digit of result

    MOV AL,STORE_RESULT
    AND AL,0FH
    CALL DISP_CHAR        ;Call near procedure to display L.S. digit of result

    JMP LAST

  KBD_INPUT PROC NEAR     ;Defining near procedure to read input from kbd
     MOV AH,01H           ;for valid range (0 to 9)
     INT 21H
     CMP AL,'0'
     JB ERROR
     CMP AL,'9'
     JA ERROR
     AND AL,0FH
     MOV BUFFER[BX],AL
     INC BX
     RET
     ERROR:DISPLAY MSG4
     JMP LAST
  KBD_INPUT ENDP

  DISP_CHAR PROC NEAR      ;Defining near procedure to display a character
     MOV BX,00
     MOV BL,AL
     MOV DL,CHART[BX]
     MOV AH,02H
     INT 21H
     RET
  DISP_CHAR ENDP

  LAST:MOV AH,4CH          ;To terminate a program
       INT 21H
CODE ENDS
END
