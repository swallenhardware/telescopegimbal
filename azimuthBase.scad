use <struts.scad>;

fidelity = 200;

outerThickness = 9;
innerThickness = 3;

guideDepth = 4;
guideOuterRadius = 185/2;
guideInnerRadius = guideOuterRadius - 3;
guideHeight = 5;

outerRadius = 190/2;

innerRadius = guideOuterRadius - 20;

meshRadius = 103.5;
bearingRadius = 31/2;
bearingHolderThickness = 5;

azimuthBase();


module azimuthBase() {

    translate([0,0,-guideDepth]) difference() {
        cylinder(guideDepth, guideOuterRadius, guideOuterRadius, $fn=fidelity);
        translate([0,0,-1]) cylinder(guideDepth+2, guideInnerRadius, guideInnerRadius, $fn=fidelity);
    }

    difference() {
        
        union() {
            cylinder(outerThickness, outerRadius, outerRadius, $fn=fidelity);
            
            translate([meshRadius,0,0]) {
                cylinder(outerThickness, bearingRadius+bearingHolderThickness, bearingRadius+bearingHolderThickness, $fn=fidelity);
                
                translate([-bearingRadius-bearingHolderThickness,-bearingRadius-bearingHolderThickness,0]) cube([bearingRadius+bearingHolderThickness, (bearingRadius+bearingHolderThickness)*2, outerThickness]);
            }
        }
        
        translate([meshRadius,0,0]) translate([0,0,-1]) cylinder(outerThickness+2, bearingRadius, bearingRadius, $fn=fidelity);
        
        translate([0,0,-1]) cylinder(outerThickness+1-innerThickness, innerRadius, innerRadius, $fn=fidelity);
        
        rotate([0,0,180]) azimuthMountHoles();
    }
}
