INCLUDE 'Conditions.asm'  
INCLUDE 'SinPlayConditions.asm'

MACRO multi     

;----------CODE--------------------------------------------------------------------------------------
LEA DX, firstmsg
MOV AH, 09h
INT 21h
printBoard
goto 10, 0
LEA DX, xTurn
MOV AH, 09h
INT 21h
ll:   
    read
    checkIfWon
    CMP gameOver, 1
    JE stop
    CMP whoTurn, 0
    JE changeO
    JA changeX 
changeX:
    goto 10, 0
    LEA DX, xTurn
    MOV AH, 09h
    INT 21h
    MOV [whoTurn], 0
    JMP ll  
changeO:
    goto 10, 0
    LEA DX, oTurn
    MOV AH, 09h
    INT 21h        
    MOV [whoTurn], 1
    JMP ll
    
stop:
    goto 8, 15
    CMP whoWon, 1
    JE O
    JA tie1
    JB X 
X:
    LEA DX, XWon
    JMP endXO
O:
    LEA DX, OWon
    JMP endXO
tie1:
    LEA DX, tie
    JMP endXO
endXO:
    MOV AH, 09h
    INT 21h
    goto 10, 15
    LEA DX, press
    MOV AH, 09h
    INT 21h
    MOV AH, 0
    INT 16h    
    MOV AH, 4Ch
    INT 21h   

;status displaying
endLine DB "-----------", 0Ah, 0Dh, 24h
nums DB 31h, 32h, 33h, 34h, 35h, 36h, 37h, 38h, 39h, 40h
firstmsg DB "Tic Tac Toe (2P GAME) ", 0Ah, 0Dh, 24h  
xTurn DB "X Turn:", 0Ah, 0Dh, 24h
oTurn DB "O Turn:", 0Ah, 0Dh, 24h
gameOver DB 0 ; BOOLEAN: 0 - false, 1 - true
invalidInput DB "Invalid Input.Try Again", 0Ah, 0Dh, 24h
whoTurn DB 0 ; BOOLEAN 0 - X, 1 - O
selectedNum DB ?
invalidOffset DB 0
whoWon DB ? ; 0 - X, 1 - O, 2 - tie
XWon DB "X Won!!!!!!", 0Ah, 0Dh, "                $"
OWon DB "O Won!!!!!!", 0Ah, 0Dh, "                $"  
tie DB "It is a tie...", 0Ah, 0Dh, "              $"
press DB "Press any key to Exit...$"


ENDM multi        


MACRO single  
    LEA DX, firstmsgm
MOV AH, 09h
INT 21h
printBoardm
gotom 10, 0
LEA DX, xTurnm
MOV AH, 09h
INT 21h
llm:   
    readm 
    checkIfWonm
    CMP gameOverm, 1
    JE stopm
    CMP whoTurnm, 0
    JE changeOm
    JA changeXm 
changeXm:
    gotom 10, 0
    LEA DX, xTurnm
    MOV AH, 09h
    INT 21h
    MOV [whoTurnm], 0
    JMP llm  
changeOm:
    gotom 10, 0
    LEA DX, oTurnm
    MOV AH, 09h
    INT 21h        
    MOV [whoTurnm], 1
    JMP llm 
    
stopm:
    gotom 8, 15
    CMP whoWonm, 1
    JE Om
    JA tie1m
    JB Xm 
Xm:
    LEA DX, XWonm
    JMP endXOm
Om:
    LEA DX, OWonm
    JMP endXOm
tie1m:
    LEA DX, tiem
    JMP endXOm
endXOm:
    MOV AH, 09h
    INT 21h
    gotom 10, 15
    LEA DX, pressm
    MOV AH, 09h
    INT 21h
    MOV AH, 0
    INT 16h    
    MOV AH, 4Ch
    INT 21h
;display message regaring status of game
endLinem DB "-----------", 0Ah, 0Dh, 24h
numsm DB 31h, 32h, 33h, 34h, 35h, 36h, 37h, 38h, 39h, 40h
firstmsgm DB "Tic Tac Toe (Single Player Game)", 0Ah, 0Dh, 24h
xTurnm DB "Player's Turn:", 0Ah, 0Dh, 24h
oTurnm DB "CPU's Turn   :", 0Ah, 0Dh, 24h
gameOverm DB 0 ; BOOLEAN: 0 - false, 1 - true
invalidInputm DB "Invalid Input.Try Again", 0Ah, 0Dh, 24h
whoTurnm DB 0 ; BOOLEAN 0 - X, 1 - O
selectedNumm DB ?
invalidOffsetm DB 0
whoWonm DB ? ; 0 - X, 1 - O, 2 - tie
XWonm DB "Player Won!!!!!!", 0Ah, 0Dh, "                $"
OWonm DB "CPU Won!!!!!!", 0Ah, 0Dh, "                $"  
tiem DB "It is a tie...", 0Ah, 0Dh, "              $"
pressm DB "Press any key to Exit...$"   
cpum DB ?








    
    
ENDM single






ORG 100h   
;for printing message
LEA DX, msg
MOV AH, 09h
INT 21h 

MOV AH, 02h
MOV DL, 0Ah
INT 21h  

MOV AH, 02h
MOV DL, 09h
INT 21h

LEA DX, singlem
MOV AH, 09h
INT 21h 

MOV AH, 02h
MOV DL, 09h
INT 21h



LEA DX, double
MOV AH, 09h
INT 21h 

MOV AH, 02h
MOV DL, 0Ah
INT 21h

LEA DX, choice
MOV AH, 09h
INT 21h   

MOV AH,01h
INT 21h  

CMP AL,32h
JE d  
JNE s

d:  
 MOV AX,0600H    ;06 TO SCROLL & 00 FOR FULLJ SCREEN
    MOV BH,71H    ;ATTRIBUTE 7 FOR BACKGROUND AND 1 FOR FOREGROUND
   MOV CX,0000H    ;STARTING COORDINATES
    MOV DX,184FH    ;ENDING COORDINATES
    INT 10H        ;FOR VIDEO DISPLAY 
    goto 0,0
    ;MOV AH,4CH    ;RETURN TO DOS MODE
    ;INT 21H
  multi


s:  
MOV AX,0600H    ;06 TO SCROLL & 00 FOR FULLJ SCREEN
    MOV BH,71H    ;ATTRIBUTE 7 FOR BACKGROUND AND 1 FOR FOREGROUND
    MOV CX,0000H    ;STARTING COORDINATES
    MOV DX,184FH    ;ENDING COORDINATES
    INT 10H        ;FOR VIDEO DISPLAY 
    goto 0,0  
    single




msg DB "Welcome to Tic Tac Toe", 0Ah, 0Dh, 24h,0Ah,0Dh, 24h   
singlem DB "1. Single Player Game", 0Ah, 0Dh, 24h
double DB "2. Multi  Player Game", 0Ah, 0Dh, 24h  
choice DB "Enter your Choice :", 0Ah, 0Dh, 24h,0Ah,0Dh, 24h

RET     



