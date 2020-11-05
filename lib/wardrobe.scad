// Bedroom Wardrobe CAD

// Note: OpenSCAD doesn't support nested use/include.
// The only way I could get it to work is by including every dependency into
// the main CAD file. Sadly, I think this is quite limited. Needs more
// investigaiton.
// include <lib/batten.scad>;
// use <lib/batten.scad>;

// Wardrobe dimensions
function wd_length() = 1733; // Y
function wd_width() = 0819; // X
function wd_height() = 2398; // Z

// Wardrobe colour
function wd_colour() = "white";
function wd_rail_colour() = "silver";

// Skirting dimensions
function wd_skirting_width() = 16;
function wd_skirting_height() = 145;

// Shelf dimensions
// Cut length to size.
function wd_shelf_height() = 18;
function wd_shelf_width() = 500;

// Clothes rail dimensions
function wd_rail_radius() = 15;
function wd_rail_z() = -60;

module wd_skirting_rear() {
	cube([wd_skirting_width(), wd_length(), wd_skirting_height()]);
}

module wd_skirting_side() {
	cube([wd_width(), wd_skirting_width(), wd_skirting_height()]);
}

module wd_wall_with_door() {
	door_length = 1381;
	door_height = 2000;
	wall_with_door(wd_length(), wd_height(), door_length, door_height);
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

// Clothes rail full length, underneath shelf_height, centred on shelf_width.
module wd_crail_full(shelf_width) {
	// rail ends screw into the battens
	rail_end_radius = 20;
	rail_end_height = 10;
	rail_end_y = [batten_large_width(),
		wd_length()-batten_large_width()-rail_end_height];

	// Height of the pole if it were standing up
	rail_height = wd_length() - batten_large_width() * 2;
	echo(str("clothes rail, cut ", rail_height, "mm"));

	// Positioned half way under shelf_width and suspended z mm
	rail_x = shelf_width / 2;

	// rail
	translate([rail_x, batten_large_width(), wd_rail_z()])
		rotate(-90, [1, 0, 0])
		color(wd_rail_colour())
		cylinder(rail_height, wd_rail_radius(), wd_rail_radius());
	
	// supports
	for (i = rail_end_y) {
		translate([rail_x, i, wd_rail_z()])
			rotate(-90, [1, 0, 0])
			color(wd_rail_colour())
			cylinder(rail_end_height, rail_end_radius,
				rail_end_radius);
	}
}

// Create a full sized shelf
module wd_shelf_full(rail=false) {
	shelf_batten(wd_length());
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
			// batten cutout
			translate([0, 0, height])
				mirror([0, 0, 1])
				cube([batten_large_width(),
					wd_shelf_height(),
					batten_large_length()]);
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
	shelf_batten(length, bl=batten_medium_length(), rbatten=false);
}

module wd_shelf_right(length=wd_shelf_left_length_default()) {
	translate([0, wd_length(), 0])
		mirror([0, 1, 0])
			wd_shelf_left(length);
}
