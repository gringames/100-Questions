extends Node
class_name QuestionFileHandler

### PATHS
const question_file_user_path: String = "user://questions.txt"
const initial_question_txt_path: String = "res://data/initial_questions.txt"


### EXISTENCE CHECK
func user_file_does_not_exist() -> bool:
	return not FileAccess.file_exists(question_file_user_path)



### COPY
func copy_initial_questions_to_user_file() -> void:
	# creates user file
	var dir = DirAccess.open("res://")
	dir.copy(initial_question_txt_path, question_file_user_path)
	handle_error(dir.get_open_error())
	# important otherwise next question will be inserted in same line 	
	append("", true) 	
	

func handle_error(error) -> void:
	if error != OK:
		print("An error occurred while copying the file: " + error)



### FILE MODIFICATION
func append(line: String, print_file: bool) -> void:
	# important to open it in read_write! write_read will override the contents
	var question_file = FileAccess.open(question_file_user_path, FileAccess.READ_WRITE)
	
	question_file.seek_end()
	question_file.store_line(line)
	question_file.seek(0)
	
	if print_file:
		print("-----------------------------------------------------")
		while not question_file.eof_reached():
			print(question_file.get_line())
		print("-----------------------------------------------------")
		
	question_file.close()



### ARRAY CONVERSION
func fill_array_from_file() -> Array:
	var array: Array
	
	if user_file_does_not_exist():
		push_error("user file does not exist!")
	
	return convert_to_array()
		


func convert_to_array() -> Array:
	var array: Array
	var questions_file = FileAccess.open(question_file_user_path, FileAccess.READ)
	
	while not questions_file.eof_reached():
		var line: String = questions_file.get_line()
		
		if is_comment(line):
			continue
		
		array.append(str(line))
		
	return array


func is_comment(line: String) -> bool:
	return line.begins_with("#") or line.is_empty()
