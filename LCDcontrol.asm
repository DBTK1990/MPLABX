LIST 	P=PIC16F877
include	<P16f877.inc>
    __CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_OFF & _HS_OSC & _WRT_ENABLE_ON & _LVP_OFF & _DEBUG_ON & _CPD_OFF

org 0x00

  RESET:
    CALL INITDisplay
    GOTO START
    

START:
    CALL WRITE.NAME
    CALL WRITE.LAST
    
    LOOP:
    NOP
    GOTO LOOP
    
INITDisplay:
   CALL BANK1                  ;move to bank1
   CLRF TRISD                  ;set portD to Output
   MOVLW 0X06                  
   MOVWF ADCON1                ;SET ALL TO D
   CLRF TRISE
   CALL BANK0
   MOVLW 0X30                  ;RESET SCREEN
   MOVWF PORTD
   CALL FUNCTION.LCD.WRITE
   CALL INITDELAY
   MOVLW 0X30
   MOVWF PORTD
   CALL FUNCTION.LCD.WRITE
   CALL INITDELAY
   MOVLW 0X30
   MOVWF PORTD
   CALL FUNCTION.LCD.WRITE
   CALL INITDELAY              ;END SCREEN RESET
   MOVLW 0X38                  ;SET CONFIG. FOR SCREEN
   MOVWF PORTD
   CALL FUNCTION.LCD.WRITE
   MOVLW 0X0C                  ;DISPLAY=ON BIT.D=1
   MOVWF PORTD                 
   CALL FUNCTION.LCD.WRITE
   MOVLW 0X01                  ;DISPLAY CLEAR
   MOVWF PORTD
   CALL FUNCTION.LCD.WRITE 
   MOVLW 0X06                  ;DISPLAY SET L.T.R
   MOVWF PORTD
   CALL FUNCTION.LCD.WRITE
   
   RETURN
   
   
FUNCTION.LCD.WRITE:            ;FUNCTION WRITE TO LCD
BCF PORTE,RE1
BSF PORTE,RE0
CALL INITDELAY
BCF PORTE,RE0
    
    RETURN

VAL.LCD.WRITE:                 ;VAL WRITE ON SCREEN
BSF PORTE,RE1
BSF PORTE,RE0
CALL INITDELAY
BCF PORTE,RE0
    
   RETURN    
    
WRITE.NAME:   
   MOVLW 0X86
   MOVWF PORTD
   CALL FUNCTION.LCD.WRITE
   MOVLW 0X44
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X75
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X64
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X75
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   RETURN 
   
   WRITE.LAST:
   MOVLW 0XC4
   MOVWF PORTD
   CALL FUNCTION.LCD.WRITE
   MOVLW 0X42
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X65
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X6E
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X61
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X66
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X73
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X68
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   MOVLW 0X69
   MOVWF PORTD
   CALL VAL.LCD.WRITE
   RETURN
    
    
    BANK0:
    BCF STATUS,IRP
    BCF STATUS,RP0
    BCF STATUS,RP1
    RETURN
    
    BANK1:
    BCF STATUS,IRP
    BCF STATUS,RP1
    BSF STATUS,RP0
    RETURN
    
    BANK2:
    BSF STATUS,IRP
    BSF STATUS,RP1
    BCF STATUS,RP0
    RETURN 
    
    BANK3:
    BSF STATUS,IRP
    BSF STATUS,RP1
    BSF STATUS,RP0
    RETURN
    
    INITDELAY:          ;INIT DELAY 2ms
    movlw 0X02          
    movwf 0x40         
    
    DELAY0:
    DECFSZ 0x40,f
    GOTO DELAY0
    RETURN
    
    
    END