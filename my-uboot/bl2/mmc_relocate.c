
#define eFUSE_SIZE		(1 * 512)	// 512 Byte eFuse, 512 Byte reserved
#define MOVI_BLKSIZE		(1<<9) /* 512 bytes */
#define PART_SIZE_BL1		(16 * 1024)
#define PART_SIZE_UBOOT		(328 * 1024)
#define PART_SIZE_KERNEL	(6 * 1024 * 1024)
#define PART_SIZE_ROOTFS	(26 * 1024 * 1024)
#define PART_SIZE_TZSW		(160 * 1024)

#define MOVI_FWBL1_BLKCNT	(PART_SIZE_FWBL1 / MOVI_BLKSIZE)
#define MOVI_BL1_BLKCNT		(PART_SIZE_BL1 / MOVI_BLKSIZE)
#define MOVI_ENV_BLKCNT		(CONFIG_ENV_SIZE / MOVI_BLKSIZE)	/* 16KB */
#define MOVI_UBOOT_BLKCNT	(PART_SIZE_UBOOT / MOVI_BLKSIZE)	/* 328KB */
#define MOVI_ZIMAGE_BLKCNT	(PART_SIZE_KERNEL / MOVI_BLKSIZE)	/* 6MB */
#define MOVI_ROOTFS_BLKCNT	(PART_SIZE_ROOTFS / MOVI_BLKSIZE)	/* 26MB */
#define MOVI_TZSW_BLKCNT	(PART_SIZE_TZSW / MOVI_BLKSIZE)		/* 160KB */

#define MOVI_UBOOT_POS		((eFUSE_SIZE / MOVI_BLKSIZE) + MOVI_FWBL1_BLKCNT + MOVI_BL1_BLKCNT)

extern void uart_asm_putc(int c);
extern void uart_asm_putx(int x);


typedef unsigned int  (*copy_sd_mmc_to_mem) \
	(unsigned int start_block, unsigned int block_count, unsigned int* dest_addr);


#define ISRAM_ADDRESS	0x02020000
#define SECURE_CONTEXT_BASE 0x02023000
#define EXTERNAL_FUNC_ADDRESS	(ISRAM_ADDRESS + 0x0030)
#define EXT_eMMC43_BL2_ByCPU_ADDRESS	(EXTERNAL_FUNC_ADDRESS + 0x4)
#define MSH_ReadFromFIFO_eMMC_ADDRESS	(EXTERNAL_FUNC_ADDRESS + 0x14)
#define MSH_EndBootOp_eMMC_ADDRESS	(EXTERNAL_FUNC_ADDRESS + 0x18)
#define LoadImageFromUsb_ADDRESS	(EXTERNAL_FUNC_ADDRESS + 0x40)


/* DRAM Base */
#define CONFIG_SYS_SDRAM_BASE		0x40000000
#define CONFIG_SYS_LOAD_ADDR		CONFIG_SYS_MAPPED_RAM_BASE + 0x3e00000
#define CONFIG_PHY_UBOOT_BASE		CONFIG_SYS_SDRAM_BASE + 0x3e00000



#define SDMMC_ReadBlocks(uStartBlk, uNumOfBlks, uDstAddr)	\
	(((void(*)(unsigned int, unsigned int, unsigned int*))(*((unsigned int *)EXTERNAL_FUNC_ADDRESS)))(uStartBlk, uNumOfBlks, uDstAddr))

void put_string(char *str)
{
        while(*str != '\0')
        {
                uart_asm_putc(*str);
                str++;
        }

        return;
}

void copy_code_to_dram(void)
{
	void (*user_bin)(void);
	unsigned int *p;
	int i;
	volatile unsigned long  count=0x100000;

	while(count-- > 0) 
                ;

        put_string("\n\rCopy bootloader to ram......\n\r");
	
	SDMMC_ReadBlocks(49,32,(unsigned int *)0x43e00000);

        put_string("Bootloader at 0x43e00000 (RAM).\n\r");
	p = (unsigned int *) 0x43e00000;
	for (i = 0; i < 50; i++) {
                put_string("0x");
        	uart_asm_putx(*(p+i));
	        put_string("  ");
                if ((i+1) % 5 == 0)
                        put_string("\r\n");
	}
	
        put_string("Copy bootloader done. Booting the bootloader........\n\r");
	
        user_bin = (void *)0x43e00000;
        (*user_bin)();
}
