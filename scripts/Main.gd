extends Control

var background_color: ColorRect

var colors: Array = [
	Color.RED, # make less poppy
	Color.LAWN_GREEN,
	Color.YELLOW, # maybe a bit too bright
	Color.DODGER_BLUE,
	Color.HOT_PINK, 
	Color.MEDIUM_PURPLE,
	Color.ORANGE
]

var number_of_colors: int
var last_index: int = -1


func _ready():
	background_color = $BackgroundColor
	number_of_colors = colors.size()
	
	next_question()



func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		next_question()



func next_question() -> void:
	print("NEXT QUESTION")
	next_text()
	next_background_color()	

func next_text() -> void:
	pass


func next_background_color() -> void:
	background_color.color = colors[get_random_index()]


func get_random_index() -> int:
	# randi_range param "to" is inclusive
	var random_index: int = randi_range(0, number_of_colors - 1)
	
	# ensure different color
	if random_index == last_index:
		random_index = (random_index + 1) % number_of_colors
	
	return random_index
	
