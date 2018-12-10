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

// prci memory mapped registers (relative to gpio0_base)
.set prci_hfrosc_cfg, 0x00
.set prci_hfxosc_cfg, 0x04
.set prci_pll_cfg,    0x08
.set prci_pll_out_div,0x0c

// gpio memory mapped registers (relative to gpio0_base)
.set hfrosc_div, 0x00
.set hfrosc_trim,  0x00
.set hfrosc_en, 0x00
.set hfrosc_ready,   0x00

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

send_zed:
	// write bitmask to gpio_base + gpio_port to turn on led
	sw		t0, gpio_port(s1)
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	// clear gpio_base + gpio_port to turn off led
	sw		x0, gpio_port(s1)
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	jalr	x0, x1, 0

send_one:
	// write bitmask to gpio_base + gpio_port to turn on led
	sw		t0, gpio_port(s1)
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	// clear gpio_base + gpio_port to turn off led
	sw		x0, gpio_port(s1)
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	add		x0, x0, x0
	jalr	x0, x1, 0



_start:
	lui		s0, %hi(prci_base)
	lui 	t0, %hi(0x70000004)
	addi 	t0,t0,%lo(0x70000004)
	sw		t0, prci_hfrosc_cfg(s0)
	lui 	t0, %hi(0x00010ff1)
	addi 	t0,t0,%lo(0x00010ff1)
	sw		t0, prci_pll_cfg(s0)

	// load the GPIO base memory offset to s1.
	// all base addresses occupy only the upper 20 bits of an address, so only lui is needed for bases
	lui		s1, %hi(gpio0_base)
	// load bitmask for gpio pins into t0
	lui 	t0, %hi(0x00040000) // 18th bit means pin 2
	addi 	t0,t0,%lo(0x00040000)
	//		store pin bitmask in gpio_base + gpio_out_en to enable pin 3 as output
	sw		t0, gpio_out_en(s1)

	// set up t2 and a7, these will serve as timeouts for the loops
	lui		t2, %hi(0x100000)
	addi	t2, t2, %lo(0x100000)
	lui		a6, %hi(0x001)
	addi	a6, a6, %lo(0x001)
	addi	x2, x0, 300

1:
	// clear t1 by adding 0 to x0 and storing in t1
	addi	t1, x0, 0

	addi	a7, a6, 0
	addi	a6,a6,1

zeds:
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	addi	a7,a7,-1
	bne		a7,x0, zeds

// green
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one

// red
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed
	jal		x1, send_zed

// blue
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one
	jal		x1, send_one


	sw		t0, gpio_port(s1)
	sw		x0, gpio_port(s1)

sleeploop:
	addi	t1, t1, 1
	bne		t1, t2, sleeploop

	addi	x2, x2, -1
	bne		x2, x0, 2f
	lui		a6, %hi(0x001)
	addi	a6, a6, %lo(0x001)
	addi	x2, x0, 300
2:

	// begin cycle again
	jal x0, 1b
