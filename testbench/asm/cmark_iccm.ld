
OUTPUT_ARCH( "riscv" )
ENTRY(_start)
MEMORY {
    EXTCODE : ORIGIN = 0,          LENGTH = 0x10000
    EXTDATA : ORIGIN = 0x10000,    LENGTH = 0x10000
    ICCM    : ORIGIN = 0xee000000, LENGTH = 0x80000
    DCCM    : ORIGIN = 0xf0040000, LENGTH = 0x10000
    CTL     : ORIGIN = 0xfffffff0, LENGTH = 16
    IO      : ORIGIN = 0xd0580000, LENGTH = 0x1000
}
SECTIONS {
  .text.init : {*(.text.init)} > EXTCODE
  init_end = .;
  .data.io  : { *(.data.io) } > IO
  .text : { *(.text) *(.text.startup)} > ICCM
   text_end = .;
  .data  :  { *(.*data) *(.rodata*) *(.sbss) STACK = ALIGN(16) + 0x1000;} > DCCM
  .bss : { *(.bss)} > DCCM
  .data.ctl :  { LONG(ADDR(.text)); LONG(text_end); LONG(0xf0040000); LONG(STACK)}>CTL
}
