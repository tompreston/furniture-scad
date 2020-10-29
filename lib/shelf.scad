// Generic shelf function

function shelf_default_thickness() = 18;
function shelf_default_width() = 500;
function shelf_default_color() = "white";

module shelf(l, w=shelf_default_width(), t=shelf_default_thickness()) {
	echo(str("shelf w ", w, "mm, cut to l ", l, "mm"));
	color(shelf_default_color())
		cube([w, l, t]);

}

module _batten_rear(l) {
	mirror([0, 0, 1])
		batten_y(l);
}

module shelf_batten(l, w=shelf_default_width(), t=shelf_default_thickness(),
		lbatten=true, rbatten=true) {
	shelf(l, w, t);
	_batten_rear(l);

	// side battens
	// The side battens are shorter because the rear batten spans the
	// length (y) of the wall.
	batten_side_width = w - batten_large_width();
	translate([batten_large_width(), 0, 0]) 
		mirror([0, 0, 1]) {
			if (lbatten) {
				batten_x(batten_side_width);
			}
			if (rbatten) {
				// right
				translate([0, l, 0])
					mirror([0, 1, 0])
						batten_x(batten_side_width);
			}
	}
}
