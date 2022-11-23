extends Node


func _on_HSlider_value_changed(value):
	$PositionControlledAnimationPlayer.target_position = value / 100
