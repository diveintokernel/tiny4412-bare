SECTIONS {
        . = 0X0202a000;
        .text : {
                *(.text)
        }

        .rodata ALIGN(4) : {
                *(.rodata*)
        }

        .data ALIGN(4) : {
                *(.data*)
        }

        bss_start = .;
        .bss  ALIGN(4) : {
                *(.bss)
        }
        bss_end = .;
}
