extends Node2D

@onready var area = $Area2D

signal dolar_tomado

func _physics_process(delta):
	pass

func _on_area_2d_body_entered(body):
	emit_signal("dolar_tomado")
	queue_free()
