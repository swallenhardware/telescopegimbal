use <parametric_involute_gear_v5.0.scad>;

fidelity = 200;

gearThickness = 10;
gearTeeth = 120;
gearOuterDiameter = 180;

extraGearHeight = 15;

diametralPitch = (gearTeeth+2)/gearOuterDiameter;

shaftDiameter = 11;

spacerDiameter = shaftDiameter + 6;
spacerLength = 3;

bearingThickness = 9;

boreCircles = 6;
boreDiameter = gearOuterDiameter/4;

elevationGear();

module elevationGear() {
    difference() {
        union() {
            rotate([-90,0,0]) gear (number_of_teeth = gearTeeth, diametral_pitch=diametralPitch, gear_thickness =gearThickness, rim_thickness = gearThickness, circles=boreCircles);
            
            //cylinder to fill the annoying hole in the gear I can't figure out how to disable
            rotate([-90,0,0]) cylinder(gearThickness, r=10);
            
            rotate([90,0,0]) cylinder(spacerLength, spacerDiameter/2, spacerDiameter/2, $fn=fidelity);
        }
        
        //bore out shaft hole
        translate([0,50,0]) rotate([90,0,0]) cylinder(100, shaftDiameter/2, shaftDiameter/2, $fn=fidelity);
        
        //bore out set screw hole
        translate([0,gearThickness/2,0]) cylinder(20, r=3/2, $fn=fidelity);
        
        translate([-gearOuterDiameter/2,-1,extraGearHeight]) cube([gearOuterDiameter, gearThickness+2, gearOuterDiameter/2]);
    }
}