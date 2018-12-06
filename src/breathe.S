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
.set gpio_out_xor,0x40

//.set led_mask, 0x00000001 // bit 1 is set (gpio 1 / hifive1 pin 9 / pwm0_1)
.set led_mask, 0x00680000

.set prci_hfrosccfg, 0x00
.set prci_hfxosccfg, 0x04
.set prci_pllcfg,    0x08
.set prci_plloutdiv, 0x0c

.set prci_rosc_en, 0x20000000
.set prci_pll_sel, 0x00038000 // bits 16, 17, and 18 are set

.set pwm_cfg,   0x00
.set pwm_count, 0x08
.set pwm_s,     0x10
.set pwm_cmp0,  0x20
.set pwm_cmp1,  0x24
.set pwm_cmp2,  0x28
.set pwm_cmp3,  0x2C


.macro set_bit base offset val
	lw		t0, \offset(\base)
	lui		t1, %hi(\val)
	addi	t1, t1, %lo(\val)
	or		t0, t0, t1
	sw		t0, \offset(\base)
.endm

.macro set_val base offset val
	add		t0, x0, \val
	sw		t0, \offset(\base)
.endm

.macro set_vali base offset val
	lui		t0, %hi(\val)
	addi	t0, t0, %lo(\val)
	sw		t0, \offset(\base)
.endm

.macro clr_bit base offset val
	lw		t0, \offset(\base)
	lui		t1, %hi(\val)
	addi	t1, t1, %lo(\val)
	neg		t1, t1
	and		t0, t0, t1
	sw		t0, \offset(\base)
.endm

.section .data
	led_buffer:
	.word 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
	.word 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
	.word 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
	.word 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
	.word 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
	led_n: .word 40

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

	set_bit	s0, prci_hfrosccfg, prci_rosc_en
	set_bit s0, prci_pllcfg, prci_pll_sel
	clr_bit s0, prci_hfrosccfg, prci_rosc_en

	lui		s1, %hi(gpio0_base)

	set_bit s1, gpio_iof_sel, led_mask
	set_bit s1, gpio_iof_en,  led_mask
	clr_bit s1, gpio_out_xor, led_mask

/*
  GPIO_REG(GPIO_IOF_SEL)    |= ( (1 << GREEN_LED_OFFSET)  | (1 << BLUE_LED_OFFSET) | (1 << RED_LED_OFFSET));
  GPIO_REG(GPIO_IOF_EN )    |= ( (1 << GREEN_LED_OFFSET)  | (1 << BLUE_LED_OFFSET) | (1 << RED_LED_OFFSET));
  GPIO_REG(GPIO_OUTPUT_XOR) &= ~( (1 << GREEN_LED_OFFSET) | (1 << BLUE_LED_OFFSET));
  GPIO_REG(GPIO_OUTPUT_XOR) |= (1 << RED_LED_OFFSET);
*/

//----------------------------------------------------------------------
	lui		s2, %hi(pwm1_base)

  // Set up RGB PWM

	set_vali s2, pwm_cfg,  0x00001200 // cmp1center | en_always | cmpzero
	set_vali s2, pwm_count, 0x00000000
	set_vali s2, pwm_cmp0,  0x000000FF

//  PWM1_REG(PWM_CFG)   = 0;
  // To balance the power consumption, make one left, one right, and one center aligned.
//  PWM1_REG(PWM_CFG)   = (PWM_CFG_ENALWAYS) | (PWM_CFG_CMP2CENTER);
//  PWM1_REG(PWM_COUNT) = 0;

  // Period is approximately 244 Hz
  // the LEDs are intentionally left somewhat dim, 
  // as the full brightness can be painful to look at.
//  PWM1_REG(PWM_CMP0)  = 0;
//----------------------------------------------------------------------

	addi a0,x0,0x000
	addi a1,x0,0x000
	addi a2,x0,0x000
	addi s6,x0,1
	addi s7,x0,0x0fe

5:

	lui 	t0, %hi(0x00010000)
1: // loop to waste some time
	addi	t0, t0, -1
	bne		t0, x0, 1b

//	addi	a0,a0,0x01
//	addi	a1,a1,0xf0
//	addi	a2,a2,0x0f

	set_val s2, pwm_cmp1, a2
	set_val s2, pwm_cmp2, a1
	set_val s2, pwm_cmp3, a0

	blt	s6,x0,2f
	j 1f
1:
	addi	a2,a2,0x1
	bne		a2,s7,5b
	addi	s6,x0,-1
	j 5b
2:
	addi	a2,a2,-0x1
	bne		a2,x0,5b
	addi	s6,x0,1
	j 5b
