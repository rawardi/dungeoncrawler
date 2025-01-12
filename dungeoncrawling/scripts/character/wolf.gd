extends CharacterBody2D


var battlewithwolf=false
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
	if battlewithwolf :
		takedamge()
		attack()

func _on_commandprocessor_enemyturn() -> void:
	if battlewithwolf :
		attack()


func die():
	if health <=0:
		var enemyattack=response.instantiate()
		emit_signal("enemyvanquished")
		enemyattack.text="enemy is defeated the hero has triumph"
		result.add_child(enemyattack)
		battlewithwolf=false


func _on_commandprocessor_wolfbattle() -> void:
	battlewithwolf=true


func _on_commandprocessor_bombthrown() -> void:
	if battlewithwolf :
		health=0
		die()


func _on_commandprocessor_attacknew() -> void:
	if battlewithwolf :
		health =0
		die()
		attack()
