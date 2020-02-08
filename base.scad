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

tabWidth = 10;
tabHeight = 2;

base();

module base() {
    //SLOT + SPUR
    difference() {
        gear (number_of_teeth = gearTeeth, diametral_pitch=diametralPitch, gear_thickness = gearThickness, rim_thickness = gearThickness);
        
        //bore out inner diameter of gear
        translate([0,0,-1]) cylinder(gearThickness+2, gearInnerDiameter/2, gearInnerDiameter/2, $fn=fidelity);
        
        //bore out the guide slot
        translate([0,0,gearThickness-guideDepth]) difference() {
            cylinder(guideDepth+1, guideOuterRadius, guideOuterRadius, $fn=fidelity);
        }
    }
    
    //MOUNT HOLES
    for(i = [0:90:270]) rotate([0,0,i]) translate([tabWidth/2-gearInnerDiameter/2,0,0]) difference() {
        translate([-tabWidth/2,-tabWidth/2,0]) cube([tabWidth, tabWidth, tabHeight]);
        
        difference() {
            translate([0,-tabWidth/2,-1]) cube([tabWidth, tabWidth, tabHeight+2]);
            
            cylinder(tabHeight, r=tabWidth/2, $fn=fidelity);
        }
        
        cylinder(tabHeight+1, r=3/2, $fn=fidelity);
    }
}

base();
