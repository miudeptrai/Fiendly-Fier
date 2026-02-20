extends Control

@onready var grid_container: GridContainer = $Panel2/GridContainer;

var sub_chapters_map: Dictionary[Button, String] = {};

func _on_chapter_button_load_sub_chapters(
	sub_chapters: Array[SubChapter]
) -> void:
	for sub_chapter in sub_chapters:
		var button: Button = Button.new();
		button.pressed.connect(_on_button_pressed.bind(button));
		button.text = sub_chapter.display_name;
		sub_chapters_map[button] = sub_chapter.map;
		grid_container.add_child(button);

func _on_button_pressed(button: Button):
	get_tree().change_scene_to_file(sub_chapters_map[button]);
