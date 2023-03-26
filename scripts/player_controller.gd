extends KinematicBody

export var _speed = 1.0
export var _mouse_sensetivity = 0.4
export var _gravity_power = 5.0
export var _jump_power = 2.0

var _gravity = 0;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_handle(event)

func mouse_handle(event):
	rotation_degrees.y -= event.relative.x * _mouse_sensetivity
		
	$Camera.rotation_degrees.x -= event.relative.y * _mouse_sensetivity
	$Camera.rotation_degrees.x = clamp($Camera.rotation_degrees.x, -90, 90)

func gravity_handle(vec, delta):
	_gravity -= _gravity_power * delta
	
	if is_on_floor():
		_gravity = 0
		
	return vec + Vector3(0, _gravity, 0)

func keyboard_handle(vec):
	if Input.is_action_pressed("ui_exit"):
		get_tree().quit()
	if Input.is_action_pressed("ui_jump"):
		_gravity = _jump_power
	if Input.is_action_pressed("ui_left"):
		vec -= transform.basis.x
	if Input.is_action_pressed("ui_right"):
		vec += transform.basis.x
	if Input.is_action_pressed("ui_up"):
		vec -= transform.basis.z
	if Input.is_action_pressed("ui_down"):
		vec += transform.basis.z
		
	return vec

func _physics_process(delta):
	var vec = Vector3.ZERO
	
	vec = keyboard_handle(vec)
	vec = gravity_handle(vec, delta)
	
	move_and_slide(vec * _speed, Vector3.UP)
