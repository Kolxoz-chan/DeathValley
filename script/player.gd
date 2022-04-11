extends KinematicBody2D

var impulse = 0
var jump_power = -300
var speed = 100
var gravity = 9.8

var wood = 0

func _physics_process(delta):
	var vec = Vector2.ZERO
	
	# Gravity
	impulse += gravity
	vec.y += impulse
	
	if is_on_floor():
		impulse = 0
	
	# Controll
	var obj = $hand.get_collider()
	if obj:
		if obj.is_in_group("killable"):
			$hint.visible = true
			if Input.is_action_just_pressed("ui_atack"):
				obj.addHit(1)
				wood += 1
				
		if obj.is_in_group("campfire"):
			$hint.visible = true
			$hint.text = "ADD"
			if wood > 0 and Input.is_action_just_pressed("ui_atack"):
				obj.addFuel(1)
				wood -= 1
	else:
		$hint.visible = false
	
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		vec.x += speed
		$Sprite.flip_h = false
		$hand.rotation_degrees = -90
		
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		vec.x -= speed
		$Sprite.flip_h = true
		$hand.rotation_degrees = 90
		
	if is_on_floor() and (Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_W)):
		impulse = jump_power
	
	move_and_slide(vec, Vector2(0, -1)) 
