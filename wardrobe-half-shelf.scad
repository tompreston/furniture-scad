// Half full-height, half half-height.
include <lib/wall.scad>;
include <lib/batten.scad>;
include <lib/shelf.scad>;
include <lib/wardrobe.scad>;

function shelf_top_z() = 1800;
function div_wall_y() = wd_length() / 2 - wd_shelf_height() / 2;

% wd_walls();
translate([0, 0, shelf_top_z()])
	wd_shelf_full(rail=true);

translate([0, div_wall_y(), 0])
	wd_div_wall(shelf_top_z(), cutout=true);

// Leave 1100mm (min 1000mm) to hang Tom's clothes
for (i = [250, 500, 750]) {
	translate([0, 0, i])
		wd_shelf_right();
}
