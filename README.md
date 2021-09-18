
# Automated Railway Gate Control


This system is designed to manage the control system of railway gate using the 8051 microcontroller. The main purpose of this project is to propose an idea to make the process automated so that the probability of accidents at railroad crossings reduces drastically. As a train approaches the railway crossing from either side, the sensors placed at a certain distance from the gate detects the approaching train and informs the microcontroller about it. This signal is used to trigger the microcontroller for opening or closing of gates. The abstraction of this system is to provide the advanced control system available everywhere.

## Components:
    1. 8051 Microcontroller (AT89C51)
    2. IR Transmitter
    3. IR Receiver
    4. L293D Motor Driver
    5. Motor
    6. Red and Green Light
    7. Bell/Buzzer
    8. Capacitors and Resistors
    9. Power Supply
    10. Keil uVision5
    11. Proteus Software (Used for testing and verification)

## Block Diagram
![final diagram(white back)](https://user-images.githubusercontent.com/68768741/133891757-d82bf9ad-9a03-4f12-b2c1-91a0bae59ea7.jpg)

## Circuit Diagram
![CIRCUIT DIAGRAM](https://user-images.githubusercontent.com/68768741/133891760-51265ff3-a89d-45a1-8186-0ee22c62adbc.JPG)

## Methodology
1. Create a new project in the Keil uVision5 software, search for the microchip AT89C51RD2 and add the STARTUP.A51 file to the project.
2. Create a new empty document and write all the code is that. Save the file with extension “.asm” and add file to the Source Group
3. In Project menu, select Options for Target and go to the Output tab.
4. Check Create HEX File and click OK button.
5. Thus Translate, Build and Rebuild the project, making sure that there are no errors.
6. Create the project on Proteus Software, and implement the circuit.
7. Copy the destination of the HEX file and insert it in the Edit Component window of the AT89C51RD2 component in the Proteus Software.
8. Thus, we are ready with the simulation of the working project.

## Working of the Project

#### CASE 1: 
Assuming the length of train is very long, the train cuts IR sensor 1 and gates are closed. Then it travels and interrupts IR sensor 2. Now both IR sensors are being blocked. As train passes further, IR sensor 1 is no longer blocked by the train but IR sensor 2 is still being blocked. Eventually train moves further and IR sensor 2 is no more interrupted and the gates are closed. Therefore, the gates will be opened only when both IR sensors are not blocked.

#### CASE 2:
There is a possibility that train passes IR sensor 1 and waits in between. So in such cases, the gates must remain close and open only when the train completely passes through IR sensor 2.

#### CASE 3:
There is a possibility that there is only single engine passing through the sensors. When it blocks IR sensor 1 and moves a little further, IR sensor 1 is again unblocked. Now, the engine is somewhere between IR sensors 1 and 2 but both sensors are unblocked. As per case 1, when both IR sensors are open, the gates shall be opened. That logic is very dangerous in this case because the engine is running somewhere between the two sensor pairs but the gates are open. In order to tackle this issue, a new algorithm is designed. In the new algorithm, the gates will be opened only when there is a block-unblock transition in IR sensor 2 equivalent a similar transition in IR sensor 1.

## Result
1. Green light ON, Train has not arrived yet.
![Working 1](https://user-images.githubusercontent.com/68768741/133892361-0c27e2c6-a3ba-418c-bc59-843f0d6c214d.JPG)

2. Train arrives/is between two sensors, Gate closes/motor rotates clockwise, Green (OFF), Red (ON), Buzzer (ON)
![Working 2](https://user-images.githubusercontent.com/68768741/133892364-58f2af95-7aa2-4d5b-ab97-d32235836a3d.JPG)

3. Train completely passes the IR sensor 2, Gate opens (motor rotates anti-clockwise), RED(OFF), Buzzer (OFF), GREEN(ON)
![Working 3](https://user-images.githubusercontent.com/68768741/133892366-5a8eed63-9aca-4d08-bcae-8ed7511718e9.JPG)


## Simulation
A simulation video has been prepared, uploaded to YouTube for a better understanding of the reader. The video has all the three cases of the project. Feel free to visit the link below.

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/K-KO-GA_Y1M/0.jpg)](http://www.youtube.com/watch?v=K-KO-GA_Y1M)
