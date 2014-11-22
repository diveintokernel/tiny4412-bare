CC 	= arm-linux-gcc
LD	= arm-linux-ld
OBJCOPY = arm-linux-objcopy
OBJDUMP = arm-linux-objdump

objs := start.o main.o system_clock.o uart_init.o
main.bin: $(objs)
	$(LD) -Tmain.lds -N -o main.elf $^
	$(OBJCOPY) -O binary -S main.elf $@
	$(OBJDUMP) -D -m arm main.elf >  main.dis
%.o:%.c
	$(CC)  -Wall -marm -c -O2 -o $@ $<
%.o:%.S
	$(CC)  -Wall -marm -c -O2 -o $@ $<

clean:
	$(RM) *.dis *.bin *.elf *.o

