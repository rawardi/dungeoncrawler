extends Node


var start=false
var travel=false
@onready var room1=$roomhandler/room1
@onready var room2=$roomhandler/room2
@onready var room3=$roomhandler/room3
@onready var playerpos=$roomhandler/Sprite2D
var can_go_right = false
var currentroomright :Node2D
var targetroomright :Node2D 
var can_go_left=false
@onready var currentroomleft=$roomhandler/room1
var targetroomleft :Node2D 
func _ready() -> void:
	currentroomleft =room1
	currentroomright=room1
func  process(input:String) :
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
					currentroomright=targetroomright
					print(currentroomright)
					can_go_right=false
					return "You go right."
				else:
					travel=false
					return "You cannot go right."
			"left" :
				if can_go_left:
					travel=false
					playerpos.global_position=targetroomleft.global_position
					currentroomleft=targetroomleft
					can_go_left=false
					return "You go left."
				else:
					travel=false
					return "You cannot go left."
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
	return "pick fucntion worked"

func checkinventory(input:String) :
	return "check Inventory"


func _on_right_body_entered(body: Node2D) -> void:
	targetroomright=body
	print(currentroomright)
	can_go_right=true


func _on_left_body_entered(body: Node2D) -> void:
	targetroomleft=body
	can_go_left=true
