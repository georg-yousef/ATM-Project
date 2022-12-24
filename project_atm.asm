include 'emu8086.inc'
.MODEL small
.DATA

    TOTAL       DW 20
    IDS         DW 0000H,0001H,0002H,0003H,0004H,0005H,0006H,0007H,0008H,0009H 
    PASSWORDS   DB   00H,  01H,  02H,  03H,  04H,  05H,  06H,  07H,  08H,  09H
    MON         DW 25000,25000,25000,25000,25000,25000,25000,25000,25000,25000  
    DATA1       DB '******WELCOME*******',0
    DATA2       DB 0DH,0AH,'ENTER YOUR ID: ',0
    DATA3       DB 0DH,0AH,'ENTER YOUR PASSWORD: ',0 
    DATA4       DB 0DH,0AH,'DENIED 0  ',0  
    DATA5       DB 0DH,0AH,'ALLOWED 1 ',0 
    msg0        DB 0DH,0AH,'please select the transaction ',0
    msg1        DB 0DH,0AH,'1. Balance inquiry ',0
    msg2        DB 0DH,0AH,'2. Money Withdraw ',0
    msg3        DB 0DH,0AH,'3. Transfer Money ',0
    msg4        DB 0DH,0AH,'4. Deposit ',0
    msg5        DB 0DH,0AH,'5. Exit ',0
    bac         DB 0DH,0AH,'1. Back',0 
    ext         DB 0DH,0AH,'2. Exit',0
    
    totalbal     DB 0DH,0AH,'Your Total Balance is ',0 
    availablebal DB 0DH,0AH,'Your Available Balance is ',0
    accountnum   DB 0DH,0AH,'Enter Account Number: ',0
    ADDEDMON     DB 0DH,0AH,'Enter amount: ',0
    THANKS       DB 0DH,0AH,'Thank you ',0 
    INVA         DB 0DH,0AH,'Invalid Input ',0
    
                
            
    
    fivehun  DB 0DH,0AH,'1. 500 ',0 
    one      DB 0DH,0AH,'2. 1000 ',0
    three    DB 0DH,0AH,'3. 3000 ',0
    five     DB 0DH,0AH,'4. 5000 ',0
    
    
    
    
    
    
    new         DB 10,13,"$"
    
    
    
    
    
    
    IDINPUT      DW 1 DUP (?)
    PASSINPUT    DB 1 DUP (?)    
    
    
.CODE
.STARTUP

DEFINE_SCAN_NUM           
DEFINE_PRINT_STRING 
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS     




AGAIN:LEA  SI,DATA1
      CALL PRINT_STRING
      LEA  SI,DATA2
      CALL PRINT_STRING
      MOV  SI,-1


      CALL SCAN_NUM
      MOV  IDINPUT,CX
      MOV  AX,CX
      MOV  CX,0 
               
               
L1:   INC  CX
      CMP  CX,TOTAL
      JE   ERROR
      INC  SI
      MOV  DX,SI
      CMP  IDS[SI],AX
      JE   PASS
      JMP  L1
      
      
      
      
      
      
PASS: LEA  SI,DATA3
      CALL PRINT_STRING        
      CALL SCAN_NUM
      MOV  PASSINPUT,CL
      MOV  AX,DX 
      MOV  DX,0002H
      DIV  DL 
      MOV  SI,AX 
      MOV  AL,CL
      MOV  AH,00H
      CMP  PASSWORDS[SI],AL
      JNE  ERROR
      JMP  MAINPROSS
      
      
      
      
      
ERROR:LEA  SI,DATA4
      CALL PRINT_STRING 
      PRINT 0AH      
      PRINT 0DH
      MOV  SI,0
      JMP  AGAIN         



MAINPROSS:LEA  SI,msg0
          CALL PRINT_STRING
          LEA  SI,msg1
          CALL PRINT_STRING
          LEA  SI,msg2
          CALL PRINT_STRING
          LEA  SI,msg3
          CALL PRINT_STRING
          LEA  SI,msg4
          CALL PRINT_STRING
          LEA  SI,msg5
          CALL PRINT_STRING
          MOV  SI,-5
          
          mov ah,9
          lea dx,new     ; new line
          int 21h
          
          
          CALL SCAN_NUM
          MOV  BL,CL
          
check:    cmp bl,1 
          je balance
          cmp bl,2 
          je withdraw
          cmp bl,3 
          je Transfer
          cmp bl,4 
          je deposit
          cmp bl,5 
          je exit
          jmp err
    
    
    
    
    
balance: mov ah,0x00   ; clear screen
         mov al,0x03
         int 0x10
         
         mov bx,IDINPUT
         mov ax,2
         mul bx
         mov SI,ax
         mov ax,MON[SI]
         
         LEA  SI,totalbal
         CALL PRINT_STRING
         
         CALL PRINT_NUM_UNS
         
         jmp option 
         
         
            
    
withdraw:  mov ah,0x00   
           mov al,0x03
           int 0x10
           
           LEA  SI,fivehun
           CALL PRINT_STRING    
           LEA  SI,one
           CALL PRINT_STRING
           LEA  SI,three
           CALL PRINT_STRING
           LEA  SI,five
           CALL PRINT_STRING 
           
           mov ah,9
           lea dx,new     
           int 21h
           
           CALL SCAN_NUM
           MOV  BL,CL
           
           cmp bl,1 
           je pross1
           cmp bl,2 
           je pross2
           cmp bl,3 
           je pross3
           cmp bl,4 
           je pross4
           jmp err





pross1:  mov bx,IDINPUT
         mov ax,2
         mul bx
         mov SI,ax
         sub MON[SI], 500
         
         
         mov ax,MON[SI]
        
         LEA  SI,availablebal
         CALL PRINT_STRING
         CALL PRINT_NUM_UNS
         JMP option



pross2:  mov bx,IDINPUT
         mov ax,2
         mul bx
         mov SI,ax
         sub MON[SI], 1000
         
         mov ax,MON[SI]
         
         
         LEA  SI,availablebal
         CALL PRINT_STRING
         CALL PRINT_NUM_UNS
         JMP option



pross3:  mov bx,IDINPUT
         mov ax,2
         mul bx
         mov SI,ax
         sub MON[SI], 3000
         
         
         mov ax,MON[SI]
        
         LEA  SI,availablebal
         CALL PRINT_STRING
         CALL PRINT_NUM_UNS
         JMP option



pross4:  mov bx,IDINPUT
         mov ax,2
         mul bx
         mov SI,ax
         sub MON[SI], 5000
         
         mov ax,MON[SI]
        
         LEA  SI,availablebal
         CALL PRINT_STRING
         CALL PRINT_NUM_UNS
         JMP option
         
         


Transfer: mov ah,0x00   
          mov al,0x03
          int 0x10
          
          LEA  SI,accountnum
          CALL PRINT_STRING
          
          mov ah,9
          lea dx,new     
          int 21h 
          
          CALL SCAN_NUM
          MOV  BX,CX
          
          mov ax,2
          mul bx
          mov bp,ax
          
          LEA  SI,ADDEDMON
          CALL PRINT_STRING
          
          mov ah,9
          lea dx,new     
          int 21h
          
          CALL SCAN_NUM
          MOV  BX,CX
          
          mov SI,bp
          add MON[SI], bx
          
          mov ax,MON[SI]
          CALL PRINT_NUM_UNS

  
  
  
  
option:   mov ah,9
          lea dx,new
          int 21h
          
          LEA  SI,bac
          CALL PRINT_STRING
          LEA  SI,ext
          CALL PRINT_STRING
          
          mov ah,9
          lea dx,new
          int 21h
          
          CALL SCAN_NUM
          MOV  BL,CL
          
          cmp bl,1 
          je back
          jmp err
          
          
          
          
          
         
back:    mov ah,0x00   
         mov al,0x03
         int 0x10
         
         call MAINPROSS           
         
          
          
           
deposit: mov ah,0x00   
         mov al,0x03
         int 0x10 
         
         LEA  SI,ADDEDMON
         CALL PRINT_STRING
         
         mov ah,9
         lea dx,new     
         int 21h
         
         CALL SCAN_NUM
          
         
         mov bx,IDINPUT
         mov ax,2
         mul bx
         mov SI,ax
         add MON[SI], cx
         
         mov ax,MON[SI]
        
         LEA  SI,availablebal
         CALL PRINT_STRING
         CALL PRINT_NUM_UNS
         JMP option






exit: mov ah,0x00
      mov al,0x03
      int 0x10
      
      LEA  SI,THANKS
      CALL PRINT_STRING
       
      mov ah,4ch
      int 21h
      


err:  mov ah,0x00
      mov al,0x03
      int 0x10
       
      LEA  SI,INVA
      CALL PRINT_STRING
       
      mov ah,9
      lea dx,new
      int 21h 
       
      call mainpross


      
.EXIT
END      
          
     
     
