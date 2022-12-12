;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Karam Shanti
; Email: kshan016@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section:
; TA:
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================
.ORIG x3000

MENU
	LD R6, SUB_MENU 
	JSRR R6
END_MENU

ADD R1, R1, #-1
BRnp SUB1;=============================================

LD R6, SUB_ALL_MACHINES_BUSY
JSRR R6
	
ADD R2, R2, #0
BRp Totally_Busy

LEA R0, allnotbusy
PUTS
BR END_Totally_Busy

Totally_Busy
	LEA R0, allbusy
	PUTS
END_Totally_Busy
	
BR SUB_MENU
SUB1
ADD R1, R1, #-1
BRnp SUB2;=============================================
	

LD R6, SUB_ALL_MACHINES_FREE
JSRR R6
	
ADD R2, R2, #0
BRp Totally_Open

LEA R0, allnotfree
PUTS
BR END_Totally_Open
	
Totally_Open
	LEA R0, allfree
	PUTS
END_Totally_Open

BR SUB_MENU
SUB2
ADD R1, R1, #-1
BRnp SUB3;=============================================
	

LEA R0, busymachine1
PUTS

LD R6, SUB_NUM_BUSY_MACHINES
JSRR R6
	
LD R6, SUB_PRINT_NUM ;this is a sub-subroutine
JSRR R6
	
LEA R0, busymachine2
PUTS

BR SUB_MENU
SUB3
ADD R1, R1, #-1
BRnp SUB4;=============================================
	

LEA R0, freemachine1
PUTS
	
LD R6, SUB_NUM_FREE_MACHINES
JSRR R6
	
LD R6, SUB_PRINT_NUM
JSRR R6
	
LEA R0, freemachine2
PUTS

BR SUB_MENU
SUB4
ADD R1, R1, #-1
BRnp SUB5;=============================================
	

LD R6, SUB_MACHINE_NUM
JSRR R6
	
LD R6, SUB_MACHINE_STATUS
JSRR R6
	
LEA R0, status1
PUTS
	
LD R6, SUB_PRINT_NUM
JSRR R6
	
ADD R2, R2, #0
BRz Still_Busy

LEA R0, status3
PUTS
BR END_Still_Busy
	
Still_Busy
	LEA R0, status2
	PUTS
END_Still_Busy

BR SUB_MENU
SUB5
ADD R1, R1, #-1
BRnp SUB6;=============================================


LD R6, SUB_FIRST_FREE_NUM
JSRR R6
	
ADD R1, R1, #0
BRn Empty

LEA R0, firstfree1
PUTS

LD R6, SUB_PRINT_NUM
JSRR R6

LD R0, newline
OUT
BR END_Empty
	
Empty
	LEA R0, firstfree2
	PUTS
END_Empty
	
BR SUB_MENU
SUB6

LEA R0, goodbye
PUTS

HALT
;---------------	
;Data
;---------------
SUB_MENU              .FILL x3200
SUB_ALL_MACHINES_BUSY .FILL x3400
SUB_ALL_MACHINES_FREE .FILL x3600
SUB_NUM_BUSY_MACHINES .FILL x3800
SUB_NUM_FREE_MACHINES .FILL x4000
SUB_MACHINE_STATUS    .FILL x4200
SUB_FIRST_FREE_NUM    .FILL x4400
SUB_MACHINE_NUM       .FILL x4600
SUB_PRINT_NUM         .FILL x4800

newline 		.fill xA
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"

.END


; SUBROUTINES BELOW         
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW
; SUBROUTINES BELOW


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------

.ORIG x3200
	
ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R3, BACKUP_R3_3200
ST R4, BACKUP_R4_3200
ST R5, BACKUP_R5_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200
		
SUB1_MENU
	LD R0, Menu_string_addr; Loads the whole menue into R0
	PUTS; Prints it out
	GETC; Gets user input
	OUT; Outputs user input
	
	ADD R1, R0, #0  ; Left shifting
	ADD R1, R1, #-16; Left shifting
	ADD R1, R1, #-16; Left shifting
	ADD R1, R1, #-16; Left shifting
	
	LD R0, SUB1_LINE_FEED; Loads line feed
	OUT                ; Prints out line feed
		
		
	ADD R1, R1, #0
		BRnz Error; Checks to see if user inputted value is positive 
	ADD R1, R1, #-7
		BRp Error; Checks to see if user inputted value it bigger than our max range (7)
	ADD R1, R1, #7; Returns decimal seven back to user inputted value and stores value back into our return value R1
	BR END_Error
		
Error
	LEA R0, Error_msg_1; Loads error message
	PUTS; Prints out "INVALID INPUT\n"
	BR SUB1_MENU; Goes back to the top of the loop (PRINT_MENU)
END_Error


LD R0, BACKUP_R0_3200
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R4, BACKUP_R4_3200
LD R5, BACKUP_R5_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET; Goes back to the main program

;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x5000
SUB1_LINE_FEED .FILL xA

BACKUP_R0_3200 .BLKW #1
BACKUP_R1_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1

.END

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------

.ORIG x3400

ST R0, BACKUP_R0_3400
ST R1, BACKUP_R1_3400
ST R2, BACKUP_R2_3400
ST R3, BACKUP_R3_3400
ST R4, BACKUP_R4_3400
ST R5, BACKUP_R5_3400
ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400
		
AND R2, R2, x0
LD R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY; set's R0 to BUSYNESS inputted values
LDR R1, R0, #0; Loads the value of R0 into R1	
ADD R1, R1, #0; Checks to see if stored value is in the desired domain
BRnp Return_Zero
		
Return_One
	ADD R2, R2, #1; Returns 1 to main
	
	
Return_Zero
        ;Returns 0 to main

LD R0, BACKUP_R0_3400
LD R1, BACKUP_R1_3400
; Don't BACKUP R2 (return value)
LD R3, BACKUP_R3_3400
LD R4, BACKUP_R4_3400
LD R5, BACKUP_R5_3400
LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400

RET; Goes back to main program
		
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------

BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB600

BACKUP_R0_3400 .BLKW #1
BACKUP_R1_3400 .BLKW #1
BACKUP_R2_3400 .BLKW #1
BACKUP_R3_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
BACKUP_R6_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1

.END

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------

.ORIG x3600

ST R0, BACKUP_R0_3600
ST R1, BACKUP_R1_3600
ST R2, BACKUP_R2_3600
ST R3, BACKUP_R3_3600
ST R4, BACKUP_R4_3600
ST R5, BACKUP_R5_3600
ST R6, BACKUP_R6_3600
ST R7, BACKUP_R7_3600
		
AND R2, R2, x0
LD R0, BUSYNESS_ADDR_ALL_MACHINES_FREE
LDR R1, R0, #0
ADD R1, R1, #1
BRnp Return_Zero_Sub_2
		
Return_One_Sub_2
	ADD R2, R2, #1
	
Return_Zero_Sub_2
    ;Return #0 to main
		
LD R0, BACKUP_R0_3600
LD R1, BACKUP_R1_3600
LD R3, BACKUP_R3_3600
LD R4, BACKUP_R4_3600
LD R5, BACKUP_R5_3600
LD R6, BACKUP_R6_3600
LD R7, BACKUP_R7_3600

RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB600

BACKUP_R0_3600 .BLKW #1
BACKUP_R1_3600 .BLKW #1
BACKUP_R2_3600 .BLKW #1
BACKUP_R3_3600 .BLKW #1
BACKUP_R4_3600 .BLKW #1
BACKUP_R5_3600 .BLKW #1
BACKUP_R6_3600 .BLKW #1
BACKUP_R7_3600 .BLKW #1

.END

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------

.ORIG x3800

ST R0, BACKUP_R0_3800
ST R1, BACKUP_R1_3800
ST R2, BACKUP_R2_3800
ST R3, BACKUP_R3_3800
ST R4, BACKUP_R4_3800
ST R5, BACKUP_R5_3800
ST R6, BACKUP_R6_3800
ST R7, BACKUP_R7_3800
		
LD R0, BUSYNESS_ADDR_NUM_BUSY_MACHINES
LDR R0, R0, #0
AND R1, R1, x0
LD R2, Bit_Checker
LD R3, Bit_Counter
		
Checker_For_Bit
AND R4, R0, R2
BRnp Not_Busy
ADD R1, R1, #1

Not_Busy
ADD R0, R0, R0
ADD R3, R3, #-1
BRp Checker_For_Bit
END_Checker_For_Bit
		
LD R0, BACKUP_R0_3800
LD R2, BACKUP_R2_3800
LD R3, BACKUP_R3_3800
LD R4, BACKUP_R4_3800
LD R5, BACKUP_R5_3800
LD R6, BACKUP_R6_3800
LD R7, BACKUP_R7_3800

RET

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB600
Bit_Checker .FILL x8000
Bit_Counter .FILL #16

BACKUP_R0_3800 .BLKW #1
BACKUP_R1_3800 .BLKW #1
BACKUP_R2_3800 .BLKW #1
BACKUP_R3_3800 .BLKW #1
BACKUP_R4_3800 .BLKW #1
BACKUP_R5_3800 .BLKW #1
BACKUP_R6_3800 .BLKW #1
BACKUP_R7_3800 .BLKW #1

.END

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------

.ORIG x4000

ST R0, BACKUP_R0_4000
ST R1, BACKUP_R1_4000
ST R2, BACKUP_R2_4000
ST R3, BACKUP_R3_4000
ST R4, BACKUP_R4_4000
ST R5, BACKUP_R5_4000
ST R6, BACKUP_R6_4000
ST R7, BACKUP_R7_4000
		
LD R0, BUSYNESS_ADDR_NUM_FREE_MACHINES
LDR R0, R0, #0
AND R1, R1, x0
LD R2, Bit_Checker_Sub4
LD R3, Bit_Counter_Sub4
		
Checker_Sub4
AND R4, R0, R2
BRz Not_Valid_Sub4
ADD R1, R1, #1

Not_Valid_Sub4
	ADD R0, R0, R0
	ADD R3, R3, #-1
	BRp Checker_Sub4
END_Checker_Sub4
		
LD R0, BACKUP_R0_4000
LD R2, BACKUP_R2_4000
LD R3, BACKUP_R3_4000
LD R4, BACKUP_R4_4000
LD R5, BACKUP_R5_4000
LD R6, BACKUP_R6_4000
LD R7, BACKUP_R7_4000

RET

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB600
Bit_Checker_Sub4                .FILL x8000
Bit_Counter_Sub4                .FILL #16
BACKUP_R0_4000 .BLKW #1
BACKUP_R1_4000 .BLKW #1
BACKUP_R2_4000 .BLKW #1
BACKUP_R3_4000 .BLKW #1
BACKUP_R4_4000 .BLKW #1
BACKUP_R5_4000 .BLKW #1
BACKUP_R6_4000 .BLKW #1
BACKUP_R7_4000 .BLKW #1

.END

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------

.ORIG x4200

SUB_FIRST_FREE_4200

ST R0, BACKUP_R0_4200
ST R1, BACKUP_R1_4200
ST R2, BACKUP_R2_4200
ST R3, BACKUP_R3_4200
ST R4, BACKUP_R4_4200
ST R5, BACKUP_R5_4200
ST R6, BACKUP_R6_4200
ST R7, BACKUP_R7_4200	
		
AND R2, R2, x0
AND R3, R3, x0
ADD R3, R3, #1
LD R0, BUSYNESS_ADDR_MACHINE_STATUS
LDR R0, R0, #0

AND R4, R4, x0
ADD R4, R4, #15
NOT R1, R1
ADD R1, R1, #1
ADD R4, R1, R4; R4 equates to left shift counter
BRz END_Left_Shift

Left_Shift
ADD R0, R0, R0
ADD R4, R4, #-1
BRp Left_Shift

END_Left_Shift; NOTE if BRz is postive, least sig bit is zero
ADD R0, R0, x0	
BRzp Busy_SUB5
ADD R2, R2, #1
		
Busy_SUB5
		
LD R0, BACKUP_R0_4200
LD R1, BACKUP_R1_4200
LD R3, BACKUP_R3_4200
LD R4, BACKUP_R4_4200
LD R5, BACKUP_R5_4200
LD R6, BACKUP_R6_4200
LD R7, BACKUP_R7_4200

RET

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS .Fill xB600
BACKUP_R0_4200 .BLKW #1
BACKUP_R1_4200 .BLKW #1
BACKUP_R2_4200 .BLKW #1
BACKUP_R3_4200 .BLKW #1
BACKUP_R4_4200 .BLKW #1
BACKUP_R5_4200 .BLKW #1
BACKUP_R6_4200 .BLKW #1
BACKUP_R7_4200 .BLKW #1

.END

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------

.ORIG x4400

ST R0, BACKUP_R0_4400
ST R1, BACKUP_R1_4400
ST R2, BACKUP_R2_4400
ST R3, BACKUP_R3_4400
ST R4, BACKUP_R4_4400
ST R5, BACKUP_R5_4400
ST R6, BACKUP_R6_4400
ST R7, BACKUP_R7_4400
		
LD R0, BUSYNESS_ADDR_FIRST_FREE
LDR R0, R0, #0
AND R1, R1, x0
AND R2, R2, x0
ADD R2, R2, #1
LD R5, Total_Num_Bits
		
Loop_Sub6
AND R4, R0, R2
BRz Next_Value
BR END_Loop_Sub6
		
Next_Value
ADD R1, R1, #1
ADD R2, R2, R2

ADD R5, R5, #-1
BRp Loop_Sub6
		
AND R1, R1, x0
ADD R1, R1, #-1
END_Loop_Sub6
		
LD R0, BACKUP_R0_4400
;Don't BACKUP R1 (return value)
LD R2, BACKUP_R2_4400
LD R3, BACKUP_R3_4400
LD R4, BACKUP_R4_4400
LD R5, BACKUP_R5_4400
LD R6, BACKUP_R6_4400
LD R7, BACKUP_R7_4400
		
RET

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xB600
Total_Num_Bits .FILL #16

BACKUP_R0_4400 .BLKW #1
BACKUP_R1_4400 .BLKW #1
BACKUP_R2_4400 .BLKW #1
BACKUP_R3_4400 .BLKW #1
BACKUP_R4_4400 .BLKW #1
BACKUP_R5_4400 .BLKW #1
BACKUP_R6_4400 .BLKW #1
BACKUP_R7_4400 .BLKW #1

.END


;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------

.ORIG x4600

ST R0, BACKUP_R0_4600
ST R1, BACKUP_R1_4600
ST R2, BACKUP_R2_4600
ST R3, BACKUP_R3_4600
ST R4, BACKUP_R4_4600
ST R5, BACKUP_R5_4600
ST R6, BACKUP_R6_4600
ST R7, BACKUP_R7_4600
		
BR Prompt_Instruction

Error_Message	
LEA R0, Error_msg_2
PUTS
		
Prompt_Instruction
LEA R0, prompt
PUTS
		
AND R0, R0, #0; Flag Checkers
AND R1, R1, #0; Flag Checkers
AND R2, R2, #0; Flag Checkers
AND R3, R3, #0; Flag Checkers
AND R4, R4, #0; Flag Checkers
ADD R4, R4, #-1; Flag Checkers
		
Loop_Sub8
GETC
OUT

LD R6, SUB_Validator
JSRR R6
		
ADD R3, R3, #0
BRn Zero_Inputs
BRz Error_Message

ADD R2, R2, #1
ADD R5, R2, #-5
BRzp Sign
BR Loop_Sub8
			
Sign
ADD R4, R4, #0
BRn END_Loop_Sub8

ADD R5, R2, #-6
BRn Loop_Sub8
END_Loop_Sub8

LEA R0, SUB8_Line_FEED
PUTS

Zero_Inputs
	Neg_Checker
	    ADD R4, R4, #0
	    BRnz END_Neg_Checker
	
	    NOT R1, R1
	    ADD R1, R1, #1
    END_Neg_Checker
		
    Validator_Sub8
	    ADD R2, R1, #-12
	    ADD R2, R2, #-3
		BRnz END_Validator_Sub8
		BR Error_Message
    END_Validator_Sub8
    
END_Zero_Inputs
		
LD R0, BACKUP_R0_4600
LD R2, BACKUP_R2_4600
LD R3, BACKUP_R3_4600
LD R4, BACKUP_R4_4600
LD R5, BACKUP_R5_4600
LD R6, BACKUP_R6_4600
LD R7, BACKUP_R7_4600

RET
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
SUB8_Line_FEED .FILL xA
SUB_Validator  .FILL x6000

BACKUP_R0_4600 .BLKW #1
BACKUP_R1_4600 .BLKW #1
BACKUP_R2_4600 .BLKW #1
BACKUP_R3_4600 .BLKW #1
BACKUP_R4_4600 .BLKW #1
BACKUP_R5_4600 .BLKW #1
BACKUP_R6_4600 .BLKW #1
BACKUP_R7_4600 .BLKW #1

.END
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------

.ORIG x4800

ST R0, BACKUP_R0_4800
ST R1, BACKUP_R1_4800
ST R2, BACKUP_R2_4800
ST R3, BACKUP_R3_4800
ST R4, BACKUP_R4_4800
ST R5, BACKUP_R5_4800
ST R6, BACKUP_R6_4800
ST R7, BACKUP_R7_4800
		
ADD R1, R1, #-10
BRzp Loop_SUB9

ADD R1, R1, #10
BR END_Loop_SUB9
		
Loop_SUB9
	LD R0, DEC_ONE
	OUT
	
END_Loop_SUB9
ADD R1, R1, #12; ASCII -> Decimal conversion
ADD R1, R1, #12; ASCII -> Decimal conversion
ADD R1, R1, #12; ASCII -> Decimal conversion
ADD R1, R1, #12; ASCII -> Decimal conversion
ADD R0, R1, #0
OUT
		
LD R0, BACKUP_R0_4800
LD R1, BACKUP_R1_4800
LD R2, BACKUP_R2_4800
LD R3, BACKUP_R3_4800
LD R4, BACKUP_R4_4800
LD R5, BACKUP_R5_4800
LD R6, BACKUP_R6_4800
LD R7, BACKUP_R7_4800

RET
		
;--------------------------------
;Data for subroutine print number
;--------------------------------
DEC_ONE .FILL #49
BACKUP_R0_4800 .BLKW #1
BACKUP_R1_4800 .BLKW #1
BACKUP_R2_4800 .BLKW #1
BACKUP_R3_4800 .BLKW #1
BACKUP_R4_4800 .BLKW #1
BACKUP_R5_4800 .BLKW #1
BACKUP_R6_4800 .BLKW #1
BACKUP_R7_4800 .BLKW #1

.END

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

.ORIG x6000

ST R0, BACKUP_R0_6000
ST R1, BACKUP_R1_6000
ST R2, BACKUP_R2_6000
ST R3, BACKUP_R3_6000
ST R4, BACKUP_R4_6000
ST R5, BACKUP_R5_6000
ST R6, BACKUP_R6_6000
ST R7, BACKUP_R7_6000
		
ADD R2, R2, #0
BRnp END_Last_Ch
	
FIRST_CHAR
AND R4, R4, x0
	
Check1
	LD R5, Line_Feed_Sub10
	NOT R5, R5
	ADD R5, R5, #1
	ADD R0, R0, R5
	BRnp Neg_Check_Sub10	
	AND R3, R3, x0
	BR END
				
Neg_Check_Sub10	
	LD R0, BACKUP_R0_6000
	LD R5, Neg_Sign 
	NOT R5, R5
	ADD R5, R5, #1
	ADD R0, R0, R5
	BRnp Pos_Sign
	LD R0, Line_Feed_Sub10
	OUT
	ADD R4, R4, #1
	AND R3, R3, x0
	BR END
			
POSITIVE_CHECK_6000
	LD R0, BACKUP_R0_6000
	LD R5, Pos_Sign
	NOT R5, R5
	ADD R5, R5, #1
	ADD R0, R0, R5
	BRnp Stop_Validator
	AND R3, R3, x0
	ADD R3, R3, #1
	BR END
				
Stop_Validator
ADD R4, R4, #-1
			
END_Last_Ch
		
ENTER_CHECK_2
	LD R0, BACKUP_R0_6000
	LD R5, Line_Feed_Sub10
	NOT R5, R5
	ADD R5, R5, #1
	ADD R0, R0, R5
	BRnp Num_Validator
	
	ADD R2, R2, #-1
	BRnp Enter_Finder	
	
	ADD R4, R4, #0
	BRn Enter_Finder
	
	AND R3, R3, x0
	BR END
			
Enter_Finder
	AND R3, R3, x0
	ADD R3, R3, #-1
	BR END
		
Num_Validator
	LD R0, BACKUP_R0_6000
	LD R5, ZERO
	NOT R5, R5
	ADD R5, R5, #1
	ADD R0, R0, R5
	BRn Num_Failure
	
	LD R0, BACKUP_R0_6000
	LD R5, NINE
	NOT R5, R5
	ADD R5, R5, #1
	ADD R0, R0, R5
	BRp Num_Failure
	
	ADD R0, R1, #0
	LD R5, Num_Nine
		
		
Multiplier
    ADD R1, R0, R1
    ADD R5, R5, #-1
    BRp Multiplier

LD R0, BACKUP_R0_6000
ADD R0, R0, #-12; Convertor
ADD R0, R0, #-12; Convertor
ADD R0, R0, #-12; Convertor
ADD R0, R0, #-12; Convertor

ADD R1, R0, R1
AND R3, R3, x0
ADD R3, R3, #1
BR END
			
Num_Failure
LD R0, Line_Feed_Sub10
OUT
AND R3, R3, x0
				
END

LD R0, BACKUP_R0_6000
LD R2, BACKUP_R2_6000
LD R5, BACKUP_R5_6000
LD R6, BACKUP_R6_6000
LD R7, BACKUP_R7_6000

RET

;========
;DATA
;========
Line_Feed_Sub10 .FILL xA
Neg_Sign .FILL x2D
Pos_Sign .FILL x2B
ZERO .FILL #48
NINE .FILL #49
Num_Nine .FILL #9
BACKUP_R0_6000 .BLKW #1
BACKUP_R1_6000 .BLKW #1
BACKUP_R2_6000 .BLKW #1
BACKUP_R3_6000 .BLKW #1
BACKUP_R4_6000 .BLKW #1
BACKUP_R5_6000 .BLKW #1
BACKUP_R6_6000 .BLKW #1
BACKUP_R7_6000 .BLKW #1 

.END

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


.ORIG x5000
MENUSTRING .STRINGZ "***********************\n* The Busyness Server *\n***********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.END

.ORIG xB600			; Remote data
BUSYNESS .FILL xFFFF		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
