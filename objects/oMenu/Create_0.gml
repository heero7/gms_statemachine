/// @description Insert description here

global.pause = true;

// Camera size
global.view_width = camera_get_view_width(view_camera[0]);
global.view_height = camera_get_view_height(view_camera[0]);

// Keys used.
global.key_revert = ord("X");
global.key_enter = vk_enter;
global.key_left = vk_left;
global.key_right = vk_right;
global.key_up = vk_up;
global.key_down = vk_down;

// Scale to the GUI
display_set_gui_size(global.view_width, global.view_height);


enum MENUPAGE {
	MAIN,
	SETTINGS,
	AUDIO,
	DIFFICULTY,
	GRAPHICS,
	CONTROLS
}

enum MENUELEMENTTYPE {
	SCRIPTRUNNER,
	PAGETRANSFER,
	SLIDER,
	SHIFT,
	TOGGLE,
	INPUT
}

// Create Menu Pages
