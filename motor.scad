motor();

fidelity = 200;

motorLength = 48;
motorWidth = 42.3;
motorMountHoleOffset = 31/2;

module motor(){
    //body
    difference(){
        translate([-motorWidth/2, -motorWidth/2, 0]) cube([motorWidth, motorWidth, motorLength]);
        
        motorMountPattern();
    }
    
    //shaft plate
    translate([0,0,motorLength]) cylinder(2, 11, 11, $fn=fidelity);
    
    //shaft
    translate([0,0,motorLength]) cylinder(24, 5/2, 5/2, $fn=fidelity);
}

module motorMountPattern() {
    
    //screw holes
        translate([motorMountHoleOffset,motorMountHoleOffset,-100]) cylinder(200, 3.175/2, 3.175/2, $fn=fidelity);
        
        translate([motorMountHoleOffset,-motorMountHoleOffset,-100]) cylinder(200, 3.175/2, 3.175/2, $fn=fidelity);
        
        translate([-motorMountHoleOffset,motorMountHoleOffset,-100]) cylinder(200, 3.175/2, 3.175/2, $fn=fidelity);
        
        translate([-motorMountHoleOffset,-motorMountHoleOffset,-100]) cylinder(200, 3.175/2, 3.175/2, $fn=fidelity);
    
        translate([0,0,-100]) cylinder(200, r=12, $fn=fidelity);
}