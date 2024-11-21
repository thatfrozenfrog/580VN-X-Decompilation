def 08C60 clear_ddd4
def 09846 bitmap
def 0FFFE brk
def 09FA8 EI
def 0A05C DI

org 0xe9e0
main:
EI
DI


clear_ddd4
pop xr0 (01 01 c0 3f)
bitmap
render_ddd4

pop er0 
adr main [-2]
