extends Node

@onready var narracao = %NarracaoPlayer
@onready var botao = %BotaoSom

var reproduzindo = false

func _ready():
	if narracao:
		narracao.finished.connect(_on_narracao_finished)

func reproduzir_narracao():
	if !narracao:
		push_warning("Player não encontrado na cena")
		return

	if !reproduzindo:
		reproduzindo = true
		narracao.play()
	else:
		reproduzindo = false
		narracao.stop()

	_atualizar_botao()

func _on_narracao_finished():
	reproduzindo = false
	_atualizar_botao()

func _atualizar_botao():
	if reproduzindo:
		botao.button_pressed = true
	else:
		botao.button_pressed = false
