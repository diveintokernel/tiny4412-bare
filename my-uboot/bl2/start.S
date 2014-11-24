.text
.global _start
_start:
        b       reset
        ldr     pc, _undefined_instruction
        ldr     pc, _software_interrupt
        ldr     pc, _prefetch_abort
        ldr     pc, _data_abort
        ldr     pc, _not_used
        ldr     pc, _irq
        ldr     pc, _fiq

_undefined_instruction: .word   undefined_instruction
_software_interrupt:    .word   software_interrupt
_prefetch_abort:        .word   prefetch_abort
_data_abort:            .word   data_abort
_not_used:              .word   not_used
_irq:                   .word   irq
_fiq:                   .word   fiq


undefined_instruction:
        nop

software_interrupt:
        nop

prefetch_abort:
        nop

data_abort:
        nop

not_used:
        nop

irq:
        nop

fiq:
        nop

reset:
        bl      set_svc
        bl      disable_watchdog
        bl      enable_icache

        // 调用C函数之前必须设置栈,栈用于保存运行环境,给局部变量分配空间
        // 参考ROM手册P14, 我们把栈指向BL2上方1K处(1K已经够用),
        // 即:0x02020000 (iRAM基地址) + 5K(iROM代码用) + 8K(BL1用) + 16K(BL2用) + 1K(用作栈))
	ldr     sp, =0x02060000
       // ldr     sp, =0x02027800 

        bl      system_clock_init       // 调用时钟初始化函数 
        bl      system_uart_init        
        bl      system_mem_init     
        bl      copy_code_to_dram 

        // never come here
halt_loop:
        b       halt_loop

set_svc:
        mrs     r0, cpsr
        bic     r0, r0, #0x1f
        orr     r0, r0, #0xd3
        msr     cpsr, r0
        mov     pc, lr

#define WTCON   0x10060000
disable_watchdog:
        ldr     r0, =WTCON
        mov     r1, #0x0
        str     r1, [r0]
        mov     pc, lr


disable_mmu:
        mcr     p15, 0, r0, c7, c7, 0
        mrc     p15, 0, r0, c1, c0, 0
        bic     r0, r0, #0x00000007
        mcr     p15, 0, r0, c1, c0, 0
        mov     pc, lr

enable_icache:
        mrc     p15, 0,  r0, c1, c0, 0
        orr     r0, r0,  #0x00001000   //enable I cache
        mcr     p15, 0,  r0, c1, c0, 0
        mov     pc, lr

