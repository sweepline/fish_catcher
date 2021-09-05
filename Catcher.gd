extends Area


export (float, 0.001, 0.1) var mouse_sensitivity: float = 0.001
const SPAWN_MAX_X = 2.0
const KEY_VEL = 6.0
const VEL = 2.0
var target_x = 0.0


func _input(event):
	if event is InputEventMouseMotion:
		target_x += event.relative.x * mouse_sensitivity
		target_x = clamp(target_x, -SPAWN_MAX_X, SPAWN_MAX_X)

func _physics_process(delta):
	var movement_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	target_x += movement_input * KEY_VEL * delta
	target_x = clamp(target_x, -SPAWN_MAX_X, SPAWN_MAX_X)
	translation.x = target_x


func _on_Catcher_area_entered(area):
	if area.has_method("caught"):
		area.caught()
