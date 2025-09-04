extends CharacterBody2D

func _physics_process(delta: float) -> void:
	apply_gravity()
	
	var input = Vector2.ZERO
	
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x != 0:
		apply_acceleration(input.x)
	elif input.x == 0:
		apply_friction()
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = -75
		
	move_and_slide()

func apply_gravity():
	velocity.y += 2
	
func apply_acceleration(input):
	velocity.x = move_toward(velocity.x, 50 * input, 20)
	
func apply_friction():
	pass
		
