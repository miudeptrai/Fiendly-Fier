extends Button

var tween: Tween;

func _ready() -> void:
	await get_tree().process_frame;
	pivot_offset = size / 2.0;

func _on_mouse_entered() -> void:
	reset_tween();
	tween.tween_property(
		self,
		"scale",
		Vector2(1.1, 1.1),
		.4
	)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC);

func _on_mouse_exited() -> void:
	reset_tween();
	tween.tween_property(
		self,
		"scale",
		Vector2.ONE,
		.4
	)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC);

func reset_tween() -> void:
	if (tween):
		tween.kill();
	tween = create_tween();
