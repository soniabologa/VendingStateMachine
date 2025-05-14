# VendingStateMachine

A finite state machine (FSM) simulation of a vending machine controller, created in VHDL using Xilinx Vivado.  
Developed as part of the ECE238L course at the University of New Mexico.

---

## Course Info

- **Course:** ECE238L – Computer Logic Design Lab  
- **Institution:** University of New Mexico  
- **Instructor:** Dr. Siamak Tavakoli  
- **Semester:** Spring 2025

---

## Project Description

This project implements a simplified FSM-based controller for a vending machine that sells candy bars for 25 cents.  
It accepts **nickels**, **dimes**, and **quarters**, and handles both **product dispensing** and **change return**.

### Features

- Accepts: `nickel_in`, `dime_in`, `quarter_in`
- Outputs:  
  - `candy_out`: Candy bar is dispensed  
  - `nickel_out`: Nickel returned as change  
  - `dime_out`: Dime returned as change  
- State-based logic includes the following states:  
  `st0, st5, st10, st20, st25, st30, st40, st45`
- In states `st25`, `st30`, `st35`, `st40`, and `st45`, a candy bar is dispensed along with appropriate change
- Includes:
  - 2 ms clock input
  - Asynchronous reset
- Written in **VHDL**
- Built with **Vivado 2020.2**

---

## How to Run

1. Clone or download this repository.
2. Open the `VendingMachine.xpr` file using **Vivado 2020.2**.
3. Synthesize, implement, and simulate the design.
4. Program your FPGA board (if applicable) to test hardware functionality.

---

## Demonstrations

- ** [Slides Presentation](https://docs.google.com/presentation/d/160RVL8m7Wzv7XOxNfjxDkiPdNg1fDX_sbmdaGZ528s0/edit?usp=sharing)**
- ** [Demo Video](https://photos.app.goo.gl/uMSAQjsASWjJdFGf8)**
