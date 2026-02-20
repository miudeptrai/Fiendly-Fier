extends Button

signal load_sub_chapters(sub_chapters: Array[SubChapter]);

@export var chapter: Chapter;

func _ready() -> void:
	text = chapter.display_name;


func _on_pressed() -> void:
	load_sub_chapters.emit(chapter.sub_chapters);
	
