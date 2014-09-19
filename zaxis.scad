include <../utils.scad>
include <vitamins.scad>
use <bearingholder.scad>
use <motorbracket.scad>

module clamp() {
  color("red") difference() {
    union() {
      translate([9,0,9]) rotate([90,0,0]) hull() {
	cylinder(r=9,h=118,center=true);
	translate([0,-4.5,0]) cube([18,9,118],center=true);
      }
      for (y=[-50,50]) {
 	translate([33,y,9]) rotate([0,90,0]) hull() {
	  cylinder(r=9,h=30,center=true);
	  translate([4.5,0,0]) cube([9,18,30],center=true);
	}

	// clamp screw surrounds
	hull() {
	for (x=[26,40]) {
          translate([x,y,18]) sphere(r=6);
	}
	}
      }
      difference() {
	translate([33,0,3]) cube([30,84,6],center=true);
	translate([48,0,3]) cylinder(r=41,h=8,center=true);
      }
    }
    union() {
      translate([9,0,9]) rotate([90,0,0]) cylinder(r=M8_clearance_radius,h=120,center=true);
      for (y=[-50,50]) {
	translate([33,y,9]) rotate([0,90,0]) cylinder(r=M8_clearance_radius,h=31,center=true);
	translate([33,y,19]) cube([31,2,20],center=true);

	//translate([18.5,y,19]) cube([1,20,20],center=true);

	// clamp screwholes
	for (x=[26,40]) {
	  translate([x,y,18]) rotate([90,0,0]) union() {
	    cylinder(r=M3_clearance_radius,h=20,center=true);
	    translate([0,0,-y/5]) cylinder(r=3,h=11,center=true);
	    translate([0,0,y/5]) cylinder(r=M3_nut_radius,h=11,center=true,$fn=6);	  
	  }
	}
      }
      // cutout??
      translate([0,0,56]) rotate([0,90,0]) cylinder(r=50,h=40,center=true);
    }
  }
}

module topclamp() {
  color("cyan") difference() {
    union() {
      clamp();
      hull() {
	translate([30,0,3]) cylinder(r=10,h=6,center=true);
	translate([17,0,3]) cube([1,40,6],center=true);
      }
      translate([30,0,8]) cylinder(r2=7.5,r1=10,h=4,center=true);
    }
    union() {
      translate([30,0,0]) cylinder(r=M5_clearance_radius,h=30,center=true);
    }
  }
}

module bottomclamp() {
  color("yellow") difference() {
    union() {
      clamp();
      translate([35,0,0]) {
	bearingring();
      }
      hull() {
	translate([17,0,3]) cube([1,50,6],center=true);
	translate([35,0,3]) cylinder(r=BB608[1]/2+5,h=6,center=true);
      }
    }
    union() {
      translate([35,0,0]) {
	cylinder(r=BB608[1]/2-2,h=20,center=true);
	translate([0,0,11]) cylinder(r=BB608[1]/2+.2,h=18,center=true);
      }
    }
  }
}

module bottomclampmotor() {
  color("orange") difference() {
    union() {
      bottomclamp();
      translate([35,0,0]) {
	motorbracket();
      }
      // endstop sensor bracket
      hull() {
	translate([43,-30,12.5]) cube([10,10,25],center=true);
	translate([33,-30,3]) cube([30,10,6],center=true);
      }
    }
    union() {
      translate([35,0,0]) {
	for (y=[-15.5,15.5]) {
	  translate([-15,y,3]) cylinder(r=2,h=10,center=true);
	}
      }
      // endstop sensor holes
      for (z=[-9.5,9.5]) {
	translate([43,-30,12.5+z]) rotate([0,90,0]) cylinder(r=1.25,h=20,center=true);
      }
    }
  }
}

module platform() {
  color("magenta") difference() {
    union() {
      for (y=[-50,50]) {
	//bearing holder
	translate([0,y,LM8UU[2]/2]) cylinder(r=LM8UU[1]/2+5,h=LM8UU[2],center=true);
	// outer legs
	hull() {
	  translate([0,y,2.5]) cylinder(r=LM8UU[1]/2+5,h=5,center=true);
	  translate([70,y*7/5,2.5]) cylinder(r=7,h=5,center=true);
	}
	hull() {
	  translate([0,y,LM8UU[2]/2]) cylinder(r=2.5,h=LM8UU[2],center=true);
	  translate([70,y*7/5,2.5]) cylinder(r=2.5,h=5,center=true);
	}
	translate([70,y*7/5,5]) cylinder(r=7,h=10,center=true);

	// inner legs
	hull() {
	  translate([0,y,2.5]) cylinder(r=LM8UU[1]/2+5,h=5,center=true);
	  translate([50,3*y/5,2.5]) cylinder(r=7,h=5,center=true);
	}
	hull() {
	  translate([0,y,LM8UU[2]/2]) cylinder(r=2.5,h=LM8UU[2],center=true);
	  translate([50,y*3/5,2.5]) cylinder(r=2.5,h=5,center=true);
	}
	translate([50,y*3/5,5]) cylinder(r=7,h=10,center=true);	

	// clamp screw surrounds
        translate([-10,y,LM8UU[2]/2]) sphere(r=7);
      }

      // joiner between bearings
      translate([5,0,LM8UU[2]/2]) cube([6,100,LM8UU[2]], center=true);
    }
    union() {
      for (y=[-50,50]) {
	// bearing holes
	translate([0,y,LM8UU[2]/2]) cylinder(r=LM8UU[1]/2,h=LM8UU[2]+2,center=true);
	// screw holes/nut traps
      	translate([70,y*7/5,10]) {
	  cylinder(r=M4_nut_radius,h=10,center=true,$fn=6);
	  cylinder(r=M4_clearance_radius,h=30,center=true);
	}
      	translate([50,y*3/5,10]) {
	  cylinder(r=M4_nut_radius,h=10,center=true,$fn=6);
	  cylinder(r=M4_clearance_radius,h=30,center=true);
	}

	// clamp cutout
	translate([-20,y,LM8UU[2]/2]) cube([40,2,50],center=true);

	// clamp screwholes
	translate([-10,y,LM8UU[2]/2]) rotate([90,0,0]) union() {
	  cylinder(r=M3_clearance_radius,h=20,center=true);
	  translate([0,0,-y/5]) cylinder(r=3,h=10,center=true);
	  translate([0,0,y/5]) cylinder(r=M3_nut_radius,h=10,center=true,$fn=6);	  
	}

      }
    }
  }
}

/*
translate([131,0,150]) rotate([0,90,0]) topclamp();
translate([-131,0,150]) rotate([0,90,180]) topclamp();
translate([131,0,-150]) rotate([0,-90,180]) bottomclampmotor();
translate([-131,0,-150]) rotate([0,-90,0]) bottomclamp();
translate([140,0,0]) rotate([0,180,0]) platform();
translate([-140,0,0]) rotate([0,180,180]) platform();
*/


//translate([-180,0,0]) clamp();

topclamp();
translate([-60,0,0]) bottomclamp();
translate([-120,0,0]) bottomclampmotor();
translate([70,0,0]) platform();
