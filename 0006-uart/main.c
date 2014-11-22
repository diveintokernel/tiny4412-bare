extern void put_char(char c);
extern char get_char(void);
extern void put_string(char *str);
extern void uart_init();

int main(void)
{
        char c;

        uart_init();

        put_string("Test Uart: add one and output\n\r");

        while (1)
        {
                c = get_char();
                put_char(c+1);
        }

        return 0;
}
