CC 	= arm-linux-gcc
LD	= arm-linux-ld
OBJCOPY = arm-linux-objcopy
OBJDUMP = arm-linux-objdump

objs :=  uart.o led.o

all : $(objs)
	$(LD) -r -o dev.o $^

%.o:%.c
	$(CC) -Wall -marm -c -O2 -o $@ $<

%.o:%.S
	$(CC) -Wall -marm -c -O2 -o $@ $<

clean:
	$(RM) *.dis *.bin *.elf *.o
