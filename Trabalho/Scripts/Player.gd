extends KinematicBody2D

export var speed = 600

var health = 5

onready var rodaDeArmas = $RodaDeArmas
onready var score = get_node("/root/Main/GUI")

#func _ready():
#	rodaDeArmas.initialize() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	var movement_direction := Vector2.ZERO
	
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		movement_direction.x = 1

	elif Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		movement_direction.x = -1

	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		movement_direction.y = 1

	elif Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		movement_direction.y = -1

	movement_direction = movement_direction.normalized()
	move_and_slide(movement_direction * speed)
	
	look_at(get_global_mouse_position())

func handle_hit():
	health -= 1
	if health == 0:
		die()

func die():
	print("Game Over")
	Global.pontuacao = score.getScore()
	get_tree().change_scene("res://Scenes/UI/GameOver.tscn")

