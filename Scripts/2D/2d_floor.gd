extends Node2D

@export var two_d_shape_scenes: Array[PackedScene] = []
@onready var two_d_shape_container = $TwoDShapeContainer

var player = null

var view_rect

# Called when the node enters the scene tree for the first time.
func _ready():
	view_rect = get_viewport_rect()
	player = get_node("Player2D")
	assert(player != null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_2d_shapes():
	var which_shape = randi() % 3
	var shape_2d = two_d_shape_scenes[which_shape].instantiate()
	shape_2d.im_collected.connect(_on_collect_2d_shape)
	shape_2d.global_position = shape_2d_spawn_location()
	two_d_shape_container.add_child(shape_2d)
	

func _on_collect_2d_shape(two_d_shape_ID):
	if player.collected_shapes >= player.max_shapes:
		return
		
	player.collected_shapes += 1
	if player.collected_shapes < player.max_shapes:
		player.my_shape_one = two_d_shape_ID
	else:
		player.my_shape_two = two_d_shape_ID	
	

func shape_2d_spawn_location():
	return Vector2(randf_range(100, view_rect.size.x -100), 0)


func _on_dspawn_timer_timeout():
	spawn_2d_shapes()
