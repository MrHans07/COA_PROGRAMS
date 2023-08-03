



;JOURNAL PROGRAM



;Addition of two 8-bit hex numbers using NEAR procedure

DATA SEGMENT
        NO1                 DB 12H
        NO2                 DB 35H
        HEX_CHART           DB '0123456789ABCDEF'
        STORE_ADDITION      DB ?
        H_ATTACH            DB 'H'
        MSG                 DB 'RESULT IS :- $'
DATA ENDS

CODE SEGMENT
        ASSUME CS:CODE,DS:DATA

        MOV AX,DATA
        MOV DS,AX               ;Initialization of DS register

        LEA DX,MSG
        MOV AH,09H
        INT 21H

        MOV AL,NO1
        ADD AL,NO2              ;Addition of two numbers. Result in AL register
        MOV AH,00H
        ADC AH,00H              ;Carry is stored in AH register
        MOV STORE_ADDITION,AL

        MOV AL,AH
        CALL DISP_CHAR          ;Call near procedure to display carry
          
        MOV AL,STORE_ADDITION
        AND AL,0F0H
        MOV CL,04H
        ROR AL,CL
        CALL DISP_CHAR          ;Call near procedure to display most 
                                ;significant digit of result
                                
        MOV AL,STORE_ADDITION
        AND AL,0FH
        CALL DISP_CHAR          ;Call near procedure to display least
                                ;significant digit of result

        MOV DL,H_ATTACH         ;To display H in result
        MOV AH,02H
        INT 21H

        JMP LAST

    DISP_CHAR PROC NEAR         ;To define near procedure for
                                ;displaying a character
        MOV BX,00H
        MOV BL,AL
        MOV DL,HEX_CHART[BX]
        MOV AH,02H
        INT 21H
        RET
    DISP_CHAR ENDP

    LAST:MOV AH,4CH             ;To terminate a program
        INT 21H
CODE ENDS
END





