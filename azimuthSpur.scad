use <parametric_involute_gear_v5.0.scad>;

fidelity=200;

gearThickness = 8;
gearTeeth = 10;
gearOuterDiameter = 18;

shaftDiameter = 10.25;
shaftLength = 9+10+gearThickness;

diametralPitch = (gearTeeth+2)/gearOuterDiameter;

azimuthSpur();

module azimuthSpur() {
    difference() {
        gear (number_of_teeth = gearTeeth, diametral_pitch=diametralPitch, gear_thickness = gearThickness, rim_thickness = gearThickness);
        
        translate([0,0,gearThickness]) cylinder(10,20,20);
    }
    
    difference() {
        cylinder(shaftLength, r=shaftDiameter/2, $fn=fidelity);
        
        translate([-shaftDiameter/2,0,5+9+gearThickness]) rotate([0,90,0]) cylinder(shaftDiameter, r=3/2, $fn=fidelity);
    }
}