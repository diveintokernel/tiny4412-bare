.global _start

_start:
@	bl	init_stack
	bl	clean_bss
	ldr	pc, =main				

init_stack:
	ldr	sp, =0x4e000000
	mov	pc, lr

clean_bss:
	ldr	r0, =bss_start
	ldr	r1, =bss_end
	cmp	r0, r1
	moveq	pc, lr

clean_loop:
	mov	r2, #0
	str	r2, [r0], #4
	cmp	r0, r1
	bne	clean_loop
	mov	pc, lr

