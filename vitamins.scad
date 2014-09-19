$fa=1;
$fs=1;

// motors []
//                       corner  body    boss    boss          shaft
//         side, length, radius, radius, radius, depth, shaft, length, holes
NEMA17  = [42.3, 47,     53.6/2, 25,     11,     2,     5,     24,     31 ];
NEMA14  = [35.2, 35,     46.6/2, 20.5,   11,     2,     5,     24,     26 ];
function NEMA_width(motor)    = motor[0];
function NEMA_length(motor)   = motor[1];
function NEMA_radius(motor)   = motor[2];
function NEMA_holes(motor)    = [-motor[8]/2, motor[8]/2];
function NEMA_big_hole(motor) = motor[4] + 0.2;
function NEMA_shaft_dia(motor) = motor[6];
function NEMA_shaft_length(motor) = motor[7];
function NEMA_hole_pitch(motor) = motor[8];

// bearings [ID,OD,W]
BB608 = [8, 22, 7];
BB105 = [5, 10, 4];
BB625 = [5, 16, 5];
LM8UU = [8, 15, 24];
LM10UU = [10, 19, 29];

// filament drive [ID,OD,W,teeth]
robotdigg_drive = [5,11,11,20];

module motor(dim) {
  side = dim[0];
  length = dim[1];
  holes = dim[8]/2;
  boss_r = dim[4];
  boss_d = dim[5];
  shaft_r = dim[6]/2;
  shaft_l = dim[7];

  color("grey") {
    difference() {
      intersection() {
	cube([side,side,length], center=true);
	cylinder(r=dim[2], h=length*2, center=true);
      }
      
      union() {
	for (x=NEMA_holes(dim),y=NEMA_holes(dim)) {
          translate([x,y,24]) cylinder(r=1.5,h=8,center=true);
	}
      }
    }
    translate([0,0,length/2]) {
      cylinder(r=shaft_r,h=shaft_l*2,center=true);
      cylinder(r=boss_r,h=boss_d*2,center=true);
    }
  }
}

module bearing(size) {
  rim = size[1]/10;
  color("silver") {
    difference() {
      cylinder(r=size[1]/2,h=size[2],center=true);
      cylinder(r=size[1]/2-rim,h=size[2]+1,center=true);
    }
    
    difference() {
      union() {
	cylinder(r=size[1]/2,h=size[2]-1,center=true);
	cylinder(r=size[0]/2+rim,h=size[2],center=true);
      }
      cylinder(r=size[0]/2,h=size[2]+1,center=true);
    }
  }
}

module filament_drive(size) {
  difference() {
    cylinder(r=size[1]/2,h=size[2],center=true);
    union() {
      cylinder(r=size[0]/2,h=size[2]+1,center=true);
      for (i=[0:360/size[3]:359]) {
        rotate([0,0,i]) translate([size[1]/2,0,0]) cylinder(r=0.5,h=size[2]+1,center=true);
      }
    }
  }
}

module pcb() {
  difference() {
    union() {
      %color("clear") translate([0,0,16.5]) cube([200,200,3],center=true);
      color("red") translate([0,0,15]) cube([215,215,2],center=true);
      color("brown") translate([0,0,3]) cube([230,230,6],center=true);
    }
    union() {
      for (x=[-105,105],y=[-105,105]) {
	translate([x,y,0]) cylinder(r=1.5,h=50,center=true);
      }
    }
  }
  for (x=[-105,105],y=[-105,105]) {
    color("grey") translate([x,y,8]) cylinder(r=1.5,h=20,center=true);
  }
}

module rod(h=100,d=8) {
  color("silver") cylinder(r=d/2,h=h,center=true);
}

M5_tap_radius = 4.2 / 2;
M5_clearance_radius = 5.3 / 2;
M5_nut_radius = 9.2 / 2;
M5_nut_depth = 4;

module nut(od=M8_nut_radius*2,id=8,h=M8_nut_depth) {
  color("silver") difference() {
    cylinder(r=od/2,h=h,center=true,$fn=6);
    cylinder(r=id/2,h=h+1,center=true);
  }
}

/*
pcb();
motor(NEMA17);
bearing(BB608);
bearing(BB105);
filament_drive(robotdigg_drive);
*/