extends Label

@onready var control: Control = $"..";


func _process(delta: float) -> void:
	var mouse_pos: Vector2 = control.get_local_mouse_position();
	position = mouse_pos.clamp(Vector2.ZERO, control.size - size);
