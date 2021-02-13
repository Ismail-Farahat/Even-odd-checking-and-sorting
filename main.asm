
ORG 100H            
include emu8086.inc  ; used to print words and numbers
      
      
JMP START            ; jump over data declaration

N DW ?               ; number of elements that user will enter
     
START:  ;; get the number of elements  
        PRINT "ENTER THE NUMBER OF ELEMENTS (FROM 0 TO 255) = "
        CALL   SCAN_NUM
        MOV    N,CX
        
        PRINTN ""
        
        
        ;; get the elements from the user
        MOV     DX,N
        MOV     DI,2000H
        PRINTN "ENTER THE ELEMENTS (FROM 0 TO 255): "
        
SCAN:   DEC     DX
        CALL    SCAN_NUM
        MOV     [DI],CX
        PRINTN  ""
        INC     DI
        INC     DI
        
        CMP     DX,0
        JNE     SCAN
         
        PRINTN  ""   
        
        
        
        ;; THE PROGRAM
        
        ;; ORDER THE NUMBERS IN ASCENDING ORDER 
        
        MOV     CX,N                ; using two loops, one for switching numbers in the array if the first element is less than ...
                                    ; ... the second element in the loop, and the other loop for repeating the previous process.
                                    
                                   
LOOP1:  MOV     DX,N                ; DX have the number of iterations. 
        DEC     DX                  ; loop over (N-1) becuase when get to the last element, there is no comparsion.
        MOV     DI,2000H
        
LOOP2:  DEC     DX                  ; inner loop  
        MOV     AX,[DI]             ; put the nth input from the user in AX
        INC     DI
        INC     DI
        MOV     BX,[DI]             ; put the (n+1)th input from the user in BX
        
        
        CMP     AX,BX               ; compare the values of AX and BX
        JGE     ORDER               ; if AX greater than or equal to BX jmp to label ORDER 
        JMP     ORD_F               ; if not, jump to ORD_F
                
                ORDER:  MOV     [DI],AX   ; put AX value in the address of BX
                        DEC     DI
                        DEC     DI
                        MOV     [DI],BX   ; put BX value in the address of AX
                        INC     DI
                        INC     DI 
                        
                ORD_F:  CMP     DX,0      ; compare DX with zero
                        JNE     LOOP2     ; if not equal to zero, jump to loop2 to continue in the inner loop (LOOP2)
 


LOOP            LOOP1             ; loop1 ----> outer loop  with iterations equal to the value of CX
        
 

        ;; ODD CHECK
        PRINTN ""       ; new line
        PRINTN "ODD NUMBERS (ASCENDING ORDER) : "

        MOV     CX,N        ; CX have the number of iterations for cheching odd numbers
        MOV     DI,2000H
         
            
ODD_C:  DEC     CX
        MOV     BL,[DI]
        TEST    BL,1        ; using test for anding all the bits except the MSB which represent if the number id even or odd  
        JNZ     ODD         ; if zero flaq is not equal zero then the number is odd, jump to ODD
        JMP     N_ODD       ; if zero flaq equal zero then the number is even, jump to N_ODD

     
                ODD:    MOV     AL,[DI]
                        CALL    PRINT_NUM_UNS
                        PRINTN ""                 ; new line
                        MOV     [DI][1000H],AL    ; saving odd numbers in memory with adress [DI][1000] = 3000
                        
                N_ODD:  INC     DI
                        INC     DI
                        CMP     CX,0       ; compare CX with zero
                        JNE     ODD_C      ; if not equal to zero, jump to ODD_C to contine checking the numbers       


        
        ;; EVEN CHECK
        PRINTN ""      ; new line
        PRINTN "EVEN NUMBERS (DESENDING ORDER) : "

        MOV     CX,N        ; CX have the number of iterations for cheching even numbers
        DEC     CX          
        
        ; this is loop is for increasing DI register to max possible value besed on the number elements N
        ; this step is for printing the numbers from the the last memory address for required DESENDING ORDER
        MOV     DI,2000H
IND:    INC     DI      
        INC     DI
        LOOP    IND
              
        MOV     CX,N
                        
EVEN_C: DEC     CX
        MOV     BL,[DI]
        TEST    BL,1        ; using test for anding all the bits except the MSB which represent if the number id even or odd
        JZ      EVEN        ; if zero flaq equal zero then the number is even, jump to EVEN
        JNZ     N_EVEN      ; if zero flaq is not equal zero then the number is odd, jump to N_EVEN

     
                EVEN:   MOV     AL,[DI]
                        CALL    PRINT_NUM_UNS
                        PRINTN ""                  ; new line
                        MOV     [DI][2000H],AL     ; saving even numbers in memory with adress [DI][2000] = 4000  
           
                N_EVEN: DEC     DI
                        DEC     DI
                        CMP     CX,0        ; compare CX with zero
                        JNE     EVEN_C      ; if not equal to zero, jump to EVEN_C to contine checking the numbers     
 
        
        
        
        ;; PRINT THE END MESSAGE
        PRINTN "" 
        PRINT "THE END"
        
RET
 
 
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS  ; required for print_num.
