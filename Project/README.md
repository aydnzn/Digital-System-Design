# Final Project - FPGA Based Timer Game

## Overview
The project is a FPGA based timer game inspired by a design project available on Instructables website[1].

## Goals
In the game, a string of LEDs lights up sequentially with one LED being a different color. The goal is to press a button at the moment the differently colored LED lights up. 
- Start the game with 3 lives. Lose a life each time the button is pressed at the wrong time. 
- The game ends when all lives are lost. 
- Score increases each time the button is pressed at the right time. The game speeds up at each level.
- Display current score at any time. 
- On game over, if the final score is the highest ever, it replaces the high score and "High Score" is displayed. Otherwise, "Lose" is displayed.
- Earn an additional life at every tenth level.

## Required Tools
- FPGA board
- LEDs (9 red and 1 yellow)
- Jumper Wires (Male-Male)
- Breadboard
- Computer and Software
- VGA-compatible Monitor (for Display)

## Contents

1. [UCF_file](/Project/proje.ucf):

The UCF provides the physical mapping and interface standards for an FPGA design. It is the blueprint linking logical signals to specific pins on the FPGA according to the project's needs. Main aspects covered in this UCF file include:

- Allocation of specific pins for clock, reset, button inputs, and various display-related signals (i.e., vertical and horizontal sync, RGB signals).
- Detailed mapping of pins for the 8-bit 'q' output and the color components of an RGB signal.
- Override of the default dedicated clock routing for 'button1'.
- Pin assignments and I/O standards specification for the seven-segment display's cathodes (SSEG_CA) and anodes (SSEG_AN).

This file employs LVCMOS33 as the I/O standard and provides a hardware configuration necessary for the synthesis, place, and route stages in the FPGA design process.
2. [VHDL_code](/Project/aydingokberk.vhd):

This VHDL script constitutes the core of a timer-based LED game. The script segments can be related to the game's functionality as follows:

- LED Timer Game: The routine responsible for the game flow controls the LEDs and validates the player's response time. The variable 'qout' orchestrates the LED sequence. Success in the game depends on the player's ability to respond in time to the lit sequence. Each timely response advances the game to a new level with a unique LED sequence.
- Lives and Scoring: The player starts with three lives, represented by 'can'. With each mistimed response, 'can' decreases. The player's score, represented by 'temp', increases with each timely button press, while 'hhhs' holds the highest score attained in the game.
- Difficulty and Extra Lives: The game speed increases with each level, challenging the player more. Every tenth level awards an extra life to the player.
Seven-Segment Display: The player's score and the highest score are exhibited on a seven-segment display, driven by 'temp' and 'hhhs'.
- Game Over: The game concludes when the player runs out of lives. A high score prompts a "high score" display, otherwise, the player sees a "lose" message.

This code intricately assembles a time-critical game, challenging players to beat their highest score by responding accurately to the LED sequence.

3. [Proposal](/Project/proposal.pdf): 

This is the original project proposal document presented in PDF format.

## Team Members
- Aydın Uzun 
- Gökberk Erdoğan

## Reference
[1] [Nexys3 LED Timer Game](http://www.instructables.com/id/Nexys3-LED-Timer-Game/)
