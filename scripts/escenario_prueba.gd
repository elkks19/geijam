extends Node2D

@onready var dolares = $dolares
@onready var cholo = $cholo

func _ready():
	pass # Replace with function body.


func _process(delta):
	for dolar in dolares.get_children():
		dolar.connect("dolar_tomado", cholo.tomar_dolar)
