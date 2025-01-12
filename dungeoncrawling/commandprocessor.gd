extends Node
var response=preload("res://response.tscn")
@onready var result= $"../PanelContainer/MarginContainer/VBoxContainer/Output/ScrollContainer/result"
var start=false
var travel=false
@onready var room1=$roomhandler/room1
@onready var room2=$roomhandler/room2
@onready var room3=$roomhandler/room3
@onready var room4=$roomhandler/room4
@onready var room5=$roomhandler/room5
@onready var room6=$roomhandler/room6
@onready var room7=$roomhandler/room7
@onready var room8=$roomhandler/room8
@onready var room9=$roomhandler/room9
@onready var playerpos=$roomhandler/Sprite2D

var currentroom :Node2D
var can_go_right = false
var targetroomright :Node2D 
var can_go_left=false
var targetroomleft :Node2D 
var can_go_up = false
var targetroomup :Node2D 
var can_go_down=false
var targetroomdown :Node2D 



#enemytextures
var enemy_textures: Array = [
	"res://image/icon.svg",
	"res://image/x2af_jbuThWxC_cQ6l8rsQ.webp"
]
#handle battle#
@onready var enemy=$"../PanelContainer/MarginContainer/VBoxContainer/imagecontainer/HBoxContainer/enemy/enemy"
var battlestate = false
signal attacknormal
signal  attacknew
signal enemyturn
var newsword =false
var guard=false
#flag for enemies
signal wolfbattle
signal slimebattle
signal demonkingfight
var wolfdefeat =false
var slimedefeat =false
# pick handle
var pickable=false
@onready var orb= $"../PanelContainer/MarginContainer/VBoxContainer/imagecontainer/HBoxContainer/player/HBoxContainer/key"
@onready var sword= $"../PanelContainer/MarginContainer/VBoxContainer/imagecontainer/HBoxContainer/player/HBoxContainer/sword"
var orbget =false

func _ready() -> void:
	currentroom=room1


func _physics_process(delta: float) -> void:
	if orbget :
		orb.visible=true








func  process(input:String) :
	if battlestate :
		print("battlestart")
		return battlestart(input)
	if start == false :
		match input :
			"start" :
				start=true
				return "please enjoy the game"
			_:
				return "please start the game"
	if travel :
		match input :
			"right" :
				if can_go_right:
					travel=false
					playerpos.global_position=targetroomright.global_position
					currentroom=targetroomright
					print(currentroom)
					can_go_right=false
					roomcheck()
					return "You go right."
				else:
					travel=false
					return "You cannot go right."
			"left" :
				if can_go_left:
					travel=false
					playerpos.global_position=targetroomleft.global_position
					currentroom=targetroomleft
					can_go_left=false
					roomcheck()
					return "You go left."
				else:
					travel=false
					return "You cannot go left."
			"up" :
				if can_go_up:
					travel=false
					playerpos.global_position=targetroomup.global_position
					currentroom=targetroomup
					print(currentroom)
					can_go_right=false
					roomcheck()
					return "You go up."
				else:
					travel=false
					return "You cannot go up."
			"down" :
				if can_go_down:
					travel=false
					playerpos.global_position=targetroomdown.global_position
					currentroom=targetroomdown
					can_go_left=false
					roomcheck()
					return "You go down."
				else:
					travel=false
					return "You cannot go down."
			_:
				travel=false
				return "doesnt recognized direction"
	else :
		match input :
			"start" :
				return "you already start the game"
			"help" :
				return help(input)
			"go" :
				travel=true
				return "go where"
			"pick" :
				return pickitem(input)
			"inventory" :
				return checkinventory(input)


func help(input:String) :
	return "this is the available command under normal state :
			go and then after the game ask you to go where the option is: up,down,left,right#
			pick : pick up stuff up
			inventory ;to check inventory"

func pickitem(input:String) :
	if currentroom==room4 :
		if orbget :
			return "the orb in the pedestal is no more , the surrounding demonic miasma grows stronger
					theres nothing left to do here"
		else :
			orbget = true
			pickable=false
			return "youve picked the orb and store it inside your inventory"
	else :
		return "theres nothing to pick on"

func checkinventory(input:String) :
	return "check Inventory"


#Handle movement possibility 
func _on_right_body_entered(body: Node2D) -> void:
	targetroomright=body
	can_go_right=true


func _on_left_body_entered(body: Node2D) -> void:
	targetroomleft=body
	can_go_left=true


func _on_down_body_entered(body: Node2D) -> void:
	targetroomdown=body
	can_go_down=true


func _on_up_body_entered(body: Node2D) -> void:
	targetroomup=body
	can_go_up=true
#handle extra room description output

func roomcheck() :
	var roomdescription=response.instantiate()
	if currentroom == room1:
		roomdescription.text="o hero help the kingdom, the demon king has risen back again
								to defeat the demon king you need to take the holy sword 
								it is located near the fountain of youth."
	elif currentroom == room2 :
		if wolfdefeat :
			roomdescription.text="the wolf here has beeen defeated , the miasma of the demon king has subsided"
		else :
			battlestate =true
			emit_signal("wolfbattle")
			enemy.texture=load(enemy_textures[1])
			roomdescription.text="the quiet atmosphere of the demonic forrest seeeps eerily , 
			suddenly an wolf attack you out of nowhere"
	elif currentroom == room3:
		if slimedefeat :
			roomdescription.text="the slime here has been defeated , yet the miasma remain"
		else :
				roomdescription.text="the  beautiful lake that usually shines clear , now tainted by miasma
								its now errily creepy , as you walk nearer slime suddenly attacks you!"
				battlestate =true
				emit_signal("slimebattle")
				enemy.texture=load(enemy_textures[0])
	elif currentroom == room4 :
		roomdescription.text="there is a small white pedestal in front of you ,
								the demonic miasma seems to be repelled and you dont feel any demonic presence nearby
								inside the pedestal , theres an orb that exude holy energy
								pick it up?"
		pickable=true
	elif currentroom == room5:
		roomdescription.text="this is room 5"
	elif currentroom == room6 :
		roomdescription.text="this is room 6"
	if currentroom == room7:
		roomdescription.text="this is room 7"
	elif currentroom == room8 :
		roomdescription.text="this is room 8"
	elif  currentroom == room9 :
		roomdescription.text="this is room 9"
	result.add_child(roomdescription)

func battlestart(input:String) :
	match input :
		"attack" :
			if newsword :
				emit_signal("attacknew")
				return "you attack with the holy sword"
			else :
				emit_signal("attacknormal")
				return "you attack!!"
		"guard" :
			guard=true
			emit_signal("enemyturn")
			return "you guarded"
		"help" :
			return helpbattle(input)
		_:
			return "thats not what you do in battle"



func helpbattle(input:String) :
	return "you can only give command 
			attack : to attack 
			guard : to defend and reduce incoming damage by 50%
			you cant run , you are hero , a hero dont run!!!"


func _on_wolf_enemyvanquished() -> void:
	battlestate=false
	var victoryprint=response.instantiate()
	victoryprint.text="you have defeated the enemy you may now procceed"
	result.add_child(victoryprint)
	enemy.texture=null


func _on_slime_enemyvanquished() -> void:
	battlestate=false
	var victoryprint=response.instantiate()
	victoryprint.text="you have defeated the enemy you may now procceed"
	result.add_child(victoryprint)
	enemy.texture=null
