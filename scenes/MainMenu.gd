extends Control

@export var questions_scene: PackedScene
var background: ColorRect
var scene_changer: SceneChanger

func _ready():
	background = $BackgroundColor
	scene_changer = SceneChanger.new()
	

func _on_start_button_down():
	scene_changer.change_scene(questions_scene)


func _on_add_button_down():
	# TODO: show question enter panel
	pass # Replace with function body.
