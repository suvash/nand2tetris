// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Pseudo code
// In an infinite loop
// read input
// if input is not zero (something pressed)
// write black to the whole screen memory

@screen_color
M=-1            // color to print screen

D=0             // intial printscreen argument
@PRINTSCREEN
0;JMP

(LOOP)
@KBD
D=M             // read keyboard input, set argument for printscreen
@PRINTSCREEN
D;JEQ           // if no keypress(input 0) jump to paintscreen
D=-1            // else set argument for printscreen

(PRINTSCREEN)
@input_color
M=D             // read argument and save the input color to variable
@screen_color
D=D-M           // input_color - screen_color

@LOOP
D;JEQ           // Loop back if no difference color
@input_color
D=M
@screen_color
M=D             // else update screen color to be input color

@SCREEN
D=A             // Get the screen address, 16384 for Hack
@x              // iterator index when we write to screen
M=D             // start iterating at the first screen byte


(PRINTLOOP)

@SCREEN
D=A             // Get the screen address
@8192           // total screen is 8K memory blocks of 16 words, for Hack
D=D+A           // address of the byte past the last word in the screen
@x
D=D-M           // iterator address - last screen word address
@LOOP
D;JEQ           // Jump to loop if iterator has arrived at end of screen

@screen_color
D=M             // pick the color
@x
A=M             // set the address
M=D             // set the color at the address

@x
D=M+1
M=D             // x = x + 1, iterator walk one byte forward

@PRINTLOOP
0;JMP
