// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//controls = {
//	right: 0,
//	left: 0,
//	up: 0,
//	down: 0,
//};

function playerInput(hasControl) {
	if (!hasControl) {
		inputRight = 0;
		inputLeft = 0;
		inputDown = 0;
		inputJump = 0;
		inputJump_released = 0;
		inputAttack = 0;
		inputDash_pressed = 0;
		inputDash_released = 0;
		return;
	}
	inputRight = keyboard_check(vk_right);
	inputLeft = keyboard_check(vk_left);
	inputDown = keyboard_check(vk_down);
	inputJump = keyboard_check_pressed(vk_space);
	inputJump_released = keyboard_check_released(vk_space);
	inputAttack = keyboard_check(ord("X"));
	inputDash_held = keyboard_check(ord("Z"));
	inputDash_pressed = keyboard_check_pressed(ord("Z"));
	inputDash_released = keyboard_check_released(ord("Z"));
}

// Horizontal Collisions
function checkHorizontalCollisions(xSpeed) {
	if (place_meeting(x + xSpeed, y, oWall)) {
		// Inch towards wall
		while (!place_meeting(x + sign(xSpeed), y, oWall)) {
			x += sign(xSpeed);
		}
		xSpeed = 0;
	}
	return xSpeed;
}

function checkVerticalCollisions(ySpeed) {
	if (place_meeting(x, y + ySpeed, oWall)) {
		while (!place_meeting(x, y + sign(ySpeed), oWall)) {
			y += sign(ySpeed);
		}
		ySpeed = 0;
	}
	return ySpeed;
}

function applyGravity(ySpeed, grv) {
	return ySpeed < 10 
		? ySpeed + grv
		: ySpeed;
}