# Switch case without break
# not really how a switch case works but thats how its described...


# rem is a qtspim pseudoinstruction 
# see solution without rem at labs/alternative/lab_3_1_a.s
# all rems could be replaced with:
#   addi $t0, $zero, NUM  # to get mod NUM 
#   div $t2, $t0          # division between the given integer and NUM
#
#   mfhi $t1              # the remainder part of the division is stored in $t1 from the hi register
# t1 = t2 % NUM

.data 
    divisible_by_2:  .asciiz "\nDivisible by 2"
    divisible_by_3:  .asciiz "\nDivisible by 3"
    divisible_by_5: .asciiz "\nDivisible by 5"
    not_divisible:   .asciiz "\nNumber not divisible by 2, 3, nor 5" 
      
.text
    .globl __start
    
__start:
    
    li $v0, 5      
    syscall     # read int

    move $s0, $v0   # save int in s0
    
    li $v0, 1
    move $a0, $s0
    syscall         # print int
    
    li $t1, 0       # counter, will be incremented if number is divisble, otherwise will stay 0
    
div_by_2:
    rem $t0, $s0, 2
    bne $t0, $zero, div_by_3    # if not divisible by 2, check 3
    
    addi $t1, $t1, 1    # number is divisible, increment counter
    
    li $v0, 4   # print string
    la $a0, divisible_by_2
    syscall
    
div_by_3:
    rem $t0, $s0, 3
    bne $t0, $zero, div_by_5    # if not divisible by 3, check 5
    
    addi $t1, $t1, 1    # number is divisible, increment counter
        
    li $v0, 4   # print string
    la $a0, divisible_by_3
    syscall
    
div_by_5:
    rem $t0, $s0, 5
    bne $t0, $zero, end    # if not divisible by 5, go to end

    addi $t1, $t1, 1    # number is divisible, increment counter
        
    li $v0, 4   # print string
    la $a0, divisible_by_5
    syscall
 
 end:
    bne $t1, $zero, exit    # if counter is 0 go to exit
    
    li $v0, 4   # print string
    la $a0, not_divisible
    syscall
 
 exit:   
    li $v0, 10
    syscall
