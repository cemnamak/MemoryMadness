extends Control
@onready var hb_levels = $VB/HBLevels

@export var level_button_scene :PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()
	
func create_level_button(ln: int) -> void:
	var new_button = level_button_scene.instantiate()		
	hb_levels.add_child(new_button)
	new_button.set_level_number(ln)
	
func setup_grid() -> void:
	for level in GameManager.LEVELS:
		create_level_button(level)


