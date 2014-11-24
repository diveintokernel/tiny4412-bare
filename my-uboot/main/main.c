#define  GPM4CON        (*(volatile unsigned int *)0x110002e0)
#define  GPM4DAT        (*(volatile unsigned int *)0x110002e4)


void delay(volatile int time)
{
        for(; time > 0; time--)
                ;
}

int main(void)
{

	int num = 0;

	led_init();

	while(1)
	{
		put_string("hello\n\r");
		led_off();
		delay(9999999);
		delay(9999999);
		delay(9999999);
		led_on();
		delay(9999999);
		delay(9999999);
		delay(9999999);
	}


	while(1)
	{
		printf("******************************************\n\r");
		printf("*************BOOTLODER********************\n\r");
		printf("1: Download Linux Kernel from TFTP Server!\n\r");
		printf("2: Boot Linux form RAM!\n\r");
		printf("3: Boot Linux form Nand Flash\n\r");
		printf("\n Please Select:");

		scanf("%d", &num);

		switch (num)
		{
			case 1:
			//tftp_load();
			break;

			case 2:
			//boot_linux_ram();
			break;
		
			case 3:
			//boot_linux_nand();
			break;

			default:
				printf("Error: wrong selection!\n\r");
			break;
		}
	}

	return 0;
}
