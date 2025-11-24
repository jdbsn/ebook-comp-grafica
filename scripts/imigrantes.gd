extends Area2D

@onready var comida = %Comida
@onready var dinheiro = %Dinheiro

var deslocamento = Vector2(0, -40)
var tempo = 0.5
var tempo_visivel = 0.5
var toques_necessarios = 5
var qtd_toques = 0

func _ready():
	set_process_input(true)
	comida.visible = false
	dinheiro.visible = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if qtd_toques == toques_necessarios:
			mostrar_efeitos()
			qtd_toques = 0
		else:
			qtd_toques += 1	

func mostrar_efeitos():
	mostrar_sprite(comida, Vector2(-148, -60))
	mostrar_sprite(dinheiro, Vector2(238, -239))

func mostrar_sprite(s, p):
	s.visible = true
	s.position = p

	var destino = s.position + deslocamento

	var t = create_tween()
	t.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	t.tween_property(s, "position", destino, tempo)
	t.tween_interval(tempo_visivel)
	t.tween_property(s, "modulate:a", 0.0, 0.3)

	t.tween_callback(func():
		s.modulate.a = 1.0
		s.visible = false
	)
