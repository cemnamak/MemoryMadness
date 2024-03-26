extends Node

const FRAME_IMAGES: Array = [
	preload("res://assets/frames/blue_frame.png"),
	preload("res://assets/frames/red_frame.png"),
	preload("res://assets/frames/yellow_frame.png"),
	preload("res://assets/frames/green_frame.png")
] 


var _item_array: Array = []
# Called when the node enters the scene tree for the first time.
func _ready():
	load_item_images()

func add_file_to_list(fn: String,path: String)-> void:
	var full_path = path + "/" + fn
	var ii_dict = {
		"item_name":fn.rstrip(".png"),
		"item_texture":load(full_path)
	}
	_item_array.append(ii_dict)

func load_item_images()-> void:
	var path:String = "res://assets/glitch"
	var dir = DirAccess.open(path)
	if not dir:
		print("error")
		return
	var file_names = dir.get_files()
	for fn in file_names:
		if ".import" not in fn:
			add_file_to_list(fn,path)
			
	print("item_loaded:%s" % _item_array.size())
	
func get_random_item_image()-> Dictionary:
	return _item_array.pick_random()

func get_image(index:int)-> Dictionary:
	return _item_array[index]

func get_random_frame_image()-> CompressedTexture2D:
	return FRAME_IMAGES.pick_random()
	
func suffle_images()->void:
	_item_array.shuffle()
