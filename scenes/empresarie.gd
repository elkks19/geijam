extends CharacterBody2D

const SPEED: float = 100.0
var motion: Vector2 = Vector2.ZERO

@onready var animation: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	motion = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		animation.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		animation.play("run")
	else:
		animation.play("idle")

	velocity = motion
	move_and_slide()
