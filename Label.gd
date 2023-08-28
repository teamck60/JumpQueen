extends Label

var timePassed = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timePassed = timePassed + delta;
	
	#position.y = get_tree().get_nodes_in_group("Player")[0].get_node("Camera2D2").global_position.y - 500;
	
	global_position.x = -149;
	
	text = str(int(timePassed))
