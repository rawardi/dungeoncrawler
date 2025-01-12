extends Node


var battlewithslime=false
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
	health=health-10
	print ("enemy health :")
	print(health)
	die()
func _on_commandprocessor_attacknormal() -> void:
	if battlewithslime :
		takedamge()
		attack()

func _on_commandprocessor_enemyturn() -> void:
	if battlewithslime :
		attack()


func die():
	if health <=0:
		var enemyattack=response.instantiate()
		emit_signal("enemyvanquished")
		enemyattack.text="enemy is defeated the hero has triumph"
		result.add_child(enemyattack)
		battlewithslime=false


func _on_commandprocessor_slimebattle() -> void:
	battlewithslime=true
	print("battlewithslime true")


func _on_commandprocessor_bombthrown() -> void:
	if battlewithslime :
		health=0
