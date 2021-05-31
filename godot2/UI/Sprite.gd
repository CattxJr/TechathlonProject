extends Sprite

const VELOCITY = -1.5
var g_texture_width = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	g_texture_width = texture.get_size().x * scale.x
	
func _process(delta):
	position.x += VELOCITY
	attempt_reposition()

func attempt_reposition():
	if position.x < -g_texture_width:
		position.x += 2 * g_texture_width

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
