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

.set uart_txdata, 0x00
.set uart_rxdata, 0x04
.set uart_txctl,  0x08
.set uart_rxctl,  0x0c
.set uart_ie,     0x10
.set uart_ip,     0x14
.set uart_div,    0x18

.set uart0_iof_mask, 0x00030000
.set uart_rxtx_en,  0x00000001

.set gpio_in_val, 0x00
.set gpio_in_en,  0x04
.set gpio_out_en, 0x08
.set gpio_port,   0x0c
.set gpio_iof_en, 0x38
.set gpio_iof_sel,0x3c

.set prci_hfrosccfg, 0x00
.set prci_hfxosccfg, 0x04
.set prci_pllcfg,    0x08
.set prci_plloutdiv, 0x0c

.set prci_rosc_en, 0x20000000
.set prci_pll_sel, 0x00038000 # bits 16, 17, and 18 are set


.macro set_val base offset val
	lw		t0, \offset(\base)
	lui		t1, %hi(\val)
	addi	t1, t1, %lo(\val)
	or		t0, t0, t1
	sw		t0, \offset(\base)
.endm

.macro clr_val base offset val
	lw		t0, \offset(\base)
	lui		t1, %hi(\val)
	addi	t1, t1, %lo(\val)
	neg		t1, t1
	and		t0, t0, t1
	sw		t0, \offset(\base)
.endm

.section .rodata
	.word 0x0

.section .text
.align 2
.globl _start

j _start

uart_write:
	lui		a6, %hi(uart0_base)
1:
	lw		a5, uart_txdata(a6)		# get the uart register
	blt		a5,x0,1b

	sw		a0, uart_txdata(a6)

	jalr x0, x1, 0
//	c.jr x1
//	ret


uart_read:
	lui		a6, %hi(uart0_base)
1:
	lw		a5, uart_rxdata(a6)	# get the config register
	blt		a5, x0, 1b
	andi	a0, a5, 0xff
	jalr x0, x1, 0

uart_read_nb:
	lui		a6, %hi(uart0_base)

	lw		a5, uart_rxdata(a6)	# get the config register
	blt		a5, x0, 2f
	addi	a0,x0,1
	jalr x0, x1, 0

2:
	add a0, x0, x0
	jalr x0, x1, 0


_start:
	lui		s0, %hi(prci_base)

	lw		t0, prci_hfrosccfg(s0)	# get the config register
	lui		t1, %hi(prci_rosc_en)
	or		t0, t0, t1				# set enable bit
	sw		t0, prci_hfrosccfg(s0)	# commit the updated config register

	lw		t0, prci_pllcfg(s0)		# get the pll config register
	lui		t1, %hi(prci_pll_sel)
	or		t0, t0, t1				# set sel, refsel, and bypass bits
	sw		t0, prci_pllcfg(s0)		# commit the updated pll config register

	lw		t0, prci_hfrosccfg(s0)	# get the config register
	lui		t1, %hi(prci_rosc_en)
	neg		t1, t1					# reverse the mask
	and		t0, t0, t1				# clear enable bit
	sw		t0, prci_hfrosccfg(s0)	# commit the updated config register

	lui		s1, %hi(gpio0_base)

	addi	t0, x0, 0x01
	neg		t0, t0					# this puts a 0xffffffff in the t0 register
	sw		t0, gpio_out_en(s1)

	lw		t0, gpio_port(s1)		# get the gpio port (output val) register
	lui		t1, %hi(uart0_iof_mask)
	or		t0, t0, t1				# set uart bits
	sw		t0, gpio_port(s1)		# commit the updated port register

	lw		t0, gpio_out_en(s1)		# get the gpio enable register
	lui		t1, %hi(uart0_iof_mask)
	or		t0, t0, t1				# set uart bits
	sw		t0, gpio_out_en(s1)		# commit the updated enable register

	lw		t0, gpio_iof_sel(s1)	# get the gpio hw function register
	lui		t1, %hi(uart0_iof_mask)
	neg		t1, t1					# reverse the mask
	and		t0, t0, t1				# clear uart bits
	sw		t0, gpio_iof_sel(s1)	# commit the updated hw select register

	lw		t0, gpio_iof_en(s1)		# get the gpio hw func enable register
	lui		t1, %hi(uart0_iof_mask)
	or		t0, t0, t1				# set uart bits
	sw		t0, gpio_iof_en(s1)		# commit the updated hw enable register

	lui		s2, %hi(uart0_base)

	lui		t0, %hi(138)
	addi	t0, t0, %lo(138)
	sw		t0, uart_div(s2)		# commit uart divisor

	lw		t1, uart_txctl(s2)		# get the uart transmit control register
	lui		t0, %hi(uart_rxtx_en)
	addi	t0, t0, %lo(uart_rxtx_en)
	or		t0, t0, t1
	sw		t0, uart_txctl(s2)		# commit uart tx control register

	lw		t1, uart_rxctl(s2)		# get the uart receive control register
	lui		t0, %hi(uart_rxtx_en)
	addi	t0, t0, %lo(uart_rxtx_en)
	or		t0, t0, t1
	sw		t0, uart_rxctl(s2)		# commit uart rx control register

1:
	jal		x1, uart_read
	jal		x1, uart_write

	j 1b
