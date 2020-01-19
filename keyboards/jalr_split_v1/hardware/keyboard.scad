kerf = 0.1;

// module copied from https://github.com/technomancy/atreus
module switch_hole(position, notches=true) {
  /* Cherry MX switch hole with the center at `position`. Sizes come
     from the ErgoDox design. */
  hole_width   = 13.7-kerf;
  hole_height  = 13.92-kerf;
  notch_width  = 3.5001;
  notch_offset = 4.2545;
  notch_depth  = 0.3;
  translate(position) {
    union() {
      square([hole_width, hole_height], center=true);
      if (notches == true) {
        for(y=[-notch_offset, notch_offset]) {
            translate([0, y])
                square([hole_width+2*notch_depth, notch_width], center=true);
        }
      }
    }
  }
};

// 18.5x18.5
// 12x12
// 7.5

cap_w = 18.5;
cap_h = 18.5;
tr_2nd = 30;
with_caps = true;

border_x = 4.2;
border_y = 4.2;

// left half
translate([(1.5*cap_w)/2,-cap_h/2]) {
    cap(0,5,1.5,1);
    for (i=[0:4]) {
        cap(1.25+i,5,1,1);
    }
    for (n=[4:2]) {
        cap(0,n,1.5,1);
        for (i=[0:4]) {
            cap(1.25+i,n,1,1);
        }
    }
    for (i=[0:2]) {
        cap(i*1.5,1,1.5,1);
    }
    cap(4.75,1,2,1);
}

// right half
translate([(1.5*cap_w)/2+tr_2nd,-cap_h/2]) {
    for (i=[5:12]) {
        cap(1.25+i,5,1,1);
    }
    for (n=[4:3]) {
        for (i=[5:10]) {
            cap(1.25+i,n,1,1);
        }
        cap(12.75,n,2,1);
    }
    for (i=[5:9]) {
        cap(1.25+i,2,1,1);
    }
    cap(12.25,2,3,1);
    
    cap(6.75,1,2,1);
    cap(8.5,1,1.5,1);
    cap(10,1,1.5,1);
    for (i=[10:12]) {
        cap(1.25+i,1,1,1);
    }
}

// left half
difference() {
    union() {
        translate([-border_x, -border_y])
        square([120.5+2*border_x, 92.5+2*border_y]);
    }
    union() {
        translate([(1.5*cap_w)/2,-cap_h/2]) {
            switch_hole(position=[0, 5*cap_h]);
            for (i=[0:4]) {
                switch_hole(position=[1.25*cap_w + cap_w*i, 5*cap_h]);
            }
            for (n=[4:2]) {
                switch_hole(position=[0, n*cap_h]);
                for (i=[0:4]) {
                    switch_hole(position=[1.25*cap_w + cap_w*i, n*cap_h]);
                }
            }
            for (i=[0:2]) {
                switch_hole(position=[i*1.5*cap_w, cap_h]);
            }
            switch_hole(position=[4.75*cap_w, cap_h]);
            bar_holes([4.75*cap_w, cap_h], 23.6);
        }
    }
}

// right half
difference() {
    union() {
        translate([120.5+tr_2nd-border_x, -border_y])
            square([148+2*border_x, 92.5+2*border_y]);
    }
    union() {
        translate([(1.5*cap_w)/2+tr_2nd,-cap_h/2]) {
            for (i=[5:12]) {
                switch_hole(position=[1.25*cap_w + cap_w*i, 5*cap_h]);
            }
            for (n=[4:3]) {
                for (i=[5:10]) {
                    switch_hole(position=[1.25*cap_w + cap_w*i, n*cap_h, 0]);
                }
                switch_hole(position=[12.75*cap_w, n*cap_h]);
                bar_holes([12.75*cap_w, n*cap_h], 23.6);
            }
            for (i=[5:9]) {
                switch_hole(position=[1.25*cap_w + cap_w*i, 2*cap_h, 0]);
            }
            switch_hole(position=[12.25*cap_w, 2*cap_h]);
            bar_holes([12.25*cap_w, 2*cap_h], 38);

            switch_hole(position=[6.75*cap_w, cap_h]);
            bar_holes([6.75*cap_w, cap_h], 23.6);
            switch_hole(position=[7.5*cap_w + cap_w, 1*cap_h]);
            switch_hole(position=[9*cap_w + cap_w, 1*cap_h]);
            for (i=[10:12]) {
                switch_hole(position=[1.25*cap_w + cap_w*i, 1*cap_h]);
            }
        }
    }
}
module cap(tx, ty, nx, ny) {
    %if (with_caps) {
        l1 = cap_w*nx;
        b1 = cap_h*ny;
        l2 = l1-6;
        b2 = b1-6;
        translate([cap_w*tx, cap_h*ty]) {
            linear_extrude(height=7.5, scale=[l2/l1,b2/b1]) {
                #square([l1, b1], center=true);
            }
        }
    }
}

module bar_holes(position, bar_dx) {
    /*
    bar_dy = 15;
    translate(position) for(x=[-bar_dx/2, bar_dx/2]) {
        hull()
            for (y=[-0.4,0.4])
                translate([x, y+bar_dy/2])
                    circle(d=3, $fn=20);
        translate([x,-bar_dy/2]) circle(d=3, $fn=20);
    }
    */
    translate(position) for(x=[-bar_dx/2, bar_dx/2]) {
        translate([x, 0])
            square([6.7-kerf, 11-kerf], center=true);
    }
}
