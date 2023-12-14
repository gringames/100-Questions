@tool
extends EditorScript

var question_txt_path: String = "res://data/initial_questions.txt"
var questions_node_name: String = "QuestionsMain"
var print_question_array: bool = true

var questions: Array

func get_questions() -> Array:
	return questions


func _run():
	fill_array_from_file()
	
	if print_question_array:
		print(questions)
		
	assign_questions_array_in_main()
		

func fill_array_from_file() -> void:
	# TODO: create user:// file on first start of game and write init_questions into that. Then use user...
	
	var questions_file = FileAccess.open(question_txt_path, FileAccess.READ)
	while not questions_file.eof_reached():
		var line: String = questions_file.get_line()
		
		if line.begins_with("#") or line.is_empty():
			continue
		
		questions.append(str(line))


func assign_questions_array_in_main() -> void:
	# get scene returns the root node
	var questions_node = get_scene()
	questions_node.questions = questions
