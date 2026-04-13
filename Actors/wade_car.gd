extends VehicleBody3D

var MovementInputVectors:Vector2
var RotatedInputVectors:Vector3
var maxSpeed = Vector2(10,10)


func _process(delta: float) -> void:
	MovementInputVectors = Input.get_vector("Left", "Right", "Forward", "Backward")
	RotatedInputVectors = global_transform.basis * Vector3(MovementInputVectors.x,0,MovementInputVectors.y)
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED

#func _input(event: InputEvent) -> void:
#	if event is InputEventMouseMotion:
#		$CameraAnchor.rotate_y(deg_to_rad(-event.screen_relative.x))
#		
#		$CameraAnchor/Camera3D.rotate_x(deg_to_rad(-event.screen_relative.y))
#		$CameraAnchor/Camera3D.rotation.x = clamp($CameraAnchor/Camera3D.rotation.x,deg_to_rad(-40),deg_to_rad(20))


func _physics_process(delta: float) -> void: 
	engine_force = -MovementInputVectors.y *300
	#brake = -MovementInputVectors.y * 300
	steering = move_toward(steering,-MovementInputVectors.x,delta)
