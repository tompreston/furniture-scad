// Wall helpers

module wall_with_door(wall_length, wall_height, door_length, door_height) {
	border_length = (wall_length - door_length) / 2;
	difference() {
		// border
		square([wall_height, wall_length]);
		// opening
		translate([0, border_length, 0])
			square([door_height, door_length]);
	}
}

