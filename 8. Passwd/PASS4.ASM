;JOURNAL PROGRAM

;Title:- Program for Password verification

DISPLAY MACRO MSG
        LEA DX,MSG
        MOV AH,09H
        INT 21H
ENDM
    
DATA SEGMENT
        MSG1     DB 10,13,'Enter the Password...:-  $'
        MSG2     DB 10,13,'CORRECT PASSWORD...$'
        MSG3     DB 10,13,'WRONG PASSWORD!! Please Enter again..$'
        TEMP     DB ?
        PASSWORD DB 'KPA'
DATA ENDS

EXTRA SEGMENT
        KBDIN DB 3 DUP(0)    ;KBDIN is an array to store user entered passwd
EXTRA ENDS

CODE SEGMENT
        ASSUME CS:CODE,DS:DATA,ES:EXTRA

        MOV AX,DATA
        MOV DS,AX      ;Initialization of DS register
        MOV AX,EXTRA
        MOV ES,AX      ;Initialization of ES register i.e. ES register will
                       ;contain start address of EXTRA segment

   N1:  LEA DI,KBDIN
        MOV CX,03H

        DISPLAY MSG1    ;Ask the user to enter the passwd

   NEXT:MOV AH,07H      ;Read a character from kbd without echo
        INT 21H
        MOV TEMP,AL
        MOV DL,'*'      ;Accept the user entered passwd and 
        MOV AH,02H      ;display * instead of actual passwd
        INT 21H
        MOV AL,TEMP
        STOS KBDIN      ;Store the entered passwd in KBDIN
                        ;array in Extra segment
        LOOP NEXT

        MOV CX,03H
        LEA SI,PASSWORD
        LEA DI,KBDIN

        REP CMPSB       ;Comparing passwd with user entered passwd
        JNE ERROR
        
        DISPLAY MSG2    ;Display correct passwd message
        JMP LAST

   ERROR:DISPLAY MSG3   ;Display wrong passwd message and terminate the
         JMP N1         ;program only if user entered passwd is correct

   LAST:MOV AH,4CH      ;Terminating a program
        INT 21H
CODE ENDS
END

