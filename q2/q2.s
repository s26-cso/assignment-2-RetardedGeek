.section .rodata
result_out: .asciz "%d "

.global next_greater

next_greater:
addi sp,sp,-80
sd ra,0(sp)
sd s0,8(sp)
sd s1,16(sp)
sd s2,24(sp)
sd s3,32(sp)
sd s4,40(sp)
sd s5,48(sp)
sd s6,56(sp)
sd s7,64(sp)
sd s8,72(sp)

addi s0,a0, -1
mv s1,a1
addi s1,s1, 8
slli s2,s0, 2
mv a0,s2
call malloc
mv s3,a0
mv s4,a0
mv a0,s2
call malloc
mv s5,a0
mv s8,a0

mv a0,s2
call malloc
mv s7,a0

li s6,0
store:
beq s6,s0,stdo
ld a0,0(s1)
call atoi
slli t0,s6,2
add t0,t0,s7
sw a0,0(t0)
addi s1,s1,8
addi s6,s6,1
j store

stdo:
mv s6,s0

loop:
beqz s6, end
addi s6, s6, -1
slli t0, s6, 2
add t0, t0, s7
lw t0, 0(t0)

li t2,-1        

lo:
beq s3, s4, ze
addi t3, s3, -4      
lw t1, 0(t3)
mv t2, t1
slli t1, t1, 2
add t1, t1, s7
lw t1, 0(t1)

blt  t0, t1, done
    addi s3, s3, -4
    j    lo

done:
    sw   t2, 0(s5)
    addi s5, s5, 4
    sw   s6, 0(s3)
    addi s3, s3, 4
    j    loop

ze:
    sw   s6, 0(s3)
    addi s3, s3, 4
    li   t0, -1
    sw   t0, 0(s5)
    addi s5, s5, 4
    j    loop

end:
    addi s5, s5, -4

endlo:
    blt  s5, s8, return
    lw   a1, 0(s5)
    la   a0, result_out
    call printf
    addi s5, s5, -4
    j    endlo

return:
    ld   s0,  8(sp)
    ld   s1, 16(sp)
    ld   s2, 24(sp)
    ld   s3, 32(sp)
    ld   s4, 40(sp)
    ld   s5, 48(sp)
    ld   s6, 56(sp)
    ld   s7, 64(sp)
    ld   s8, 72(sp)
    ld   ra,  0(sp)
    addi sp,  sp, 80
    ret