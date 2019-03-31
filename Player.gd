# Alec Ray
# Tutorial on godotengine.org
# 3/31/2019

extends Area2D

signal hit # Define signal player emits on collision w/ enemy.

export var speed = 400 # How fast the player will move (px/s).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	
	# Check for input
	var velocity = Vector2() #The player's movement vector. 0,0 by default.
	if Input.is_action_pressed("ui_right"):
        velocity.x += 1
	if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
        velocity.y += 1
	if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
	if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
	else:
        $AnimatedSprite.stop()
	
	# Set positions and clamp to screen
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Flip sprite direction
	if velocity.x != 0:
	    $AnimatedSprite.animation = "right"
	    $AnimatedSprite.flip_v = false
	    # See the note below about boolean assignment
	    $AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
	    $AnimatedSprite.animation = "up"
	    $AnimatedSprite.flip_v = velocity.y > 0

# Called whenever the player collides with an enemy
func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	# call_deferred ensures appropriate wait time to avoid errors
	$CollisionShape2D.call_deferred("set_disabled", true)

# Reset player on starting new game
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false