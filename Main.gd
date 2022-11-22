extends Node

var anim_target_position = 0
var anim_position = 0

func _on_HSlider_value_changed(value):
	set_target_position(value / 100)


func set_target_position(pos):
	anim_target_position = pos


func _process(_delta):
	if $Anim.is_playing():
		anim_position = $Anim.current_animation_position / $Anim.current_animation_length
	# Check for closeness to target position
	if abs(anim_target_position - anim_position) < 0.01:
		if $Anim.is_playing():
			$Anim.stop(false)
	else:
		if anim_target_position > anim_position:
			if not $Anim.is_playing() or $Anim.playback_speed < 0:
				# Play forward to advance towards the target position
				$Anim.play("Animate")
		else:
			if not $Anim.is_playing() or $Anim.playback_speed > 0:
				# Play backwards to move back towards the target position
				$Anim.play_backwards("Animate")
