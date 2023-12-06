extends Control

### SCENE PATHS
const questions_game_scene_path: String = "res://scenes/questions.tscn"
const add_questions_scene_path: String = "res://scenes/questions.tscn"

### OTHER
var background: ColorRect
var scene_changer: SceneChanger


### INIT
func _ready():
	background = $BackgroundColor
	scene_changer = SceneChanger.new()
	
	
### EVENTS
func _on_start_button_down():
	call_change_scene(questions_game_scene_path)


func _on_add_button_down():
	call_change_scene(add_questions_scene_path)


### HELPERS
func call_change_scene(path: String) -> void:
	scene_changer.change_scene(path, get_tree())
