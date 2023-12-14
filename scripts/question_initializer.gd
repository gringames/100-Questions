class_name QuestionInitializer

var question_file: QuestionFile
var initial_question_txt_path: String = "res://data/initial_questions.txt"
var print_question_array: bool = true

func _ready():
	question_file = QuestionFile.new()
		

func fill_array_from_file() -> Array:
	var array: Array
	var user_path: String = question_file.question_file_path
	
	if user_file_does_not_exist():
		copy_initial_questions_to(user_path)
	
	return convert_to_array(user_path)
		
		
func user_file_does_not_exist() -> bool:
	var user_file_path: String = question_file.question_file_path
	return not FileAccess.file_exists(user_file_path)


func copy_initial_questions_to(user_file_path: String) -> void:
	# creates user file
	var dir = DirAccess.open("res://")
	dir.copy(initial_question_txt_path, user_file_path)
	var error = dir.get_open_error()
	if error != OK:
		print("An error occurred while copying the file: " + error)


func convert_to_array(user_path: String) -> Array:
	var array: Array

	var questions_file = FileAccess.open(user_path, FileAccess.READ)
	while not questions_file.eof_reached():
		var line: String = questions_file.get_line()
	
		if line.begins_with("#") or line.is_empty():
			continue
	
		array.append(str(line))
		
	return array
