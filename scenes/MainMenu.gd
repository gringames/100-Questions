extends Control

const questions_scene_path: String = "res://scenes/questions.tscn"
var background: ColorRect
var scene_changer: SceneChanger

func _ready():
	background = $BackgroundColor
	scene_changer = SceneChanger.new()
	

func _on_start_button_down():
	scene_changer.change_scene(questions_scene_path, get_tree())


func _on_add_button_down():
	# TODO: show question enter panel
	pass # Replace with function body.
