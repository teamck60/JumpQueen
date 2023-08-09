extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var direction = 0
var jump_charge = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func update_animation():
	if Input.is_action_pressed("ui_accept"):
		$AnimatedSprite2D.play("jump_start")
	elif velocity.y < 0 :
		$AnimatedSprite2D.play("jump")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("fall")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		direction = 0
		jump_charge -= 20
		jump_charge = clamp(jump_charge,-800,-150)
		
		
	if not is_on_floor():
		velocity.y += gravity * delta
		if is_on_wall():
			direction = -direction /2
	
	
	
	# Handle Jump.
	if Input.is_action_just_released("ui_accept") and is_on_floor():
		direction = Input.get_axis("ui_left", "ui_right")
		velocity.y = jump_charge
		velocity.x = direction * SPEED
		jump_charge = 0
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor() and not Input.is_action_pressed("ui_accept"): 
		direction = Input.get_axis("ui_left", "ui_right")
		
	if direction:
	
		velocity.x = direction * SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	

	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	if direction < 0:
		$AnimatedSprite2D.flip_h = true

	update_animation()
	move_and_slide()
