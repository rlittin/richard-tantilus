include <vitamins.scad>
include <../utils.scad>

$fa=1;
$fs=1;

extruder_spline = [5,11,11]; // ID,OD,W

filament = 3; // diameter mm
hotend = 16; // diameter

filament_offset = filament/2 + extruder_spline[2]/2 - 0.5;

module base() {
  rotate([-90,0,0]) difference() {
    union() {
      cube([60,20,10], center=true);
    }
    union() {
      for (x=[-25,25]) {
        translate([x,0,-6]) polyhole(r=M4_clearance_radius, h=12);
        translate([x,0,5]) cylinder(r=M4_nut_radius, h=8, center=true, $fn=6);
      }
      //cylinder(r=filament/2, h=25, center=true);
      translate([0,0,-5]) cylinder(r=hotend/2, h=10, center=true);

    }
  }
}

module body() {
  difference() {
    union() {
    hull() {
      for (x=[-16,16],y=[-16,16]) {
        translate([x,y,0]) cylinder(r=5, h=20, center=true);
      }
    }
    translate([-5,23,0]) cube([10,12,20],center=true);

    translate([filament_offset,-30,0]) base();
    translate([filament_offset-5,-24,0]) cube([30,10,20],center=true);
    }
    union() {
      // screw holes
      for (x=[-15.5,15.5],y=[-15.5,15.5]) {
        translate([x,y,-15]) polyhole(r=M3_clearance_radius, h=30, center=true);
      }
      // filament hole
      translate([filament_offset,0,0]) rotate([90,0,0]) cylinder(r=filament/2, h=100, center=true);
      // shaft hole
      cylinder(r=extruder_spline[1]/2+1, h=50, center=true);
      // cutout for motor
      translate([-35,0,0,]) rotate([0,0,45]) hull() {
        for (x=[-16,16],y=[-16,16]) {
          translate([x,y,0]) cylinder(r=5, h=50, center=true);
        }
      }
      // idler bearing
      translate([filament_offset+filament/2+BB608[1]/2-0.5,0,0]) cylinder(r=BB608[1]/2+1.1, h=BB608[2]+2, center=true);
      //
      translate([15.5,10,0]) cube([12,50,22], center=true);
      translate([15.5,-16,0]) cylinder(r=6, h=30, center=true);

      // tensioner screw hole
    translate([-25,24,3]) rotate([0,90,0]) polyhole(r=M4_clearance_radius,h=50,center=true);
      
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
        translate([shaft_offset,0,0]) cylinder(r=8, h=20, center=true);
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
        translate([0,22,3]) rotate([0,90,0]) cylinder(r=1.6, h=20, center=true);
        translate([0,32,3]) rotate([0,90,0]) cylinder(r=1.6, h=20, center=true);
      }
    }
  }
}

module front_plate() {
  difference() {
    hull() {
      for (x=[-16,6],y=[-16,16]) {
        translate([x,y,0]) cylinder(r=5, h=4, center=true);
      }
      translate([16,-16,0]) cylinder(r=5, h=4, center=true);
    }
    union() {

      // screw holes
      for (x=[-15.5,15.5],y=[-15.5,15.5]) {
        translate([x,y,-15]) polyhole(r=M3_clearance_radius, h=30, center=true);
      }
      // shaft hole
      cylinder(r=3, h=50, center=true);
      // bearing
      translate([0,0,2]) cylinder(r=BB105[1]/2, h=4, center=true);
      // cutout for motor
      translate([-35,0,0,]) rotate([0,0,45]) hull() {
        for (x=[-16,16],y=[-16,16]) {
          translate([x,y,0]) cylinder(r=5, h=50, center=true);
        }
      }
    }
  }
}

//motor(NEMA17);
translate([0,0,10]) body();

translate([25,5,5]) rotate([0,-90,0]) idler_holder();
/*
%translate([filament_offset+filament/2+BB608[1]/2-0.5,0,0]) {
  bearing(BB608);
  cylinder(r=4,h=16,center=true);
}
*/

translate([-40,15,2]) front_plate();