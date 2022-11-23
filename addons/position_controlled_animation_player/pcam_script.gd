tool

extends AnimationPlayer

export(float, 0, 1) var target_position = 0.0 setget set_target_position, get_target_position
export var closeness_factor = 0.01
export var animation_name = ""

var anim_target_position = 0.0
var anim_current_position = 0.0
var anim_playing_forward = true
var _dummy

func _ready():
	if animation_name.empty() and get_animation_list().size() > 0:
		animation_name = get_animation_list()[0]


func set_target_position(pos):
	anim_target_position = pos


func get_target_position():
	return anim_target_position


func _process(_delta):
	if is_playing():
		anim_current_position = current_animation_position / current_animation_length
	# Check for closeness to target position
	if abs(anim_target_position - anim_current_position) < closeness_factor:
		if is_playing():
			stop(false)
	else:
		if anim_target_position > anim_current_position:
			# Play forward to advance towards the target position
			if not is_playing():
				play(animation_name)
			elif not anim_playing_forward:
				play(animation_name)
			anim_playing_forward = true
		else:
			# Play backwards to move back towards the target position
			if not is_playing():
				play_backwards(animation_name)
			elif anim_playing_forward:
				play_backwards(animation_name)
			anim_playing_forward = false
