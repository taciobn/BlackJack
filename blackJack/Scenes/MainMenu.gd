extends Control


func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Play_button_down():
	get_tree().change_scene("res://Scenes/main.tscn")
	pass


func _on_Quit_button_down():
	get_tree().quit()
	pass 
