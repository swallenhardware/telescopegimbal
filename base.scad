use <parametric_involute_gear_v5.0.scad>;

fidelity = 200;

gearThickness = 10;
gearTeeth = 120;
gearOuterDiameter = 195;
gearInnerDiameter = 175;

diametralPitch = (gearTeeth+2)/gearOuterDiameter;

guideDepth = 4;
guideOuterRadius = 185/2+1;
guideInnerRadius = guideOuterRadius - 3-0.5;
guideHeight = 5;

base();

module base() difference() {
    gear (number_of_teeth = gearTeeth, diametral_pitch=diametralPitch, gear_thickness = gearThickness, rim_thickness = gearThickness);
    
    //bore out inner diameter of gear
    translate([0,0,-1]) cylinder(gearThickness+2, gearInnerDiameter/2, gearInnerDiameter/2, $fn=fidelity);
    
    //bore out the guide slot
    translate([0,0,gearThickness-guideDepth]) difference() {
        cylinder(guideDepth+1, guideOuterRadius, guideOuterRadius, $fn=fidelity);
        
        //cylinder(guideDepth+1, guideInnerRadius, guideInnerRadius, $fn=fidelity);
    }
}

//base();