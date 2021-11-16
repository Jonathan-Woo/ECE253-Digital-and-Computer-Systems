.data
.text
.global _start
_start:
	LDR R1,=TEST_NUM
	MOV R2,#0
	MOV R3,#0
	MOV R4,#0
	MOV R7,#0
	MOV R8,#0
	
	LOOP:
		LDR R2,[R1, R3]
		//Check for -1
		ADD R4,R2,#1
		CMP R4,#0
		BEQ END
		
		//continue if not -1
		CMP R2,#0
		//increment if positive
		BGT POSITIVE
		//Continue if not
		B CONTINUE
	POSITIVE:
		ADD R8,R8,#1
		B CONTINUE
	CONTINUE:
		//add to total sum
		ADD R7,R7,R2
		//increment R3 (iterator)
		ADD R3,R3,#4
		B LOOP
END: 
	B END

	