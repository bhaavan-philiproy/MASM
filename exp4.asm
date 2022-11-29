DATA SEGMENT
	MSG1 DB 'ENTER THE COUNT:$'
	STR DB 10,13,'ENTER THE NUMBERS:$'
	STR1 DB 0DH,0AH,'BUBBLE SORTED:$'
	STR3 DB 0DH,0AH,'$'
	ARRAY1 DB 10 DUP(0)
DATA ENDS

CODE SEGMENT 
ASSUME CS:CODE,DS:DATA
START:	MOV AX,DATA
	MOV DS,AX
	LEA DX,MSG1
	MOV AH,09H
	INT 21H
	MOV AH,01H
	INT 21H
	AND AL,0FH
	MOV CL,AL
	MOV CH,00H
	PUSH CX
	MOV AH,09H
	LEA DX,STR
	INT 21H
	LEA SI,ARRAY1	
INPUTS:	MOV AH,01H
	INT 21H
	CMP AL,' '
	JZ INPUTS
	MOV [SI],AL
	INC SI
	DEC CX
	JNZ INPUTS
	POP CX
	MOV BX,CX
	PUSH BX
	DEC CX	
NEXTSCAN:MOV BX,CX
	 LEA SI,ARRAY1	
NEXTCOMP:MOV AL,[SI]
	 MOV DL,[SI+1]
	 CMP AL,DL
	 JC NOSWAP
	 MOV [SI],DL
	 MOV [SI+1],AL	
NOSWAP:	INC SI
	DEC BX
	JNZ NEXTCOMP
	DEC CX
	JNZ NEXTSCAN
	MOV AH,09
	LEA DX,STR1
	INT 21H
	MOV AH,09
	LEA DX,STR3
	INT 21H
	POP BX
	MOV CX,BX
	LEA SI,ARRAY1	
PRINT:	MOV DL,' '
	MOV AH,02H
	INT 21H
	MOV DL,[SI]
	MOV AH,02H
	INT 21H
        INC SI
	DEC CX
	JNZ PRINT
	MOV AH,4CH
	INT 21H

CODE ENDS
END START
