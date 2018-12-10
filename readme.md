tut_rv32_examples
=================

Examples and supporting files to go along with the RISCV32 tutorials on BetterOS.org


# config files

This package contains several files needed for development and programming 
for the HiFive1 development board. These files are enumerated below:
 - config/flash.lds
 
 Linker script for gcc/ld. Controls how the program is laid out in memory.
 - config/openocd.cfg
 
 Configuration file for OpenOCD. Needed for OpenOCD to communicate properly with the HiFive1.


# source code examples

the src directory contains several assembly code examples intended to be 
used in conjunction with the corresponding tutorial on BetterOS.org.


 - src/blink.S

 A very simple "hello world" type assembly program. Blinks an LED connected to GPIO pin 2 (HiFive1)

 - src/breathe.S

 Demonstrates simple PWM configuration.

 - src/uart_echo.S

 Demonstrates simple UART communication (echos all characters received).
