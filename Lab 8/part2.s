//Bubble sort
//1. Compare the list[i] and list[i+1] values
//2. If list[i] > list[i+1] or the other way around depending on
//ascending vs descending, swap values
//3. Continue and iterate the entire list
//4. Repeat the number of times of the list
//Therefore nested loop
.text
.global _start
.global SWAP
_start:
	LDR R1,= LIST		//Address of list
	LDR R2, [R1]		//length of list
	SUB R2, R2, #1		//we iterate to one less than the length of the list
	
	MOV R3, #0			//outer list loop limit
	MOV R4, #0			//inner list loop limit
	
	MOV R9, #-1			//count of number of swaps per inner loop
	
	LDR SP,= 0x3FFFFFFC
	
LOOP_OUT:
	//check whether any swaps occured in previous iteration
	//reset to 0 otherwise
	CMP R9, #0
	BEQ END
	MOV R9, #0

	//reset inner list iterator
	MOV R4, #0
	
	//check whether iterator is still valid
	CMP R3, R2
	BEQ END
	
	//go into inner loop
	//set inner loop iterator
	MOV R5, R2
	SUB R5, R5, #1
	SUB R5, R5, R3
	B LOOP_IN
	
LOOP_OUT_BREAK:
	//iterate
	ADD R3, R3, #1
	B LOOP_OUT
	
LOOP_IN:
	//check whether iterator is still valid
	CMP R4, R5
	BEQ LOOP_OUT_BREAK
	
	//enter SWAP
	//set address of elements to be swapped
	MOV R10, #4
	MUL R8, R4, R10
	ADD R0, R1, R8
	ADD R0, R0, #4
	
	//Push R6 and R7 to prevent clobber
	//when using in subroutine
	BL SWAP
	
	//Check whether swap occured
	CMP R0, #0
	BEQ LOOP_IN_BREAK
	
ADD:
	ADD R9, R9, #1
	
LOOP_IN_BREAK:
	//iterate
	ADD R4, R4, #1
	B LOOP_IN
	
SWAP:
	//Push to stack to prevent clobber
	PUSH {R6,R7}

	//assign values to be swapped
	LDR R6, [R0]
	LDR R7, [R0, #4]
	
	//compare values
	CMP R6, R7
	BLT NO_SWAP
	
	//swap
	STR R7, [R0]
	STR R6, [R0, #4]
	
	//return 1
	MOV R0, #1
	POP {R6,R7}
	MOV PC, LR
	
NO_SWAP:
	//return 0	
	MOV R0, #0
	
	//Pop from stack to prevent clobber
	POP {R6,R7}
	MOV PC, LR
	
END:
	B END