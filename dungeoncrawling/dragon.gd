extends Node
var battlewithdragon=false
var health=200
signal attackback
signal enemyvanquished
var response=preload("res://response.tscn")
var dragonsuprise = true
@onready var result= $"../../PanelContainer/MarginContainer/VBoxContainer/Output/ScrollContainer/result"


func attack() :
	var enemyattack=response.instantiate()
	emit_signal("attackback")
	if dragonsuprise :
		enemyattack.text="the dragon is suprised  he seem to take more damage but now hes angry!!"
	else :
		enemyattack.text= " the dragon attack ferociously as hes been angered"
	result.add_child(enemyattack)

func takedamge() :
	if dragonsuprise :
		health=health-20
		print ("enemy health :")
		print(health)
		die()
	else :
		health=health-10
		print ("enemy health :")
		print(health)
		die()
func _on_commandprocessor_attacknormal() -> void:
	if battlewithdragon :
		takedamge()
		attack()

func _on_commandprocessor_enemyturn() -> void:
	if battlewithdragon:
		attack()


func die():
	if health <=0:
		var enemyattack=response.instantiate()
		emit_signal("enemyvanquished")
		enemyattack.text="enemy is defeated the hero has triumphed against the dragon, now he can take the holy sword"
		result.add_child(enemyattack)
		battlewithdragon=false


func _on_commandprocessor_dragonbattle() -> void:
	battlewithdragon=true
	print("battlewithdragon true")


func _on_commandprocessor_bombthrown() -> void:
	if battlewithdragon:
		if dragonsuprise :
			health=0
			die()
		else :
			health=100
			die()
