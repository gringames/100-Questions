extends Control

@export_category("End")
@export var end_text: String = "no more questions :("
@export var end_color: Color = Color.BLACK


@export_category("Questions")
@export var questions: Array

@export_category("Colors")
@export var colors: Array = [
	Color.RED, # make less poppy
	Color.LAWN_GREEN,
	Color.YELLOW, # maybe a bit too bright
	Color.DODGER_BLUE,
	Color.HOT_PINK, 
	Color.MEDIUM_PURPLE,
	Color.ORANGE
]


### COLOR
var background_color: ColorRect
var number_of_colors: int
var last_color_index: int = -1

### TEXT
var question_label: Label
var number_of_questions: int
var question_index: int = 0


func _ready():
	background_color = $BackgroundColor
	number_of_colors = colors.size()
	
	question_label = $QuestionBox/QuestionLabel
	number_of_questions = questions.size()
	
	next_question()


func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		next_question()



func next_question() -> void:
	next_text()
	next_background_color()	


func next_text() -> void:
	if question_index == number_of_questions:
		stop_listening_for_input()
		display_end_screen()
		return
		
	question_label.text = questions[question_index]
	question_index += 1


func display_end_screen() -> void:
	question_label.text = end_text
	background_color.color = end_color
	

func stop_listening_for_input() -> void:
	set_process_input(false)


func next_background_color() -> void:
	background_color.color = colors[get_random_color_index()]


func get_random_color_index() -> int:
	# randi_range param "to" is inclusive
	var random_index: int = randi_range(0, number_of_colors - 1)
	
	# ensure different color
	if random_index == last_color_index:
		random_index = (random_index + 1) % number_of_colors
	
	return random_index
	
