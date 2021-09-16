include <sock.scad>
include <motor.scad>

tolerance = 0.5;

// Motor Params
// ------------

// NEMA17
motor_width = 41.75;
motor_height = 41.75;
motor_housing_minor_width = 36;
motor_housing_minor_height = 36;
motor_coil_minor_width = 28;
motor_coil_minor_height = 28;
motor_socket_height = 4.4;
motor_socket_width = 16;
motor_housing_depth = 9.5;
motor_coil_depth = 15;
motor_screw_spacing = 31;
motor_recess_diameter = 9;
motor_recess_depth = 2.6;


// Sock Params
// -----------
sock_latch_depth = 4;
sock_latch_overhang = 3;
sock_face_depth = 3;

// Board Params
// ------------

// Magnetic sensor board v0.2
board_min_height = 2.5;

// Magnet Params
// -------------
magnet_diameter = 5.95;
magnet_tolerance = 0.5;

// Misc Params
// -----------
screw_diameter = 2;
rounding = 0.2;

assert(sock_face_depth > board_min_height, "sock_face_depth must be greater than board_min_height");

difference() {
    sock(motor_width, 
         motor_height, 
         motor_housing_minor_width, 
         motor_housing_minor_height,
         motor_coil_minor_width,
         motor_coil_minor_height,
         motor_housing_depth,
         sock_latch_depth,
         sock_latch_overhang,
         sock_face_depth,
         motor_screw_spacing,
         screw_diameter,
         motor_recess_diameter,
         motor_recess_depth,
         magnet_diameter,
         magnet_tolerance,
         rounding
    );

    motor(motor_width + tolerance, 
          motor_height + tolerance, 
          motor_housing_minor_width, 
          motor_housing_minor_height,
          motor_coil_minor_width,
          motor_coil_minor_height,
          motor_socket_height + tolerance,
          motor_socket_width + tolerance,
          motor_housing_depth + tolerance,
          motor_coil_depth,
          motor_recess_diameter + tolerance,
          motor_recess_depth + tolerance
    );
    
    
    
    
    //translate([-40, -40, -50]) {
    //    cube([40, 80, 100]);
    //}
    //translate([-40, -40, -50]) {
    //    cube([80, 40, 100]);
    //}
}
