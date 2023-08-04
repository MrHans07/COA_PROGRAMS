

;Journal Program
;Factorial of 8-bit hex number using Recursive Procedure
;(Range of Inpput 0 to 8 )

DATA SEGMENT
        NUMBER              DW 0004H
        HEX_CHART           DB '0123456789ABCDEF'
        LSB_OF_RESULT       DB ?
        MSB_OF_RESULT       DB ?
        H_ATTACH            DB 'H'
        MSG                 DB 'FACTORIAL IS :- $'
DATA ENDS

CODE SEGMENT
        ASSUME CS:CODE,DS:DATA

        MOV AX,DATA
        MOV DS,AX           ;Initialization of DS register

        LEA DX,MSG
        MOV AH,09H
        INT 21H

        MOV AX,NUMBER
        MOV CX,NUMBER
        CALL FACTORIAL      ;Calling a near procedure to calculate factorial
       
      EXIT:MOV MSB_OF_RESULT,AH
        MOV LSB_OF_RESULT,AL

        MOV AL,MSB_OF_RESULT
        AND AL,0F0H
        MOV CL,04H
        ROR AL,CL
        CALL DISP_CHAR      ;Calling a Near procedure to display
                            ;most significand digit of most significand byte

        MOV AL,MSB_OF_RESULT
        AND AL,0FH
        CALL DISP_CHAR      ;Calling a Near procedure to display
                            ;least significand digit of most significand byte    
          
        MOV AL,LSB_OF_RESULT
        AND AL,0F0H
        MOV CL,04H
        ROR AL,CL
        CALL DISP_CHAR      ;Calling a Near procedure to display
                            ;most significand digit of least significand byte

        MOV AL,LSB_OF_RESULT
        AND AL,0FH
        CALL DISP_CHAR      ;Calling a Near procedure to display
                            ;least significand digit of least significand byte

        MOV DL,H_ATTACH     ;Display H in result
        MOV AH,02H
        INT 21H

        JMP LAST

    FACTORIAL PROC NEAR       ;Defining a near procedure for factorial
        CMP CX,01
        JG N1
        MOV AX,01
        JMP EXIT
        N1:CALL CALCULATION   ;Calling other near procedure
        RET
    FACTORIAL ENDP

    CALCULATION PROC NEAR
        DEC CX
        MUL CX
        CMP CX,01
        JE EXIT
        CALL FACTORIAL        ;Indirect recursion
        RET
    CALCULATION ENDP
    
    DISP_CHAR PROC NEAR       ;Defining a near procedure to display a character
        MOV BX,00H
        MOV BL,AL
        MOV DL,HEX_CHART[BX]
        MOV AH,02H
        INT 21H
        RET
    DISP_CHAR ENDP

    LAST:MOV AH,4CH           ;Termination of a program
        INT 21H
CODE ENDS
END


