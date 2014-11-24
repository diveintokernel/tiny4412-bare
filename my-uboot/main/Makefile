CC 	= arm-linux-gcc
LD	= arm-linux-ld
OBJCOPY = arm-linux-objcopy
OBJDUMP = arm-linux-objdump

CFLAGS := -fno-builtin -I$(shell pwd)/include
export CFLAGS

OBJS := start.o main.o dev/dev.o lib/lib.o

boot.bin : boot.elf 
	$(OBJCOPY) -O binary -S boot.elf $@

boot.elf: $(OBJS)
	$(LD) -Tboot.lds -o boot.elf $^

%.o:%.c
	$(CC)  $(CFLAGS) -Wall -marm -c -O2 -o $@ $<

%.o:%.S
	$(CC)  $(CFLAGS) -Wall -marm -c -O2 -o $@ $<

lib/lib.o : 
	make -C lib all

dev/dev.o :
	make -C dev all

.PHONY: clean
clean:
	$(RM) *.dis *.bin *.elf *.o
	make -C lib clean
	make -C dev clean
