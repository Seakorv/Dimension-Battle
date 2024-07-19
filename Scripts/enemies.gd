class_name Enemy extends Area3D

signal enemy_shot(is_correct)

@export var shape_ID: int = 0
@export var my_2D_one: int = 0
@export var my_2D_two: int = 0
@export var speed: float = 2
@export var rot_speed: float = 0.01

var vel = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	rotation.y += rot_speed / 2
	rotation.x += rot_speed / 2
	vel.z = speed
	position += vel * delta


func _on_area_entered(area):
	if area is Player3DShapes and area.is_shot:
		if area.shape_ID == shape_ID:
			enemy_shot.emit(true)
			queue_free()
		else:
			enemy_shot.emit(false)
		
		area.queue_free()
