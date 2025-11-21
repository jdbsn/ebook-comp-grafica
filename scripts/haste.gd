extends RigidBody2D

@export var potencia_motor: float = 4000000
@export var sensibilidade_tilt: float = 3.0

func _ready():
	sleeping = false
	can_sleep = false

func _physics_process(delta):
	var tilt = 0.0
	
	var input_teclado = Input.get_axis("ui_left", "ui_right")
	
	if input_teclado != 0:
		tilt = input_teclado * 9.8
	else:
		var accel = Input.get_accelerometer()
		tilt = accel.x

	if tilt != 0:
		var torque = tilt * sensibilidade_tilt * potencia_motor * delta
		apply_torque(torque)
