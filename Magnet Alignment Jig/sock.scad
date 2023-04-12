include <rounding.scad>

module sock(width, 
            height, 
            housing_minor_width, 
            housing_minor_height,
            coil_minor_width,
            coil_minor_height,
            housing_depth,
            latch_depth,
            latch_overhang,
            face_depth,
            screw_spacing,
            screw_diameter,
            recess_diameter,
            recess_depth,
            magnet_diameter,
            magnet_tolerance,
            rounding) {
                 
    half_height = height / 2;
    half_width = width / 2;
    half_housing_minor_height = housing_minor_height / 2;
    half_housing_minor_width = housing_minor_width / 2;
    
    screw_offset = (width - screw_spacing) / 2;
    faceDims = screw_offset * 2;
    totalCubeDims = faceDims+latch_depth;
    totalCubeHeight = face_depth + housing_depth + latch_overhang;
                
    supportWidth = width - (faceDims * 2);
    supportHeight = totalCubeDims * 0.3;
                
    roundingX = half_width-faceDims;
    roundingY = half_height-faceDims;
    roundingR = half_width - supportHeight - roundingX;
    
    difference() {
        for (x=[-1:2:1]) {
            for (y=[-1:2:1]) {
                difference() {
                    translate([x * (half_width - faceDims + (totalCubeDims/2)), y * (half_width - faceDims + (totalCubeDims/2)), -housing_depth - latch_overhang + (totalCubeHeight/2)]) {
                        cube([
                            totalCubeDims,
                            totalCubeDims,
                            totalCubeHeight
                        ], center=true);
                    }
                    
                    translate([x * (half_width - screw_offset), y* (half_width - screw_offset), -0.0002]) {
                        cylinder(totalCubeHeight * 2, screw_diameter/2, screw_diameter/2, $fn=64, center=true);
                    }
                }
            }
        }
        
        if (rounding > 0) {
            roundingX = half_width-faceDims;
            roundingY = half_height-faceDims;
            roundingR = half_width - supportHeight - roundingX;
            
            translate([0, 0, -totalCubeHeight + face_depth - 1]) {
                rounding(roundingX, roundingY, 180, roundingR, totalCubeHeight + 2);
                rounding(roundingX, -roundingY, 90, roundingR, totalCubeHeight + 2);
                rounding(-roundingX, roundingY, 270, roundingR, totalCubeHeight + 2);
                rounding(-roundingX, -roundingY, 0, roundingR, totalCubeHeight + 2);
                
                rounding(roundingX + totalCubeDims, roundingY + totalCubeDims, 0, totalCubeDims * rounding, totalCubeHeight + 2);
                rounding(roundingX + totalCubeDims, -roundingY - totalCubeDims, 270, totalCubeDims * rounding, totalCubeHeight + 2);
                rounding(-roundingX - totalCubeDims, roundingY + totalCubeDims, 90, totalCubeDims * rounding, totalCubeHeight + 2);
                rounding(-roundingX - totalCubeDims, -roundingY - totalCubeDims, 180, totalCubeDims * rounding, totalCubeHeight + 2);
            }
            
            
        }
    }
    
    translate([0, half_height - supportHeight/2, face_depth/2]) {cube([supportWidth,supportHeight,face_depth], center=true);}
    translate([half_height - supportHeight/2, 0, face_depth/2]) {cube([supportHeight,supportWidth,face_depth], center=true);}
    translate([0, -half_height + supportHeight/2, face_depth/2]) {cube([supportWidth,supportHeight,face_depth], center=true);}
    translate([-half_height + supportHeight/2, 0, face_depth/2]) {cube([supportHeight,supportWidth,face_depth], center=true);}
    
    difference() {
        union() {
            cylinder(face_depth, d=recess_diameter*1.3, $fn=64);
            translate([0,0,-face_depth]) {
                cylinder(recess_depth * 1.5, d=magnet_diameter + magnet_tolerance + 2, $fn=64);
            }
        }
        
        translate([0, 0, (-recess_depth -face_depth) * 0.75]) {
            cylinder((recess_depth + face_depth) * 1.5, d=magnet_diameter + magnet_tolerance, $fn=64);
        }
    }
    
    magnetSupportWidth = half_width - (recess_diameter*1.3) / 2;
    translate([recess_diameter / 2 + magnetSupportWidth/2, 0, face_depth-0.5]) {cube([magnetSupportWidth,supportHeight*0.5,1], center=true);}
    translate([-recess_diameter / 2 - magnetSupportWidth/2, 0, face_depth-0.5]) {cube([magnetSupportWidth,supportHeight*0.5,1], center=true);}
    translate([0, recess_diameter / 2 + magnetSupportWidth/2, face_depth-0.5]) {cube([supportHeight*0.5, magnetSupportWidth,1], center=true);}
    translate([0, -recess_diameter / 2 - magnetSupportWidth/2, face_depth-0.5]) {cube([supportHeight*0.5, magnetSupportWidth,1], center=true);}
    
    
    if (rounding > 0) {
        translate([0, 0, -totalCubeHeight+face_depth]) {
            rounding(half_width, half_height-faceDims, 90, latch_depth, totalCubeHeight);
            rounding(half_width-faceDims, half_height, 270, latch_depth, totalCubeHeight);
            
            rounding(-half_width, half_height-faceDims, 0, latch_depth, totalCubeHeight);
            rounding(-half_width+faceDims, half_height, 180, latch_depth, totalCubeHeight);
            
            rounding(-half_width, -half_height+faceDims, 270, latch_depth, totalCubeHeight);
            rounding(-half_width+faceDims, -half_height, 90, latch_depth, totalCubeHeight);
            
            rounding(half_width, -half_height+faceDims, 180, latch_depth, totalCubeHeight);
            rounding(half_width-faceDims, -half_height, 0, latch_depth, totalCubeHeight);
        }
    }
}

//sock(41.75, 41.75, 36, 36, 28, 28, 9.5, 4, 4, 3, 31, 2, 9.4, 2.6, 5, 0.1, 0.5);