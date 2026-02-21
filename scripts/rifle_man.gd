extends Area2D

@onready var button: Button = $Button;
@onready var map: Node2D = get_parent();

@export var stats: Stats;

var user_screen: CharacterBody2D;

func _ready() -> void:
	add_to_group("Troop");
	stats.health_depleted.connect(_on_health_depleted);
	stats.morale_depleted.connect(_on_morale_depleted);
	stats.moved.connect(_on_moved);

func setup(user: CharacterBody2D, pos: Vector3i) -> void:
	user_screen = user;
	button.pressed.connect(user_screen._on_troop_pressed.bind(self));
	
	stats.grid_pos = pos;

func _on_health_depleted() -> void:
	pass;

func _on_morale_depleted() -> void:
	pass;


func _on_moved() -> void:
	global_position = stats.get_global_pos(map.tile_size);
	
	
