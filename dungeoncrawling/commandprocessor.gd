extends Node


var start=false
var travel=false

func  process(input:String) :
	if start == false :
		match input :
			"start" :
				start=true
				return "please enjoy the game"
			_:
				return "please start the game"
	else :
		match input :
			"help" :
				return help(input)
			"go" :
				return "go where"
				travel=true
			"pick" :
				return pickitem(input)
			"inventory" :
				return checkinventory(input)




func help(input:String) :
	return "this is the available command under normal state :
			go and then after the game ask you to go where the option is: up,down,left,right#
			pick : pick up stuff up
			inventory ;to check inventory"

func go(input:String) :
	return "this go function worked"

func pickitem(input:String) :
	return "pick fucntion worked"

func checkinventory(input:String) :
	return "check Inventory"
