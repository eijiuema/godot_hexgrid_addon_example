extends KinematicBody2D

export var SPEED = 500

func _physics_process(delta: float) -> void:
	
	var velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
		
	if Input.is_action_pressed("ui_up"):
		velocity.y -= SPEED
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += SPEED
		
	var collision = move_and_slide(velocity)