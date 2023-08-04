
;JOURNAL PROGRAM

;TO GENERATE FIBONACCI SERIES

;Title:- To Generate Fibonacci Series ( First 12 Numbers )

DISPLAY_ZERO MACRO           ;Define macro to display 0
        MOV DL,'0'
        MOV AH,02H
        INT 21H
ENDM

DISPLAY_SPACE MACRO          ;Define macro to give space between digits
        MOV DL,' '
        MOV AH,02H
        INT 21H
ENDM

DATA SEGMENT
        NUMBER1             DB 00
        NUMBER2             DB 01
        CHART               DB '0123456789'
        QUOTIENT            DB ?
        REMAINDER           DB ?
        COUNTER             DW 000AH
DATA ENDS

CODE SEGMENT
        ASSUME CS:CODE,DS:DATA

        MOV AX,DATA               
        MOV DS,AX            ;Initialization of DS register

        MOV CX,COUNTER
                                    
        DISPLAY_ZERO         ; Call macro to display 0
        DISPLAY_ZERO         ; Call macro to display 0

        DISPLAY_SPACE        ; Call macro to give space between digits

        DISPLAY_ZERO         ; Call macro to display 0
        MOV AL,NUMBER2
        CALL DISP_CHAR       ; Call near procedure to display 1.

    N1: MOV AH,00
        MOV AL,NUMBER1
        ADD AL,NUMBER2
        MOV DH,AL
        MOV BH,10
        DIV BH               ; AX divided by BH. Quotient in AL
                             ; and Remainder in AH
        MOV QUOTIENT,AL
        MOV REMAINDER,AH

        DISPLAY_SPACE        ; Call macro to give space between digits

        MOV AL,QUOTIENT
        CALL DISP_CHAR       ; Call near procedure to display quotient

        MOV AL,REMAINDER
        CALL DISP_CHAR       ; Call near procedure to display remainder

        MOV AL,NUMBER2              
        MOV NUMBER1,AL
        MOV NUMBER2,DH              
        LOOP N1

        JMP LAST

    DISP_CHAR PROC NEAR      ; Defining near procedure to display a chracter
        MOV BX,00H
        MOV BL,AL
        MOV DL,CHART[BX]
        MOV AH,02H
        INT 21H
        RET
    DISP_CHAR ENDP

    LAST:MOV AH,4CH          ; To terminate a program
        INT 21H
CODE ENDS
END



