include <bearings.scad>

$fa=1;
$fs=1;


module rod(d,l) {
  color("silver") cylinder(r=d/2,h=l,center=true);
}

module pulley() {
  difference() {
    union() {
      cylinder(r=10,h=8);
      cylinder(r=7,h=20);
    }
    cylinder(r=4,h=50,center=true);
  }
}

for (x=[-150,150],y=[-150,150]) {
  translate([x,y,0]) rod(8,300);
}

for (x=[-150,150],z=[-150]) {
  translate([x,0,z]) rotate([90,0,0]) rod(8,300);
}

for (y=[-150,150],z=[-150]) {
  translate([0,y,z]) rotate([0,90,0]) rod(8,300);
}

//translate([150,0,150]) rotate([90,0,0]) rod(10,280);



module beltshaft() {
  rod(8,350);
  for (z=[-150,150]) {
    translate([0,0,z]) bearing(608ZZ);
  }
  translate([0,0,-130]) pulley();
  translate([0,0,130]) rotate([180,0,0]) pulley();
}

module axis() {
  for (x=[-130,130]) {
    translate([x,0,0]) rotate([90,0,0]) beltshaft();
  }
  for (y=[-150,150]) {
    translate([0,y,0]) rotate([0,90,0]) rod(10,230);
  }
  translate([0,0,-5]) rotate([90,0,0]) rod(8,280);
  color("orange") translate([0,150,0]) cylinder(r=20,h=20,center=true);
  color("orange") translate([0,-150,0]) cylinder(r=20,h=20,center=true);
}

translate([0,0,150]) axis();
translate([0,0,125]) rotate([0,180,90]) axis();