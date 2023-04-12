module rounding(x, y, rot, radius, height) {
    translate([x, y, 0]) {
        rotate([0, 0, rot]) {
            translate([-radius, -radius, 0]) {
                intersection() {
                    difference() {
                        cube([radius*2.1, radius*2.1, height*2], center=true);
                        translate([0, 0, -height]) {
                            cylinder(r=radius, h=height*4, $fn=60);
                        }
                    }
                    cube([radius*1.05, radius*1.05, height]);
                }
            }
        }
    }
}