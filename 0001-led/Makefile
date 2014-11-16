CC 	= arm-linux-gcc
LD	= arm-linux-ld
OBJCOPY = arm-linux-objcopy
OBJDUMP = arm-linux-objdump

led.bin: led.S
	$(CC) -c -o led.o led.S
	$(LD)	-Tled.lds -N led.o -o led.elf
	$(OBJCOPY) -O binary -S led.elf  led.bin
	$(OBJDUMP) -D -m arm led.elf > led.dis
clean:
	$(RM) *.dis *.bin *.o *.elf
