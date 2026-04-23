extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MaddockBones/AnimationTree/AnimationPlayer.play("mainmenugifdance")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/trenchbroom_loader_test.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/wuhu_island.tscn")
