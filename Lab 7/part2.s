.data
.text
.global _start
_start:
	LDR R2 ,= TEST_NUM
	LDR R1 ,[R2]
	MOV R0, #0
	
LOOP:
	CMP R1, #0
	BEQ END
	LSR R2, R1, #1
	AND R1, R1, R2
	ADD R0, #1
	B LOOP

END: 
	B END

