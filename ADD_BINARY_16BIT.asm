.MODEL SMALL
.STACK 100H

.DATA
    S1 DB 10,13,'NHAP A(NHAP DU 16BIT): $'
    S2 DB 10,13,'NHAP B(NHAP DU 16BIT): $'
    S3 DB 10,13,'A+B=$'
    NUM1 DW ?
    NUM2 DW ?
    
.CODE
    MAIN PROC    
        
        MOV AX, @DATA
        MOV DS, AX   
        MOV DL, 30H
    START1:   
    
        XOR BX, BX
        LEA DX, S1
        MOV AH, 9
        INT 21H   
        
        MOV CX, 16
        MOV AH, 1
        
        LOOP1:
            INT 21H
            CMP AL,0DH
            JNE SKIP1
            JMP OUT1
            SKIP1:
            AND AL, 0FH
            SHL BX,1
            OR BL, AL
            MOV NUM1, BX
        LOOP LOOP1
        
        OUT1:
        
        LEA DX, S2
        MOV AH, 9
        INT 21H
        
        MOV CX, 16
        MOV AH, 1
        
        LOOP2:
            INT 21H
            CMP AL,0DH
            JNE SKIP2
            JMP OUT2
            SKIP2:
            AND AL, 0FH
            SHL BX,1
            OR BL, AL
            MOV NUM2, BX
        LOOP LOOP2
        
        OUT2:
        
        LEA DX, S3
        MOV AH, 9
        INT 21H
        
        MOV AX,NUM1
        MOV BX,NUM2
        ADD BX,AX
        JNC SKIP
        MOV AH, 2
        MOV DL, 31H
        INT 21H
        SKIP:
            MOV CX, 16
            MOV AH, 2   
        OUT3:
            SHL BX, 1
            JC ONE
            MOV DL, 30H
            JMP DISPLAY
            ONE:
                MOV DL,31H
            DISPLAY:
                INT 21H
        LOOP OUT3
     MOV AH, 4CH
     INT 21H   
  MAIN ENDP
END MAIN
       
            
            
        

     
        
        