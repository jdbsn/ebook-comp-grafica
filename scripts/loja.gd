extends Area2D

@export var mensagem_label: Label

var current_body: Area2D = null
var timer := Timer.new()

func _ready():
	add_child(timer)
	timer.one_shot = true
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area.has_method("return_to_start"):
		current_body = area
		timer.start(0.5)

func _on_area_exited(area):
	if current_body == area:
		timer.stop()
		current_body = null

func _process(delta):
	if timer.is_stopped() and current_body:
		_process_entrada()

func _process_entrada():
	if current_body == null:
		return

	if current_body.id_pessoa == 1:
		mostrar_mensagem("NÃO CONTRATADO")


	elif current_body.id_pessoa == 2:
		mostrar_mensagem("CONTRATADO!")

	current_body.return_to_start()
	current_body = null

func mostrar_mensagem(texto: String):
	mensagem_label.text = texto
	mensagem_label.modulate.a = 0.0
	mensagem_label.visible = true

	var tw = create_tween()
	tw.tween_property(mensagem_label, "modulate:a", 1.0, 0.2)
	tw.tween_interval(1.5)
	tw.tween_property(mensagem_label, "modulate:a", 0.0, 0.4)

	tw.finished.connect(func():
		mensagem_label.visible = false
	)
