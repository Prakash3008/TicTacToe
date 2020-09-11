MACRO checkIfWon 
LOCAL zeroR, zeroC, zeroAL, blank, checkRows, checkCols, checkAL, Won, tie, stop
LEA BX, [nums]
blank:
    CMP [BX], 4Fh
    JB zeroR
    INC BX
    CMP [BX], 40h
    JE tie
    JA blank
zeroR:
    LEA BX, [nums]
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
    LEA BX, [nums]
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
    LEA BX, [nums]
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
    MOV AL, [whoTurn]
    MOV [whoWon], AL
    MOV gameOver, 1
    JMP stop
tie:         
    MOV [whoWon], 2
    MOV gameOver, 1
    JMP stop
stop:
            
ENDM checkIfWon 
    

MACRO goto a, b ; a = row, b = col  
    MOV AH, 02h
    MOV DH, a
    MOV DL, b
    MOV BH, 0
    INT 10h
ENDM goto     

MACRO lineDown
    MOV AH, 02h
    MOV DL, 0Ah
    INT 21h
    MOV DL, 0Dh
    INT 21h
ENDM lineDown 

MACRO printPart a
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
    goto 8,9
    JMP c
    
c:  CMP whoTurn, 0
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
     
ENDM printPart

MACRO printBoard
    LOCAL r, finish
    MOV AH, 02h
    MOV DH, 4
    MOV DL, 0
    MOV BH, 0
    INT 10h
    LEA BX, [nums]
    MOV CX, 3
r:
    space
    byx
    space
    line
    space
    byx
    space
    line
    space
    byx
    space
    nl
    DEC CX
    CMP CX, 0
    JE finish
    JMP r
finish:                       
ENDM printBoard    


MACRO read
    LOCAL readD, wrong, x, o, ee
readD:
    goto 11, 0
    MOV AH, 01h
    INT 21h    
    CMP AL, 31h
    JB wrong
    CMP AL, 39h
    JA wrong
    LEA BX, nums
    SUB AL, 30h
    MOV selectedNum, AL 
    MOV AH, 0
    ADD BX, AX
    DEC BX
    CMP [BX], 4Fh
    JAE wrong 
    CMP whoTurn, 0
    JE x
    JA o
wrong:
    MOV DL, 13
    ADD DL, invalidOffset
    goto DL, 0
    INC invalidOffset
    MOV AH, 09h
    LEA DX, invalidInput
    INT 21h
    JMP readD  
x:
    MOV [BX], 58h
    JMP ee         
o:
    MOV [BX], 4Fh
ee:
    printPart [selectedNum]       
ENDM read
    
MACRO space
    MOV AH, 02h
    MOV DL, ' '
    INT 21h
ENDM space

MACRO line
    MOV AH, 02h
    MOV DL, '|'
    INT 21h
ENDM line

MACRO byx
    MOV AH, 02h
    MOV DL, [BX]
    INT 21h
    INC BX
ENDM byx

MACRO nl
    LOCAL f
    MOV AH, 02h
    MOV DL, 0Ah
    INT 21h
    MOV DL, 0Dh
    INT 21h
    CMP CX, 1
    JE f
    LEA DX, endLine
    MOV AH, 09h
    INT 21h
f:
    
ENDM nl