include <lib/wall.scad>
include <lib/batten.scad>
include <lib/shelf.scad>
include <lib/wardrobe.scad>
include <lib/lcupboard.scad>

% lc_walls();

for (i = [150, 300, 450, 600]) {
	translate([0, 0, i])
		shelf_batten(lc_length(), 600);
}
