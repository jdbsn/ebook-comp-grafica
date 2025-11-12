extends Node

@onready var narracao = %NarracaoPlayer
var reproduzindo = false

func reproduzir_narracao():
	if narracao:
		if(!reproduzindo):
			reproduzindo = true
			narracao.play()
		else:
			reproduzindo = false
			narracao.stop()
	else:
		push_warning("Player não encontrado na cena")
