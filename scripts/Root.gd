extends Control

onready var story = $RootContainer/Window/Container/StoryLabel
onready var line_edit = $RootContainer/Window/Container/PlayerEditContainer/LineEdit
onready var buttonlabel = $RootContainer/Window/Container/PlayerEditContainer/OkButton/OkContainer/OkLabel

var ans = []
var ques_base = "Can I get %s"
var cur_story = null

var ques = [
		{
		"prompts" : ["a noun", "an adjective", "an animal", "the name of a food item", "an adjective", "another adjective"],
		"story" : "Old Mother Hubbard went to the %s. \n\nTo get her %s %s some %s. \n\nWhen she got there, it was %s, and so her %s dog had none."
		},
		{
		"prompts" : ["a noun", "another noun", "the name of something liquid", "the name of a part of a body"],
		"story" : "Jack and Jill went up the %s. \n\nTo fetch a/an %s of %s. \n\nJack fell down and broke his %s. \n\nAnd Jill came tumbling after."
		},
		{
		"prompts" : ["an adjective", "an verb(past tense)", "a plural noun"],
		"story" : "There was a/an %s woman. \n\nWho %s in a shoe. \n\nShe had so many %s. \n\nShe didn't know what to do."
		},
		{
		"prompts" : ["the name of a part of a body", "an adjective", "another adjective", "yet another adjective"],
		"story" : "Right in the middle of her %s, \n\nAnd when she was %s, she was very, very %s, \n\nAnd when she was bad, she was %s."
		},
		{
		"prompts" : ["a verb", "a verb(-ing)", "a pronoun", "an adverb", "the name of a part of a body", "a noun", "a verb", "a conjunction", "a noun"],
		"story" : "June %s the love. \n\n%s on %s lips, \n\nplanted %s among the \n\nsoftness of their %s. \n\nThe %s of summer \n\n%s our tongues- \n\n%s to the taste, \n\nit's all honey & %s."
		},
		{
		"prompts" : ["a noun", "a verb", "a noun", "another noun", "an adjective"],
		"story" : "There was an old %s of Stroud,\n\nWho %s horribly jammed in a crowd; \n\nSome she slew with a %s, \n\nSome %s scrunched with a stick, \n\nThat %s old person of Stroud."
		},
		{
		"prompts" : ["a noun", "a verb", "a noun", "another noun", "a plural noun"],
		"story" : "My %s and I, we shall %s a %s, \n\nSo snug and warm and cosy, \n\nWhen the kingcups gleam on the meadow %s, \n\nWhere the %s are rosy!"
		},
		{
		"prompts" : ["the name of an animal", "the name of a vehicle", "a verb(-ing)"],
		"story" : "Dashing through the snow in a one %s open %s. \n\nO'er the fields we go %s all the way."
		},
		{
		"prompts" : ["a colour", "a plural noun", "a noun", "an adjective"],
		"story" : "Roses are %s, \n\n%s are blue, \n\n%s is %s, \n\nand so are you."
		},
		{
		"prompts" : ["the name of a part of a body", "a verb", "another verb(past tense)", "yet another verb"],
		"story" : "Wrap your %s in mine. \n\nDon't let me %s away, \n\nlike you never %s me to %s."
		}
		]

func _ready():
	welcome()
	os_setup()
	carat_blink()
	set_cur_story()
	is_done()
	focus_on()

func os_setup():
	OS.min_window_size = Vector2(720, 480)
	
func welcome():
	var wel = "Welcome to Lexeme. "
	story.text = wel

func carat_blink():
	line_edit.caret_blink = true
	line_edit.caret_blink_speed = 0.5

func set_cur_story():
	var stories = ques
	randomize()
	cur_story = stories[randi() % stories.size()]

func focus_on():
	line_edit.clear()
	line_edit.grab_focus()

func _on_LineEdit_text_entered(new_text):
	add_to_ans()

func _on_OkButton_pressed():
	proceed()
	
func proceed():
	if check_if_done():
		get_tree().reload_current_scene()
	else: 
		add_to_ans()
		line_edit.grab_focus()

func add_to_ans():
	ans.append(line_edit.text)
	story.text = ""
	line_edit.clear()
	is_done()

func check_if_done():
	return ans.size() == cur_story.prompts.size()

func ask():
	story.text += ques_base % cur_story.prompts[ans.size()] + " please?"

func is_done():
	if check_if_done():
		tell_story()
	else: 
		ask()

func tell_story():
	story.text = cur_story.story % ans
	end_story()
	
func end_story():
	line_edit.queue_free()
	buttonlabel.text = "Restart"

#
