extends Node


func _on_TouchScreenButton_pressed():
	Input.action_press("accelerate")

func _on_TouchScreenButton_released():
	Input.action_release("accelerate")
