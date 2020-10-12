// Main shelf with rail, two low shelves
use <lib/wardrobe.scad>

% wd_walls();
translate([0, 0, 1800])
	wd_shelf_full(rail=true);
translate([0, 0, 600])
	wd_shelf_full();
translate([0, 0, 300])
	wd_shelf_full();
