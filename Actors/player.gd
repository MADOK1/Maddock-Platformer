extends CharacterBody3D

var MovementInputVectors:Vector2
var RotatedInputVectors:Vector3
var maxSpeed = Vector2(10,10)
@onready var Animator:AnimationTree = $SubViewport/MaddockBones/AnimationTree

func _ready() -> void:
	Animator["parameters/playback"].travel("Idle")
func _process(delta: float) -> void:
	MovementInputVectors = Input.get_vector("Left", "Right", "Forward", "Backward")
	RotatedInputVectors = global_transform.basis * Vector3(MovementInputVectors.x,0,MovementInputVectors.y)
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.screen_relative.x))
		
		$CameraAnchor.rotate_x(deg_to_rad(-event.screen_relative.y))
		$CameraAnchor.rotation.x = clamp($CameraAnchor.rotation.x,deg_to_rad(-40),deg_to_rad(20))
		#if $CameraAnchor.rotation.x >= 40: $CameraAnchor.rotation.x =40
		#wssssssawif $CameraAnchor.rotation.x <= -50: $CameraAnchor.rotation.x =-50

	if event.is_action_pressed("Jump") and is_on_floor():
		velocity.y += 7
		Animator["parameters/playback"].travel("Jump")

func _physics_process(delta: float) -> void: 
	if is_on_floor():
		velocity.x = lerp(velocity.x,RotatedInputVectors.x * 10,0.2)
		velocity.z = lerp(velocity.z,RotatedInputVectors.z * 10,0.2)
	elif (abs(MovementInputVectors.x) + abs(MovementInputVectors.y)) != 0:
		velocity.x = lerp(velocity.x,RotatedInputVectors.x * 10,0.01)
		velocity.z = lerp(velocity.z,RotatedInputVectors.z * 10,0.01)
	#if is_on_floor():
	#	if abs(MovementInputVectors.x) < 0.05:
	#		velocity.x = lerp(velocity.x, 0.0, 0.1)
	#	if abs(MovementInputVectors.y) < 0.05:
	#		velocity.z = lerp(velocity.z, 0.0, 0.1)

	velocity.y -=9.8*get_physics_process_delta_time()
	print(velocity)
	if (abs(velocity.x) > 0.05 or abs(velocity.z) > 0.05) and Animator["parameters/playback"].get_current_node() != "Walk":
		Animator["parameters/playback"].travel("Walk")
	elif (abs(velocity.x) <= 0.05 or abs(velocity.z) <= 0.05) and Animator["parameters/playback"].get_current_node() != "Idle":
		Animator["parameters/playback"].travel("Idle")


	move_and_slide()
