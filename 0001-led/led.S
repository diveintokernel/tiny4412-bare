#define         GPM4CON        0x110002E0
#define         GPM4DAT        0x110002E4

.text
.global _start
_start:
        /*
         * set GPM4 as output 
         **/
        ldr     r0, =GPM4CON
        ldr     r1, [r0]
        bic     r1, r1, #0xff00
        bic     r1, r1, #0xff
        orr     r1, r1, #0x1100
        orr     r1, r1, #0x11
        str     r1, [r0]

        /*
         * read the GPM4DAT
         **/        
        ldr     r0, =GPM4DAT
        ldr     r1, [r0]

leds_loop:
        bic     r1, r1, #0xf    /* set all leds on (bit[0-3] = 0b0000) */
        str     r1, [r0]
        ldr     r2, =0xffffff
        bl      delay

        orr     r1, r1, #0xe    /* set led1 on (bit[0-3] = 0b1110) */
        str     r1, [r0]
        ldr     r2, =0xffffff
        bl      delay
        
        bic     r1, r1, #0x3    /* set led2 on (bit[0-3] = 0b1101) */
        orr     r1, r1, #1
        str     r1, [r0]
        ldr     r2, =0xffffff
        bl      delay
        
        bic     r1, r1, #0x6    /* set led3 on (bit[0-3] = 0b1011) */
        orr     r1, r1, #2
        str     r1, [r0]
        ldr     r2, =0xffffff
        bl      delay
        
        bic     r1, r1, #0xc    /* set led4 on (bit[0-3] = 0b0111) */
        orr     r1, r1, #4
        str     r1, [r0]
        ldr     r2, =0xffffff
        bl      delay
        
        orr     r1, r1, #0xf    /* set all leds off (bit[0-3] = ob1111)*/
        str     r1, [r0]
        ldr     r2, =0xffffff
        bl      delay

        b       leds_loop

        /*
         * never come here
         **/
halt_loop:
        b       halt_loop

        /*
         * delay some time
         **/
delay:
        sub     r2, r2, #1
        cmp     r2, #0x0
        bne     delay
        mov     pc, lr
