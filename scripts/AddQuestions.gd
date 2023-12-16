extends Control

### NODE REFERENCES
var textbox: TextEdit

### SCENE CHANGER
const menu_scene_path: String = "res://scenes/MainMenu.tscn"
var scene_changer: SceneChanger

### FILE
var question_file_handler: QuestionFileHandler


### INIT
func _ready():
	textbox = $VBoxContainer/TextEdit
	scene_changer = SceneChanger.new()
	question_file_handler = QuestionFileHandler.new()


### BUTTON METHODS

func _on_back_button_down():
	scene_changer.change_scene(menu_scene_path, get_tree())
	
	
func _on_submit_button_down():
	var question_text: String = textbox.text
	
	# avoid adding empty lines
	if question_text.is_empty():
		return
	
	add_question_to_file(question_text)
	clear_text()

	
### HELPERS

func add_question_to_file(question: String) -> void:
	question_file_handler.append(question, true)


func clear_text() -> void:
	textbox.text = ""

