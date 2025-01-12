extends Control

const InputResponse = preload("res://outputhandler.tscn")
const respondlabel=preload("res://response.tscn")
signal image_change
signal gamestart
var start=true
@onready var result=$PanelContainer/MarginContainer/VBoxContainer/Output/ScrollContainer/result
@onready var playerinput= $PanelContainer/MarginContainer/VBoxContainer/input/LineEdit
@onready var commandprocessor=$commandprocessor
func _ready() -> void:
	var starting_message=respondlabel.instantiate()
	starting_message.text=("Type \"start\" to start the game
							o hero help the kingdom, the demon king has risen back again
								to defeat the demon king you need to take the holy sword 
								it is located near the fountain of youth.
								
			this is the available command under normal state :
			go and then after the game ask you to go where the option is: up,down,left,right#
			pick : pick up stuff up
			inventory ;to check inventory
			the game only can recieve one word command so please dont use space in between or something as it crash it")
	write_game_response(starting_message)


func _on_line_edit_text_submitted(new_text: String) -> void:
	clearinputoutput()
	#Adding and showing what the Player input 
	var input_response=InputResponse.instantiate()
	var response=commandprocessor.process(new_text)
	input_response.set_text(new_text,response)
	write_game_response(input_response)
	if start  :
		emit_signal("gamestart")
		start=false
func write_game_response(response):  
	result.add_child(response)







func clearinputoutput():
	var maxline=0
	# Clear previous input response with cap of 20
	for child in result.get_children():
		maxline+=1
		playerinput.text=""
	if maxline >=20 :
		var first_child=result.get_child(0)
		first_child.queue_free()
