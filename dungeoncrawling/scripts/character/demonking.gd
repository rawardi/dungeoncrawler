extends Node



var battlewithdemonking=false
var health=200
signal attackback
signal enemyvanquished
var response=preload("res://response.tscn")
@onready var result= $"../../PanelContainer/MarginContainer/VBoxContainer/Output/ScrollContainer/result"



func attack() :
	var enemyattack=response.instantiate()
	emit_signal("attackback")
	enemyattack.text="the demon king overwhelming power strikes at you!!"
	result.add_child(enemyattack)

func takedamge() :
	health=health-10
	print ("enemy health :")
	print(health)
	die()
func _on_commandprocessor_attacknormal() -> void:
	if battlewithdemonking :
		var quips=response.instantiate()
		var taunt =randi_range(0,1)
		if taunt== 0 :
			quips.text="what weakling , you dissapoint me hero"
		if taunt == 1 :
			quips.text="is this the hope of humanity? what a letdown"
		response.add_children(quips)
		takedamge()
		attack()

func _on_commandprocessor_enemyturn() -> void:
	if battlewithdemonking :
		attack()


func die():
	if health <=0:
		var enemyattack=response.instantiate()
		emit_signal("enemyvanquished")
		enemyattack.text="enemy is defeated the hero has triumph"
		result.add_child(enemyattack)
		battlewithdemonking=false



func _on_commandprocessor_bombthrown() -> void:
	if battlewithdemonking :
		var quips=response.instantiate()
		health=health-100
		quips.text="what kind of coward are you!!"
		result.add_child(quips)


func _on_commandprocessor_attacknew() -> void:
	var firstimeattackedbyholysword=true
	var quips=response.instantiate()
	if firstimeattackedbyholysword :
		quips.text="what the? is that the holy sword? not bad hero"
		result.add_child(quips)
		health=health-80
		firstimeattackedbyholysword=false
		die()
	else :
		health=health-40
		die()

func _on_commandprocessor_demonkingfight() -> void:
	battlewithdemonking=true 

func _physics_process(delta: float) -> void:
	if health <= 0:
		get_tree().change_scene_to_file("res://scene/ends/normalend.tscn")
