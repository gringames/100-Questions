extends Node
class_name QuestionFileHandler

const question_file_path: String = "user://questions.txt"
	
	
func append(line: String, print_file: bool) -> void:
	# important to open it in read_write! write_read will override the contents
	var question_file = FileAccess.open(question_file_path, FileAccess.READ_WRITE)
	
	question_file.seek_end()
	question_file.store_line(line)
	question_file.seek(0)
	
	if print_file:
		print("-----------------------------------------------------")
		while not question_file.eof_reached():
			print(question_file.get_line())
		print("-----------------------------------------------------")
		
	question_file.close()
