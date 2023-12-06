extends Node
class_name SceneChanger

func change_scene(scene_path: String, tree) -> void:
	tree.change_scene_to_file(scene_path)
