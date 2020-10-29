// Landing cupboard

// left to right
function lc_length() = 0808;
// front to back
function lc_width() = 1039;
// base to ceiling
function lc_height() = 1537;

// Skirting dimensions
function lc_skirting_width() = 16;
function lc_skirting_height() = 145;

module lc_skirting_rear() {
	cube([lc_skirting_width(), lc_length(), lc_skirting_height()]);
}

module lc_skirting_side() {
	cube([lc_width(), lc_skirting_width(), lc_skirting_height()]);
}

module lc_wall_with_door() {
	door_length = 617;
	door_height = 1138;
	wall_with_door(lc_length(), lc_height(), door_length, door_height);
}

// Walls, guidance only 2D shapes
module lc_walls() {
	// base
	square([lc_width(), lc_length()]);
	// rear
	rotate(-90, [0, 1, 0])
		square([lc_height(), lc_length()]);
	// door
	translate([lc_width(), 0, 0])
		rotate(-90, [0, 1, 0])
		lc_wall_with_door();

	lc_skirting_rear();
	lc_skirting_side();
	translate([0, lc_length()-lc_skirting_width(), 0])
		lc_skirting_side();
}

module lc_shelf() {
	echo(str("shelf, cut to ", length, "mm"));
	batten_side_large();
	wd_batten_rear_large(length / 2);
	color(wd_colour())
		cube([wd_shelf_width(), length, wd_shelf_height()]);
}
