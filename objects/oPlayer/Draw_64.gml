/// @description Draw the Current state
draw_set_color(c_black);
draw_rectangle(0, 120, 200, 30, false);

draw_set_font(fFont);
draw_set_color(c_white);

draw_text(10, 60, "State: " + stateNameMap[? state]);
draw_text(10, 90, "Facing Direction: " + string(facingDir));