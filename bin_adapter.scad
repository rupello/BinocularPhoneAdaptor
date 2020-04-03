// phone dimensions
phone_length = 152.00 ;
phone_width  = 75 ;
phone_thickness = 12 ;

// camera position offset from edges of phone
phone_cam_side_offset = 15.00;
phone_cam_top_offset = 17.00;

// binocular eyepiece radius
binocular_eyepiece_radius = 23 ;
binocular_eyepiece_height = 10 ;

module adaptor()
{
    difference() 
    {
        translate([-19,-20,0]) {
            adaptor_box() ;
        }

        {
            union()
            {
                // binocular eye pieces
                cylinder(h = binocular_eyepiece_height, r = binocular_eyepiece_radius);
                translate([72,0,0]) {
                    cylinder(h = binocular_eyepiece_height*3, r = binocular_eyepiece_radius);
                }
                translate([36,36,0]) {
                    cylinder(h = binocular_eyepiece_height, r = binocular_eyepiece_radius);
                }
                translate([90,50,0]) {
                    cylinder(h = binocular_eyepiece_height, r = binocular_eyepiece_radius);
                }
                
                //phone
                translate([-phone_cam_side_offset,-phone_cam_top_offset,binocular_eyepiece_height]) {
                    cube([phone_width,phone_length,phone_thickness]);
                }
                
                // remove section adjacent to power/volume buttons
                translate([-phone_cam_side_offset-20,-phone_cam_top_offset+35,binocular_eyepiece_height]) {
                    cube([phone_width,phone_length,phone_thickness*2]);
                }
            }

        }
    }
}

module adaptor_box()
{
    union()
    {
        // bottom section
        cube([phone_width*1.5, 68, binocular_eyepiece_height]);
        // middle section
        translate([0, 0, binocular_eyepiece_height-1]) {
            cube([phone_width*1.1, 68, phone_thickness]);
        }
        // top edge overhang
        difference() {    
            translate([0,0,binocular_eyepiece_height+phone_thickness-1]) {
                cube([phone_width*1.1, 68, 3]);
            }                
            translate([6,10,binocular_eyepiece_height+phone_thickness-1]) {
                cube([phone_width*0.95, 60, 10]); // cut-out the top
            }    
        }        
    }
}


difference() 
{
    adaptor(); 
    
    translate([0,0,30]) 
    {
        scale([1.1,1.1,1])
        {
            adaptor_bounding_box();
        }
        
    }
}