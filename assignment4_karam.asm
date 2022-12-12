;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Karam Shanti
; Email: kshan016@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================
.ORIG x3000

START
LD R0, introPromptPtr
PUTS

AND R4, R4, x0; Where we're storing the user inputted values
AND R5, R5, x0; Pos / Neg sign flag

LD R6, value_counter ; R6 will count how many values are left as the program runs (max 5)

;=====================================================================================================

    GETC
    OUT
    LD R2, newline
    ADD R1, R0, R2
    BRz Terminate
    
    LD R2, minus
    ADD R1, R0, R2
    BRz Flag_Checker
    
    LD R2, plus
    ADD R1, R0, R2
    BRz MAIN_LOOP
    
    LD R2, HEXA_48
    ADD R1, R0, R2
    BRn First_Error
    
    LD R2, HEXA_57
    ADD R1, R0, R2
    BRp First_Error
    BR Storer

;=====================================================================================================

First_Error
    LD R0, errorMessagePtr
    PUTS
    BRnzp First_Error2

First_Error2
    LD R0, linefeed
    OUT
    BRnzp START
    
Flag_Checker
    ADD R5, R5, #1
    BRnzp MAIN_LOOP
    
 Storer
 ADD R0, R0, #-16
 ADD R0, R0, #-16
 ADD R0, R0, #-16
 ADD R4, R4, R0
 ADD R6, R6, #-1

;=====================================================================================================

MAIN_LOOP; Meant for when values have to be reset
SAVED_LOOP; Meant for non terminated values

    GETC
    OUT
    LD R2, newline
    ADD R1, R0, R2
    BRz Sign_Checker
    
    AND R3, R3, x0
    ADD R3, R4, #0
    LD R7, Loop_Counter
    FOR_LOOP
    ADD R4, R4, R3
    ADD R7, R7, #-1
    BRp FOR_LOOP
    
    LD R2, HEXA_48
    ADD R1, R0, R2
    BRn Second_Error
    
    LD R2, HEXA_57
    ADD R1, R0, R2
    BRp Second_Error
    
    ADD R0, R0, #-16
    ADD R0, R0, #-16
    ADD R0, R0, #-16
    ADD R4, R4, R0
    ADD R6, R6, #-1
    BRp SAVED_LOOP
    BR Sign_Checker
    
;=====================================================================================================

Second_Error
    LD R0, linefeed
    OUT
    BRnzp First_Error2

Second_Error2
    LD R0, errorMessagePtr
    PUTS
 BRnzp START

Sign_Checker
ADD R5, R5, #-1
BRnp END_PROGRAM
NOT R4, R4
ADD R4, R4, #1
    
END_PROGRAM
LD R0, linefeed
OUT

Terminate
HALT

;=====================================================================================================

introPromptPtr .FILL xB000
errorMessagePtr .FILL xB200

newline .FILL x-A
minus .FILL x-2D
plus .FILL x-2B
linefeed .FILL xA
HEXA_57 .FILL x-39
HEXA_48 .FILL x-30
value_counter .FILL #5
Loop_Counter    .FILL #9

.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt
.STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 ; error message
.STRINGZ	 "ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
