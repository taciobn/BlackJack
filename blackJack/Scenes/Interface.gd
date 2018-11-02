extends Control


func _ready():
	pass



func _on_JogarNovamente_button_down():
	$ApostaPanel.hide()
	$ResultPanel.hide()
	get_tree().change_scene("res://Scenes/main.tscn")
	pass


func _on_VoltarMenu_button_down():
	$ApostaPanel.hide()
	$ResultPanel.hide()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	pass
