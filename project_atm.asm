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
    DATA6        DB '******WELCOME BACK******',0
    IDINPUT      DW 1 DUP (?)
    PASSINPUT    DB 1 DUP (?)
DATA ENDS
    
    
