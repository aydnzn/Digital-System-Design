# Laboratory 7 – Simple VGA Driver to Display 256 Different Colors

This project is part of the course 'Digital System Design Lab'. The purpose of this lab is to design a VGA driver to display 256 different colors on a monitor. The color data of each pixel is generated using an 8 bit counter implemented on an FPGA board.

## Description

The VGA driver project generates two timing signals, `vsync` and `hsync`, to synchronize the plotting of vertical and horizontal pixels respectively. The color data for each pixel is represented by the 8-bit counter, with the first 3-bits for red, next 3-bits for green, and last 2-bits for blue. The counter counts up, and as it does, 256 different color combinations are displayed on the screen.

The VGA driver is implemented on a FPGA board and generates a video signal that can be displayed on a VGA monitor. 

## VGA Signal Timing

This project uses VGA signal timing, which is composed of `h` lines with `w` pixels each. A frame size is typically defined as `w x h` with sizes such as 640 x 480, 800 x 600, 1024 x 768, and 1280 x 1024. For this lab, we aim for a 640 x 480 size.

## Design and Implementation

This project is implemented in VHDL and is intended to be run on an FPGA. It includes several components such as frequency divider, synchronization signal generators, color generator and overall design, which are all written in VHDL. 

## Pin Assignment

We have assigned pins for the Nexys3 board to make the connection with the FPGA board. The pin assignment is found in the `ucf` file in the project directory. 

## Components

### 1. [VGA Driver](/Lab7/ee240_vgadriver.vhd):

`ee240_vgadriver.vhd` is a VGA driver written in VHDL. It takes two inputs - a reset signal (`nreset`) and a clock signal (`board_clk`) and produces two synchronization signals (`vsync` and `hsync`) along with RGB color signals.

Key aspects of the VGA driver script include frequency division of the board clock, position counters, generation of sync signals, video control process, color generator, and RGB output.

### 2. [Testbench](/Lab7/test2.vhd):

`test2.vhd` is a VHDL test bench script for the VGA driver. It simulates different states of the `nreset` and `board_clk` signals and observes the VGA driver's response. This test bench is essential for ensuring the VGA driver's correctness under different operating conditions.

### 3. [UCF File](/Lab7/lab7pin.ucf):

`lab7pin.ucf` is a script that specifies the physical pin locations on the FPGA for different signals used in the VGA driver. Assigning signals to specific locations on the FPGA is crucial for correctly interfacing the VGA driver with external devices.