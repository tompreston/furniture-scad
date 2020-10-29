list:
	openscad -o /tmp/temp.stl wardrobe-half-shelf.scad 2>&1 | \
		grep ECHO | sort | uniq -c
	openscad -o /tmp/temp.stl lcupboard-low-shelves.scad 2>&1 | \
		grep ECHO | sort | uniq -c
