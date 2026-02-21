extends CharacterBody2D

@export var speed: float = 1000.0;

var cur_selected_troop: Area2D: set = _on_selected_troop_set;

func _process(delta: float) -> void:
	var dir: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	);
	velocity = dir * speed;
	
	move_and_slide();

func _on_troop_pressed(troop: Area2D) -> void:
	if (troop == cur_selected_troop): return;
	cur_selected_troop = troop;
	print("Loading move range");

func _on_selected_troop_set(new_troop: Area2D) -> void:
	if (new_troop != cur_selected_troop):
		print("New selected troop");
		cur_selected_troop = new_troop;
