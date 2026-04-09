extends CharacterBody3D

var MovementInputVectors:Vector2
var RotatedInputVectors:Vector3

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

		print(event.screen_relative)
	if event.is_action_pressed("Jump") and is_on_floor():
		velocity.y += 7
		Animator["parameters/playback"].travel("Jump")

func _physics_process(delta: float) -> void: 
	velocity.x = RotatedInputVectors.x * 10
	velocity.z = RotatedInputVectors.z * 10
	velocity.y -=9.8*get_physics_process_delta_time()
	if velocity.x != 0 or velocity.z != 0 and 	Animator["parameters/playback"].animation != "Walk":
		Animator["parameters/playback"].travel("Walk")
	else:
		Animator["parameters/playback"].travel("Idle")


	move_and_slide()
