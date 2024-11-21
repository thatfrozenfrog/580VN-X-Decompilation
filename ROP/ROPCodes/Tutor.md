# Assembler Syntax Translation

## 1. `org`  
Starts a new code segment and sets the starting address. All addresses (label calculations) in this segment will begin at this address. Labels can also be used to define addresses.  
```
org 0x3a3b ; The starting address of this segment is 3a3b
hex .. ..
label: ; The label is located at 3a3c
org 0x4a4b ; The starting address of this segment is 4a4b
org &label +2 ; The starting address of this segment is 3a3e
org & +10 ; The starting address of this segment is 3a4e
; Note: A space must follow the `&` symbol
```
When `org` is followed by curly braces, it denotes an inserted code segment. After the braces, the code returns to the previous segment.  
```
org 0xd522
hex .. .. ; This is at address d524
org & -8 { ; This segment starts at d51c (note the required space)
    hex .. .. .. ..
}
; This returns to address d524
```
If two segments overlap, the assembler will merge the code. However, any conflicts will result in an error.

## 2. `hex`  
```
hex 3. .. 30 43
```
Writes raw hexadecimal data directly, treated as a sequence of hexadecimal values. `.` represents a placeholder for any value (determined by the assembler). `hex` can be omitted.  

## 3. Labels / Addressing  

```
#org d522
hex 33 33 
loop:   ; <-- At this point, the label represents the address (0xd522 + 2 = 0xd524)
hex .. .. .. ..
adr loop ; <-- 'adr loop' will be replaced with: hex 24 d5 (d524, the address of `loop`)
adr loop 55 ; <-- 0xd524 + 55
adr loop -2 ; <-- 0xd522
adr +2 ; <-- Without specifying a label name, it calculates from the current address (d52e) and replaces with d530
```

## 4. Function Labels  
All available labels can be found in `sym.txt`.  
Note: All labels must be used on a separate line.  
```
Example: Line 115 in sym.txt:
20840       and r1, 15, sll r0, 4, or r1, r0
When used in assembly:
and r1, 15, sll r0, 4, or r1, r0
It will be replaced with: hex 40 08 .2 ..
```

```
Example 2: Line 115 in sym.txt:
@0F746       read_key
When used in assembly:
read_key
It will be replaced with: hex 48 f7 .2 .. (Note: When the address starts with '@', the assembler automatically adds 2 to the address)
```

Use `def` to define labels, such as `def @22040 diag`.

For function labels with parameters: Follow the address with parentheses indicating the number of bytes to pop when calling the label. Do not include `pop pc` in the count. For example, a label for `pop qr0` can be defined as `def 130e2(8) pop qr0`. When calling such function labels in the program, the parentheses must contain the appropriate number of bytes, e.g., `pop qr0 (31 32 .. .. .. .6 7. fe)`.

## 5. Using `asm.py`  
```
python3.exe .\asm.py xxx (the file you want to compile)
python3.exe .\asm.py xxx (the file you want to compile) -min ; Outputs the hex `..` exactly as-is, without automatic replacement
```