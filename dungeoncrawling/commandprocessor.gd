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
@onready var room10=$roomhandler/room10
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
signal bombthrown
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
var dragondefeat = false
# pick handle
var bomb = false
var pickable=false
@onready var orb= $"../PanelContainer/MarginContainer/VBoxContainer/imagecontainer/HBoxContainer/player/HBoxContainer/key"
@onready var sword= $"../PanelContainer/MarginContainer/VBoxContainer/imagecontainer/HBoxContainer/player/HBoxContainer/sword"
var orbget =false
var holyswordget=false
#handle rest
var restarea=false
signal rested

#handle dialouge
var dialogactive =false
#handle demon king room
var demonkingmiasma=true

func _ready() -> void:
	currentroom=room1


func _physics_process(delta: float) -> void:
	if orbget :
		orb.visible=true








func  process(input:String) :
	if currentroom == room10 :
		match  input :
			"accept" :
				get_tree()
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
			"east" :
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
			"west" :
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
			"north" :
				if can_go_up:
					if targetroomup==room10 :
						if demonkingmiasma :
							return "the miasma is too strong , you will die , maybe an artifact of the goddess can help reduce it"
						else :
							return "you walk bravely into the demon king castle for the final showdown"
					else :
						travel=false
						playerpos.global_position=targetroomup.global_position
						currentroom=targetroomup
						print(currentroom)
						can_go_right=false
						roomcheck()
						return "You go north."
				else:
					travel=false
					return "You cannot go up."
			"south" :
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
			"rest" :
				return rest(input) 
			"chat" :
				return dialog(input)
			"orb" :
				if orb :
					if currentroom==room8 :
						demonkingmiasma=false
						return "the orb shines brightly  it slowly erode the demon king miasma, it is now possible to go into the castle"
					else :
						return "the orb doesnt do anything"
				else :
					return "what is an orb?"
			_:
				return "unrecognized command"


func help(input:String) :
	return "this is the available command under normal state :
			go :and then after the game ask you to go where the option is: north , south , west , east
			pick : pick up stuff up
			inventory ;to check inventory
			orb : artifact of goddes that help will help you find it "

func pickitem(input:String) :
	if currentroom==room4 :
		if orbget :
			return "the orb in the pedestal is no more , the surrounding demonic miasma grows stronger
					theres nothing left to do here"
		else :
			orbget = true
			pickable=false
			return "youve picked the orb and store it inside your inventory"
	if currentroom==room7 :
		if dragondefeat : 
			holyswordget=true
			pickable=false
			return "youve taken the holy sword , now you are much more stronger , this may be enough to defeat the demon king"
	else :
		return "theres nothing to pick on"

func checkinventory(input:String) :
	return "check Inventory"
#rest func
func rest(input : String) :
	if restarea :
		emit_signal("rested")
		restarea=false
		return "you have rested, and recovered to full strength"
	else :
		return "this isnt a place to rest"

#func chat 
var firstmeetdwarve=true 
func dialog(input : String) :
	if dialogactive==true  and currentroom == room6 :
		if firstmeetdwarve :
			firstmeetdwarve=false
			bomb=true
			return "hear ye lad , the dragon has been corrupted by the demon lord!!! 
			it no longer recognize its job to wait for the hero rather it is now want to kill it whomever want to be the owner of it
			this old bone cant help you anymore but if anything i can give you this bomb to help kill it"
		else :
			return "what are you dilly dallying about go kill that dragon and take the sword to save the world!!"



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

signal dragonbattle
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
		roomdescription.text="there is clear pond radiating with holy energy , this seems a goodplace to rest?"
		restarea=true
	elif currentroom == room6 :
		roomdescription.text="theres an old dwarve nearby , he seems a bit disgrunted maybe you can chat with him?"
		dialogactive=true
	if currentroom == room7:
		if dragondefeat :
			roomdescription.text="the body of the giant dragon is slain , although the dragon is corrupted it still exude holy energy"
		else :
			roomdescription.text="as you get near the location of the holy sword you see a giant dragon sleeping
								the dragon is still currently asleep you can suprise it "
			battlestate =true
			emit_signal("dragonbattle")
	elif currentroom == room8 :
		roomdescription.text="the castle of the demon king stands before you, the ominous aura makes it hard to even stand near it"
	elif  currentroom == room9 :
		roomdescription.text="this is room 9"
	elif currentroom == room10 :
		roomdescription.text="stand before now is the demon king itself, you ready your sword.
								the demon king open her mouth 
								would you share the half of the world with me?
								confused  you ask what does she mean
								she smirks 
								exactly what i mean
								do you accept my offer?"
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
		"bomb" :
			if bomb :
				emit_signal("bombthrown")
				bomb=false
				return "you thrown the bomb"
			else :
				return "you dont have any bomb"
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
	wolfdefeat =true


func _on_slime_enemyvanquished() -> void:
	battlestate=false
	var victoryprint=response.instantiate()
	victoryprint.text="you have defeated the enemy you may now procceed"
	result.add_child(victoryprint)
	enemy.texture=null
	slimedefeat=true


func _on_dragon_enemyvanquished() -> void:
	battlestate=false
	var victoryprint=response.instantiate()
	victoryprint.text="you  have courageously or trickfully defeated the dragon the holy sword is now yours to take"
	result.add_child(victoryprint)
	enemy.texture=null
	dragondefeat=true
	pickable=true
