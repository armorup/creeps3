extends KinematicBody

signal squashed

export var min_speed = 10
export var max_speed = 18

var velocity = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	# warning-ignore:return_value_discarded
	move_and_slide(velocity)


func _on_VisibilityNotifier_screen_exited():
	queue_free()


func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(rand_range(-PI/4, PI/4))
	var random_speed = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	$AnimationPlayer.playback_speed = random_speed / min_speed


func squash():
	velocity = Vector3.ZERO
	emit_signal("squashed")
	queue_free()