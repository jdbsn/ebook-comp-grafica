extends RigidBody2D

@export var potencia_motor: float = 4000000
@export var sensibilidade_tilt: float = 2.0

func _ready():
	sleeping = false
	can_sleep = false
	print("SCRIPT INICIADO NA: ", name) # Verifica se o script está rodando

func _physics_process(delta):
	var tilt = 0.0
	
	# --- LÓGICA DE TESTE ---
	# Vamos forçar a leitura do teclado primeiro para garantir
	var input_teclado = Input.get_axis("ui_left", "ui_right")
	
	if input_teclado != 0:
		tilt = input_teclado * 9.8
	else:
		# Se não apertou tecla, tenta o acelerômetro
		var accel = Input.get_accelerometer()
		tilt = accel.x
		# print(accel) # Descomente se quiser ver o acelerômetro

	# Aplica força
	if tilt != 0:
		var torque = tilt * sensibilidade_tilt * potencia_motor * delta
		apply_torque(torque)
		# print("Aplicando Torque: ", torque) # Debug final
