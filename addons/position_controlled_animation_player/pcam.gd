tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("PositionControlledAnimationPlayer", "AnimationPlayer", preload("pcam_script.gd"), preload("PCAnimationPlayer.svg"))


func _exit_tree():
	remove_custom_type("PositionControlledAnimationPlayer")
