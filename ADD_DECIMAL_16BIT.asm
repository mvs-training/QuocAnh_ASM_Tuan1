.MODEL SMALL
.STACK 100H
.DATA
    S1 DB 10,13,'NHAP A: $'
    S2 DB 10,13,'NHAP B: $'
    S3 DB 10,13,'A+B=$'
    NUM1 DW ?
    NUM2 DW ?
    SAVE DW 0  
.CODE
    MAIN PROC
        
        MOV AX,@DATA
        MOV DS,AX
        MOV DL,30H
        
        MOV AH,9
        LEA DX,S1;A
        INT 21H
        CALL INPUT
        MOV BX,SAVE
        MOV NUM1,BX
        
        MOV AH,9
        LEA DX,S2;B
        INT 21H
        CALL INPUT
        MOV BX,SAVE
        MOV NUM2,BX
        
        MOV AH,9
        LEA DX,S3;A+B
        INT 21H
        CALL ADD1
        CALL OUTPUT
        MOV AH,9
        INT 21H
        MOV AH,4CH
        INT 21H
        
        
        INPUT:
        
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        MOV BX,10
        XOR CX,CX
        MOV SI,CX   
        LOOP1:        
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE OUT1
        CMP AL,08H
        JNE NEG1
        INC SI
        JMP LOOP1
        
        TODEC:
        PUSH CX
        MOV CX,1
        MOV AH,10
        MOV DL,20H
        INT 10H
        POP CX
        JMP LOOP1
          
        NEG1:
        SUB AL,30H
        XOR AH,AH
        XCHG AX,CX
        MUL BX
        ADD CX,AX
        JMP LOOP1
        
        OUT1:
        AND SI,SI
        JZ POP1
        NEG CX
        
        POP1:
        MOV SAVE,CX
        POP SI
        POP DX
        POP CX
        POP BX
        RET
        JMP INPUT
        
        ADD1:
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        MOV AX,NUM1
        MOV BX,NUM2
        ADD AX,BX
        MOV SAVE,AX
        POP DX
        POP CX
        POP BX
        POP AX
        RET
        JMP ADD1
        
        OUTPUT:
        PUSH BX
        PUSH CX
        PUSH DX
        MOV AX,SAVE
        PUSH AX
        XOR CX,CX
        AND AX,AX
        MOV BX,10
        CMP AX,0
        JNS LOOP2
        PUSH AX
        POP AX
        NEG AX
        
        LOOP2:
        XOR DX,DX
        DIV BX
        ADD DX,30H
        PUSH DX
        INC CX
        AND AX,AX
        JNZ LOOP2
        
        OUT2:
        POP AX
        MOV AH,0EH
        INT 10H
        LOOP OUT2
        POP DX
        POP CX
        POP BX
        POP AX
        RET
        
    MAIN ENDP
END MAIN
        
        
        
        
        
        