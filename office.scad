// Office layout with shelves and desks
use <lib/wardrobe.scad>

function office_width() = 2300;
function office_length() = 4200;
function office_door_width() = 450;
function office_door_length() = 1200;
function office_height() = 2370;

module office_walls(show_back_wall=true) {
	// backwall
	rotate([0, -90, 0]) square([office_height(), office_length()]);

	// window wall
	translate([0, office_length(), 0])
		rotate([0, -90, -90])
		square([office_height(), office_width()]);

	// left wall
	rotate([0, -90, -90])
		square([office_height(), office_width() + office_door_width()]);

	if (show_back_wall) {
		// wall with door
		translate([office_width() + office_door_width(), 0, 0])
			rotate([0, -90, 0])
			square([office_height(), office_door_length()]);

		// wall to the right of door
		translate([office_width(), office_door_length(), 0])
			rotate([0, -90, -90])
			square([office_height(), office_door_width()]);

		// back wall
		translate([office_width(), office_door_length(), 0])
			rotate([0, -90, 0])
			square([office_height(), office_length() - office_door_length()]);
	}
}

module desks() {
	elevate = 700;
	width = 800;
	length_t = 1600;
	length_k = 1200;
	spacing_wall = 150;
	spacing_between = 20;

	// Tom's Desk
	translate([0, office_length() - spacing_wall - length_t, elevate])
		cube([width, length_t, 20]);

	// Kat's Desk
	translate([0, office_length() - spacing_wall - length_t - spacing_between - length_k, elevate])
		cube([width, length_k, 20]);
}

module monitor() {
	w = 260;
	l = 540;
	h = 600;

	translate([50, office_length() - 1600 + 300, 700])
		cube([w, l, h]);
}

module kallax() {
	w = 1470;
	h = w;
	d = 400;

	translate([300, d, 0])
		rotate([0, 0, -90])
		cube([d, w, h]);
}

module filing_cabinet_old() {
	w = 500;
	l = 400;
	h = 1030;

	translate([office_width() - l, office_length(), 0])
		rotate([0, 0, -90])
		cube([w, l, h]);
}

module filing_cabinet_new() {
	w = 500;
	l = 400;
	h = 1030;

	translate([0, 0, 0])
		rotate([0, 0, 0])
		cube([w, l, h]);
}

module shelves() {
	// chunky scaffold cut in half
	// https://www.gumtree.com/p/wood-timber/chunky-scaffold-board-/1424909094
	w = 225;
	l = 3900 / 2;
	h = 38;

	// 1.5m shelves
	/* w = 225; */
	/* l = 1500; */
	/* h = 38; */

	elevate_row_bottom = 1500;
	elevate_row_top = elevate_row_bottom + 330;
	spacing_wall = 150;
	spacing_between = 20;

	// top right
	translate([0, office_length() - spacing_wall - l, elevate_row_top])
		cube([w, l, h]);

	// top left
	translate([0, office_length() - spacing_wall - l - spacing_between - l, elevate_row_top])
		cube([w, l, h]);

	// bottom right
	translate([0, office_length() - spacing_wall - l, elevate_row_bottom])
		cube([w, l, h]);

	// bottom left
	translate([0, office_length() - spacing_wall - l - spacing_between - l, elevate_row_bottom])
		cube([w, l, h]);
}

% office_walls(show_back_wall=false);
desks();
monitor();
/* kallax(); */
filing_cabinet_old();
shelves();
