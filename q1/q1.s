.global make_node

make_node:
addi sp,sp,-12
sd ra,0(sp)
sw a0,8(sp)
li a0,24
call malloc
lw t0,8(sp)
sd zero,8(a0)
sd zero,16(a0)
sw t0,0(a0)
ld ra,0(sp)
addi sp,sp,12
ret

.global insert
insert:
addi sp,sp,-20
sd ra,0(sp)
sd a0,8(sp)
sw a1,16(sp)
beqz a0,insert_base
lw t0,0(a0)
blt t0,a1,insert_go_right

insert_go_left:
ld t0,8(a0)
mv a0,t0
lw  a1, 16(sp)   
call insert
ld t0,8(sp)
sd a0,8(t0)
beq a0,a0,insert_done

insert_go_right:
ld t0,16(a0)
mv a0,t0
lw  a1, 16(sp)   
call insert
ld t0,8(sp)
sd a0,16(t0)
beq a0,a0,insert_done

insert_base: 
mv a0,a1
call make_node
beq a0,a0,insert_return

insert_done:
ld a0,8(sp)

insert_return:
ld ra,0(sp)
addi sp,sp,20
ret

.global get
get:

addi sp,sp,-8
sd ra,0(sp)

get_loop:
beqz a0,get_return
lw t0,0(a0)
beq t0,a1,get_return
blt t0,a1,get_go_right

get_go_left:
ld t0,8(a0)
mv a0,t0
beq a0,a0,get_loop

get_go_right:
ld t0,16(a0)
mv a0,t0
beq a0,a0,get_loop

get_return:
ld ra,0(sp)
addi sp,sp,8
ret


.global getAtMost
getAtMost:

addi sp,sp,-8
sd ra,0(sp)
li t1,-1

gam_loop:
beqz a0,gam_return
lw t0,0(a0)
beq t0,a1,gam_found
blt t0,a1,gam_go_right

gam_go_left:
ld t0,8(a0)
mv a0,t0
beq a0,a0,gam_loop

gam_go_right:
mv t1,t0
ld t0,16(a0)
mv a0,t0
beq a0,a0,gam_loop

gam_found:
mv t1,t0

gam_return:
mv a0,t1
ld ra,0(sp)
addi sp,sp,8
ret