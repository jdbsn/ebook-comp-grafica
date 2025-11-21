extends Control

@onready var play_button = %BotaoPlay
var hide_timer: SceneTreeTimer = null

func _gui_input(event):
	if (event is InputEventMouseButton and event.pressed) \
	or (event is InputEventScreenTouch and event.pressed):

		play_button.show()
		_start_hide_timer()

func _start_hide_timer():
	if hide_timer and hide_timer.is_connected("timeout", _hide_button):
		hide_timer.disconnect("timeout", _hide_button)

	hide_timer = get_tree().create_timer(2.0)
	hide_timer.timeout.connect(_hide_button)

func _hide_button():
	play_button.hide()

func _on_finished() -> void:
	play_button.reset()
