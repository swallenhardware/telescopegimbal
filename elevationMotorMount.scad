use <struts.scad>
use <motor.scad>

fidelity = 200;

plateThickness = 3;

supportRadius = 5;
supportFootOffset = 30;

motorWidth = 42.3;
motorMountHeight = 31;

motorMountHoleOffset = 31/2;

elevationMotorMount();

module elevationMotorMount() difference() {
    union() {
        hull() {
            copyMirror([0,1,0]) {
                translate([0,supportFootOffset,0]) rotate([0,-90,0]) cylinder(plateThickness, r=supportRadius, $fn=fidelity);
            }
            
            translate([0,-motorWidth/2,motorMountHeight]) rotate([0,-90,0]) cube([plateThickness, motorWidth, plateThickness]);
        }
        
        translate([-plateThickness-motorWidth,-motorWidth/2,motorMountHeight]) cube([motorWidth, motorWidth, plateThickness]);
        
        //supports
        copyMirror([0,1,0]) difference() {
             hull() {
                translate([-plateThickness,supportFootOffset-supportRadius,supportRadius]) cube([plateThickness,supportRadius,supportRadius]);
            
                translate([-motorWidth-plateThickness+supportRadius*2,motorWidth/2-supportRadius*2,motorMountHeight]) cube([supportRadius*2, supportRadius*2, plateThickness]);
            }
            
            //cut out spots for mount bolt heads
            translate([0,supportFootOffset,0]) rotate([0,-90,0]) cylinder(20,r=8/2,$fn=fidelity);
            
            translate([-plateThickness-motorMountHoleOffset-motorWidth/2,motorMountHoleOffset,motorMountHeight]) rotate([0,180,0]) cylinder(20,r=8/2,$fn=fidelity);
        }
    }
    
    translate([-plateThickness-motorWidth/2,0,0]) motorMountPattern();
    rotate([0,0,90]) elevationMountHoles();
    
    //cut away area for large bevel
    translate([1,0,0]) rotate([0,-90,0]) cylinder(plateThickness+2, r=45/2, $fn=fidelity);
}
