extends Area2D

export var speed = 800
var direction := Vector2.ZERO

onready var deletaBala = $DeletaBala

func _ready():
	$DeletaBala.start()

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed * delta
		
		global_position += velocity

func set_direction(newDirection: Vector2):
	self.direction = newDirection
	

func _on_DeletaBala_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	# Se o objeto tiver a função de lider com acertos, então executa
	# Isso garante que apenas o que pode reagir as balas ira reagir.
	if body.has_method("handle_hit"):
		body.handle_hit()
	queue_free()
