.MODEL SMALL 
.STACK 100H
.CODE

MAIN PROC
	 MOV CH,0
	 MOV CL,0
	 
	 INPUT: 
	 MOV AH,1
	 INT 21H 
	 CMP AL,13D
	 JE LINE                                
	 AND DX,0
	 MOV DL,AL
	 PUSH DX  
	 INC CL
	 JMP INPUT   
	 
	 LINE:
	 MOV AH,2
	 MOV DL,0AH
	 INT 21H
	 MOV DL,0DH
	 INT 21H
	 
	 
	 
	 PRINT:
	 AND DX,0
	 POP DX
	 MOV AH,2 
	 INT 21H  
	 LOOP PRINT
	 
	
		MAIN ENDP
END MAIN