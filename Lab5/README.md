# LABORATORY 5 – Conversion of 6-bit Floating Point Numbers into Sign-Magnitude Representation and its FPGA Implementation

## Overview

This laboratory explores the design and implementation of a decoder that converts a 6-bit floating point representation into a sign-magnitude representation. The output is displayed in Binary Coded Decimal (BCD) format using seven-segment LED displays on an FPGA board. The project promotes understanding of nonlinear encoding methods utilized in practical systems and representation of signals via numbers approximating their logarithmic values. A simplified floating-point representation comprising one sign bit, a 2-bit exponent, and a 3-bit significand is used in this lab.

## FPGA Implementation

Implementation of this project involves reading the slide switches, sequentially displaying the sign-magnitude number on the four-digit seven-segment LED displays, and converting a 6-bit binary number into a two-digit BCD. VHDL code is provided for tasks like sequential display of digits on the four-digit seven-segment LED displays and the conversion of the 6-bit binary number into a two-digit BCD.

## Pin Assignment

After completion of the design, compilation, ISim simulations, and synthesis, validation of the design on the FPGA board is necessary. This involves linking the input and output ports of the design to the appropriate pins of the FPGA. Pin assignment on the FPGA can be done either manually or by utilizing the provided .ucf file before synthesis.

## Contents

1. [UCF_file](/Lab5/lab5.ucf):
This script details pin assignments for the Nexys3 Spartan VI Board, a programmable logic device. It maps board elements (slide switches and seven-segment display units) to their corresponding locations on the board and specifies the input/output standard for each pin. The script also designates a pin for the board clock.

2. [VHDL_code](/Lab5/lab5ff23desk07.vhd):
This VHDL script describes the behavioral design of the 'lab5ff23desk07' module. It performs decoding and multiplexing operations on a 6-bit floating point number via a multi-stage process:
   - Decomposition: The 6-bit number is broken down into significand and exponent.
   - Multiplication: The significand is multiplied by 2 raised to the power of the exponent, resulting in a 7-bit number.
   - Division: The 7-bit number is divided into units and tens.
   - Display: Each segment (units and tens) is converted into a seven-segment display representation.
Additionally, multiplexing operations are carried out at a frequency of 400Hz, refreshing each seven-segment display at a frequency of 100Hz in a round-robin fashion.

3. [Testbench](/Lab5/test2.vhd):
This VHDL testbench script is designed to test the 'lab5ff23desk07' module. It simulates the module's functionality by providing it with inputs and recording its outputs. Given that the testbench interacts with signals for slide switches (FP) and seven-segment display segments (SSEG_CA and SSEG_AN), the module appears to be a display system. The testbench also includes a simulated clock signal with a defined period, and it provides the module with specific stimuli to examine its functionality under different conditions.
