extends Node2D

@onready var tilemap: TileMap = $TileMap;
@onready var user_screen: CharacterBody2D = $"User Screen";
@onready var tile_size: Vector2i = tilemap.tile_set.tile_size;

const RIFLE_MAN: PackedScene = preload("uid://dochsu3hvhqgl");

var grid_width: int;
var grid_height: int;
var layer_count: int;

var astar: AStar3D = AStar3D.new();

func _ready() -> void:
	load_astar();
	
	var troop: Area2D = RIFLE_MAN.instantiate();
	add_child(troop);
	troop.setup(user_screen, Vector3i(0,0,0));
	
	print(tilemap.map_to_local(Vector2i(0,0)));
	print(troop.stats.get_global_pos(tile_size));

func load_astar() -> void:
	var grid_rect: Rect2i = tilemap.get_used_rect();
	grid_width = grid_rect.size.x;
	grid_height = grid_rect.size.y;
	
	layer_count = tilemap.get_layers_count();
	
	astar.clear();
	#Add points
	for layer in range(layer_count):
		var used_cells: Array[Vector2i] = tilemap.get_used_cells(layer);
		
		for cell in used_cells:
			var tile_data: TileData = tilemap.get_cell_tile_data(layer, cell);
			if (tile_data == null): continue;
			
			if (not tile_data.get_custom_data("walkable")): continue;
			
			var pos: Vector3i = Vector3i(cell.x, cell.y, layer);
			var id: int = get_id(pos);
			
			astar.add_point(id, pos);
	
	#Connect points
	connect_astar();
	print("Connected astar successfully");
	
	#Disable points
	disable_all();

func connect_astar() -> void:
	for layer in range(layer_count):
		var used_cells: Array[Vector2i] = tilemap.get_used_cells(layer);
		
		for cell in used_cells:
			var tile_data: TileData = tilemap.get_cell_tile_data(layer, cell);
			if (tile_data == null): continue;
			
			if (not tile_data.get_custom_data("walkable")): continue;
			
			var pos: Vector3i = Vector3i(cell.x, cell.y, layer);
			var id: int = get_id(pos);
			
			var adj: Array[Vector2i] = [
				Vector2i.UP,
				Vector2i.RIGHT,
				Vector2i.DOWN,
				Vector2i.LEFT
			];
			for dir in adj:
				var neighbour: Vector2i = cell + dir;
				#Connect upper layer of rafters
				var is_rafter: bool = tile_data.get_custom_data("go_up") and\
										tile_data.get_custom_data("direction") == dir;
				var neighbour_data: TileData = tilemap.get_cell_tile_data(
					layer + int(is_rafter),
					neighbour
				);
				if (neighbour_data == null): continue;
				if (not neighbour_data.get_custom_data("walkable")): continue;
				
				var neighbour_pos: Vector3i = Vector3i(
					neighbour.x,
					neighbour.y,
					clampi(layer + int(is_rafter), 0, layer_count - 1)
				);
				var neighbour_id: int = get_id(neighbour_pos);
				
				if (astar.has_point(neighbour_id)):
					astar.connect_points(id, neighbour_id);

func disable_all() -> void:
	for layer in range(layer_count):
		var used_cells: Array[Vector2i] = tilemap.get_used_cells(layer);
		
		for cell in used_cells:
			var tile_data: TileData = tilemap.get_cell_tile_data(layer, cell);
			if (tile_data == null): continue;
			
			if (not tile_data.get_custom_data("walkable")): continue;
			
			var pos: Vector3i = Vector3i(cell.x, cell.y, layer);
			var id: int = get_id(pos);
			
			astar.set_point_disabled(id, true);

func get_id(pos: Vector3i) -> int:
	return pos.x + pos.y * grid_width + pos.z * grid_width * grid_height;
	
	
	
	
	
	
