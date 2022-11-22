extends Node

var anim_target_position = 0
var anim_current_position = 0
var anim_playing_forward = true

func _on_HSlider_value_changed(value):
	set_target_position(value / 100)


func set_target_position(pos): # 0.0 .. 1.0
	anim_target_position = pos


func _process(_delta):
	if $Anim.is_playing():
		anim_current_position = $Anim.current_animation_position / $Anim.current_animation_length
	# Check for closeness to target position
	if abs(anim_target_position - anim_current_position) < 0.01:
		if $Anim.is_playing():
			$Anim.stop(false)
	else:
		if anim_target_position > anim_current_position:
			# Play forward to advance towards the target position
			if not $Anim.is_playing():
				$Anim.play("Animate")
			elif not anim_playing_forward:
				$Anim.play("Animate")
			anim_playing_forward = true
		else:
			# Play backwards to move back towards the target position
			if not $Anim.is_playing():
				$Anim.play_backwards("Animate")
			elif anim_playing_forward:
				$Anim.play_backwards("Animate")
			anim_playing_forward = false
