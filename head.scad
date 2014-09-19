include <../richard-extruder/vitamins.scad>
include <../utils.scad>
include <bearings.scad>

$fa=1;
$fs=1;


b=LM10UU;

print=1;

c=11;

hoff=c+8.5+b[1]/2;
zoff=12.5;//b[1]/2+2.5;
xoff=hoff;//b[2]/2;
yoff=hoff;//b[2]/2;

module hotend() {
  color("red") difference() {
    union() {
      cylinder(r=6, h=27, center=true);
      translate([0,0,11]) cylinder(r=8, h=5, center=true);
      translate([0,0,3]) cylinder(r=8, h=2, center=true);
      translate([0,0,-10]) cylinder(r=3,h=50,center=true);

      translate([0,0,-20]) cylinder(r=9,h=12,center=true);

      translate([0,0,-30]) cylinder(r=7,h=7,center=true,$fn=6);
      translate([0,0,-36]) cylinder(r1=1,r2=6,h=5,center=true);
      
    }
    cylinder(r=1.5,h=50,center=true);
  }
}


module half() {
  color("orange") intersection() {
    difference() {
      union() {
	translate([0,yoff,zoff]) {
          rotate([90,0,0]) intersection() {
            cylinder(r=b[1]/2+2.5,h=b[2]+4,center=true);
            translate([0,-b[1]/4,0]) cube([50,b[1],50], center=true);
          }
          translate([0,0,-(b[1]/2+2.5)/2]) cube([b[1]+5,b[2]+4,b[1]/2+2.5], center=true);
	}
	
	hull() {
          translate([0,yoff,3]) cube([b[1]+5,b[2]+4,6],center=true);
	  
          for (x=[hoff-c,hoff+c],y=[hoff-c,hoff+c]) {
            translate([x,y,3]) cylinder(r=5,h=6,center=true);
          }
	}
      }
      union() {
	// bearing cutout
	translate([0,yoff,zoff]) rotate([90,0,0]) {
          hull() {
            cylinder(r=b[0]/2+2,h=b[2]+10,center=true);
            translate([0,10,0]) cylinder(r=b[0]/2+2,h=b[2]+10,center=true);
          }
          cylinder(r=b[1]/2+0.25,h=b[2]+1,center=true);
          cylinder(r=b[1]/2+1,h=b[2]-6,center=true);
	}
	// hotend cutout
	hull() {
          translate([hoff,hoff,0]) cylinder(r=6.2,h=50,center=true);
          translate([hoff+20,hoff,0]) cylinder(r=6.2,h=50,center=true);
	}
	hull() {
          translate([hoff,hoff,27.25]) cylinder(r=8.2,h=50,center=true);
          translate([hoff+20,hoff,27.25]) cylinder(r=8.2,h=50,center=true);
	}
	
	// screw holes
	for (x=[hoff-c,hoff+c],y=[hoff-c,hoff+c]) {
          translate([x,y,0]) cylinder(r=M4_clearance_radius,h=50,center=true);
	}
	
	// zip tie gap
	translate([0,yoff,zoff]) rotate([90,0,0]) bearing(b=[b[1]+4,b[1]+8,5]);
      }
    }
    translate([0,0,100]) cube([200,200,200],center=true);
  }
}

module extruder() {
  color("blue") difference() {
    union() {
      // base
      hull() {
        for (x=[-c,c],y=[-c,c]) {
          translate([x,y,2.5]) cylinder(r=5,h=5,center=true);
        }
      }
      hull() {
        translate([0,-4,15]) cube([20,20,30],center=true);
        //translate([0,0,35]) cube([15,30,30],center=true);
        translate([0,-6,30]) rotate([0,90,0]) cylinder(r=12,h=20,center=true);
      
	// screw hole surrounds
	for (z=[-15,15]) {
          translate([0,-11,30+z]) rotate([0,90,0]) cylinder(r=5,h=20,center=true);	
	}
      }
    }
    union() {
      // base nut traps/holes
      for (x=[-c,c],y=[-c,c]) {
        translate([x,y,0]) cylinder(r=M4_clearance_radius,h=10,center=true);
        translate([x,y,6]) cylinder(r=M4_nut_radius,h=8,center=true,$fn=6);
      }

      // filament hole
      cylinder(r=1.75,h=200,center=true);
      cylinder(r=8,h=6,center=true);

      // gear hole
      translate([0,-6,30]) rotate([0,90,0]) cylinder(r=6.5,h=100,center=true);
      translate([0,12,30]) rotate([0,90,0]) {
        cylinder(r=12,h=9,center=true);
        cylinder(r=6,h=100,center=true);
      }

      // screw holes
      for (z=[-15,15]) {
        translate([0,-11,30+z]) rotate([0,90,0]) cylinder(r=M3_clearance_radius,h=25,center=true);	
      }
      translate([-7,-11,45]) rotate([0,90,0]) cylinder(r=6,h=20,center=true);	
    }
  }
}

module idler() {
  color("green") difference() {
    union() {
      hull() {
	for (z=[-15,7]) {
	  translate([0,12,30+z]) rotate([0,90,0]) cylinder(r=5,h=19,center=true);
	}
	translate([0,13,30]) rotate([0,90,0]) cylinder(r=6,h=19,center=true);	
      }
      hull() {
	for (z=[-15,23]) {
	  translate([0,9.5,30+z]) rotate([0,90,0]) cylinder(r=2.5,h=19,center=true);
	}
      }
    }
    union() {
      // idler cutout
      difference() {
	hull() {
	  for (y=[0,12]) {
	    translate([0,y,30]) rotate([0,90,0]) {
	      cylinder(r=12,h=8,center=true);
	    }
	  }
	}
	union() {
	  for (x=[-8,8]) {
	    hull() {
	      for (y=[0,12]) {
		translate([x,y,30]) rotate([0,90,0]) {
		  cylinder(r=5,h=10,center=true);
		}
	      }
	    }
	  }
	}
      }
      hull() {
	for (y=[0,12]) {
	  translate([0,y,30]) rotate([0,90,0]) {
	    //bearing(b=[8,24,8]);
	    cylinder(r=4,h=15,center=true);
	  }
	}
      }
      // pivot screw
      translate([0,12,15]) rotate([0,90,0]) cylinder(r=M3_clearance_radius,h=25,center=true);
      // tensioner screw
      hull() {
	translate([-3,12,48]) rotate([90,0,0]) cylinder(r=2,h=50,center=true);
	translate([-3,12,55]) rotate([90,0,0]) cylinder(r=2,h=50,center=true);
      }
    }
  }
}

module pivot() {
  color("purple") difference() {
    hull() {
      translate([-3,-11,45]) rotate([0,90,0]) cylinder(r=5,h=10,center=true);
      translate([-3,-11,49]) rotate([90,0,0]) cylinder(r=5,h=10,center=true);
    }
    
    union() {
      translate([-3,-11,45]) rotate([0,90,0]) cylinder(r=M3_clearance_radius,h=12,center=true);
      translate([-3,-11,49]) rotate([90,0,0]) cylinder(r=M3_clearance_radius,h=12,center=true);
    }
  }
}

module side() {
  color("white") translate([-12.5,0,0]) {
    difference() {
      hull() {
	translate([0,-6,30]) rotate([0,90,0]) cylinder(r=12,h=5,center=true);
	// screw hole surrounds
	for (z=[-15,15]) {
	  translate([0,-11,30+z]) rotate([0,90,0]) cylinder(r=5,h=5,center=true);	
	}
	translate([0,12,15]) rotate([0,90,0]) cylinder(r=5,h=5,center=true);	
      }
      union() {
	for (z=[-15,15]) {
	  translate([0,-11,30+z]) rotate([0,90,0]) cylinder(r=M3_clearance_radius,h=10,center=true);	
	}
	translate([0,12,15]) rotate([0,90,0]) cylinder(r=M3_clearance_radius,h=10,center=true);	
	translate([-2,-6,30]) rotate([0,90,0]) cylinder(r=5.2,h=5,center=true);	
	translate([0,-6,30]) rotate([0,90,0]) cylinder(r=4,h=10,center=true);	
      }
    }
  }
}

module motorholder() {
  color("cyan") translate([12.5,0,0]) {
    difference() {
      hull() {
	translate([0,-6,30]) rotate([0,90,0]) cylinder(r=12,h=5,center=true);
	// screw hole surrounds
	for (z=[-15,15]) {
	  translate([0,-11,30+z]) rotate([0,90,0]) cylinder(r=5,h=5,center=true);	
	}
	translate([0,12,15]) rotate([0,90,0]) cylinder(r=5,h=5,center=true);	

	for (y=[-15,15],z=[-13,13]) {
	  translate([0,y-43,35+z]) rotate([0,90,0]) cylinder(r=5,h=5,center=true);	
	}
      }
      union() {
	for (z=[-15,15]) {
	  translate([0,-11,30+z]) rotate([0,90,0]) cylinder(r=M3_clearance_radius,h=10,center=true);	
	}
	translate([0,12,15]) rotate([0,90,0]) cylinder(r=M3_clearance_radius,h=10,center=true);	
	translate([2,-6,30]) rotate([0,90,0]) cylinder(r=5.2,h=5,center=true);	
	translate([0,-6,30]) rotate([0,90,0]) cylinder(r=4,h=10,center=true);	

	// motor screw holes
	for (y=[-13,13],z=[-13,13]) {
	  hull() {
	    translate([0,y-41,35+z]) rotate([0,90,0]) cylinder(r=M3_clearance_radius,h=10,center=true);
	    translate([0,y-45,35+z]) rotate([0,90,0]) cylinder(r=M3_clearance_radius,h=10,center=true);
	  }
	}
	hull() {
	  translate([0,-41,35]) rotate([0,90,0]) cylinder(r=11.5,h=10,center=true);
	  translate([0,-45,35]) rotate([0,90,0]) cylinder(r=11.5,h=10,center=true);
	}

      }
    }
  }
}

if (print == 1) {
  half();
  translate([0,-40,0]) half();
  translate([-35,-10,0]) extruder();
  translate([-75,20,-7]) rotate([90,0,90]) idler();
  translate([-75,50,2]) rotate([0,90,0]) pivot();
  translate([-75,-50,-10]) rotate([0,90,0]) side();
  translate([-20,-20,-10]) rotate([0,-90,90]) motorholder();
} else {
  half();
  rotate([180,0,90]) half();
  
  translate([xoff,yoff,6]) {
    extruder();
    idler();
    pivot();
    side();
    motorholder();
  }
  
  // bearings/hotend/etc..
  %translate([0,yoff,zoff]) rotate([90,0,0]) bearing(b);
  %translate([xoff,0,-zoff]) rotate([0,90,0]) bearing(b);
  translate([hoff,hoff,-6.25]) hotend();
  
  // cableties
  %translate([0,yoff,zoff]) rotate([90,0,0]) bearing(b=[b[1]+5,b[1]+7,3]);
  %translate([xoff,0,-zoff]) rotate([0,90,0]) bearing(b=[b[1]+5,b[1]+7,3]);
  
  // rods
  %translate([0,0,zoff]) rotate([90,0,0]) cylinder(r=b[0]/2,h=300,center=true);
  %translate([0,0,-zoff]) rotate([0,90,0]) cylinder(r=b[0]/2,h=300,center=true);

  // extruder gear
  %translate([0,-6,30]) rotate([0,90,0]) bearing(b=[5,11,11]);
  // idler bearing
  %translate([0,12,30]) rotate([0,90,0]) {
    bearing(b=[8,22,7]);
    cylinder(r=4,h=15,center=true);
  }
  // large drive gear
  %translate([25,-6,30]) rotate([0,90,0]) {
    bearing(b=[5,60,10]);
    translate([0,0,-25]) cylinder(r=2.5,h=60,center=true);
  }
  // motor and small drive gear
  %translate([-10,-43,35]) rotate([0,90,0]) motor(NEMA14);
  %translate([21,-43,35]) rotate([0,90,0]) bearing(b=[5,19,18]);

  %translate([-3,0,49]) rotate([90,0,0]) cylinder(r=1.5,h=50,center=true);
}