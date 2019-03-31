extends CanvasLayer

# When button is pressed
signal start_game

# Temporary message
func show_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()

# Called when player loses
func show_game_over():
    show_message("Game Over")
    yield($MessageTimer, "timeout")
    $MessageLabel.text = "Dodge the\nCreeps!"
    $MessageLabel.show()
	# A useful delay (like time.sleep)
    yield(get_tree().create_timer(1), 'timeout')
    $StartButton.show()

#Called by main whenever score changes
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()



