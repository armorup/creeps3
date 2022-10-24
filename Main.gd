extends Node

export (PackedScene) var mob_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Music.play()
	$UserInterface/Retry.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	mob.initialize(mob_spawn_location.translation, player_position)
	add_child(mob)
	mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")


func _on_Player_hit():
	$MobTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$UserInterface/Retry.show()


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.is_visible():
		$Music.play()
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

