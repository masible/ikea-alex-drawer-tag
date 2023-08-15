use <material-cutter.scad>

module label(w, h) {
    orig_model_size = [ 26, 46, 99 ];
    orig_label_size = [ 89, 36 ];
    cut_x = 1;
    cut_y = orig_label_size[1] - h;
    cut_z = orig_label_size[0] - w;
    assert(cut_x > 0, "Cut is bigger than object");
    assert(cut_y > 0, "Cut is bigger than object");
    object("original/Drawer Tag Centered.stl", orig_model_size, [ cut_x, cut_y, cut_z ]);
}

label(63.5, 33.9);