TITLE HEX_TO_BIN

DATA SEGMENT 
    HEX_NUMBER_MSG DB 10,13,"THE HEX NUMBER IS: ","$"
    BIN_NUMBER_MSG DB 10,13,"THE BINARY NUMBER IS: ","$"
DATA ENDS

CODE SEGMENT
START:
      MOV AX,DATA
      MOV DS,AX
           
      CALL HEXINPUT
      CALL DISPLAYBINARY

EXIT:
      MOV AH,4CH
      INT 21H

HEXINPUT PROC

DISLPAYMSG:
      LEA DX,HEX_NUMBER_MSG
      MOV AH, 09H
      INT 21H

      MOV BX, 0

INPUT:  
      MOV AH, 08H
      INT 21H

      CMP AL, "."
      JE  EXIT 
      
      CMP AL, "A"
      JL DECIMAL

      CMP AL,"Z"
      JG  INPUT

      MOV DL,AL
      MOV AH,02H
      INT 21H
       
      ADD AL,09H 
      JMP CONVERT
      
DECIMAL:
      CMP AL, 39H
      JG  INPUT

      MOV DL,AL
      MOV AH,02H
      INT 21H

      JMP CONVERT       
CONVERT:
      AND AL, 15
      MOV CL, 4
      SHL AL,CL
      MOV CX, 8

LOOP1:
      SHL AL, 1
      RCL BX, 1
      LOOP LOOP1 
  
HEXINPUT ENDP    

DISPLAYBINARY PROC
      LEA DX,BIN_NUMBER_MSG
      MOV AH,09H
      INT 21H

      MOV CX, 4
      MOV AH, 2

LOOP2:
      SHL BL, 1
      JC CONVERT2
      MOV DL, 30H
      JMP DISPLAY

CONVERT2:
      MOV DL, 31H

DISPLAY:
      INT 21H
      LOOP LOOP2 
   
      JMP START
      RET 
DISPLAYBINARY ENDP 

CODE ENDS
END START


