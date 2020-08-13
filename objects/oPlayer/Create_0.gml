/// @description Insert description here
// You can write your code in this editor
horizontalSpeed = 0;
verticalSpeed = 0;
facingDir = 1;
jumpHeight = -5;
walkSpeed = 4;
dashSpeed = walkSpeed * 2;
dashTimer = 0;
airFriction = 0.85;
playerGrv = 0.2;
image_speed = 0;

enum PLAYERSTATE {
	SPAWN,
	IDLE,
	CROUCH,
	RUNNING,
	RISING,
	FALLING,
	DASH
}

state = PLAYERSTATE.SPAWN;
prevState = -1;

stateNameMap = ds_map_create();
ds_map_add(stateNameMap, PLAYERSTATE.SPAWN, "SPAWN");
ds_map_add(stateNameMap, PLAYERSTATE.IDLE, "IDLE");
ds_map_add(stateNameMap, PLAYERSTATE.RUNNING, "RUNNING");
ds_map_add(stateNameMap, PLAYERSTATE.RISING, "RISING");
ds_map_add(stateNameMap, PLAYERSTATE.FALLING, "FALLING");
ds_map_add(stateNameMap, PLAYERSTATE.CROUCH, "CROUCH");
ds_map_add(stateNameMap, PLAYERSTATE.DASH, "DASH");