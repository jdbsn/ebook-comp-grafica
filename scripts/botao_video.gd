extends Button

@onready var video := $"../VideoStreamPlayer"

var paused := true

func _pressed():
	if paused == false:
		video.set_paused(true)
		paused = true
		text = "▶︎ Assistir vídeo"
	else:
		if video.stream_position == 0:
			video.play()

		video.set_paused(false)
		hide()
		paused = false
		text = "❚❚ Pausar vídeo"

func reset():
	text = "Assistir vídeo"
	paused = true
	show()
