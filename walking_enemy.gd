extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D

var direction = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	
	if is_on_wall():
		direction *= -1
		
		animatedSprite.flip_h = (direction == Vector2.RIGHT)
	
	velocity = direction * 30
	move_and_slide()
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().reload_current_scene()
