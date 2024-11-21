def 08C60 clear_ddd4
def 09846 bitmap
def 0FFFE brk
def 09FA8 EI
def 0A05C DI
org 0xe902
EI
DI
start:
clear_ddd4
pop xr0 (00 00 2a 3f)
bitmap
render_ddd4
pop er14
hex 0a e9
jpop er14

