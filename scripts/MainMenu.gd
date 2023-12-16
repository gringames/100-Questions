extends Control

### SCENE PATHS
const questions_game_scene_path: String = "res://scenes/MainGame.tscn"
const add_questions_scene_path: String = "res://scenes/AddQuestions.tscn"

### OTHER
var background: ColorRect
var scene_changer: SceneChanger
var question_file_handler: QuestionFileHandler


### INIT
func _ready():
	background = $BackgroundColor	
	scene_changer = SceneChanger.new()
	question_file_handler = QuestionFileHandler.new()
	create_user_file_if_necessary()
	

func create_user_file_if_necessary() -> void:
	if question_file_handler.user_file_does_not_exist():
		question_file_handler.copy_initial_questions_to_user_file()



### BUTTON METHODS
func _on_start_button_down():
	call_change_scene(questions_game_scene_path)


func _on_add_button_down():
	call_change_scene(add_questions_scene_path)


func call_change_scene(path: String) -> void:
	scene_changer.change_scene(path, get_tree())
