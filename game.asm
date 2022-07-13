##################################################################### #
# Bitmap Display Configuration:
# - Unit width in pixels: 4 (update this as needed)
# - Unit height in pixels: 4 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed) 
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones) 
# - Milestone 1/2/3 (choose the one the applies) 
# --all apllies
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features) 
# 1. moving enemy
# 2. moving platform
# 3. Win condition
# 4. Fail condition
# 5. Health/score
# 6. Double jump
# Link to video demonstration for final submission:
# - (insert YouTube ). Make sure we can view it! 
# https://youtu.be/xIZpOWo2WVI
#
# Are you OK with us sharing the video with people outside course staff?
# - yes / no / yes, and please share this project github link as well!
#
# Any additional information that the TA needs to know:
# - (write here, if any)
# #####################################################################
.eqv	BASE_ADDRESS	0x10008000	#BASE ADDRESS for the screen's framebuffer
.eqv	Yellow	0xe3c008	#character color
.eqv	Brown	0xac6c14	#floor color-- safe to reach
.eqv	Health	0xff0000	# heart color
.eqv	Green	0x3d9015	# reach this and win
.eqv	Grey	0x716a72	# reach this, minus one health
.eqv	Black	0x000000
.eqv	White	0xffffff

.data
square:		.word	0x1000bc08, 0x1000bc0c, 0x1000bd08, 0x1000bd0C
moving_enemy:	.word	0x100092B4, 0x100093B4, 0x100094B4
moving_platform:	.word	0x1000A6B0, 0x1000A6B4, 0x1000A6B8, 0x1000A6BC, 0x1000A6C0, 0x1000A6C4
.text
.global main
main:
initial:
	#li $gp, BASE_ADDRESS
	
	# build safe floors
	li $t1, Brown	#color of floor
	# build moving enemy
	li $t5, Health
	la $s3, moving_enemy
	sw $t5, 5300($gp)
	sw $t5, 5044($gp)
	sw $t5, 4788($gp)
	addi $s4, $gp, 4788
	sw $s4, 0($s3)
	addi $s4, $gp, 5044
	sw $s4, 4($s3)
	addi $s4, $gp, 5300
	sw $s4, 8($s3) 
	#### floor area -> brown 
	li $t2, 0
	li $s0, 12
	la $t9, 5556($gp)	#initial place for eight length floor
	jal num_length_floor
	li $t2, 0
	li $s0, 12
	la $t9, 5812($gp)
	jal num_length_floor	#draw the second floor of eight_length
	
	li $t2, 0
	li $s0, 14
	la $t9, 7288($gp)
	jal num_length_floor
	li $t2, 0
	li $s0, 14
	la $t9, 7544($gp)
	jal num_length_floor	#safe floor 2
	
	li $t2, 0
	li $s0, 12
	la $t9, 8776($gp)
	jal num_length_floor
	li $t2, 0
	li $s0, 12
	la $t9, 9032($gp)
	jal num_length_floor	#safe floor 3
	
	li $t2, 0
	li $s0, 10
	la $t9, 12140($gp)
	jal num_length_floor
	li $t2, 0
	li $s0, 10
	la $t9, 12396($gp)
	jal num_length_floor	#safe floor 4
	
	li $t2, 0
	li $s0, 22
	la $t9, 13384($gp)
	jal num_length_floor	#safe floor 5
	
	li $t2, 0
	li $s0, 12
	la $t9, 14648($gp)
	jal num_length_floor
	li $t2, 0
	li $s0, 12
	la $t9, 14904($gp)
	jal num_length_floor	#safe floor 6
	
	li $t2, 0
	li $s0, 12
	la $t9, 8400($gp)
	jal num_length_floor
	li $t2, 0
	li $s0, 12
	la $t9, 8656($gp)
	jal num_length_floor	#safe floor 7
	
	li $t2, 0
	li $s0, 64
	la $t9, 15872($gp)
	jal num_length_floor
	li $t2, 0
	li $s0, 64
	la $t9, 16128($gp)
	jal num_length_floor	#last two lines
	
	li $t2, 0
	li $s0, 12
	la $t9, 11040($gp)
	jal num_length_floor
	#li $t2, 0
	#li $s0, 12
	#la $t9, 11296($gp)
	#jal num_length_floor
	
	li $t2, 0
	li $s0, 8
	la $t9, 11088($gp)
	jal num_length_floor
	#li $t2, 0
	#li $s0, 8
	#la $t9, 11344($gp)
	#jal num_length_floor		# draw the longest platform
	
	li $t2, 0
	li $s0, 33
	la $t9, 7844($gp)
	jal num_height_floor
	li $t2, 0
	li $s0, 33
	la $t9, 7848($gp)
	jal num_height_floor	
	li $t2, 0
	li $s0, 33
	la $t9, 7852($gp)
	jal num_height_floor		# draw vetical lines
	
	li $t2, 0
	li $s0, 12
	la $t9, 8224($gp)
	jal num_height_floor
	li $t2, 0
	li $s0, 12
	la $t9, 8228($gp)
	jal num_height_floor	
	li $t2, 0
	li $s0, 12
	la $t9, 8232($gp)
	jal num_height_floor
	
	###-----end of floor--
	###-----start of trap--
	li $t2, 0
	li $s0, 20
	li $t8, Grey
	la $t9, 15792($gp)
	jal grey_length_floor
	li $t2, 0
	li $s0, 10
	la $t9, 15536($gp)
	jal grey_jumped_floor
	
	###---trap done---
	###---win gate---
	li $t7, Green
	li $t2, 0
	la $t9, 6392($gp)
	jal green_height_floor
	li $t7, Green
	li $t2, 0
	la $t9, 6396($gp)
	jal green_height_floor
	
	###---win gate done---
	###---heart---
	li $t6, Health
	sw $t6, 264($gp)
	sw $t6, 272($gp)
	li $t2, 0
	li $s0, 5
	la $t9, 516($gp)
	jal red_length_floor
	li $t6, Health
	li $t2, 0
	li $s0, 3
	la $t9, 776($gp)
	jal red_length_floor
	sw $t6, 1036($gp)	# fisrt heart
	
	sw $t6, 292($gp)
	sw $t6, 300($gp)
	li $t2, 0
	li $s0, 5
	la $t9, 544($gp)
	jal red_length_floor
	li $t6, Health
	li $t2, 0
	li $s0, 3
	la $t9, 804($gp)
	jal red_length_floor
	sw $t6, 1064($gp)	# second heart
	
	sw $t6, 320($gp)
	sw $t6, 328($gp)
	li $t2, 0
	li $s0, 5
	la $t9, 572($gp)
	jal red_length_floor
	li $t6, Health
	li $t2, 0
	li $s0, 3
	la $t9, 832($gp)
	jal red_length_floor
	sw $t6, 1092($gp)	# third heart
	
	###--- heart done---
	###--- moving platform ---
	li $t2, 0
	li $s0, 6
	la $t9, 9904($gp)
	jal num_length_floor
	la $t0, moving_platform
	
	addi $t4, $gp, 9904
	sw $t4, 0($t0)
	addi $t4, $gp, 9908
	sw $t4, 4($t0)
	addi $t4, $gp, 9912
	sw $t4, 8($t0)
	addi $t4, $gp, 9916
	sw $t4, 12($t0)
	addi $t4, $gp, 9920
	sw $t4, 16($t0)
	addi $t4, $gp, 9924
	sw $t4, 20($t0)
	###---character begin---
	## initial suqare
	li $t5, Yellow
	sw $t5, 15368($gp)
	sw $t5, 15372($gp)
	sw $t5, 15624($gp)
	sw $t5, 15628($gp)	
	la $t2, square
	
	addi $t4, $gp, 15368
	sw $t4, 0($t2)
	addi $t4, $gp, 15372
	sw $t4, 4($t2)
	addi $t4, $gp, 15624
	sw $t4, 8($t2)
	addi $t4, $gp, 15628
	sw $t4, 12($t2)
	
	###--- character done
	###---initial key board
	li $s7, 0xffff0000 #Address of keystroke event
	la $s6, square	# address of character
	
	addi $sp, $sp, -4	# moving enemy variable(0/1)
	sw $zero, 0($sp)
	addi $sp, $sp, -4	# platform variable(0/1)
	sw $zero, 0($sp)
	li $s1, 0	# moving enenmy variable
	li $a3, 0	# second moving variable for platform
	
	li $s2, 3	# num of health
	li $s0, 40	# refresh time
	la $s3, moving_enemy
	la $t0, moving_platform
	
	########## game main ############
game_main:
	add $a0, $s6, $zero	# address of character
	add $a1, $s7, $zero	# address of key stroke 
	jal key_update
	li $s5, 0
	
	beq $s2, 0, draw_gg
        ble $s2, -1, refresh
        
        la $t0, moving_platform
        jal move_platform
        
        la $s3, moving_enemy
        jal move_e		# enemy moving
        
	add $a0, $s6, $zero	# address of character
	jal gravity_loop	# after every key press, check gravity
	
	add $a0, $s6, $zero
	jal win_collision
	
	add $a0, $s6, $zero	# address of character
	add $a2, $s2, $zero	# num of health
	
	#jal enemy_collision
	jal trap_collision	# if there's a trap, refresh and heart minus one
	addi $s2, $v1, 0
	add $a2, $s2, $zero
	add $a0, $s6, $zero	# address of character
	jal enemy_collision
	addi $s2, $v1, 0
	
	add $a2, $s2, $zero	# num of health
	j show_health
	
refresh:
	li $v0, 32
        add $a0, $s0, $zero
        syscall
        
        j game_main
        
	li $v0, 10
	syscall
	
game_over:
	addi $s2, $s2, -1
	jal over
	j refresh
########### check health ##########
show_health:
	#addi $sp, $sp, -4
	#sw $ra, 0($sp)
	beq $a2, 3, refresh
	beq $a2, 2, two_health
	beq $a2, 1, one_health
	
	sw $zero, 264($gp)
	sw $zero, 272($gp)
	li $t2, 0
	li $s0, 5
	la $t9, 516($gp)
	jal black_length_floor
	li $t2, 0
	li $s0, 3
	la $t9, 776($gp)
	jal black_length_floor
	sw $zero, 1036($gp)
	
one_health:	# we have deleted one heart beforem so just delete the second heart
	sw $zero, 292($gp)
	sw $zero, 300($gp)
	li $t2, 0
	li $s0, 5
	la $t9, 544($gp)
	jal black_length_floor
	li $t2, 0
	li $s0, 3
	la $t9, 804($gp)
	jal black_length_floor
	sw $zero, 1064($gp)
	j refresh
	
two_health:
	sw $zero, 320($gp)
	sw $zero, 328($gp)
	li $t2, 0
	li $s0, 5
	la $t9, 572($gp)
	jal black_length_floor
	li $t2, 0
	li $s0, 3
	la $t9, 832($gp)
	jal black_length_floor
	sw $zero, 1092($gp)
	j refresh
	
back_health:	# full health or return back
	#lw $ra, 0($sp)
	#addi $sp, $sp, 4
	j game_main
black_length_floor:
	move $t3, $s0	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 2	#offset = i * 4, move to next line
	add $t4, $t3, $t9
	sw $zero, 0($t4)
	addi $t2, $t2, 1
	j black_length_floor
########### finish health #########
########### draw game over ########
draw_gg:
	jal delete_all
	
	li $t9, White
	
	# draw "G"
	sw $t9, 4940($gp)
	sw $t9, 4944($gp)
	sw $t9, 4948($gp)
	
	sw $t9, 5208($gp)
	
	sw $t9, 5192($gp)
	sw $t9, 5448($gp)
	sw $t9, 5704($gp)
	sw $t9, 5960($gp)
	sw $t9, 6216($gp)
	
	sw $t9, 6476($gp)
	sw $t9, 6480($gp)
	sw $t9, 6484($gp)
	
	sw $t9, 6232($gp)
	sw $t9, 5976($gp)
	sw $t9, 5972($gp)
	sw $t9, 5968($gp)
	
	# draw "A"
	sw $t9, 4972($gp)
	
	sw $t9, 5224($gp)
	sw $t9, 5232($gp)
	
	li $t2, 0
	li $s0, 5
	la $t8, 5476($gp)
	jal white_height_floor
	li $t2, 0
	li $s0, 5
	la $t8, 5492($gp)
	jal white_height_floor
	
	sw $t9, 5736($gp)
	sw $t9, 5740($gp)
	sw $t9, 5744($gp)
	
	#draw "M"
	li $t2, 0
	li $s0, 7
	la $t8, 4992($gp)
	jal white_height_floor
	li $t2, 0
	li $s0, 7
	la $t8, 5008($gp)
	jal white_height_floor
	sw $t9, 5252($gp)
	sw $t9, 5260($gp)
	sw $t9, 5512($gp)
	
	# draw "E"
	li $t2, 0
	li $s0, 7
	la $t8, 5020($gp)
	jal white_height_floor
	sw $t9, 5024($gp)
	sw $t9, 5028($gp)
	sw $t9, 5032($gp)
	sw $t9, 5036($gp)
	
	sw $t9, 5792($gp)
	sw $t9, 5796($gp)
	sw $t9, 5800($gp)
	sw $t9, 5804($gp)
	
	sw $t9, 6560($gp)
	sw $t9, 6564($gp)
	sw $t9, 6568($gp)
	sw $t9, 6572($gp)
	
	# draw "O"
	li $t2, 0
	li $s0, 5
	la $t8, 8264($gp)
	jal white_height_floor
	li $t2, 0
	li $s0, 5
	la $t8, 8280($gp)
	jal white_height_floor
	
	sw $t9, 8012($gp)
	sw $t9, 8016($gp)
	sw $t9, 8020($gp)
	
	sw $t9, 9548($gp)
	sw $t9, 9552($gp)
	sw $t9, 9556($gp)
	
	# draw "V"
	li $t2, 0
	li $s0, 5
	la $t8, 8036($gp)
	jal white_height_floor
	li $t2, 0
	li $s0, 5
	la $t8, 8052($gp)
	jal white_height_floor
	
	sw $t9, 9580($gp)
	sw $t9, 9320($gp)
	sw $t9, 9328($gp)
	
	# draw "E"
	li $t2, 0
	li $s0, 7
	la $t8, 8064($gp)
	jal white_height_floor
	sw $t9, 8068($gp)
	sw $t9, 8072($gp)
	sw $t9, 8076($gp)
	sw $t9, 8080($gp)
	
	sw $t9, 8836($gp)
	sw $t9, 8840($gp)
	sw $t9, 8844($gp)
	sw $t9, 8848($gp)
	
	sw $t9, 9604($gp)
	sw $t9, 9608($gp)
	sw $t9, 9612($gp)
	sw $t9, 9616($gp)
	
	# draw "R"
	li $t2, 0
	li $s0, 7
	la $t8, 8092($gp)
	jal white_height_floor
	li $t2, 0
	li $s0, 2
	la $t8, 8364($gp)
	jal white_height_floor
	
	sw $t9, 8096($gp)
	sw $t9, 8100($gp)
	sw $t9, 8104($gp)
	
	sw $t9, 8864($gp)
	sw $t9, 8868($gp)
	sw $t9, 8872($gp)
	
	sw $t9, 9124($gp)
	sw $t9, 9384($gp)
	sw $t9, 9644($gp)
	
	j update
draw_win:
	jal delete_all
	
	li $t9, White
	# draw "Y"
	sw $t9, 4928($gp)
	sw $t9, 5184($gp)
	sw $t9, 5440($gp)
	sw $t9, 5700($gp)
	
	sw $t9, 4944($gp)
	sw $t9, 5200($gp)
	sw $t9, 5456($gp)
	sw $t9, 5708($gp)
	
	sw $t9, 5960($gp)
	sw $t9, 6216($gp)
	sw $t9, 6472($gp)
	sw $t9, 6728($gp)
	
	# draw "O"
	li $t2, 0
	li $s0, 6
	la $t8, 5212($gp)
	jal white_height_floor
	li $t2, 0
	li $s0, 6
	la $t8, 5228($gp)
	jal white_height_floor
	
	sw $t9, 4960($gp)
	sw $t9, 4964($gp)
	sw $t9, 4968($gp)
	
	sw $t9, 6752($gp)
	sw $t9, 6756($gp)
	sw $t9, 6760($gp)
	
	# draw "U"
	li $t2, 0
	li $s0, 7
	la $t8, 4984($gp)
	jal white_height_floor
	li $t2, 0
	li $s0, 7
	la $t8, 5000($gp)
	jal white_height_floor
	
	sw $t9, 6780($gp)
	sw $t9, 6784($gp)
	sw $t9, 6788($gp)
	
	# draw "W"
	li $t2, 0
	li $s0, 7
	la $t8, 8548($gp)
	jal white_height_floor
	li $t2, 0
	li $s0, 7
	la $t8, 8564($gp)
	jal white_height_floor
	
	sw $t9, 9832($gp)
	sw $t9, 9580($gp)
	sw $t9, 9840($gp)
	
	# draw "I"
	li $t2, 0
	li $s0, 7
	la $t8, 8584($gp)
	jal white_height_floor
	
	sw $t9, 8580($gp)
	sw $t9, 8588($gp)
	sw $t9, 10116($gp)
	sw $t9, 10124($gp)
	
	# draw "N"
	li $t2, 0
	li $s0, 7
	la $t8, 8604($gp)
	jal white_height_floor
	li $t2, 0
	li $s0, 7
	la $t8, 8620($gp)
	jal white_height_floor
	
	sw $t9, 8864($gp)
	sw $t9, 9120($gp)
	sw $t9, 9380($gp)
	sw $t9, 9640($gp)
	sw $t9, 9896($gp)
	
update:
	add $a1, $s7, $zero
	li $s4, 2
	lw $t2, 0($a1)	# check user pressed any key
	beq $t2, 1, setup
key_re:
	jr $ra
setup:
	# a1 is address of key stroke
	lw $t9, 4($a1)	# this assumes $t9 is set to 0xfff0000 from before
	#li $t5, Yellow	#set the color
	beq $t9, 0x70, respond_p	# repond to p --> refresh
	blt $s2, -1, key_re	# health too less
	j update
	
white_height_floor:
	move $t3, $s0 	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 8	#offset = i * 256, move to next line
	add $t4, $t3, $t8
	sw $t9, 0($t4)
	addi $t2, $t2, 1
	j white_height_floor
########### draw completed ########
###########  helpers for build backgroud  ########
num_length_floor:
	move $t3, $s0	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 2	#offset = i * 4, move to next line
	add $t4, $t3, $t9
	sw $t1, 0($t4)
	addi $t2, $t2, 1
	j num_length_floor
yellow_length_floor:
	li $t3, 2	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 2	#offset = i * 4, move to next line
	add $t4, $t3, $t9
	sw $t5, 0($t4)
	addi $t2, $t2, 1
	j yellow_length_floor
red_length_floor:
	move $t3, $s0	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 2	#offset = i * 4, move to next line
	add $t4, $t3, $t9
	sw $t6, 0($t4)
	addi $t2, $t2, 1
	j red_length_floor
num_height_floor:
	move $t3, $s0 	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 8	#offset = i * 256, move to next line
	add $t4, $t3, $t9
	sw $t1, 0($t4)
	addi $t2, $t2, 1
	j num_height_floor
green_height_floor:
	li $t3, 8	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 8	#offset = i * 256, move to next line
	add $t4, $t3, $t9
	sw $t7, 0($t4)
	addi $t2, $t2, 1
	j green_height_floor
grey_length_floor:
	move $t3, $s0	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 2	#offset = i * 4, move to next line
	add $t4, $t3, $t9
	sw $t8, 0($t4)
	addi $t2, $t2, 1
	j grey_length_floor
grey_jumped_floor:
	move $t3, $s0	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 3	#offset = i * 4, move to next line
	add $t4, $t3, $t9
	sw $t8, 0($t4)
	addi $t2, $t2, 1
	j grey_jumped_floor
############ end of helpers function -- for build background ##########
############ platform move ###########
move_platform:
	la $t0, moving_platform
	li $t4, 4
	li $t5, Brown
	li $t8, 1
	addi $t6, $ra, 0
	lw $t9, 0($sp)	# the first indexed element is for platform
	beq $t9, $zero, platform_right	# 0 is shift right
	beq $t9, $t8, platform_left	# 1 is shift left
platform_back:
	addi $ra, $t6, 0
	jr $ra
platform_right:
	li $t9, 0
	sw $t9, 0($sp)
	bge $a3, $t4, platform_left	# a3 is enemy variable if a3 < 4, cannot shift right anymore
	lw $t7, 20($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, 4
	sw $t5, 0($t7)
	sw $t7, 20($t0)
	
	lw $t7, 16($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, 4
	sw $t5, 0($t7)
	sw $t7, 16($t0)
	
	lw $t7, 12($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, 4
	sw $t5, 0($t7)
	sw $t7, 12($t0)
	
	lw $t7, 8($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, 4
	sw $t5, 0($t7)
	sw $t7, 8($t0)
	
	lw $t7, 4($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, 4
	sw $t5, 0($t7)
	sw $t7, 4($t0)
	
	lw $t7, 0($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, 4
	sw $t5, 0($t7)
	sw $t7, 0($t0)
	
	addi $a3, $a3, 1
	li $s0, 40
	li $v0, 32
        add $a0, $s0, $zero
        syscall
        li $v0, 32
        add $a0, $s0, $zero
        syscall
	jr $ra
platform_left:
	li $t9, 1
	sw $t9, 0($sp)
	beq $a3, $zero, platform_right
	
	lw $t7, 0($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, -4
	sw $t5, 0($t7)
	sw $t7, 0($t0)
	
	lw $t7, 4($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, -4
	sw $t5, 0($t7)
	sw $t7, 4($t0)
	
	lw $t7, 8($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, -4
	sw $t5, 0($t7)
	sw $t7, 8($t0)
	
	lw $t7, 12($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, -4
	sw $t5, 0($t7)
	sw $t7, 12($t0)
	
	lw $t7, 16($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, -4
	sw $t5, 0($t7)
	sw $t7, 16($t0)
	
	lw $t7, 20($t0)
	sw $zero, 0($t7)
	addi $t7, $t7, -4
	sw $t5, 0($t7)
	sw $t7, 20($t0)
	
	addi $a3, $a3, -1
	li $s0, 40
	li $v0, 32
        add $a0, $s0, $zero
        syscall
        li $v0, 32
        add $a0, $s0, $zero
        syscall
	jr $ra
############ enenemy move ###########
move_e:
	la $s3, moving_enemy
	li $t4, 12
	li $t5, Health
	li $t8, 1
	addi $t6, $ra, 0
	lw $t9, 4($sp)
	beq $t9, $zero, shift_right
	beq $t9, $t8, shift_left
shift_back:
	addi $ra, $t6, 0
	jr $ra
shift_right:
	li $t9, 0
	sw $t9, 4($sp)
	bge $s1, $t4, shift_left	# s1 is enemy variable if s1 < 12, cannot shift right anymore
	lw $t7, 0($s3)

	sw $zero, 0($t7)
	addi $t7, $t7, 4
	sw $t5, 0($t7)
	sw $t7, 0($s3)
	
	lw $t7, 4($s3)
	sw $zero, 0($t7)
	addi $t7, $t7, 4
	sw $t5, 0($t7)
	sw $t7, 4($s3)
	
	lw $t7, 8($s3)
	sw $zero, 0($t7)
	addi $t7, $t7, 4
	sw $t5, 0($t7)
	sw $t7, 8($s3)
	
	addi $s1, $s1, 1
	li $s0, 40
	li $v0, 32
        add $a0, $s0, $zero
        syscall
        li $v0, 32
        add $a0, $s0, $zero
        syscall
	jr $ra
shift_left:
	li $t9, 1
	sw $t9, 4($sp)
	beq $s1, $zero, shift_right
	lw $t7, 0($s3)

	sw $zero, 0($t7)
	addi $t7, $t7, -4
	sw $t5, 0($t7)
	sw $t7, 0($s3)
	
	lw $t7, 4($s3)
	sw $zero, 0($t7)
	addi $t7, $t7, -4
	sw $t5, 0($t7)
	sw $t7, 4($s3)
	
	lw $t7, 8($s3)
	sw $zero, 0($t7)
	addi $t7, $t7, -4
	sw $t5, 0($t7)
	sw $t7, 8($s3)
	
	addi $s1, $s1, -1
	li $s0, 40
	li $v0, 32
        add $a0, $s0, $zero
        syscall
        li $v0, 32
        add $a0, $s0, $zero
        syscall
	jr $ra
############ key board part  ###########
key_update:
	li $s4, 2
	lw $t2, 0($a1)	# check user pressed any key
	beq $t2, 1, key_setup
key_refresh:
	jr $ra
key_setup:
	# a1 is address of key stroke
	lw $t9, 4($a1)	# this assumes $t9 is set to 0xfff0000 from before
	li $t5, Yellow	#set the color
	beq $t9, 0x70, respond_p	# repond to p --> refresh
	blt $s2, -1, key_refresh	# health too less
	beq $t9, 0x61, respond_a	# repond to a --> go left
	beq $t9, 0x64, respond_d	# respond to d --> go right
	bge $s5, 2, key_update		# num of jumps cannot bigger than 2
	beq $t9, 0x77, respond_w	# repond to w --> jump
	j key_update
respond_a:
	# check the square reached left end   -4
	lw $t1, 0($a0)	# a0 is address of square
	li $t8, 256	# set t8 = 256
	div $t1, $t8
	mfhi $t8
	beq $t8, 0, key_refresh
	
	j left_collision
	
left:	## update new location
	addi $t1, $t1, -4
	sw $t5, 0($t1)	# first unit of square
	sw $t1, 0($a0)
	
	lw $t1, 4($a0)	# second unit  gp is address of second unit
	sw $zero, 0($t1)	# move left, so clear it to black first
	addi $t1, $t1, -4	# go to next index
	sw $t5, 0($t1)		# set the color into the new position
	sw $t1, 4($a0)		# store it into address of square
	
	lw $t1, 8($a0)	# third unit  gp is address of second unit
	sw $zero, 0($t1)	# move left, so clear it to black first
	addi $t1, $t1, -4	# go to next index
	sw $t5, 0($t1)		# set the color into the new position
	sw $t1, 8($a0)
	
	lw $t1, 12($a0)	# fourth unit  gp is address of second unit
	sw $zero, 0($t1)	# move left, so clear it to black first
	addi $t1, $t1, -4	# go to next index
	sw $t5, 0($t1)		# set the color into the new position
	sw $t1, 12($a0)
	j key_refresh
	
respond_d:
	# check the square shift right end  +4
	lw $t1, 4($a0)	# a0 is address of square
	li $t8, 256	# set t8 = 256
	div $t1, $t8
	mfhi $t8
	beq $t8, 252, key_refresh
	
	j right_collision
	
right:	## update new location
	addi $t1, $t1, 4
	sw $t5, 0($t1)	# second unit of square
	sw $t1, 4($a0)
	
	lw $t1, 0($a0)		# first unit gp
	sw $zero, 0($t1)	# move right, so clear it to black first
	addi $t1, $t1, 4	# go to next index
	sw $t5, 0($t1)		# set the color into the new position
	sw $t1, 0($a0)		# store it into address of square
	
	lw $t1, 12($a0)		# fourth unit gp 
	sw $zero, 0($t1)	# move right, so clear it to black first
	addi $t1, $t1, 4	# go to next index
	sw $t5, 0($t1)		# set the color into the new position
	sw $t1, 12($a0)
	
	lw $t1, 8($a0)		# third unit gp
	sw $zero, 0($t1)	# move right, so clear it to black first
	addi $t1, $t1, 4	# go to next index
	sw $t5, 0($t1)		# set the color into the new position
	sw $t1, 8($a0)
	
	#lw $t1, 12($a0)		# fourth unit gp 
	#sw $zero, 0($t1)	# move right, so clear it to black first
	#addi $t1, $t1, 4	# go to next index
	#sw $t5, 0($t1)		# set the color into the new position
	#sw $t1, 12($a0)
	
	j key_refresh
respond_w:
	li $s0, 40
	addi $s5, $s5, 1
	li $t2, 0
	li $t3, 5
	li $t5, Yellow

loop:	
	beq $t2, $t3, key_update
	bgt $t2, $t3, key_refresh
	lw $t1, 0($a0)	# check the first unit
	# go up, -256 * 5  5 units
	sw $zero, 0($t1)
	addi $t1, $t1, -256
	sw $t5, 0($t1)
	sw $t1, 0($a0)
	
	lw $t1, 4($a0)
	sw $zero, 0($t1)
	addi $t1, $t1, -256
	sw $t5, 0($t1)
	sw $t1, 4($a0)
	
	lw $t1, 8($a0)
	sw $zero, 0($t1)
	addi $t1, $t1, -256
	sw $t5, 0($t1)
	sw $t1, 8($a0)
	
	lw $t1, 12($a0)
	sw $zero, 0($t1)
	addi $t1, $t1, -256
	sw $t5, 0($t1)
	sw $t1, 12($a0)		# go up
	
	li $v0, 32
        add $a0, $s0, $zero
        syscall
        
        j up_collision
	
up:
        addi $t2, $t2, 1
	j loop
	
respond_p:
	#la $s6, square
	#add $a0, $s6, $zero
	#lw $t9, 0($a0)
	#sw $zero, 0($t9)
	#lw $t9, 4($a0)
	#sw $zero, 0($t9)
	#lw $t9, 8($a0)
	#sw $zero, 0($t9)
	#lw $t9, 12($a0)
	#sw $zero, 0($t9)
	#beq $s2, -1, res_gg
	#beq $s2, -2, res_win
	jal delete_all
	
	j delete_gg
d_g:	
	j delete_win
d_w:	
	j initial
	
##res_gg:
	#jal delete_gg
	#j initial
#res_win:
	#jal delete_win
	#j initial
	
####################### end of key part
######### delete ######
delete_all:
	# delete default background
	add $t6, $ra, $zero
	li $t2, 0
	li $s0, 12
	la $t9, 5556($gp)	#initial place for eight length floor
	jal delete_length_floor
	li $t2, 0
	li $s0, 12
	la $t9, 5812($gp)
	jal delete_length_floor	#draw the second floor of eight_length
	
	li $t2, 0
	li $s0, 14
	la $t9, 7288($gp)
	jal delete_length_floor
	li $t2, 0
	li $s0, 14
	la $t9, 7544($gp)
	jal delete_length_floor	#safe floor 2
	
	li $t2, 0
	li $s0, 12
	la $t9, 8776($gp)
	jal delete_length_floor
	li $t2, 0
	li $s0, 12
	la $t9, 9032($gp)
	jal delete_length_floor	#safe floor 3
	
	li $t2, 0
	li $s0, 10
	la $t9, 12140($gp)
	jal delete_length_floor
	li $t2, 0
	li $s0, 10
	la $t9, 12396($gp)
	jal delete_length_floor	#safe floor 4
	
	li $t2, 0
	li $s0, 22
	la $t9, 13384($gp)
	jal delete_length_floor	#safe floor 5
	
	li $t2, 0
	li $s0, 12
	la $t9, 14648($gp)
	jal delete_length_floor
	li $t2, 0
	li $s0, 12
	la $t9, 14904($gp)
	jal delete_length_floor	#safe floor 6
	
	li $t2, 0
	li $s0, 12
	la $t9, 8400($gp)
	jal delete_length_floor
	li $t2, 0
	li $s0, 12
	la $t9, 8656($gp)
	jal delete_length_floor	#safe floor 7
	
	li $t2, 0
	li $s0, 64
	la $t9, 15872($gp)
	jal delete_length_floor
	li $t2, 0
	li $s0, 64
	la $t9, 16128($gp)
	jal delete_length_floor	#last two lines
	
	li $t2, 0
	li $s0, 12
	la $t9, 11040($gp)
	jal delete_length_floor
	
	li $t2, 0
	li $s0, 8
	la $t9, 11088($gp)
	jal delete_length_floor		# draw the longest platform
	
	li $t2, 0
	li $s0, 33
	la $t9, 7844($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 33
	la $t9, 7848($gp)
	jal delete_height_floor	
	li $t2, 0
	li $s0, 33
	la $t9, 7852($gp)
	jal delete_height_floor		# draw vetical lines
	
	li $t2, 0
	li $s0, 12
	la $t9, 8224($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 12
	la $t9, 8228($gp)
	jal delete_height_floor	
	li $t2, 0
	li $s0, 12
	la $t9, 8232($gp)
	jal delete_height_floor
	###-----end of floor--
	###-----start of trap--
	li $t2, 0
	li $s0, 20
	la $t9, 15792($gp)
	jal delete_length_floor
	li $t2, 0
	li $s0, 10
	la $t9, 15536($gp)
	jal delete_jumped_floor
	###---trap done---
	###---win gate---
	li $t2, 0
	li $s0, 8
	la $t9, 6392($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 8
	la $t9, 6396($gp)
	jal delete_height_floor
	
	# moving obstacles
	la $s6, square
	add $a0, $s6, $zero
	lw $t9, 0($a0)
	sw $zero, 0($t9)
	lw $t9, 4($a0)
	sw $zero, 0($t9)
	lw $t9, 8($a0)
	sw $zero, 0($t9)
	lw $t9, 12($a0)
	sw $zero, 0($t9)
	# moving platform
	la $t0, moving_platform
	add $t9, $t0, $zero
	lw $t5, 0($t9)
	sw $zero, 0($t5)
	lw $t5, 4($t9)
	sw $zero, 0($t5)
	lw $t5, 8($t9)
	sw $zero, 0($t5)
	lw $t5, 12($t9)
	sw $zero, 0($t5)
	lw $t5, 16($t9)
	sw $zero, 0($t5)
	lw $t5, 20($t9)
	sw $zero, 0($t5)
        # moving_enemy
        la $s3, moving_enemy
	add $t9, $s3, $zero
	lw $t5, 0($t9)
	sw $zero, 0($t5)
	lw $t5, 4($t9)
	sw $zero, 0($t5)
	lw $t5, 8($t9)
	sw $zero, 0($t5)
	add $ra, $t6, $zero
	jr $ra
### delete words
delete_gg:
	jal delete_all
	# draw "G"
	sw $zero, 4940($gp)
	sw $zero, 4944($gp)
	sw $zero, 4948($gp)
	
	sw $zero, 5208($gp)
	
	sw $zero, 5192($gp)
	sw $zero, 5448($gp)
	sw $zero, 5704($gp)
	sw $zero, 5960($gp)
	sw $zero, 6216($gp)
	
	sw $zero, 6476($gp)
	sw $zero, 6480($gp)
	sw $zero, 6484($gp)
	
	sw $zero, 6232($gp)
	sw $zero, 5976($gp)
	sw $zero, 5972($gp)
	sw $zero, 5968($gp)
	
	# draw "A"
	sw $zero, 4972($gp)
	
	sw $zero, 5224($gp)
	sw $zero, 5232($gp)
	
	li $t2, 0
	li $s0, 5
	la $t9, 5476($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 5
	la $t9, 5492($gp)
	jal delete_height_floor
	
	sw $zero, 5736($gp)
	sw $zero, 5740($gp)
	sw $zero, 5744($gp)
	
	#draw "M"
	li $t2, 0
	li $s0, 7
	la $t9, 4992($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 7
	la $t9, 5008($gp)
	jal delete_height_floor
	sw $zero, 5252($gp)
	sw $zero, 5260($gp)
	sw $zero, 5512($gp)
	
	# draw "E"
	li $t2, 0
	li $s0, 7
	la $t9, 5020($gp)
	jal delete_height_floor
	sw $zero, 5024($gp)
	sw $zero, 5028($gp)
	sw $zero, 5032($gp)
	sw $zero, 5036($gp)
	
	sw $zero, 5792($gp)
	sw $zero, 5796($gp)
	sw $zero, 5800($gp)
	sw $zero, 5804($gp)
	
	sw $zero, 6560($gp)
	sw $zero, 6564($gp)
	sw $zero, 6568($gp)
	sw $zero, 6572($gp)
	
	# draw "O"
	li $t2, 0
	li $s0, 5
	la $t9, 8264($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 5
	la $t9, 8280($gp)
	jal delete_height_floor
	
	sw $zero, 8012($gp)
	sw $zero, 8016($gp)
	sw $zero, 8020($gp)
	
	sw $zero, 9548($gp)
	sw $zero, 9552($gp)
	sw $zero, 9556($gp)
	
	# draw "V"
	li $t2, 0
	li $s0, 5
	la $t9, 8036($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 5
	la $t9, 8052($gp)
	jal delete_height_floor
	
	sw $zero, 9580($gp)
	sw $zero, 9320($gp)
	sw $zero, 9328($gp)
	
	# draw "E"
	li $t2, 0
	li $s0, 7
	la $t9, 8064($gp)
	jal delete_height_floor
	sw $zero, 8068($gp)
	sw $zero, 8072($gp)
	sw $zero, 8076($gp)
	sw $zero, 8080($gp)
	
	sw $zero, 8836($gp)
	sw $zero, 8840($gp)
	sw $zero, 8844($gp)
	sw $zero, 8848($gp)
	
	sw $zero, 9604($gp)
	sw $zero, 9608($gp)
	sw $zero, 9612($gp)
	sw $zero, 9616($gp)
	
	# draw "R"
	li $t2, 0
	li $s0, 7
	la $t9, 8092($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 2
	la $t9, 8364($gp)
	jal delete_height_floor
	
	sw $zero, 8096($gp)
	sw $zero, 8100($gp)
	sw $zero, 8104($gp)
	
	sw $zero, 8864($gp)
	sw $zero, 8868($gp)
	sw $zero, 8872($gp)
	
	sw $zero, 9124($gp)
	sw $zero, 9384($gp)
	sw $zero, 9644($gp)
	j d_g
	
delete_win:
	jal delete_all
	sw $zero, 4928($gp)
	sw $zero, 5184($gp)
	sw $zero, 5440($gp)
	sw $zero, 5700($gp)
	
	sw $zero, 4944($gp)
	sw $zero, 5200($gp)
	sw $zero, 5456($gp)
	sw $zero, 5708($gp)
	
	sw $zero, 5960($gp)
	sw $zero, 6216($gp)
	sw $zero, 6472($gp)
	sw $zero, 6728($gp)
	
	# draw "O"
	li $t2, 0
	li $s0, 6
	la $t9, 5212($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 6
	la $t9, 5228($gp)
	jal delete_height_floor
	
	sw $zero, 4960($gp)
	sw $zero, 4964($gp)
	sw $zero, 4968($gp)
	
	sw $zero, 6752($gp)
	sw $zero, 6756($gp)
	sw $zero, 6760($gp)
	
	# draw "U"
	li $t2, 0
	li $s0, 7
	la $t9, 4984($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 7
	la $t9, 5000($gp)
	jal delete_height_floor
	
	sw $zero, 6780($gp)
	sw $zero, 6784($gp)
	sw $zero, 6788($gp)
	
	# draw "W"
	li $t2, 0
	li $s0, 7
	la $t9, 8548($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 7
	la $t9, 8564($gp)
	jal delete_height_floor
	
	sw $zero, 9832($gp)
	sw $zero, 9580($gp)
	sw $zero, 9840($gp)
	
	# draw "I"
	li $t2, 0
	li $s0, 7
	la $t9, 8584($gp)
	jal delete_height_floor
	
	sw $zero, 8580($gp)
	sw $zero, 8588($gp)
	sw $zero, 10116($gp)
	sw $zero, 10124($gp)
	
	# draw "N"
	li $t2, 0
	li $s0, 7
	la $t9, 8604($gp)
	jal delete_height_floor
	li $t2, 0
	li $s0, 7
	la $t9, 8620($gp)
	jal delete_height_floor
	
	sw $zero, 8864($gp)
	sw $zero, 9120($gp)
	sw $zero, 9380($gp)
	sw $zero, 9640($gp)
	sw $zero, 9896($gp)
	
	j d_w
### delete helpers	
delete_length_floor:
	move $t3, $s0	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 2	#offset = i * 4, move to next line
	add $t4, $t3, $t9
	sw $zero, 0($t4)
	addi $t2, $t2, 1
	j delete_length_floor
	
delete_height_floor:
	move $t3, $s0 	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 8	#offset = i * 256, move to next line
	add $t4, $t3, $t9
	sw $zero, 0($t4)
	addi $t2, $t2, 1
	j delete_height_floor
	
delete_jumped_floor:
	move $t3, $s0	# num of vertical lines
	beq $t2, $t3, raback
	#  loop
	sll $t3, $t2, 3	#offset = i * 4, move to next line
	add $t4, $t3, $t9
	sw $zero, 0($t4)
	addi $t2, $t2, 1
	j delete_jumped_floor
######### delete done ######
over:
	addi $t9, $ra, 0
        jal delete_all
        
        jal draw_gg
        
        addi $ra, $t9, 0
        jr $ra
        
win:
	addi $t9, $ra, 0
        jal delete_all
        
        jal draw_win
        
        addi $ra, $t9, 0
        jr $ra
##### collision #####
up_collision:
	add $a0, $s6, $zero
	lw $t9, 0($a0)	# check the first unit
	lw $t8, 4($a0)	# check the second unit
	addi $t6, $t9, -256
	addi $t7, $t8, -256	# check the previous line 
	lw $s3, 0($t6)
	lw $t4, 0($t7)
	bne $t4, $zero, gravity_loop
	bne $s3, $zero, gravity_loop
	#beq $t4, $zero, debug
	j up
	
left_collision:
	add $a0, $s6, $zero
	lw $t2, 0($a0)
	lw $t3, 8($a0)
	addi $t4, $t2, -4
	addi $t6, $t3, -4
	lw $s3, 0($t4)
	lw $s4, 0($t6)
	bne $s3, $zero, key_refresh
	bne $s4, $zero, key_refresh
	j left
	
right_collision:
	add $a0, $s6, $zero
	lw $t2, 4($a0)
	lw $t3, 12($a0)
	addi $t4, $t2, 4
	addi $t6, $t3, 4
	lw $s3, 0($t4)
	lw $s4, 0($t6)
	bne $s3, $zero, key_refresh
	bne $s4, $zero, key_refresh
	j right
enemy_collision:
	li $s0, 40
	add $a0, $s6, $zero
	add $v1, $a2, $zero
	li $t7, White
	li $t8, Health
	li $t5, Yellow
	lw $t3, 8($a0)
	lw $t2, 12($a0)
	addi $t4, $t3, -4	# left side of third unit
	addi $t6, $t2, 4	# right side of fourth unit
	lw $s3, 0($t4)
	lw $s4, 0($t6)
	beq $s3, $t8, get_trapped	# any of feet reached trap, then get trapped
	beq $s4, $t8, get_trapped
	jr $ra
	
trap_collision:
	li $s0, 40
	add $a0, $s6, $zero
	add $v1, $a2, $zero
	li $t7, White
	li $t8, Grey
	li $t5, Yellow
	lw $t3, 8($a0)
	lw $t2, 12($a0)
	addi $t4, $t3, 256
	addi $t6, $t2, 256
	lw $s3, 0($t4)
	lw $s4, 0($t6)
	beq $s3, $t8, get_trapped	# any of feet reached trap, then get trapped
	beq $s4, $t8, get_trapped
back:
	jr $ra
get_trapped:
	addi $v1, $v1, -1	# if get trapped, health minus one
	blez $v1, back
	lw $t9, 0($a0)
	sw $t7, 0($t9)
	lw $t9, 4($a0)
	sw $t7, 0($t9)
	lw $t9, 8($a0)
	sw $t7, 0($t9)
	lw $t9, 12($a0)
	sw $t7, 0($t9)
	
	li $v0, 32
        add $a0, $s0, $zero
        syscall
        
        li $v0, 32
        add $a0, $s0, $zero
        syscall
        
        add $a0, $s6, $zero
        lw $t9, 0($a0)
	sw $t5, 0($t9)
	lw $t9, 4($a0)
	sw $t5, 0($t9)
	lw $t9, 8($a0)
	sw $t5, 0($t9)
	lw $t9, 12($a0)
	sw $t5, 0($t9)
	
	li $v0, 32
        add $a0, $s0, $zero
        syscall
        
        add $a0, $s6, $zero
	lw $t9, 0($a0)
	sw $zero, 0($t9)
	lw $t9, 4($a0)
	sw $zero, 0($t9)
	lw $t9, 8($a0)
	sw $zero, 0($t9)
	lw $t9, 12($a0)
	sw $zero, 0($t9)
	# jump to initial place
	li $t5, Yellow
	sw $t5, 15368($gp)
	sw $t5, 15372($gp)
	sw $t5, 15624($gp)
	sw $t5, 15628($gp)	
	la $s6, square
	
	addi $t4, $gp, 15368
	sw $t4, 0($s6)
	addi $t4, $gp, 15372
	sw $t4, 4($s6)
	addi $t4, $gp, 15624
	sw $t4, 8($s6)
	addi $t4, $gp, 15628
	sw $t4, 12($s6)
	
	j back
win_collision:
	add $a0, $s6, $zero
	#li $s2, -2
	li $t5, Green
	lw $t2, 12($a0)
	addi $t3, $t2, 4	# right unit of fourth unit
	addi $t4, $t2, 256	# down unit of fourth unit
	lw $s3, 0($t3)
	lw $s4, 0($t4)
	beq $t5, $s3, draw_win
	beq $t5, $s4, draw_win
	jr $ra
##### find collision #####
######### gravity setting  ###############
gravity_loop:
	li $s0, 40
	add $a0, $s6, $zero
	li $t5, Yellow
	li $t3, Black
	lw $t1, 8($a0)		# check the character third unit
	lw $t2, 12($a0)		# check the fourth unit
	addi $t4, $t1, 256	# check the next line of character
	addi $t6, $t2, 256
	lw $t7, 0($t4)		# t7 is the color of next pixel
	lw $t8, 0($t6)		# t8 is the color
	bne $t7, $t3, raback
	bne $t8, $t3, raback
	
drop:	# drop
	sw $zero, 0($t1)
	addi $t1, $t1, 256
	sw $t5, 0($t1)
	sw $t1, 8($a0)		# drop the third unit
	
	sw $zero, 0($t2)
	addi $t2, $t2, 256
	sw $t5, 0($t2)
	sw $t2, 12($a0)		# drop the fourth unit
	
	lw $t1, 0($a0)
	sw $zero, 0($t1)
	addi $t1, $t1, 256
	sw $t5, 0($t1)
	sw $t1, 0($a0)		# drop the first unit
	
	lw $t1, 4($a0)
	sw $zero, 0($t1)
	addi $t1, $t1, 256
	sw $t5, 0($t1)
	sw $t1, 4($a0)		# drop the second unit
	
	li $v0, 32
        add $a0, $s0, $zero
        syscall			# sleep
     
	j gravity_loop

########################## end of gravity
raback:
	jr $ra
