extends Node

class_name PositionControlledAnimation

export(float, 0, 1) var target_position = 0.0 setget set_target_position
export var closeness_factor = 0.01
export(NodePath) var animation_player_node

var anim_target_position = 0.0
var anim_current_position = 0.0
var anim_playing_forward = true
onready var anim: AnimationPlayer = $Anim

func _ready():
	# Allow for integration of this class into a scene
	if animation_player_node: # if has been set in the export var
		$HSlider.hide()
		$Godot.hide()
		anim = get_node(animation_player_node)


func _on_HSlider_value_changed(value):
	set_target_position(value / 100)


func set_target_position(pos):
	anim_target_position = pos


func _process(_delta):
	if anim.is_playing():
		anim_current_position = anim.current_animation_position / anim.current_animation_length
	# Check for closeness to target position
	if abs(anim_target_position - anim_current_position) < closeness_factor:
		if anim.is_playing():
			anim.stop(false)
	else:
		if anim_target_position > anim_current_position:
			# Play forward to advance towards the target position
			if not anim.is_playing():
				anim.play("Animate")
			elif not anim_playing_forward:
				anim.play("Animate")
			anim_playing_forward = true
		else:
			# Play backwards to move back towards the target position
			if not anim.is_playing():
				anim.play_backwards("Animate")
			elif anim_playing_forward:
				anim.play_backwards("Animate")
			anim_playing_forward = false
