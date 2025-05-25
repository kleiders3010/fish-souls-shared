@tool
extends Sprite2D
class_name ProceduralSegment
@export var radius = 50
@export var owned_bone : Bone2D

var recently_rotated = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	draw_circle(to_local(global_position), 5, Color(0, 0, 1))
	draw_circle(to_local(global_position), radius, Color(0, 0, 1), false)
