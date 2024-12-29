;mode 124an
;total: 76bytes
;Prerequisite: Persist the string starting at address 0xea30
;Note!!!! After completing the ROP, do not press [CALC]!!!

;Reference keys:
;0 0 0 0 0 0 0 0 0 in>cm 0 0 <ea> 0 0 0 0 |C e 2 0 ! <91> 0 0 <1a> <9a> 0 0 sinh() ) 0 0 <54> >a+bi π Rep 0 0 0 0 0 0 <c4> e 2 0 k 0 1 0  π square x >a+bi 0 0 0 0 ∟ <03> 2 0 e^ <0d> 2 0 <24> square sin-1 : 2 0
;hex:30 30 30 30 30 30 30 30 30 fe 01 30 30 ea 30 30 30 30 ae 21 32 30 d8 91 30 30 1a 9a 30 30 6c d0 30 30 54 d2 22 8f 30 30 30 30 30 30 c4 21 32 30 e2 30 31 30 22 d5 48 d2 30 30 30 30 c8 03 32 30 72 0d 32 30 24 d5 7a 23 32 30
;A total of 9 invisible characters, recommended to use:
;xxxxx->x
;x in>cm:
;x:
;x in>cm:
; @=xxx
;Method brushing, for details refer to Zhihu https://zhuanlan.zhihu.com/p/620584634
data:
    space 9
    hex fe      ;Note!!! The compiler will give the <fe> character, but when inputting on the actual machine, it should be entered together with the next byte, input in>cm
loop:
    hex 01 30 ; 01: Line 0
y:
    hex 30 ea ;Starting address
    hex 30 30 30 30 ;Placeholder
    printline
    
    
    setlr ;setlr must be used before using labels ending with RT
    ;Increment
    mov er2,1
    pop er8
    adr y -730 ;Here -730 is to calculate the offset relative to 0xd248 (cannot directly use d522)
    r0=0,[er8]+=er2,pop xr8 ;Increment
    hex 30 30 30 30 ;for xr8
    waitkey
    ;34+14=48above
; Program main entry:
start:
    pop qr0
    hex 22 d5 48 d2 30 30 30 30 
    smart_strcpy
    pop ER14
    adr loop -8
    jpop qr80   ;jump and pop qr8, pop qr0
