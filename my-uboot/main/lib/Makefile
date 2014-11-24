CC 	= arm-linux-gcc
LD	= arm-linux-ld
OBJCOPY = arm-linux-objcopy
OBJDUMP = arm-linux-objdump

objs := div64.o lib1funcs.o ctype.o muldi3.o printf.o string.o vsprintf.o

all : $(objs)
	$(LD) -r -o lib.o $^

%.o:%.c
	$(CC)  $(CFLAGS) -Wall -marm -c -O2 -o $@ $<

%.o:%.S
	$(CC)  $(CFLAGS) -Wall -marm -c -O2 -o $@ $<

clean:
	$(RM) *.dis *.bin *.elf *.o
