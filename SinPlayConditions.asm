MACRO checkIfWonm 
    LOCAL zeroR, zeroC, zeroAL, blank, checkRows, checkCols, checkAL, Won, tie, stop
    LEA BX, [numsm]
blank:
    CMP [BX], 4Fh
    JB zeroR
    INC BX
    CMP [BX], 40h
    JE tie
    JA blank
zeroR:
    LEA BX, [numsm]
    MOV CX, 0
    JMP checkRows    
checkRows:
    INC CX
    MOV AL, [BX]
    AND AL, [BX+1]
    CMP AL, [BX+2]
    JE won
    ADD BX, 3
    CMP CX, 3
    JAE zeroC
    JMP checkRows
    
zeroC:
    LEA BX, [numsm]
    MOV CX, 0
checkCols:
    INC CX
    MOV AL, [BX]
    AND AL, [BX+3]
    CMP AL, [BX+6]
    JE won
    INC BX
    CMP CX, 3
    JE checkAL
    JMP checkCols          

checkAL:
    LEA BX, [numsm]
    MOV AL, [BX]
    AND AL, [BX+4]
    CMP AL, [BX+8]
    JE won
    ADD BX, 2
    MOV AL, [BX]
    AND AL, [BX+2]
    CMP AL, [BX+4]
    JE won
    JMP stop            
Won:
    MOV AL, [whoTurnm]
    MOV [whoWonm], AL
    MOV gameOverm, 1
    JMP stopm
tie:         
    MOV [whoWonm], 2
    MOV gameOverm, 1
    JMP stopm
stop:
            
ENDM checkIfWonm
    
MACRO gotom a, b ; a = row, b = col  
    MOV AH, 02h
    MOV DH, a
    MOV DL, b
    MOV BH, 0
    INT 10h
ENDM gotom     

MACRO lineDownm
    MOV AH, 02h
    MOV DL, 0Ah
    INT 21h
    MOV DL, 0Dh
    INT 21h
ENDM lineDownm 

MACRO printPartm a
    LOCAL c, x, o, check, one, two, three, four, five, six, seven, eight, nine, print       
  JMP check  
check:
    MOV CH, a    
    CMP CH, 1
    JE one
    CMP CH, 2
    JE two
    CMP CH, 3
    JE three
    CMP CH, 4
    JE four
    CMP CH, 5
    JE five
    CMP CH, 6
    JE six
    CMP CH, 7
    JE seven
    CMP CH, 8
    JE eight
    JA nine
one:
    goto 4,1
    JMP c 
two:
    goto 4,5
    JMP c
three:
    goto 4,9
    JMP c
four:
    goto 6,1
    JMP c
five:
    goto 6,5
    JMP c
six:
    goto 6,9
    JMP c
seven:
    goto 8,1
    JMP c
eight:
    goto 8,5
    JMP c
nine:
    gotom 8,9
    JMP c
    
c:  CMP whoTurnm, 0
    JE x
    JA o
x:
  MOV DL, 'X'
  JMP print 
o:    
  MOV DL, 'O'
  
print:
    MOV AH, 02h
    INT 21h                      
     
ENDM printPartm

MACRO printBoardm
    LOCAL r, finish
    MOV AH, 02h
    MOV DH, 4
    MOV DL, 0
    MOV BH, 0
    INT 10h
    LEA BX, [numsm]
    MOV CX, 3
r:
    spacem
    byxm
    spacem
    linem
    spacem
    byxm
    spacem
    linem
    spacem
    byxm
    spacem
    nl
    DEC CX
    CMP CX, 0
    JE finish
    JMP r
finish:                       
ENDM printBoardm    

MACRO readm 
    LOCAL readD, wrong, x, o, ee, chkcpu,strt
   strt:  
    CMP whoTurnm,0
    JE readD
    JA chkcpu

chkcpu: 
MOV AH, 00h     
   INT 1AH
     MOV  AL, DL
    XOR  DL, DL
    MOV  CL, 10    
    DIV  CL 
    MOV AL,AH
    ADD AL,30h
     CMP AL, 31h
    JB wrong1
    CMP AL, 39h
    JA wrong1
    LEA BX, numsm
    SUB AL, 30h
    MOV selectedNumm, AL 
    MOV AH, 0
    ADD BX, AX
    DEC BX
    CMP [BX], 4Fh
    JAE wrong1 
    CMP whoTurnm, 0
    JE x
    JA o        
             

readD:
    goto 11, 0
    MOV AH, 01h
    INT 21h    
    CMP AL, 31h
    JB wrong
    CMP AL, 39h
    JA wrong
    LEA BX, numsm
    SUB AL, 30h
    MOV selectedNumm, AL 
    MOV AH, 0
    ADD BX, AX
    DEC BX
    CMP [BX], 4Fh
    JAE wrong 
    CMP whoTurnm, 0
    JE x
    JA o
wrong:
    MOV DL, 13
    ADD DL, invalidOffsetm
    goto DL, 0
    INC invalidOffsetm
    MOV AH, 09h
    LEA DX, invalidInputm
    INT 21h
    CMP whoTurnm,0
    JE readD
    JA chkcpu
    
wrong1:
    JMP chkcpu  
x:
    MOV [BX], 58h
    JMP ee         
o:
    MOV [BX], 4Fh
ee:
    printPartm [selectedNumm]       
ENDM readm
    
MACRO spacem
    MOV AH, 02h
    MOV DL, ' '
    INT 21h
ENDM spacem

MACRO linem
    MOV AH, 02h
    MOV DL, '|'
    INT 21h
ENDM linem

MACRO byxm
    MOV AH, 02h
    MOV DL, [BX]
    INT 21h
    INC BX
ENDM byxm

MACRO nlm
    LOCAL f
    MOV AH, 02h
    MOV DL, 0Ah
    INT 21h
    MOV DL, 0Dh
    INT 21h
    CMP CX, 1
    JE f
    LEA DX, endLinem
    MOV AH, 09h
    INT 21h
f:
    
ENDM nlm





