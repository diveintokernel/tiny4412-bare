#define  GPM4CON        (*(volatile unsigned int *)0x110002e0)
#define  GPM4DAT        (*(volatile unsigned int *)0x110002e4)


void led_init()
{
	unsigned long tmp = 0;

        /*
         * set GPM4_0~GPM4_3  as output
         **/
        tmp = GPM4CON;
        tmp &= ~0xffff;
        tmp |= 0x1111;
        GPM4CON = tmp;
}

void led_off()
{
	GPM4DAT = 0xf;
}

void led_on()
{
	GPM4DAT = 0x0;
}
