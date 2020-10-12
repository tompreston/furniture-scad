// Middle full-height, left and right shelves
use <lib/wardrobe.scad>

function shelf_top_z() = 1800;
function div_wall_y() = 300;

% wd_walls();
translate([0, 0, shelf_top_z()])
	wd_shelf_full(rail=true);

// Left divider
//translate([0, div_wall_y(), 0])
//	wd_div_wall(shelf_top_z());
// Right divider
translate([0, wd_length(), 0])
	mirror([0, 1, 0])
	translate([0, div_wall_y(), 0])
	wd_div_wall(shelf_top_z());

// Leave 1100mm (min 1000mm) to hang Tom's clothes
for (i = [250, 500, 750, 1000, 1250, 1500]) {
	translate([0, 0, i]) {
		//wd_shelf_left(div_wall_y());
		wd_shelf_right(div_wall_y());
	}
}
