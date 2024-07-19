extends Area3D

var root = null

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area is Enemy:
		area.queue_free()
		root.update_lives()
