.text
.global _start
_start:
        // 调用C函数之前必须设置栈,栈用于保存运行环境,给局部变量分配空间
        // 参考ROM手册P14, 我们把栈指向BL2上方1K处(1K已经够用),
        // 即:0x02020000 (iRAM基地址) + 5K(iROM代码用) + 8K(BL1用) + 16K(BL2用) + 1K(用作栈))
        ldr     sp, =0x02027800         // 调用main函数(main这个名称不是固定的，可以随意改)
        
        // diable the watchdog
        ldr     r0, =0x10060000
        mov     r1, #0
        str     r1, [r0]

        // enablel the I cache
        mrc     p15, 0,  r0, c1, c0, 0
        orr     r0, r0,  #0x00001000   //enable I cache
        mcr     p15, 0,  r0, c1, c0, 0


        bl      system_clock_init       // 调用时钟初始化函数 
       
relocate: 
        adr     r0, _start
        ldr     r1, =_start
        ldr     r2, =bss_start
        cmp     r0, r1
        beq     clean_bss 
copy_loop:
        ldr     r3, [r0], #4
        str     r3, [r1], #4
        cmp     r1, r2
        bne     copy_loop
clean_bss:
        ldr     r0, =bss_start
        ldr     r1, =bss_end
        cmp     r0, r1
        beq     run_on_ram
        mov     r2, #0
clear_loop:
        str     r2, [r0], #4
        cmp     r0, r1
        bne     clear_loop
run_on_ram:
        
        ldr     pc, =main

        // never come here
halt_loop:
        b       halt_loop
