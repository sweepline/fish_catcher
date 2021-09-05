extends Spatial


const SPAWN_MAX_X = 2.0
const SPAWN_VEC = Vector3(0, 4.9, -25)

const codfish_factory = preload("res://codfish/CodFish.tscn")

var time = 0.0
export (int, 0, 100) var difficulty: float = 10

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	time += delta

func spawn_codfish():
	var loc = SPAWN_MAX_X * ((sin(time) + sin(time / 0.9)) / 2)
	instance_codfish(10, loc)

func get_spawn(x):
	var vec = SPAWN_VEC
	vec.x = x
	return vec

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$SpawnTimer.connect("timeout", self, "spawn_codfish")
	$SpawnTimer.wait_time = 0.4
	$SpawnTimer.start()

func instance_codfish(speed, location, color = "green"):
	var codfish = codfish_factory.instance()
	codfish.rotation.y = PI
	add_child(codfish)
	codfish.set_color(color)
	codfish.start(10, get_spawn(location))
	
func _on_DespawnArea_area_entered(area):
	area.queue_free()
