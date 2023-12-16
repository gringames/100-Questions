class_name QuestionInitializer

var question_file_handler: QuestionFileHandler
var initial_question_txt_path: String = "res://data/initial_questions.txt"
var print_question_array: bool = true

func _ready():
	question_file_handler = QuestionFileHandler.new()
		

func fill_array_from_file() -> Array:
	var array: Array
	var user_path: String = question_file_handler.question_file_path
	
	if user_file_does_not_exist(user_path):
		copy_initial_questions_to(user_path)
		# important otherwise next question will be inserted in same line 
		append_newline() 
	
	return convert_to_array(user_path)
		
		
func user_file_does_not_exist(user_file_path: String) -> bool:
	return not FileAccess.file_exists(user_file_path)


func copy_initial_questions_to(user_file_path: String) -> void:
	# creates user file
	var dir = DirAccess.open("res://")
	dir.copy(initial_question_txt_path, user_file_path)
	handle_error(dir.get_open_error())
	

func handle_error(error) -> void:
	if error != OK:
		print("An error occurred while copying the file: " + error)
		

func append_newline() -> void:
	# handler will add a newline after the line that is passed, so empty string suffices
	question_file_handler.append("", true)


func convert_to_array(user_path: String) -> Array:
	var array: Array

	var questions_file = FileAccess.open(user_path, FileAccess.READ)
	while not questions_file.eof_reached():
		var line: String = questions_file.get_line()
	
		if line.begins_with("#") or line.is_empty():
			continue
	
		array.append(str(line))
		
	return array
