include <../utils.scad>
include <vitamins.scad>
use <motorbracket.scad>

$fa=1;
$fs=1;

bearing_z_center = 20;
bearing_center_offset = 30;

module bearingring(b=BB608) {
  color("blue") difference() {
    union() {
      hull() {
        translate([0,0,2.5]) cylinder(r=b[1]/2+5,h=5,center=true);
	translate([0,0,7.5]) rotate_extrude(convexity = 10, $fn = 100) translate([b[1]/2+2.5, 0, 0]) circle(r = 2.5);
      }
    }
    union() {
      cylinder(r=b[1]/2-2,h=20,center=true);
      translate([0,0,11]) cylinder(r=b[1]/2+.2,h=18,center=true);
    }
  }
}

module bearingholder(b=BB608) {
  color("blue") difference() {
    union() {
      hull() {
        translate([0,0,2.5]) cylinder(r=b[1]/2+5,h=5,center=true);
	translate([0,0,7.5]) rotate_extrude(convexity = 10, $fn = 100) translate([b[1]/2+2.5, 0, 0]) circle(r = 2.5);
      }
      hull() {
	translate([0,0,2.5]) cylinder(r=b[1]/2+5,h=5,center=true);
	translate([bearing_center_offset-11,0,5]) cube([2,b[1]+10,10],center=true);
      }

      translate([bearing_center_offset,0,10]) rotate([90,0,0]) cylinder(r=10,h=bearing_z_center,center=true);
      translate([bearing_center_offset,0,5]) cube([20,bearing_z_center,10],center=true);
    }
    
    union() {
      cylinder(r=b[1]/2-2,h=20,center=true);
      translate([0,0,11]) cylinder(r=b[1]/2+.2,h=18,center=true);
      translate([bearing_center_offset,0,10]) rotate([90,0,0]) cylinder(r=M10_clearance_radius,h=100,center=true);
    }
  }
}

module motorholder() {
  color("green") union() {
    bearingholder();
    motorbracket();
  }
}

module corner(flip=0) {
  color("white") scale([flip==0?1:-1,1,1]) difference() {
    union() {
      //cube([32,32,32], center=true);
      translate([0,0,15]) cylinder(r=10.5, h=30, center=true);
      translate([-5.75,-13,21]) rotate([0,90,0]) cylinder(r=9, h=32.5, center=true);
      translate([-5.75,-13,10.5]) cube([32.5,18,21],center=true);
      translate([5.25,-5.25,10.5]) cube([10.5,10.5,21],center=true);

      translate([-13,-5.75,9]) rotate([90,0,0]) cylinder(r=9, h=32.5, center=true);
      translate([-13,-5.75,4.5]) cube([18,32.5,9],center=true);
      translate([-5.25,5.25,4.5]) cube([10.5,10.5,9],center=true);
    }
    union() {
      translate([0,0,15]) cylinder(r=M10_clearance_radius,h=40,center=true);
      translate([-7,-13,21]) rotate([0,90,0]) cylinder(r=M8_clearance_radius,h=40,center=true);
      translate([-13,-7,9]) rotate([90,0,0]) cylinder(r=M8_clearance_radius,h=40,center=true);
      for (i=[-1,1]) {
        translate([-5.75+i*3*flip,-13,30]) cylinder(r=2,h=2,center=true);
      }
    }
  }
}

module foot() {
  color("purple") difference() {
    hull() {
      translate([0,0,15]) cylinder(r=11,h=30,center=true);
      translate([0,0,20]) scale([1,1,0.5]) sphere(r=22);
    }
    union() {
      translate([0,0,28]) cylinder(r=M10_nut_radius, h=50, center=true, $fn=6);
      cylinder(r=M10_clearance_radius,h=20,center=true);
      for (r=[0:60:359]) {
	rotate([0,0,r]) translate([23,0,0]) cylinder(r=8,h=100);
      }
    }
  }
}

bearingholder();
translate([0,-40,0]) motorholder();

translate([-40,0,0]) corner();
translate([-50,-40,0]) corner(1);

translate([0,40,0]) foot();

