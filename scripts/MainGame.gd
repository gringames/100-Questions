extends Control

@export_category("End")
@export var scene_to_go_to: String = "res://scenes/MainMenu.tscn"
@export var time_to_wait_until_returning_to_main_menu: float = 2
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

### QUESTIONS
var question_file_handler: QuestionFileHandler

### END
var scene_changer: SceneChanger



### SETUP
func _ready():
	question_label = $QuestionBox/QuestionLabel
	background_color = $BackgroundColor
	number_of_colors = colors.size()
	scene_changer = SceneChanger.new()
	question_file_handler = QuestionFileHandler.new()
	questions = question_file_handler.fill_array_from_file()
	number_of_questions = questions.size()
	
	next_question()



### INPUT
func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		next_question()



### UPDATE
func next_question() -> void:
	next_text()
	next_background_color()	


func next_text() -> void:
	if question_index >= number_of_questions:
		set_listening_for_input(false)
		display_end_screen()
		wait_and_return_to_main_menu(time_to_wait_until_returning_to_main_menu)
		# needed otherwise rest of method will be executed
		return
		
	question_label.text = questions[question_index]
	question_index += 1


func next_background_color() -> void:
	background_color.color = colors[get_random_color_index()]


func get_random_color_index() -> int:
	# randi_range's param "to" is inclusive
	var random_index: int = randi_range(0, number_of_colors - 1)
	
	# ensure different color
	if random_index == last_color_index:
		random_index = (random_index + 1) % number_of_colors
	
	return random_index



### QUIT
func display_end_screen() -> void:
	question_label.text = end_text
	background_color.color = end_color
	

func set_listening_for_input(do_listen: bool) -> void:
	set_process_input(do_listen)


func wait_and_return_to_main_menu(seconds_to_wait: float) -> void:
	# creates a single use timer and waits for it to timeout
	await get_tree().create_timer(seconds_to_wait).timeout

	set_listening_for_input(true)
	_on_back_to_main_menu_button_down()	


func _on_back_to_main_menu_button_down():
	scene_changer.change_scene(scene_to_go_to, get_tree())
