include <../utils.scad>
include <vitamins.scad>
use <bearingholder.scad>
use <zaxis.scad>

$fa=1;
$fs=1;


// z axis
translate([131,0,150]) rotate([0,90,0]) topclamp();
translate([-131,0,150]) rotate([0,90,180]) topclamp();
translate([131,0,-150]) rotate([0,-90,180]) bottomclampmotor();
translate([-131,0,-150]) rotate([0,-90,0]) bottomclamp();

translate([140,0,0]) rotate([0,180,0]) platform();
translate([-140,0,0]) rotate([0,180,180]) platform();

pcb();

// z axis bearinds
for (y=[-50,50]) {
  for (x=[-140,140]) {
    translate([x,y,0]) rod(300);
    translate([x,y,-LM8UU[2]/2]) bearing(LM8UU);
  }
}
// threaded rods
for (x=[-152,152],z=[-141,141]) {
  color("grey") translate([x,0,z]) rotate([90,0,0]) rod(380);
}
// z axis drive rod
translate([0,0,-115]) rotate([0,90,0]) rod(300);
translate([136.5,0,-115]) rotate([0,90,0]) bearing(BB608);
translate([-136.5,0,-115]) rotate([0,90,0]) bearing(BB608);

// bearings,pulleys,belts
for (x=[-127,127]) {
  for (z=[-115,120]) {
    translate([x,0,z]) rotate([0,90,0]) bearing(BB625);
    translate([x,0,z]) rotate([0,90,0]) rod(40,5);    
  }

  for (y=[-8.5,8.5]) {
    color("black") translate([-x,y,2.5]) cube([6,1,235],center=true);
  }
}

// corner rods
for (x=[-165,165],y=[-165,165]) {
  color("grey") translate([x,y,30]) rod(400,10);
  for (z=[215,165,128,-116,-154]) {
    translate([x,y,z]) nut(M10_nut_radius*2,10,M10_nut_depth);
  }
  translate([x,y,-160]) rotate([180,0,0]) foot();
}
// front/rear horizontal rods
for (y=[-152,152],z=[-129,153]) {
  color("grey") translate([0,y,z]) rotate([0,90,0]) rod(380);
}
// main frame corners
for (z=[-150,132]) {
  for (x=[-1,1],y=[-1,1]) {
    translate([165*x,165*y,z]) rotate([0,0,180+90*(y+1)]) corner(1-x*y);
  }
}

// x/y drive
// bearing holder
translate([135,-155,180]) rotate([90,0,0]) bearingholder();
translate([155,-135,200]) rotate([-90,0,-90]) bearingholder();

translate([135,155,180]) rotate([-90,0,0]) motorholder();
translate([155,135,200]) rotate([90,0,90]) bearingholder();

translate([-135,155,180]) rotate([90,0,180]) bearingholder();
translate([-155,135,200]) rotate([-90,0,90]) motorholder();

translate([-135,-155,180]) rotate([-90,0,180]) bearingholder();
translate([-155,-135,200]) rotate([90,0,270]) bearingholder();

// drive rods
for (i=[-135,135]) {
  translate([0,i,200]) rotate([0,90,0]) rod(350,8);
  translate([i,0,180]) rotate([90,0,0]) rod(350,8);
}
// bearings
for (x=[-135,135],y=[-160,160]) {
  translate([x,y,180]) rotate([90,0,0]) bearing(BB608);
  translate([x,y,180]) rotate([90,0,0]) bearing(BB608);
}
for (x=[-160,160],y=[-135,135]) {
  translate([x,y,200]) rotate([0,90,0]) bearing(BB608);
  translate([x,y,200]) rotate([0,90,0]) bearing(BB608);
}


translate([0,0,195]) rotate([0,90,0]) rod(300,8);
translate([0,0,185]) rotate([90,0,0]) rod(300,8);


// motors
translate([200,0,-115]) rotate([0,-90,0]) motor(NEMA17);
translate([135,224,180]) rotate([90,0,0]) motor(NEMA17);
translate([-224,135,200]) rotate([0,90,0]) motor(NEMA17);
