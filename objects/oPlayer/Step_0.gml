/// @description Player State Machine

playerInput(true);
movingDirection = inputRight - inputLeft;
grounded = place_meeting(x, y + 1, oWall);
switch (state) {
	case PLAYERSTATE.SPAWN: {
		playerInput(false);
		verticalSpeed = applyGravity(verticalSpeed, 0.3);
		verticalSpeed = checkVerticalCollisions(verticalSpeed);
		y += verticalSpeed;
		if (grounded) state = PLAYERSTATE.IDLE;
	}
		break;
	case PLAYERSTATE.IDLE: {
		movingDirection = inputRight - inputLeft;
		if (movingDirection != 0
			&& grounded) state = PLAYERSTATE.RUNNING;
		if (inputJump) state = PLAYERSTATE.RISING;
		if (inputDown) state = PLAYERSTATE.CROUCH;
		if (inputDash) state = PLAYERSTATE.DASH;
	}
		break;
	case PLAYERSTATE.CROUCH: {
		image_index = 1;
		mask_index = mPlayerCrouch;
		
		if (movingDirection != 0) facingDir = sign(movingDirection);
		horizontalSpeed = movingDirection * walkSpeed * 0.6;
		horizontalSpeed = checkHorizontalCollisions(horizontalSpeed);
		x += horizontalSpeed;
		
		if (!inputDown) {
			// check above if we're colliding above.
			if (place_meeting(x, y - sprite_height, oWall)) return;
			
			mask_index = sPlayer;
			image_index = 0;
			
			
			if (horizontalSpeed != 0) state = PLAYERSTATE.RUNNING;
			else state = PLAYERSTATE.IDLE;
		}
	}
		break;
	case PLAYERSTATE.RUNNING: {
		if (movingDirection != 0) facingDir = sign(movingDirection);
		horizontalSpeed = movingDirection * walkSpeed;
		horizontalSpeed = checkHorizontalCollisions(horizontalSpeed);
		x += horizontalSpeed;
		
		// Options out of Run
		if (inputJump) state = PLAYERSTATE.RISING;
		if (grounded && movingDirection == 0) state = PLAYERSTATE.IDLE;
		if (inputDown) state = PLAYERSTATE.CROUCH;
	}
		break;
	case PLAYERSTATE.RISING: {
		verticalSpeed = jumpHeight;
		verticalSpeed = checkVerticalCollisions(verticalSpeed);
		y += verticalSpeed;
		
		if (movingDirection != 0) facingDir = sign(movingDirection);
		horizontalSpeed = movingDirection * walkSpeed * airFriction;
		horizontalSpeed = checkHorizontalCollisions(horizontalSpeed);
		x += horizontalSpeed;
		
		// Options out of Rising
		if (verticalSpeed < 0) state = PLAYERSTATE.FALLING;
	}
		break;
	case PLAYERSTATE.FALLING:

		
		// if (prevState == PLAYERSTATE.DASH) { verticalSpeed = 1; }
		// else verticalSpeed = applyGravity(verticalSpeed, playerGrv);
		verticalSpeed = applyGravity(verticalSpeed, playerGrv);
		// show_debug_message("VSP[gravity]: " + string(verticalSpeed));
		verticalSpeed = checkVerticalCollisions(verticalSpeed);
		// show_debug_message("VSP[verify coll]: " + string(verticalSpeed));
		y += verticalSpeed;
		show_debug_message("[Y-Axis](Falling): " + string(y));
		
		if (inputDash) {
			state = PLAYERSTATE.DASH;
			return;
		}
		
		if (movingDirection != 0) facingDir = sign(movingDirection);
		horizontalSpeed = movingDirection * walkSpeed * airFriction;
		horizontalSpeed = checkHorizontalCollisions(horizontalSpeed);
		x += horizontalSpeed;
		
		if (grounded) { 
			state = PLAYERSTATE.IDLE;
			show_debug_message("\n***********************");
		}
		break;
	case PLAYERSTATE.DASH: {
		if (dashTimer >= 30) {
			dashTimer = 0;
			if (!grounded) { 
				state = PLAYERSTATE.FALLING;
				prevState = PLAYERSTATE.DASH;
				show_debug_message("\n***********************");
				show_debug_message("[Y-Axis](Dash): " + string(y));
				return;
			}
			state = PLAYERSTATE.IDLE;
			return;
		}
		show_debug_message("!!![Y-Axis](Dash Height): " + string(y));
		dashTimer++;
		horizontalSpeed = dashSpeed * facingDir;
		horizontalSpeed = checkHorizontalCollisions(horizontalSpeed);
		x += horizontalSpeed;
	}
		break;
		
}