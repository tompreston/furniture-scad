// Bedroom Wardrobe CAD
// Tips/lessons:
// - Build modules relative to 0,0,0, then translate into place later.
// - Dimensions are measured length (across), width (away), height (up).
// - This matches to y, x, z here.
// - Dimensions are also relative, so no necessarily x, y, z.
// - Use functions to represent dimensions

// Wardrobe dimensions
function wd_length() = 1733; // Y
function wd_width() = 0819; // X
function wd_height() = 2398; // Z

// Wardrobe colour
function wd_colour() = "white";
function wd_rail_colour() = "silver";
function wd_batten_colour() = "white";

// Skirting dimensions
function wd_skirting_width() = 16;
function wd_skirting_height() = 145;

// Shelf dimensions
// Cut length to size.
function wd_shelf_height() = 18;
function wd_shelf_width() = 500;

// Batten dimensions
// Battens hold up shelves, cut height to size, and translate into place
// Notes: length and width of batton doesn't map directly to xyz
function wd_batten_large_length() = 68;
function wd_batten_large_width() = 21;

// Clothes rail dimensions
function wd_rail_radius() = 10;
function wd_rail_z() = -40;

module wd_wall_with_door() {
	door_length = 1381;
	door_height = 2000;
	border_length = (wd_length() - door_length) / 2;
	difference() {
		// border
		square([wd_height(), wd_length()]);
		// opening
		translate([0, border_length, 0])
			square([door_height, door_length]);
	}
}

module wd_skirting_rear() {
	cube([wd_skirting_width(), wd_length(), wd_skirting_height()]);
}

module wd_skirting_side() {
	cube([wd_width(), wd_skirting_width(), wd_skirting_height()]);
}

// Walls, guidance only 2D shapes
module wd_walls() {
	// base
	square([wd_width(), wd_length()]);
	// rear
	rotate(-90, [0, 1, 0])
		square([wd_height(), wd_length()]);
	// door
	translate([wd_width(), 0, 0])
		rotate(-90, [0, 1, 0])
		wd_wall_with_door();

	wd_skirting_rear();
	wd_skirting_side();
	translate([0, wd_length()-wd_skirting_width(), 0])
		wd_skirting_side();
}

module _crail_support(shelf_width, y) {
	h = 50;
	w = 20;
	l = 10;
	translate([shelf_width / 2 - w, y, 0 - h])
		color(wd_rail_colour())
		cube([w, l, h]);
}

// Clothes rail full length, underneath shelf_height, centred on shelf_width.
module wd_crail_full(shelf_width) {
	// rail ends screw into the battens
	rail_end_radius = 20;
	rail_end_height = 10;
	rail_end_y = [wd_batten_large_width(),
		wd_length()-wd_batten_large_width()-rail_end_height];

	// rail supports suspend from the shelf
	rail_supports_y = [433, 1299];

	// Height of the pole if it were standing up
	rail_height = wd_length() - wd_batten_large_width() * 2;
	echo(str("clothes rail, cut ", rail_height, "mm"));

	// Positioned half way under shelf_width and suspended z mm
	rail_x = shelf_width / 2;

	// rail
	translate([rail_x, wd_batten_large_width(), wd_rail_z()])
		rotate(-90, [1, 0, 0])
		color(wd_rail_colour())
		cylinder(rail_height, wd_rail_radius(), wd_rail_radius());
	
	// supports
	for (i = rail_supports_y) {
		_crail_support(shelf_width, i);
	}
	for (i = rail_end_y) {
		translate([rail_x, i, wd_rail_z()])
			rotate(-90, [1, 0, 0])
			color(wd_rail_colour())
			cylinder(rail_end_height, rail_end_radius,
				rail_end_radius);
	}
}

// Batten on the rear wall
module wd_batten_rear_large(length=wd_length()) {
	echo(str("batten rear, cut to ", length, "mm"));
	translate([0, 0, 0-wd_batten_large_length()])
		color(wd_batten_colour())
		cube([wd_batten_large_width(), length, wd_batten_large_length()]);
}

module wd_batten_side_large() {
	echo(str("batten side, cut to ", wd_width(), "mm"));
	batten_rear_width = wd_batten_large_width();
	length = wd_batten_large_width();
	width = wd_width() - wd_batten_large_width();
	height = wd_batten_large_length();
	translate([batten_rear_width, 0, 0-wd_batten_large_length()])
		color(wd_batten_colour())
		cube([width, length, height]);
}

// Create a full sized shelf
module wd_shelf_full(rail=false) {
	echo(str("shelf full width, cut to ", wd_length(), "mm"));
	// Battens
	wd_batten_rear_large();
	wd_batten_side_large();
	translate([0, wd_length()-wd_batten_large_width(), 0])
		wd_batten_side_large();

	// Shelf
	color(wd_colour())
		cube([wd_shelf_width(), wd_length(), wd_shelf_height()]);

	if (rail) {
		wd_crail_full(wd_shelf_width());
	}
}

// Wardrobe divider wall
// Set cutout to true to cut out rail, batten, skirting holes
module wd_div_wall(height, cutout=false) {
	echo(str("divider wall, cut to ", height, "mm"));
	if (cutout) {
		difference() {
			color(wd_colour())
				cube([wd_shelf_width(), wd_shelf_height(), height]);
			// Cutout for rail
			// Note: When you build this, drill a nice hole
			c_rail_x = wd_shelf_width() / 2 - wd_rail_radius();
			c_rail_height = abs(wd_rail_z()) + wd_rail_radius();
			translate([c_rail_x, 0, height])
				mirror([0, 0, 1])
				cube([wd_rail_radius() * 2,
					wd_shelf_height(),
					c_rail_height]);
			// batten
			translate([0, 0, height])
				mirror([0, 0, 1])
				cube([wd_batten_large_width(),
					wd_shelf_height(),
					wd_batten_large_length()]);
			// skirting
			cube([wd_skirting_width(),
				wd_shelf_height(),
				wd_skirting_height()]);
		}
	} else {
		cube([wd_shelf_width(), wd_shelf_height(), height]);
	}
}

function wd_shelf_left_length_default() = 
	wd_length() / 2 - wd_shelf_height() / 2;

module wd_shelf_left(length=wd_shelf_left_length_default()) {
	echo(str("shelf, cut to ", length, "mm"));
	wd_batten_side_large();
	wd_batten_rear_large(length / 2);
	color(wd_colour())
		cube([wd_shelf_width(), length, wd_shelf_height()]);
}

module wd_shelf_right(length=wd_shelf_left_length_default()) {
	// don't echo, wd_shelf_left does this for us
	translate([0, wd_length(), 0])
	mirror([0, 1, 0])
		wd_shelf_left(length);
}
