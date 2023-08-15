// SPDX-License-Identifier: GPL-3-or-later
//
// Cut material in the middle of the model in each of the direction
//
// To cut 1mm of material in each direction from a 10x10x10 model:
//
// use <material-cutter.scad>
// object("path_to_stl.stl", [ 10, 10, 10 ], [ 1, 1, 1]);

model_path = "original/Drawer Tag Centered.stl";

// The size of the object to cut
object_size = [ 26, 46, 99 ];

// Amount to cut in each direction
cut_size = [ 1, 2.1, 25.5 ];

// cut x
module module_x(path, obj, cut) {
    union() {
        translate([-cut[0]/2, 0, 0])
        intersection() {
            import(path, convexity=10);
            translate([(obj[0] + cut[0]) / 2, 0, obj[2] /2])
            cube([obj[0], obj[1], obj[2]], center=true);
        }
    
        translate([cut[0]/2, 0, 0])
        intersection() {
            import(path, convexity=10);
            translate([-(obj[0] + cut[0]) / 2, 0, obj[2] /2])
            cube([obj[0], obj[1], obj[2]], center=true);
        }
    }
}

module module_y(path, obj, cut) {
    union() {
        translate([0, -cut[1]/2, 0])
        intersection() {
            module_x(path, obj, cut);
            translate([0, (obj[1] + cut[1]) / 2, obj[2] /2])
            cube([obj[0], obj[1], obj[2]], center=true);
        }
    
        translate([0, cut[1]/2, 0])
        intersection() {
            module_x(path, obj, cut);
            translate([0, -(obj[1] + cut[1]) / 2, obj[2] /2])
            cube([obj[0], obj[1], obj[2]], center=true);
        }
    }
}

module module_z(path, obj, cut) {
    union() {
        translate([0, 0, -cut[2]])
        intersection() {
            module_y(path, obj, cut);
            translate([0, 0, (obj[2] *2 + cut[2]) / 2])
            cube([obj[0], obj[1], obj[2]], center=true);
        }

        intersection() {
            module_y(path, obj, cut);
            translate([0, 0, -cut[2] / 2])
            cube([obj[0], obj[1], obj[2]], center=true);
        }
    }
}

module object(path, obj, cut) {
    assert(cut[0] < obj[0], "Cut is bigger than object");
    assert(cut[1] < obj[1], "Cut is bigger than object");
    assert(cut[2] < obj[2], "Cut is bigger than object");
    module_z(path, obj, cut);
}

object(model_path, object_size, cut_size);