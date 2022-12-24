.model small
.stack 100h 
.data  

TOTAL        DW 20
    IDS1         DW 0000H,0001H,0002H,0003H,0004H,0005H,0006H,0007H,0008H,0009H
    IDS2         DW 000AH,000BH,000CH,000DH,000EH,000FH,0010H,0011H,0012H,0013H 
    PASSWORDS1   DB   00H,  01H,  02H,  03H,  04H,  05H,  06H,  07H,  08H,  09H
    PASSWORDS2   DB   0AH,  0BH,  0CH,  0DH,  0EH,  0FH,  01H,  02H,  03H,  04H
    DATA1        DB '******WELCOME*******',0
    DATA2        DB 0DH,0AH,'ENTER YOUR ID: ',0
    DATA3        DB 0DH,0AH,'ENTER YOUR PASSWORD: ',0 
    DATA4        DB 0DH,0AH,'DENIED 0  ',0  
    DATA5        DB 0DH,0AH,'ALLOWED 1 ',0 
    wel          DB 10,13," Please select the transaction $"
    bal          DB 10,13,10,13,"1- Balance Inquiry $" 
    with         DB 10,13,"2- Money Withdraw $" 
    trans        DB 10,13,"3- Transfer Money $" 
    ex           DB 10,13,"4- Exit $"
    bac          DB 10,13,"1- Back$" 
    ext          DB 10,13,"2- Exit$"
    IDINPUT      DW 1 DUP (?)
    PASSINPUT    DB 1 DUP (?)
   
 ;Money Withdrow Option
    fivehun  db 10,13,"1. 500 USD$" 
    one      db 10,13,"2. 1,000 USD$"
    three    db 10,13,"3. 3,000 USD$"
    five     db 10,13,"4. 5,000 USD$"
    ten      db 10,13,"5. 10,000 USD$"
    fiften   db 10,13,"6. 15,000 USD$"
    tweenty  db 10,13,"7. 20,000 USD$"

    t1       db 10,13,"Your Total Balance is: 24,500 USD $" 
    av1      db 10,13,"Your Available Balance is: 24,400 USD $"
    
    t2       db 10,13,"Your Total Balance is: 24,000 USD $" 
    av2      db 10,13,"Your Available Balance is: 23,900 USD $"
    
    t3       db 10,13,"Your Total Balance is: 22,000 USD $" 
    av3      db 10,13,"Your Available Balance is: 21,900 USD $"
    
    t4       db 10,13,"Your Total Balance is: 20,000 USD $" 
    av4      db 10,13,"Your Available Balance is: 19,900 USD $"

    t5       db 10,13,"Your Total Balance is: 15,000 USD $" 
    av5      db 10,13,"Your Available Balance is: 14,900 USD $"
    
    t6       db 10,13,"Your Total Balance is: 10,000 USD $" 
    av6      db 10,13,"Your Available Balance is: 9,900 USD $"
    
    t7       db 10,13,"Your Total Balance is: 5,000 USD $" 
    av7      db 10,13,"Your Available Balance is: 4,900 USD $" 

DATA ENDS
    
    
CODE SEGMENT

START:MOV  AX,DATA
      MOV  DS,AX  
DEFINE_SCAN_NUM           
DEFINE_PRINT_STRING 
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS 


AGAIN:LEA  SI,DATA1              ; the string in data1 is stored in SI and then printed on the screen using PRINT_STRING procedure
      CALL PRINT_STRING           
      LEA  SI,DATA2              
      CALL PRINT_STRING
      MOV  SI,-1

      CALL SCAN_NUM
      MOV  IDINPUT,CX
      MOV  AX,CX            ; SCAN_NUM gets the number from the user and stores it in CX register
      MOV  CX,0 
L1:   INC  CX
      CMP  CX,TOTAL
      JE   ERROR
      INC  SI
      MOV  DX,SI
      CMP  IDS1[SI],AX
      JE   PASS1            ; check which array matches the input and jump to it
      CMP  IDS2[SI],AX
      JE   PASS2
      JMP  L1
PASS1:LEA  SI,DATA3
      CALL PRINT_STRING
      CALL SCAN_NUM      ; read the input and store it in cl
      MOV  PASSINPUT,CL
      MOV  AX,DX
      MOV  DX,0002H
      DIV  DL       ;al=ax/dl
      MOV  SI,AX 
      MOV  AL,CL     ; store the input in al
      MOV  AH,00H
      CMP  PASSWORDS1[SI],AL
      JNE  ERROR
      JMP  mainpross
