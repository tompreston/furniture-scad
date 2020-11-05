// Batton CAD
function batten_colour() = "white";

// Batten dimensions
// Battens hold up shelves, cut height to size, and translate into place
// Notes: length and width of batton doesn't map directly to xyz
function batten_large_length() = 92;
function batten_large_width() = 21;
function batten_medium_length() = 68;

module batten_y(h, l=batten_large_length(), w=batten_large_width()) {
	echo(str("batten y ", l, "mm x ", w, "mm, cut to ", h, "mm"));
	color(batten_colour())
		cube([w, h, l]);
}

module batten_x(h, l=batten_large_length(), w=batten_large_width()) {
	echo(str("batten x ", l, "mm x ", w, "mm, cut to ", h, "mm"));
	color(batten_colour())
		cube([h, w, l]);
}
