/*
 * (C) Copyright 2011 Samsung Electronics Co. Ltd
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 */

#include "tiny4412.h"
#include "exynos4412.h"
#include "tiny4412_val.h"

/*
 * system_uart_init: Initialize UART in asm mode, 115200bps fixed.
 * void system_uart_init(void)
 */
	.globl system_uart_init
system_uart_init:

	/* set GPIO to enable UART */
	@ GPIO setting for UART for UART0/1/2/3
	
	ldr r0, =0x11400000
	ldr r1, =0x22222222
	str r1, [r0]
	ldr r0, =0x11400020
	ldr r1, =0x222222
	str r1, [r0]

	ldr r0, =S5PV310_CLOCK_BASE
	ldr r1, =CLK_SRC_PERIL0_VAL
	ldr r2, =CLK_SRC_PERIL0_OFFSET
	str r1, [r0, r2]
	ldr r1, =CLK_DIV_PERIL0_VAL
	ldr r2, =CLK_DIV_PERIL0_OFFSET
	str r1, [r0, r2]

	ldr r0, =S5PV310_UART_CONSOLE_BASE
	ldr r1, =0x111
	str r1, [r0, #UFCON_OFFSET]

	mov r1, #0x3
	str r1, [r0, #ULCON_OFFSET]

	ldr r1, =0x3c5
	str r1, [r0, #UCON_OFFSET]

	ldr r1, =UART_UBRDIV_VAL
	str r1, [r0, #UBRDIV_OFFSET]

	ldr r1, =UART_UDIVSLOT_VAL
	str r1, [r0, #UDIVSLOT_OFFSET]

	ldr r1, =0x4f4f4f4f
	str r1, [r0, #UTXH_OFFSET]		@'O'

	mov pc, lr


	.globl uart_asm_putc
uart_asm_putc:
	push	{r9}
	ldr r9, =S5PV310_UART_CONSOLE_BASE
	str r0, [r9, #UTXH_OFFSET]
	ldr r9, =0x20000				@delay
.Luartputc:
	sub r9, r9, #1
	cmp r9, #0
	bne .Luartputc
	pop {r9}
	mov pc, lr


	.globl uart_asm_putx
uart_asm_putx:
	stmfd sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, #28
.Luartputx:
	mov r0, r5, asr r4
	and r0, r0, #15
	cmp r0, #9
	addle	r0, r0, #48
	addgt	r0, r0, #55
	bl	uart_asm_putc
	sub r4, r4, #4
	cmn r4, #4
	bne .Luartputx
	ldmfd sp!, {r3, r4, r5, pc}

