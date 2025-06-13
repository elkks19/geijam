extends Area2D

@export var door_path: NodePath


var touching_player := false

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body: Node):
	if body.name in ["player", "empresario2"]:
		touching_player = true
		_update_door(true)

func _on_body_exited(body: Node):
	if body.name in ["player", "empresario2"]:
		touching_player = false
		_update_door(false)

func _update_door(open: bool):
	var door = get_node_or_null(door_path)
	if door:
		if open:
			door.visible = false
			door.get_node("CollisionShape2D").disabled = true
		else:
			door.visible = true
			door.get_node("CollisionShape2D").disabled = false
