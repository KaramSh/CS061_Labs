;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Karam Shanti
; Email: kshan016@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary 
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------


LD R4, Space_Counter ; The "Space Counter" is equal to #-4

ADD R1, R1, #0  ; R1 is equal to the value of the first thing in the pointer / or better understood as the first binary digit of the conversion from xABCD (1010) /  *1 is negative number in binary and 0 is positive*
BRn NEG_LOOP    ; This branch checks to see if the value of R1 is negative or not, if so it will travel to the NEG_CODE loop / if (R1 < 0) -> NEG_CODE, else LD R0, ZERO

LD R0, ZERO ; Load the decimal #0 into R0
OUT ; Print #0

LOOP	
    ADD R4, R4, #1  ; Add's #1 to the number of spaces used up
    BRzp END_LOOP   ; Looks for when R4 becomes zero or positive and if in the case it's not it will go to the loop titled END_LOOP

    ADD R1, R1, R1  ;Incerments to the next position of the pointer
    BRn NEG_LOOP    ;If value of current postion of pointer (R1) is not negative then it will go to the loop labeled NEG_LOOP

    LD R0, ZERO ; R0 is loaded with the value of ZERO which is #0
    OUT ;   Print #0
    BRp LOOP    ; Directly goes back to LOOP

NEG_LOOP    
	LD R0, ONE  ; Loads R0 with the value #1
	OUT ; Prints #1
	BRp LOOP    ; Directly goes back to LOOP
	
END_LOOP

;============================== Code above prints out the first 4 binary numbers of value =======================================================================
LD R0, space 
OUT 

LD R4, Space_Counter   
ADD R1, R1, R1  

ADD R1, R1, #0 
BRn NEG_LOOP_2  

LD R0, ZERO 
OUT 

LOOP_2
	ADD R4, R4, #1
	BRzp END_LOOP_2

	ADD R1, R1, R1
	BRn NEG_LOOP_2

	LD R0, ZERO
	OUT
	BRp LOOP_2


NEG_LOOP_2
		LD R0, ONE
		OUT
		BRp LOOP_2

END_LOOP_2

;============================== Code above prints out the next 4 binary numbers of value =======================================================================

LD R0, space
OUT

LD R4, Space_Counter
ADD R1, R1, R1

ADD R1, R1, #0
BRn NEG_LOOP_3

LD R0, ZERO
OUT

LOOP_3
	ADD R4, R4, #1
	BRzp END_LOOP_3

	ADD R1, R1, R1
	BRn NEG_LOOP_3

	LD R0, ZERO
	OUT
	BRp LOOP_3


NEG_LOOP_3
		LD R0, ONE
		OUT
		BRp LOOP_3

END_LOOP_3

;============================== Code above prints out the next 4 binary numbers of value =======================================================================

LD R0, space
OUT

LD R4, Space_Counter
ADD R1, R1, R1

ADD R1, R1, #0
BRn NEG_LOOP_4

LD R0, ZERO
OUT

LOOP_4
	ADD R4, R4, #1
	BRzp END_LOOP_4

	ADD R1, R1, R1
	BRn NEG_LOOP_4

	LD R0, ZERO
	OUT
	BRp LOOP_4


NEG_LOOP_4
		LD R0, ONE
		OUT
		BRp LOOP_4

END_LOOP_4

LD R0, Linefeed
OUT

;============================== END OF LOOPS =======================================================================


HALT
;---------------	
;Data
;---------------

Value_ptr	.FILL xCA01	; The address where value to be displayed is stored
Linefeed	.FILL		xA
space 		.FILL		x20

ONE		.FILL		x31 ; Ascii number 1
ZERO		.FILL		x30 ; ; Ascii number 0
Space_Counter		.FILL		#-4

.END

.ORIG xCA01					; Remote data
Value .FILL xABCD	; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.



;---------------	
;END of PROGRAM
;---------------	
.END