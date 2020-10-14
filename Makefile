list:
	openscad -o /tmp/temp.stl wardrobe-half-shelf.scad 2>&1 | \
		grep ECHO | sort | uniq -c
