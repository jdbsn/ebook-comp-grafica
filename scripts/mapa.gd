extends Node2D

@onready var caravela := $Caravela

var arrastando := false
var deslocamento := Vector2.ZERO

func _ready():
	caravela.input_event.connect(_quando_clica)

func _quando_clica(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			arrastando = true
			deslocamento = caravela.global_position - event.position
		else:
			arrastando = false

func _input(event):
	if arrastando and event is InputEventMouseMotion:
		caravela.global_position = event.position + deslocamento
