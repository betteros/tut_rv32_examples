// definitions for memory mapped register bases
.set clint_base, 0x02000000
.set plic_base,  0x0c000000
.set aon_base,   0x10000000
.set prci_base,  0x10008000
.set gpio0_base, 0x10012000
.set uart0_base, 0x10013000
.set pwm0_base,  0x10015000
.set uart1_base, 0x10023000
.set pwm1_base,  0x10025000
.set pwm2_base,  0x10035000

// gpio memory mapped registers (relative to gpio0_base)
.set gpio_in_val, 0x00
.set gpio_in_en,  0x04
.set gpio_out_en, 0x08
.set gpio_port,   0x0c
.set gpio_iof_en, 0x38
.set gpio_iof_sel,0x3c

.section .text
.align 2
.globl _start

_start:
	// load the GPIO base memory offset to s1.
	// all base addresses occupy only the upper 20 bits of an address, so only lui is needed for bases
	lui		s1, %hi(gpio0_base)
	// load bitmask for gpio pins into t0
	lui 	t0, %hi(0x00040000) // 19th bit means pin 3
	addi 	t0,t0,%lo(0x00040000)
	//		store pin bitmask in gpio_base + gpio_out_en to enable pin 3 as output
	sw		t0, gpio_out_en(s1)

	// set up t2 and a7, these will serve as timeouts for the loops
	lui		t2, %hi(0x10000)
	lui		a7, %hi(0x15000)

1:
	// clear t1 by adding 0 to x0 and storing in t1
	addi	t1, x0, 0

2:
	// write bitmask to gpio_base + gpio_port to turn on led
	sw		t0, gpio_port(s1)

	// increment t1 and loop until t1 reaches t2
	addi	t1, t1, 1
	bne		t1, t2, 2b

3:
	// clear gpio_base + gpio_port to turn off led
	sw		x0, gpio_port(s1)

	// increment t1 and loop until t1 reaches a7
	addi	t1, t1, 1
	bne		t1, a7, 3b

	// begin cycle again
	// j i is shorthand for jal x0, i
	j 1b
