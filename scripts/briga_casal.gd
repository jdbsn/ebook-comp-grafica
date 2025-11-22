extends Node2D

@onready var figura_esq = %Homem
@onready var figura_dir = %Mulher
@onready var bebe = %BebeChorando
@onready var balao = %BalaoFala

var pos_inicial_esq_x = 0.0
var pos_inicial_dir_x = 0.0

var bloqueado = false 
var tempo_animacao = 4.0

var toques_ativos = {}
var distancia_anterior = 0.0
var sensibilidade_touch = 0.5
var sensibilidade_mouse = 20.0

var min_distancia = 50.0
var max_distancia = 250.0 

func _ready():
	if figura_esq and figura_dir:
		pos_inicial_esq_x = figura_esq.position.x
		pos_inicial_dir_x = figura_dir.position.x
		
		var distancia_inicial = pos_inicial_dir_x - pos_inicial_esq_x

func _input(event):
	if bloqueado:
		return

	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				mover_figuras(sensibilidade_mouse) 
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				mover_figuras(-sensibilidade_mouse)

	elif event is InputEventScreenTouch:
		if event.pressed:
			toques_ativos[event.index] = event.position
		else:
			toques_ativos.erase(event.index)
			distancia_anterior = 0.0
			
			if toques_ativos.size() == 0:
				verificar_retorno_ao_soltar()

	elif event is InputEventScreenDrag:
		toques_ativos[event.index] = event.position
		if toques_ativos.size() == 2:
			calcular_pinça_touch()

func calcular_pinça_touch():
	if bloqueado: return 
	
	var posicoes = toques_ativos.values()
	var ponto_a = posicoes[0]
	var ponto_b = posicoes[1]
	var distancia_atual = ponto_a.distance_to(ponto_b)
	
	if distancia_anterior > 0:
		var diferenca = distancia_atual - distancia_anterior
		mover_figuras(diferenca * sensibilidade_touch)
	
	distancia_anterior = distancia_atual

func mover_figuras(movimento_total):
	if balao.visible:
		balao.hide()
	
	var passo = movimento_total / 2
	
	var nova_pos_esq = figura_esq.position.x - passo
	var nova_pos_dir = figura_dir.position.x + passo
	
	var distancia_atual = figura_dir.position.x - figura_esq.position.x
	var distancia_futura = nova_pos_dir - nova_pos_esq
	
	if distancia_futura < distancia_atual:
		if distancia_futura < min_distancia:
			return

	if distancia_futura > max_distancia:
		resetar_suavemente()
		return
		
	figura_esq.position.x = nova_pos_esq
	figura_dir.position.x = nova_pos_dir

func verificar_retorno_ao_soltar():
	if abs(figura_esq.position.x - pos_inicial_esq_x) > 1.0:
		resetar_suavemente()

func resetar_suavemente():
	bloqueado = true
	
	var tween = create_tween()
	
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.set_parallel(true)
	
	tween.tween_property(figura_esq, "position:x", pos_inicial_esq_x, tempo_animacao)
	tween.tween_property(figura_dir, "position:x", pos_inicial_dir_x, tempo_animacao)
	tween.tween_property(bebe, "position:x", 280, tempo_animacao)
	
	tween.chain().tween_callback(desbloquear_input)

func desbloquear_input():
	bloqueado = false
	distancia_anterior = 0.0 
	
	balao.show()
