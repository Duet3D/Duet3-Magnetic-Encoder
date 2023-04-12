include <sector.scad>

module motor(width, 
             height, 
             housing_minor_width, 
             housing_minor_height,
             coil_minor_width,
             coil_minor_height,
             socket_height,
             socket_width,
             housing_depth,
             coil_depth,
             recess_diameter,
             recess_depth) {
                 
    half_height = height / 2;
    half_width = width / 2;
    half_housing_minor_height = housing_minor_height / 2;
    half_housing_minor_width = housing_minor_width / 2;
    half_socket_width = socket_width / 2;
    
    difference() {
        translate([0,0,-housing_depth + 0.001]) {
            linear_extrude(height=housing_depth) {
                polygon([
                    [half_housing_minor_width, half_height],
                    [half_width, half_housing_minor_height],
                
                    [half_width, -half_housing_minor_height],
                    [half_housing_minor_width, -half_height],
                
                    [half_socket_width, -half_height],
                    [half_socket_width, -half_height-socket_height],
                
                    [-half_socket_width, -half_height-socket_height],
                    [-half_socket_width, -half_height],
                    
                    [-half_housing_minor_width, -half_height],
                    [-half_width, -half_housing_minor_height],
                
                    [-half_width, half_housing_minor_height],
                    [-half_housing_minor_width, half_height]
                ]);
                
                housing_radius = sqrt(pow(width / 2, 2) + pow(housing_minor_width / 2, 2));
                startAngle = atan(housing_minor_width / width);
                endAngle = 90 - atan(housing_minor_height / height);
                for (offset=[0:90:270]) {
                    sector(housing_radius, [startAngle + offset, endAngle + offset], fn=500);
                }
            }
        }
        
        translate([0, 0, -recess_depth+0.002]) {
            cylinder(recess_depth, d=recess_diameter, $fn=64);
        }
    }
    
    half_coil_minor_height = coil_minor_height / 2;
    half_coil_minor_width = coil_minor_width / 2;
    
    translate([0,0,-coil_depth-housing_depth + 0.002]) {
        linear_extrude(height=coil_depth) {
            polygon([
                [half_coil_minor_width, half_height],
                [half_width, half_coil_minor_height],
            
                [half_width, -half_coil_minor_height],
                [half_coil_minor_width, -half_height],
                
                [-half_coil_minor_width, -half_height],
                [-half_width, -half_coil_minor_height],
            
                [-half_width, half_coil_minor_height],
                [-half_coil_minor_width, half_height]
            ]);
            
            coil_radius = sqrt(pow(width / 2, 2) + pow(coil_minor_width / 2, 2));
            startAngle = atan(coil_minor_width / width);
            endAngle = 90 - atan(coil_minor_height / height);
            for (offset=[0:90:270]) {
                sector(coil_radius, [startAngle + offset, endAngle + offset], fn=500);
            }
        }
    }
   
}

//motor(41.75, 41.75, 33, 33, 26.8, 26.8, 4.4, 16, 7.9, 15, 9.4, 2.6);