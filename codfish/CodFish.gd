extends Area

var colors = {
	"gold": preload("res://codfish/codbodygold.tres"),
	"blue": preload("res://codfish/codbodyblue.tres"),
	"purple": preload("res://codfish/codbodypurple.tres"),
	"green": preload("res://codfish/codbodygreen.tres"),
	}

export var speed: float = 1.0
export var started = false

func _ready():
	$AnimationPlayer.playback_speed = speed * 0.5

func set_color(color):
	$Armature/Skeleton/body.material_override = colors[color]

func start(_speed, location):
	global_transform.origin = location
	speed = _speed
	$AnimationPlayer.playback_speed = speed * 0.5
	started = true
	
func _physics_process(delta):
	if ! started:
		return
	translation.z += speed * delta
	
func caught():
	print(name, " got caught.")
	var time = 0.1
	$Tween.interpolate_property(self,
		"scale",
		scale,
		Vector3.ZERO,
		time,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN
	)
	$Timer.wait_time = time
	$Timer.connect("timeout", self, "queue_free")
	
	$Tween.start()
	$Timer.start()
