extends Node

var anim_target_position = 0
var anim_position = 0

export var animation_length = 3.0

func _on_HSlider_value_changed(value):
	anim_target_position = value / 100


func _process(_delta):
	if $Anim.is_playing():
		anim_position = $Anim.current_animation_position / $Anim.current_animation_length
	if abs(anim_target_position - anim_position) < 0.01:
		if $Anim.is_playing():
			$Anim.stop(false)
	else:
		if anim_target_position > anim_position:
			if not $Anim.is_playing() or $Anim.playback_speed < 0:
				$Anim.play("Animate")
		else:
			if not $Anim.is_playing() or $Anim.playback_speed > 0:
				$Anim.play_backwards("Animate")
