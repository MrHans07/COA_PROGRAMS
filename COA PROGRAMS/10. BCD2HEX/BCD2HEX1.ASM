
;JOURNAL PROGRAM

;BCD TO HEX

;Title:- 2 Digit BCD to HEX

DISPLAY MACRO MSG
        LEA DX,MSG
        MOV AH,09H
        INT 21H
ENDM

DATA SEGMENT
        BUFFER         DB 02 DUP(0)
        MSG1           DB 13,10,"ENTER THE NUMBER........:- $"
        MSG2           DB 13,10,"INVALID ENTRY...$"
        MSG3           DB 13,10,"Equivalent HEX number is:- $"
        HEX_CHART      DB '0123456789ABCDEF'
        STORE_RESULT   DB ?
        H_ATTACH       DB 'H'
DATA ENDS

CODE SEGMENT
        ASSUME CS:CODE,DS:DATA

        MOV AX,DATA
        MOV DS,AX

        DISPLAY MSG1
                
        MOV BX,00
        CALL KBD_INPUT     ;To read most significant digit of input from kbd 
        CALL KBD_INPUT     ;To read least significant digit of input from kbd 

        MOV BX,00
        MOV AL,BUFFER[BX]
        MOV DH,BUFFER[BX+1]
       
        MOV BH,0AH
        MUL BH                 ; AX = BH * AL
        ADD AL,DH              
        MOV STORE_RESULT,AL

        DISPLAY MSG3

        MOV AL,STORE_RESULT
        AND AL,0F0H
        MOV CL,04
        ROR AL,CL
        CALL DISP_CHAR
        
        MOV AL,STORE_RESULT
        AND AL,0FH
        CALL DISP_CHAR

        MOV DL,H_ATTACH
        MOV AH,02H
        INT 21H
        JMP LAST

      KBD_INPUT PROC NEAR        ; Defining near procedure to read input from
                                 ; kbd for valid range (0 to 9)
         MOV AH,01H
         INT 21H
         CMP AL,'0'
         JB ERROR
         CMP AL,'9'
         JA ERROR
         AND AL,0FH
         MOV BUFFER[BX],AL
         INC BX
         RET
         ERROR:DISPLAY MSG2
         JMP LAST
      KBD_INPUT ENDP

      DISP_CHAR PROC NEAR        ;Defining near procedure to display a charcater
         MOV BX,00H
         MOV BL,AL
         MOV DL,HEX_CHART[BX]
         MOV AH,02H
         INT 21H
         RET
      DISP_CHAR ENDP

      LAST:MOV AH,4CH            ;To treminate a program
      INT 21H
CODE ENDS
END





              
