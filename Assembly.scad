use <telescope.scad>
use <base.scad>
use <azimuthBase.scad>
use <struts.scad>
use <elevationGear.scad>
use <motor.scad>
use <bevelGears.scad>
use <azimuthSpur.scad>
use <elevationSpur.scad>
use <mountBands.scad>
use <elevationMotorMount.scad>


elevationRotation = 30;

translate([0,0, 216/2+40]) rotate([elevationRotation,0,180]) translate([0,-216/2,0]) rotate([90,0,180]) telescope(28,0);
base();
translate([0,0,10]) rotate([0,0,-90]) azimuthBase();
translate([0,0,19]) rotate([0,0,90]) struts();
translate(elevationMountLocation()+[0,0,19]) rotate([-elevationRotation,0,0]) rotate([0,0,-90]) elevationGear();
translate([-70-42.3/2-9-3,0,48+90]) rotate([180,0,0]) motor();
translate([-70-42.3/2-9-3,0,90-18]) rotate([180,0,0]) bevelGear2();
translate([-70-9,0,19+216/2+40-19-177/2-14.75/2]) elevationMotorMount();

translate([-3+70,0,19]+elevationMountLocation()) rotate([-elevationRotation,0,0]) {
    lowerMount();
    translate([0,0,8.125]) upperMount();
}
translate([0,0,19]) azimuthMotorPosition() rotate([90,0,0]) {
    motor();
    translate([0,0,60]) bevelGear2();
}
translate([0,-103.5,19]) bevelGear1();
translate([0,-103.5,2]) rotate([0,0,90]) azimuthSpur();
translate([-70+13,0,19+216/2+40-19-177/2-14.75/2]) rotate([0,-90,0]) elevationSpur();
translate([-70-9,0,19+216/2+40-19-177/2-14.75/2]) rotate([0,-90,0]) bevelGear1();

module azimuthMotorPosition() {
    translate([0,-103.5,48/2]) rotate([0,0,-60]) translate([0,80,0]) children();
}