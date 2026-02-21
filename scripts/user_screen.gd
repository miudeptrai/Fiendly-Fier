extends CharacterBody2D

@onready var label: Label = $Control/Label;
@onready var lower_ui: Panel = $Control/LowerUI;
@onready var stats_ui: Panel = $Control/StatsUI;

@export var speed: float = 1000.0;

var cur_selected_troop: Area2D: set = _on_selected_troop_set;

func load_stats_ui() -> void:
	stats_ui.get_node("NameTag").text = cur_selected_troop.stats.display_name;
	stats_ui.get_node("HealthBar").value = cur_selected_troop.stats.get_health_percentage();
	stats_ui.get_node("MoraleBar").value = cur_selected_troop.stats.get_morale_percentage();
	stats_ui.get_node("TextureRect").texture = cur_selected_troop.stats.texture;

func _process(delta: float) -> void:
	var dir: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	);
	velocity = dir * speed;
	
	move_and_slide();

func _on_troop_pressed(troop: Area2D) -> void:
	#UI
	if (troop == cur_selected_troop):
		if (lower_ui.visible):
			lower_ui.hide();
			stats_ui.hide();
		else:
			lower_ui.show();
			stats_ui.show();
		return;
	
	cur_selected_troop = troop;
	
	load_stats_ui();
	lower_ui.show();
	stats_ui.show();
	
	print("Loading move range");

func _on_selected_troop_set(new_troop: Area2D) -> void:
	if (new_troop != cur_selected_troop):
		print("New selected troop");
		cur_selected_troop = new_troop;

func _on_troop_mouse_entered(troop: Area2D) -> void:
	#Nametag
	label.text = troop.stats.display_name + '\n';
	label.text += "Health: %.2f%%" % troop.stats.get_health_percentage();
	label.text += '\n';
	label.text += "Morale: %.2f%%" % troop.stats.get_morale_percentage();
	label.show();

func _on_troop_mouse_exited() -> void:
	label.hide();
