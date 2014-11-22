#define  GPA0CON (*(volatile unsigned int *)0x11400000)
#define  GPA1CON (*(volatile unsigned int *)0x11400020)
#define  CLK_SRC_PERIL0 (*(volatile unsigned int *)0x1003c250)
#define  CLK_DIV_PERIL0 (*(volatile unsigned int *)0x1003c550)
#define  UFCON0 (*(volatile unsigned int *)0x13800008)
#define  ULCON0 (*(volatile unsigned int *)0x13800000)
#define  UCON0 (*(volatile unsigned int *)0x13800004)
#define  UBRDIV0 (*(volatile unsigned int *)0x13800028)
#define  UFRACVAL0 (*(volatile unsigned int *)0x1380002c)
#define  UTRSTAT0 (*(volatile unsigned int *)0x13800010)
#define  URXH0 (*(volatile unsigned int *)0x13800024)
#define  UTXH0 (*(volatile unsigned int *)0x13800020)

void uart_init(void)
{
        /* set GPIO as UART */
        GPA0CON = 0x22222222;
        GPA1CON = 0x222222;

        CLK_SRC_PERIL0 = ((0 << 20) | (6 << 16) | (6 << 12) | (6 << 8) | (6 << 4) | (6 << 0));

        /* set UART clock divider ratio 
         * CLK_DIV_PERIL0 : bit[3:0] UART0_RATIO=7 SCLK_UART0=MOUTUART0/(7+1)=100MHz
         */
        CLK_DIV_PERIL0 = ((0 << 20) | (7 << 16) | (7 << 12) | (7 << 8) | (7 << 4) | (7 << 0)); 

        UFCON0 = 0x111;

        ULCON0 = 0x3;

        UCON0 = 0x5;

        UBRDIV0 = 53;
        UFRACVAL0 = 4;
}


char get_char(void)
{
        char c;

        while (!(UTRSTAT0 & (1<<0)));

        c = URXH0;

        return c; 
}

void put_char(char c)
{
        while (!(UTRSTAT0 & (1<<2)));
       
        UTXH0 = c;

        return; 
}

void put_string(char *str)
{
        while (*str != '\0')
        {
                put_char(*str);
                str++;
        }

        return ;
}
