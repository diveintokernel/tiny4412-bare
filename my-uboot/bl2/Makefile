CC 	= arm-linux-gcc
LD	= arm-linux-ld
OBJCOPY = arm-linux-objcopy
OBJDUMP = arm-linux-objdump

objs := start.o system_clock_init.o system_mem_init.o system_uart_init.o mmc_relocate.o
bl2.bin: $(objs)
	$(LD) -Tbl2.lds -N -o bl2.elf $^
	$(OBJCOPY) -O binary -S bl2.elf $@
	$(OBJDUMP) -D -m arm bl2.elf >  bl2.dis
%.o:%.c
	$(CC)  -Wall -marm -c -O2 -o $@ $<
%.o:%.S
	$(CC)  -Wall -marm -c -O2 -o $@ $<

clean:
	$(RM) *.dis *.bin *.elf *.o

