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
	lui		s1, %hi(gpio0_base)
	lui 	t0,%hi(0x00040000)
	addi 	t0,t0,%lo(0x00040000)
	sw		t0, gpio_out_en(s1)
1:
	addi	t1, x0, 0
	lui		t2, %hi(0x100000)
	lui		a7, %hi(0x200000)

2:
	sw		t0, gpio_port(s1)
	addi	t1, t1, 1
	bne		t1, t2, 2b
3:
	sw		x0, gpio_port(s1)
	addi	t1, t1, 1
	bne		t1, a7, 3b
	j 1b
