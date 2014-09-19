include <../utils.scad>

module motorbracket(h=45,bd=22) {
  color("purple") union() {
    difference() {
      union() {
        hull() {
          for (x=[-15.5,15.5],y=[-15.5,15.5]) {
            translate([x,y,h-1]) cylinder(r=5.5,h=2,center=true);
          }
          translate([0,0,1]) cylinder(r=bd/2+5,h=2,center=true);	  
	  
        }
        //translate([0,0,20]) cylinder(r=21.5,h=h,center=true);	  
      }
      union() {
        for (x=[-15.5,15.5],y=[-15.5,15.5]) {
          translate([x,y,h+1.5]) cylinder(r=M3_clearance_radius,h=10,center=true);
          translate([x,y,h/2-4]) cylinder(r=3,h=h,center=true);
        }
        translate([0,0,h/2]) cylinder(r2=18.5,r1=bd/2+2,h=h+1,center=true);

        //cylinder(r=b[1]/2-2,h=20,center=true);
        //translate([0,0,22]) cylinder(r=b[1]/2+.2,h=40,center=true);

	translate([0,0,h/2]) {
	  rotate([90,0,0]) scale([0.75,1.5,1]) cylinder(r=h/4,h=44,center=true);
	  rotate([0,90,0]) scale([1.5,0.75,1]) cylinder(r=h/4,h=44,center=true);
	}
      }
    }
  }
}

motorbracket();