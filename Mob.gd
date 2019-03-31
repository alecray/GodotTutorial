extends RigidBody2D

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
var mob_types = ["walk", "swim", "fly"]

func _ready():
	# Pick a random sprite animation from array.
    $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	
func _on_Visibility_screen_exited():
	# Delete mobs when they leave the scene
    queue_free()