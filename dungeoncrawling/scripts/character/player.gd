extends CharacterBody2D

@export var health=100



func _on_wolf_attackback() -> void:
	health=health-20


func _on_slime_attackback() -> void:
	health=health-10

func _physics_process(delta: float) -> void:
	if health <= 0:
		get_tree().change_scene_to_file("res://scene/ends/gameover.tscn")


func _on_commandprocessor_rested() -> void:
	health=100


func _on_dragon_attackback() -> void:
	health=health-40


func _on_demonking_attackback() -> void:
	health=health-40
