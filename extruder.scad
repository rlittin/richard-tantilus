include <vitamins.scad>
include <../utils.scad>
use <motor_plate.scad>

$fa=1;
$fs=1;

//extruder_spline = [5,7.5,15]; // ID,OD,W
extruder_spline = [5,11,11]; // ID,OD,W

filament = 3; // diameter mm
hotend = 16; // diameter

filament_offset = filament/2 + extruder_spline[1]/2 - 0.5;

module base() {
  rotate([-90,0,0]) difference() {
    union() {
      translate([0,-2,1]) cube([60,24,10], center=true);
      //translate([0,0,2]) cube([34,20,8], center=true);
      //intersection() {
        //cylinder(r=13, h=8, center=true);
        //translate([0,-5,0]) cube([25,25,10], center=true);
      //}
    }
    union() {
      for (x=[-25,25]) {
        translate([x,0,-6]) polyhole(r=M4_clearance_radius, h=12);
        translate([x,0,5]) cylinder(r=M4_nut_radius, h=8, center=true, $fn=6);
      }
      //cylinder(r=filament/2, h=25, center=true);
      translate([0,0,-4]) cylinder(r=hotend/2, h=8, center=true);
/*
      for (r=[30:120:359]) {
        rotate([0,0,r]) {
          translate([10.5,0,-5]) polyhole(r=M3_clearance_radius,h=10);
          translate([10.5,0,5]) cylinder(r=M3_nut_radius, h=6, center=true, $fn=6);
        }
        translate([0,-14,5]) cube([6,10,6], center=true);
        translate([-10.5*sin(60),10,5]) cube([6,10,6], center=true);
      }
      */
      translate([0,-30,0]) cylinder(r=20,h=100,center=true);
    }
  }
}

module body() {
  difference() {
    union() {
      cube([20,42,20], center=true);

//      translate([-5,23,0]) cube([10,12,20],center=true);

      translate([filament_offset,-26.75,0]) base();
//    translate([filament_offset-5,-24,0]) cube([30,10,20],center=true);
    }
    union() {
      // screw holes
      for (x=[-5,15.5],y=[-15.5,15.5]) {
        translate([x,y,-15]) polyhole(r=M3_clearance_radius, h=30, center=true);
      }
      // filament hole
      translate([filament_offset,0,0]) rotate([90,0,0]) cylinder(r=filament/2, h=100, center=true);
// for alex's extruder nozzle
      translate([filament_offset,-20.5,0]) rotate([90,0,0]) cylinder(r=6, h=13, center=true);

      // shaft hole
      translate([0,0,0]) cylinder(r=extruder_spline[1]/2+2, h=22, center=true);

      //translate([0,0,-10]) cylinder(r=8, h=14, center=true);

      // idler bearing
      translate([filament_offset+filament/2+BB608[1]/2-0.5,0,0]) cylinder(r=BB608[1]/2+1.1, h=BB608[2]+2, center=true);

      // tensioner screw hole
      //translate([-25,24,3]) rotate([0,90,0]) polyhole(r=M3_clearance_radius,h=50,center=true);
      //translate([-25,0,3]) rotate([-45,90,0]) polyhole(r=M3_clearance_radius,h=50,center=true);
      translate([-5,15.5,6]) cylinder(r=5.5,h=12,center=true);
      translate([-5,21,6]) cube([11,11,12],center=true);
      translate([-10.5,15.5,6]) cube([11,11,12],center=true);

      // corner of motor
      translate([-13.5,0,0]) cylinder(r=5.75,h=50,center=true);
    }    
  }
}

module tensioner_pivot() {
  difference() {
    union() {
      cylinder(r=5,h=9,center=true);
      translate([0,6,0]) cube([10,12,9],center=true);
    }
    union() {
      translate([-25,7,-1.5]) rotate([0,90,0]) polyhole(r=M3_clearance_radius,h=50,center=true);
      translate([0,0,-25]) polyhole(r=M3_clearance_radius,h=50,center=true);
    }
  }
}

shaft_offset = filament_offset+filament/2+BB608[1]/2-0.5-15.5;
module idler_holder() {
  difference() {
    union() {
      hull() {
        translate([0,15.5,0]) cube([10,10,20], center=true);
        translate([0,-15.5,0]) cylinder(r=5, h=20, center=true);
        translate([shaft_offset,0,0]) intersection() {
          cylinder(r=8, h=20, center=true);
          translate([50,0,0]) cube([100,100,100],center=true);
        }
      }
      translate([0,24,3])cube([10,10,12],center=true);
    }
    union() {
      translate([shaft_offset,0,0]) difference() {
      hull() {
        cylinder(r=BB608[1]/2+1, h=BB608[2]+2, center=true);
        translate([-10,0,0]) cylinder(r=BB608[1]/2+1, h=BB608[2]+2, center=true);
      }
      translate([shaft_offset,0,0]) hull() {
        cylinder(r=5.5, h=16, center=true);
        translate([-10,0,0]) cylinder(r=5.5, h=16, center=true);
      }

      }
      translate([shaft_offset,0,0]) hull() {
        cylinder(r=4, h=16, center=true);
        translate([-10,0,0]) cylinder(r=4, h=16, center=true);
      }
      translate([shaft_offset,0,0]) cylinder(r=BB608[1]/2, h=BB608[2]+0.5, center=true);
      translate([0,-15.5,-15]) polyhole(r=M3_clearance_radius, h=30);
//translate([0,-15.5,-10]) cylinder(r=5.5, h=6, center=true);
      hull() {
        translate([0,22,3]) rotate([0,90,0]) cylinder(r=1.75, h=20, center=true);
        translate([0,32,3]) rotate([0,90,0]) cylinder(r=1.75, h=20, center=true);
      }
    }
  }
}

module front_plate() {
  difference() {
    hull() {
      for (x=[-5,6],y=[-16,16]) {
        translate([x,y,0]) cylinder(r=5, h=6, center=true);
      }
      translate([16,-16,0]) cylinder(r=5, h=6, center=true);
    }
    union() {

      // screw holes
      for (x=[-5,15.5],y=[-15.5,15.5]) {
        translate([x,y,-15]) polyhole(r=M3_clearance_radius, h=30, center=true);
      }
      // shaft hole
      cylinder(r=3, h=50, center=true);
      // bearing
      translate([0,0,3]) cylinder(r=BB105[1]/2, h=4, center=true);
      // corner of motor
      translate([-13.5,0,0]) cylinder(r=6,h=50,center=true);
    }
  }
}

//motor(NEMA17);
translate([0,0,10]) body();

translate([25,3,5]) rotate([0,-90,0]) idler_holder();
translate([-40,10,3]) front_plate();
translate([-40,-25,4.5]) tensioner_pivot();
translate([10,-60,4]) plate(NEMA17, BB105);

