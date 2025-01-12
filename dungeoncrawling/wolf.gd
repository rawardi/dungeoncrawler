extends CharacterBody2D



var health=20
signal attackback
signal enemyvanquished
var response=preload("res://response.tscn")
@onready var result= $"../../PanelContainer/MarginContainer/VBoxContainer/Output/ScrollContainer/result"


func attack() :
	var enemyattack=response.instantiate()
	emit_signal("attackback")
	enemyattack.text="enemy attack!!"
	result.add_child(enemyattack)

func takedamge() :
	health=health-5
	print ("enemy health :")
	print(health)
	die()
func _on_commandprocessor_attacknormal() -> void:
	takedamge()
	attack()

func _on_commandprocessor_enemyturn() -> void:
	attack()


func die():
	if health <=0:
		var enemyattack=response.instantiate()
		emit_signal("enemyvanquished")
		enemyattack.text="enemy is defeated the hero has triumph"
		result.add_child(enemyattack)
