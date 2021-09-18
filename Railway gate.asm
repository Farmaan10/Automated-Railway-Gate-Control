Start: MOV P3, #0FFH; IR connected to Port3. No block, IR’s output is logica1. ff makes P3 input port
CLR P2.0 ;connected to IN1 of L293D, clearing P2 makes it output
CLR P2.1 ;connected to IN2 of L293D, clearing P2 makes it output
CLR P2.2 ; Red traffic light and Alarm
SETB P2.3 ; Green on for all time except for the time Red is switched on
CheckIR: ACALL DELAY
		 MOV R7, P3 ;IR (1) read.
		 MOV A, R7
		 RRC A
		 JNC MotorForward; ;Jump when CY=0 i.e. IR is blocked.
		 SJMP CheckIR
BACK1: MOV R7, P3 ;IR(2) read.
	   MOV A, R7
	   RRC A   
	   RRC A
	   JNC SecondIRDetected
	   SJMP BACK1
MotorForward:SETB P2.2 ; Red light on
			 CLR P2.3 ; Green light off
			 ACALL DELAY1
			 ACALL DELAY1
			 SETB P2.0 ;This loop closes the gate.
			 CLR P2.1
			 ACALL DELAY1
			 ACALL DELAY1
			 ACALL DELAY
			 CLR P2.0
			 SJMP BACK1
SecondIRDetected:MOV R6,P3 ;Train is cutting IR(2) and is going to pass through it.
				 MOV A, R6
				 RRC A
				 RRC A
				 JC MotorReverse_Check_FirstIR ; Check IR (1) when train crosses IR (2)
				 SJMP SecondIRDetected ; Wait till train crosses IR (2)
MotorReverse_Check_FirstIR:MOV R5,P3
						   MOV A,R5
						   RRC A
						   JNC MotorReverse_Check_FirstIR ;Keep looping when IR (1) is cut. Go down once train crosses IR (1)
SecondIR_Check:MOV R4,P3 ;Check IR (2) after making sure that train has crossed IR(1)
			   MOV A,R4
			   RRC A
			   RRC A
			   JNC SecondIR_Check ;Keep looping when IR(2) is cut. Go down when train crosses IR(2)
			   CLR P2.0 ;This loop opens the gate.
			   SETB P2.1
			   ACALL DELAY1
			   ACALL DELAY1
			   ACALL DELAY
			   CLR P2.1
			   CLR P2.2 ;Red light and Alarm turned off
			   SETB P2.3 ;Green light back on
			   SJMP Start
DELAY:MOV R7,#0FFH ;Delay program 1
TOP:MOV R6,#0FFH
	MOV R5,#0FFH
BACK:DJNZ R5,BACK
UP:DJNZ R6,UP
   DJNZ R7,TOP
   RET
DELAY1:MOV R4,#14H ;Delay program 2
OneSec:MOV TMOD,#01H
	   MOV TL0,#0AFH
	   MOV TH0,#3CH
	   SETB TR0
WAIT:JNB TF0,WAIT
	 CLR TR0
	 CLR TF0
	 DJNZ R4,OneSec
	 RET
	 END