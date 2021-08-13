extends KinematicBody2D

var velocidade = 20
var health = 100
var dir_x = 0
var dir_y = 0

var bulletScene = load("res://Scenes/Bullet.tscn")
var drop = preload("res://Scenes/DropComum.tscn")

onready var score = get_node("/root/Main/GUI")
onready var pontaDaArma = $PontaDaArma
onready var player = get_parent().get_node("Player")
onready var animationPlayer = $AnimationPlayer



func _ready():
	
	randomize()	
		
	# Gera um int de 0 a 3 que define de onde o inimigo irá aparecer
	var spawn = randi() % 4	
	var target = Vector2(self.position.x, self.position.y)
	# Se 0 entao de baixo
	if spawn == 0:		
		self.position.y = 600
		target = Vector2(self.position.x, 500)
		$MoveTween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)	
		$MoveTween.start()
		self.rotation_degrees += 180
	# Se 1 entao de cima
	elif spawn == 1:
		self.position.y = 0
		target = Vector2(self.position.x, 100)
		$MoveTween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)	
		$MoveTween.start()
	# Se 2 entao da esquerda
	elif spawn == 2:
		self.position.x = 0
		self.position.y = rand_range(100, 600)
		target = Vector2(100, self.position.y)
		$MoveTween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)	
		$MoveTween.start()
		self.rotation_degrees += -90
	# Se 3 entao da direita
	elif spawn == 3:
		self.position.x = 1000
		self.position.y = rand_range(100, 600)
		target = Vector2(900, self.position.y)
		$MoveTween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)	
		$MoveTween.start()
		self.rotation_degrees += 90
		
	animationPlayer.play("Alerta")
	$Timer.start()
	
# Anda
func _process(delta):
	
	position.x += dir_x * velocidade * delta
	position.y += dir_y * velocidade * delta 
	move_and_slide(position.normalized())
	

# Atira no player
func shoot():

	var bullet = bulletScene.instance()
	
	get_parent().add_child(bullet)
	
	# Seta que a bala vai sair da ponta da arma
	bullet.global_position = pontaDaArma.global_position
	
	# Faz com que o projetil seja disparado em linha reta
	bullet.global_rotation = pontaDaArma.global_rotation + PI/2
	
	# Atira no player	
	bullet.direction = Vector2(
							player.position.x - pontaDaArma.global_position.x,
							player.position.y - pontaDaArma.global_position.y
							).normalized()
							
	animationPlayer.play("Flash")
	

# Anda para uma direção aleatória
func walk():
	randomize()
	
	dir_x = randi() % 5 - 2
	dir_y = randi() % 5 - 2
	
	velocidade = randi()% 10 + 30
	
	reiniciaTimer()

# Se tomar N tiros morre
func handle_hit():
	health -= 35
	if health <= 0:
		score.setScore(1)
		die()

func dropItem():
	var novoDrop = drop.instance()
	novoDrop.position = self.position
	get_parent().add_child(novoDrop)

# Quando morrer
func die():
	dropItem()
	# Libera memoria
	queue_free()

# Tempo aleatorio até que o inimigo tome alguma ação
func reiniciaTimer():
	var newTimer = randi()%3 +1
	$Timer.wait_time = newTimer
	$Timer.start()

func _on_Timer_timeout():
	# Mira no player
	rotation = lerp_angle(rotation, global_position.direction_to(player.global_position).angle(), 1)	
	shoot()
	
	# Movimenta
	walk()
	
	
	
