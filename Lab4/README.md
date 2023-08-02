# LABORATORY 4 – COUNTERS

This repository hosts all the source files and documentation related to Laboratory 4: Counters. Here, you'll find information on the physical components used, conceptual overview, preparation steps, lab work undertaken, FPGA programming, and associated VHDL code and UCF files.

## Materials

The following materials were used in this laboratory session:

- Breadboard
- Lots of wires
- [74HC73_dual_JK_Flip-Flops](/Lab4/74HC73.pdf)
- [74HC00](/Lab4/7400.pdf)
- [74HC4510](/Lab4/HCT4510.pdf)
- Resistances

## Concept

The laboratory consisted of two main parts: designing circuits using off-the-shelf ICs, and utilizing an FPGA board with VHDL programming for a 4-bit synchronous binary counter design.

## Preparation

Before the actual lab session, the following tasks were accomplished:

- Prepared wiring diagrams for the following types of counters:
    - Count-up ripple counter
    - Decade ripple counter
    - Two-stage counter
    - Light-sensitive two-stage counter

- Authored VHDL code for a 4-bit synchronous binary counter and performed preliminary testing in the Project Navigator.

## Lab Work

During the lab session, the following tasks were undertaken:

- Constructed and tested an asynchronous (ripple) counter
- Constructed and tested a count-up ripple counter
- Constructed and tested a decade ripple counter
- Constructed and tested a two-stage counter
- Constructed and tested a light-sensitive two-stage counter

## FPGA Programming

The following tasks were accomplished related to FPGA programming:

- Designed a 4-bit synchronous binary up-counter using VHDL and implemented it on the FPGA board.
- Mapped the I/O ports of the VHDL entity to the FPGA board's pin using the UCF file.


## Work

1. [UCF_file](lab4count4.ucf):
This UCF file provides necessary constraints to the FPGA design software about the physical implementation of the design. It ensures that the FPGA programming software correctly maps the design onto the physical chip.

2. [VHDL_code](lab4test.vhd):
This VHDL code is the primary source file for the 4-bit synchronous binary counter. It describes a complex digital circuit that performs a series of logical operations (AND and XOR) based on the 'EN' input and maintains state using FDCE flip-flops.

2. [Testbench](lab4test.vhd)
This is a testbench for the lab4desk07ff23 module. It is used to simulate and verify the behavior of the binary counter under a specific set of conditions and timing sequences. The testbench generates specific signal patterns and monitors the outputs to verify the correctness of the lab4desk07ff23 module.