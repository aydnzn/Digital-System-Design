# Laboratory 6 – Up/Down BCD Counting The Number Of Pushes On Buttons and Its FPGA Implementation

## 1. Description

This lab is designed to design a parallel loadable, 2-digit up/down BCD counter. Counting is done by pressing and releasing a push-button switch. The counter can be parallel loaded, up-counted, or down-counted by pressing and releasing one of the three push-button switches. The content of the counter is displayed on two 7-segment LED displays. The counter is implemented on the FPGA board.

## 2. FPGA Implementation of The Up/Down Counter

This lab assignment focuses on the design, synthesis, and implementation of a BCD counter. The assignment's details, including reading the switch, up/down BCD counter, writing the counter content to the LED display, overall design, and pin assignment, are detailed in the full lab manual.

### 2.1 Prelab
For the prelab, VHDL code should be written for frequency divider and debouncer circuit and a parallel loadable 2-digit up/down BCD counter. The functionality of these codes should be verified using ISim.

### 2.2 In Lab
During the lab, Xilinx ISE should be used to synthesize the design based on the Xilinx Spartan VI family. The bit file should be generated and uploaded to the FPGA. The design's functionality should be demonstrated on the hardware.

## 3. Pin Assignments

Please refer to the detailed pin assignment given in the lab manual. Pin assignments for the Nexys3 Board are detailed in the .ucf file in the lab manual.

## 4. Test & Verification


## Work

1. [AND4_Logic_Gate](/Lab6/and4.vhd):
A VHDL implementation of a 4-input AND gate logic (AND4 gate). This script can be used to simulate the AND4 gate logic or synthesize the logic onto an FPGA or any other digital hardware system.

2. [D_Flip-Flop](/Lab6/dff.vhd):
This VHDL script implements a D Flip-Flop, a fundamental building block in digital electronics. It can be used to simulate a D Flip-Flop or synthesize one in a hardware design for an FPGA or another digital system.

3. [main](/Lab6/frequency_divider.vhd):
This VHDL script implements a frequency divider and a 4-bit binary-coded decimal (BCD) counter with the capability to count up, count down, and parallel load. The counter is designed to interact with a 7-segment display for output.

    The script includes three main components:

        - A frequency divider that reduces an input frequency to 100 Hz.
        - A debouncing process that prevents false triggering of the count due to switch bounce. This is implemented through a series of [D Flip-Flops (DFF)](/Lab6/dff.vhd) and [4-input AND gates](/Lab6/and4.vhd).
        - The core BCD counter with up-count, down-count, and parallel load functionality.

The BCD counter values are converted to 7-segment display format, then routed to the display output. The display is refreshed at a rate of 100 Hz to ensure visibility.

4. [Testbench](/Lab6/test7.vhd):
A testbench for the BCD counter module that simulates its behavior by providing predefined inputs and observing the resulting outputs.
