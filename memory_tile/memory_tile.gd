extends TextureButton

class_name MemoryTile

@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage

var _item_name: String
var _can_select_me: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_selection_enabled.connect(on_selection_enabled)
	SignalManager.on_selection_disabled.connect(on_selection_disabled)
	

func get_item_name()-> String:
	return _item_name

func setup(ii_dict:Dictionary,fi: CompressedTexture2D)-> void:
	frame_image.texture = fi
	item_image.texture = ii_dict.item_texture
	_item_name = ii_dict.item_name
	reveal(false)
	
func kill_on_success() -> void:
	z_index = 1
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self,"disabled",true,0)
	tween.tween_property(self,"rotation",deg_to_rad(720),0.5)
	tween.tween_property(self,"scale",Vector2(1.5,1.5),0.5)
	tween.set_parallel(false)
	tween.tween_interval(0.6)
	tween.tween_property(self,"scale",Vector2(0,0),0)
	

func reveal(r: bool) -> void:
	item_image.visible = r
	frame_image.visible = r

func on_selection_enabled() -> void:
	_can_select_me = true
	
func on_selection_disabled() -> void:
	_can_select_me = false

func _on_pressed():
	if _can_select_me:
		SignalManager.on_tile_selected.emit(self)
	
