extends Area2D

@export var id_pessoa: int   # 1 = pessoa 1, 2 = pessoa 2

var dragging := false
var offset := Vector2.ZERO
var start_position: Vector2


func _ready():
	start_position = global_position
	input_event.connect(_on_click)

func _on_click(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			offset = global_position - event.position
		else:
			dragging = false

func _input(event):
	if dragging and event is InputEventMouseMotion:
		global_position = event.position + offset

func return_to_start():
	dragging = false

	var tw = create_tween()
	tw.tween_property(self, "global_position", start_position, 0.4)
