use <parametric_involute_gear_v5.0.scad>;

fidelity = 200;

motorShaftDiameter = 5;

supportRadius = 36/2;
supportHeight = 9.5;
shaftRadius = 10.5/2;
keyHoleHeight = 5;

gear1_teeth = 24;
gear2_teeth = 8;
axis_angle = 90;
outside_circular_pitch=300;

outside_pitch_radius1 = gear1_teeth * outside_circular_pitch / 360;
outside_pitch_radius2 = gear2_teeth * outside_circular_pitch / 360;
pitch_apex1=outside_pitch_radius2 * sin (axis_angle) + 
    (outside_pitch_radius2 * cos (axis_angle) + outside_pitch_radius1) / tan (axis_angle);
cone_distance = sqrt (pow (pitch_apex1, 2) + pow (outside_pitch_radius1, 2));
pitch_apex2 = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius2, 2));
echo ("cone_distance", cone_distance);
pitch_angle1 = asin (outside_pitch_radius1 / cone_distance);
pitch_angle2 = asin (outside_pitch_radius2 / cone_distance);
echo ("pitch_angle1, pitch_angle2", pitch_angle1, pitch_angle2);
echo ("pitch_angle1 + pitch_angle2", pitch_angle1 + pitch_angle2);

//bevelGear1();

translate([40,0,0]) bevelGear2();

//big gear
module bevelGear1(support=1) {
    difference() {
        translate([0,0,supportHeight*support]) difference() {
            
            union() {
            translate([0,0,pitch_apex1+20-pitch_apex2]) bevel_gear (
                    number_of_teeth=gear1_teeth,
                    cone_distance=cone_distance,
                    pressure_angle=30,
                    outside_circular_pitch=outside_circular_pitch);
                
                //fill in the annoying hole
                cylinder(15,r=3);
            }
            
            rotate([180,0,0]) cylinder(15,20,20);
        }
        translate([0,0,21]) cylinder(15,20,20);
    }
    
    //make the support column
    if(support==1) difference() {
        cylinder(supportHeight,r=supportRadius, $fn=fidelity);
        
        translate([0,0,-1]) cylinder(supportHeight,r=shaftRadius, $fn=fidelity);
        
        translate([0,supportRadius/2,keyHoleHeight]) rotate([90,0,0]) cylinder(supportRadius, r=3/2, $fn=fidelity);
        translate([0,-shaftRadius-2,keyHoleHeight]) rotate([90,0,0]) cylinder(supportRadius, r=7/2, $fn=fidelity);
    }
}

//little gear
module bevelGear2() difference() {
    bevel_gear (
			number_of_teeth=gear2_teeth,
			cone_distance=cone_distance,
			pressure_angle=30,
			outside_circular_pitch=outside_circular_pitch);
    
    rotate([180,0,0]) cylinder(15,20,20);
    
    translate([0,0,8]) cylinder(15,20,20);
    
    cylinder(50,r=motorShaftDiameter/2,$fn=fidelity);
}