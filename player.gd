extends CharacterBody2D

@export var JUMP_FORCE = -120
@export var MAX_SPEED = 50
@export var ACCELERATION = 2
@export var FRICTION = 2
@export var GRAVITY = 4
@export var ADDITIONAL_FALL_GRAVITY = 4

@onready var animatedSprite = $AnimatedSprite2D

var input = Vector2.ZERO

# Defined: which character to load
func _ready() -> void:
	animatedSprite.sprite_frames = load("res://YellowPlayer.tres")

# Defined: speed, animation, movements of the character
func _physics_process(delta: float) -> void:
	apply_gravity()

	# To determine whether character is going left or right
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	# character is moving (either left or right)
	if input.x != 0:
		apply_acceleration(input.x)

	# character is stationery
	elif input.x == 0:
		apply_friction()

	# Jump only if character has hit the floor/block
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = JUMP_FORCE

	# if character is falling down
	else:
		animatedSprite.animation = "Jump"
		if velocity.y > 0:
			velocity.y += ADDITIONAL_FALL_GRAVITY

	# Make sure the character keeps moving when commanded
	move_and_slide()


# Defined: speed when the character falls
func apply_gravity():
	velocity.y += GRAVITY


# Defined: speed and animation when character moves (left or right)
func apply_acceleration(input):
	velocity.x = move_toward(velocity.x, MAX_SPEED * input, ACCELERATION)

	# character is moving left
	if input < 0:
		animatedSprite.flip_h = false
	# character is moving right
	else:
		animatedSprite.flip_h = true
	animatedSprite.animation = "Run"


# Defined: speed(0) and animation when character is not moving
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	animatedSprite.animation = "Idle"
		
