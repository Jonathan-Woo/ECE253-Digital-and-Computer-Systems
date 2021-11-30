.text
.global _start

_start:
    LDR        R1, =0xFF200000     // LEDR
    LDR        R2, =0xFF200050     // KEYS
    LDR        R8, =0xFFFEC600    // Timer 
    LDR        R0, =50000000  // Delay (0.25s)
	MOV        R3, #0     // Moving track (0 = IN, 1 = OUT)
    STR        R0, [R8]            
    MOV        R0, #0b011        // A = 1, E = 1, I = 0
    STR        R0, [R8, #8]        
    MOV        R6, #0b0000000001     // Initial Pattern - LED0 
    MOV        R9, #0b1000000000   // Initial Pattern - LED0
    ORR        R7, R6, R9        // ORR R6 and R9 so both are lit up
    MOV        R5, #0x00000001
DISPLAY:
	STR R7,[R1]
CHECKTIMER:
	LDR R4, [R8, #12]
	CMP R4, #0
	BEQ CHECKTIMER
	LDR R4, =1
	STR R4,[R8, #12] 
CHECKKEY:
	LDR R4, [R2]
	CMP R4, #0xfffffff8
	BEQ ENDMOVE
	CMP R4,#0xfffffff0
	BEQ STARTMOVE
ENDMOVE:
	MOV R3, #0
	B SHIFT
STARTMOVE:
	MOV R3, #1
	B SHIFT
	
SHIFT:
	CMP R3, #0
	BEQ CHECKKEY
	LSL R6, R6, #1
	LSR R9, R9, #1
	ORR R7, R6, R9
	CMP R6, #0b0000000001
	BEQ OVERFLOW
	CMP R6, #0b1000000000
	BEQ OVERFLOW
	B DISPLAY
OVERFLOW:
	MOV R6, #0b0000000001     // Initial Pattern - LED0 
  	MOV R9, #0b1000000000
	ORR R7, R6, R9
	B DISPLAY


	
	