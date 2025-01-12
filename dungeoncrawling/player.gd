extends CharacterBody2D

var health=100




func _on_wolf_attackback() -> void:
	health=health-20


func _physics_process(delta: float) -> void:
	if health <= 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
