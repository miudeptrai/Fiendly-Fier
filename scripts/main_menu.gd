extends Control


func _on_missions_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mission_selector.tscn");
