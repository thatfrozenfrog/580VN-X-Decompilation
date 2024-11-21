
org 0xd830
init_map:
    pop xr0
    hex 30 ea 2e 2e
    memset
    hex 01 01 ;0x0101 ~ 0x0100 ~ 256
    setlr

render:
    ; include process below
    ; 
_render_character:
    pop er2
    adr data 4880
    l er0,[er2]
    pop er2
    hex 40 30 ; 0x40 represent '@'
    st r2,[er0]
_render_map:
    pop qr0
    hex 08 01 30 ea 30 30 30 30 
    smallprint
    pop er0
    hex 08 09
    smallprint
    pop er0
    hex 08 11
    smallprint
    pop er0
    hex 08 19
    smallprint

    pop er0
    hex 08 21
    smallprint
    pop er0
    hex 08 29
    smallprint
    pop er0
    hex 08 31
    smallprint
    pop er0
    hex 08 39
    smallprint

    flush_screen
    pop er0
    adr key
    read_key
    pop xr0
    adr key
    hex e2 62
    setlr
    key_cvt    ; to er0
    pop er8
    hex 1c 30
    sub r0,r8,pop er8
    hex 30 30
    mov r1,0
    ; er0 : [0,3]
    pop er2
    adr const 4880
    load_table
    ; er0 : [1,-1,16,-16]
    mov er2,er0
    pop er8
    adr data 4880
    r0=0,[er8]+=er2,pop xr8 
    hex 30 30 30 30 
    pop xr0
    hex 30 d8 40 eb
    smart_strcpy
    pop ER14
    hex 20 d8
    jpop qr80
data:
    hex 35 ea  

key:
    hex 30 30

const:
    hex e0 ff; 0: -16
    hex 20 00; 1: +16
    hex 01 00; 2: +1
    hex ff ff; 3: -1