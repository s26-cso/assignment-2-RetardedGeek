.section .bss
ch1: .space 1
ch2: .space 1

.section .rodata
print_str:  .asciz "%s\n"

.section .data
filename: .asciz "input.txt"
yes: .asciz "Yes"
no: .asciz "No"

.section .text
.globl main

main:
addi sp,sp,-40
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)
sd s3,32(sp)


li a0, -100       #current directory
la a1, filename   #pointer to filename
li a2, 0             
li a3, 0             
li a7, 56            
ecall
mv s0, a0         #save fd 

li a1, 0          #offset
li a2, 2          #SEEK_END
li a7, 62         #lseek
ecall
mv s1, a0         #s1=file size 

mv a0, s0
li a1, 0
li a2, 0             
li a7, 62
ecall

li s2, 0          #left=0
addi s3, s1, -1   #right=size-1

loop:
ble s3,s2,suc
mv a0, s0         #fd
mv a1, s2         #offset=left
li a2, 0          #SEEK_SET
li a7, 62         #lseek
ecall

mv a0, s0         #fd
la a1, ch1
li a2, 1          #read 1 byte
li a7, 63         #read
ecall

mv a0, s0
mv a1, s3         #offset=right
li a2, 0          #SEEK_SET
li a7, 62
ecall

mv a0, s0
la a1, ch2
li a2, 1
li a7, 63
ecall

la t0,ch1
lb t1,0(t0)
la t0,ch2
lb t2,0(t0)
bne t1,t2,fail
addi s2,s2,1
addi s3,s3,-1
beq a0,a0,loop

suc:
la a1,yes
beq a0,a0,end

fail:
la a1,no

end:
la a0,print_str
call printf
ld ra,0(sp)
ld s0,8(sp)
ld s1,16(sp)
ld s2,24(sp)
ld s3,32(sp)
addi sp,sp,40
ret
