;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Karam Shanti
; Email: kshan016@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: B21
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------


GETC
OUT
AND R1, R1, x0
ADD R1, R1, R0

LD R0, linefeed
OUT

GETC
OUT
AND R2, R2, x0
ADD R2, R2, R0


LD R0, linefeed
OUT

AND R0, R0, x0
ADD R0, R0, R1
OUT

LD R0, space
OUT

LD R0, minus
OUT

LD R0, space
OUT


AND R0, R0, x0
ADD R0, R0, R2
OUT

LD R0, space
OUT

LD R0, equal
OUT

LD R0, space
OUT

;-----------------------------------------------
LD R3, subtract
NOT R3, R3
ADD R3, R3, #1

ADD R1, R1, R3
ADD R2, R2, R3

NOT R2, R2
ADD R2, R2, #1

AND R6, R6, x0
ADD R6, R6, R1
ADD R6, R6, R2
BRzp DO_WHILE

NOT R6, R6
ADD R6, R6, #1

LD R0, minus
OUT

LD R5, addition
ADD R6, R6, R5

AND R0, R0, x0
ADD R0, R0, R6
OUT

LD R0, linefeed
OUT

HALT

DO_WHILE

LD R5, addition
ADD R6, R6, R5
AND R0, R0, x0
ADD R0, R0, R6
OUT

LD R0, linefeed
OUT


HALT                ; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL 0x0A	; newline character - use with LD followed by OUT

plus    .FILL   x2B
space   .FILL   x20
equal   .FILL   x3D
linefeed    .FILL   xA
minus   .FILL   x2D

subtract .FILL x30
addition .FILL x30
;---------------	
;END of PROGRAM
;---------------	
.END

