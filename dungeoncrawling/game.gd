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
	starting_message.text=("Type anything to start the game")
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
	# Clear previous input response
	for child in result.get_children():
		child.queue_free()
		playerinput.text=""
