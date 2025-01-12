extends ProgressBar

@onready var playerhealth = $"../../../../../../../commandprocessor/player"


func _physics_process(delta: float) -> void:
	self.value=playerhealth.health
