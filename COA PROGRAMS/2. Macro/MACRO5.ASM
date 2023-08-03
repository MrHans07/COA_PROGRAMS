
;Journal Program

;Title:- Program using MACRO.
;Aim :- Write 8086 Assembly Language Program to display
       ;personal information using MACRO.
;Name: -
;Roll No:-
;Class :- SE A/B Computer
;-----------------------------------------------------------------


DISPLAY MACRO MSG               ;Defining a Macro, to display a string
        LEA DX,MSG				
        MOV AH,09H
        INT 21H
ENDM

DATA SEGMENT
        MSG1 DB 10,13, "**************************************** $"
        MSG2 DB 10,13, "NAME    :- K.P.ADHIYA       $"
        MSG3 DB 10,13, "ROLL NO :-                  $"
        MSG4 DB 10,13, "CLASS   :-                  $"
        MSG5 DB 10,13, "COLLEGE :-                  $"
        MSG6 DB 10,13, "**************************************** $"
DATA ENDS

CODE SEGMENT
        ASSUME CS:CODE ,DS:DATA

        MOV AX,DATA       ;Store start address of data segment in AX register
        MOV DS,AX         ;Initializing DS register, i.e. DS register contains
                          ;start address of data segment
                    
        DISPLAY MSG1      ;Calling a Macro to display string, and
        DISPLAY MSG2      ;passing parameters to a Macro
        DISPLAY MSG3                    
        DISPLAY MSG4                    
        DISPLAY MSG5                    
        DISPLAY MSG6                    
        
        MOV AH,4CH        ;Terminate the program and rteurn back to OS
        INT 21H

CODE ENDS
END


