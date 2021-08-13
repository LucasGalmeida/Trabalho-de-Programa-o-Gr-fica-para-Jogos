extends Control


func _ready():
	get_node("VBoxContainer/Label2").text = "Pontuação: " + str(Global.pontuacao)

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
	
func _on_Button2_pressed():
	get_tree().quit()
