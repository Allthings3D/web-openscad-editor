// ──── ALLTHINGS3D PREMIUM MODULAR WORKSPACE BLUEPRINT ────

// [ORDER VISUAL CUSTOMIZATION]

// Type the lettering text for your custom order layout below
Customer_Name = "SMITH"; 

// Pick an available professional font style asset type typography configuration template
Font_Style = "Liberation Sans:style=Bold"; // [Liberation Sans:style=Bold, Liberation Serif:style=Bold, Liberation Mono:style=Bold]

// Size height dimension scale mapping values for your typography font
Font_Size = 12; // [10:1:18]

// Lettering spacing alignment factor adjustment (Squeeze metrics tighter to overlap safe vectors)
Letter_Spacing = 0.95; // [0.85:0.05:1.15]


// [FILAMENT COLORS (DUAL-COLOR PREVIEW)]

// Select the primary filament color for the base plate foundation
Base_Color = "Black"; // [Black, White, Red, Blue, Gold, Silver, Orange, Pink]

// Select the accent filament color for the raised lettering text
Text_Color = "Gold"; // [Black, White, Red, Blue, Gold, Silver, Orange, Pink]


// [FOUNDATION INFRASTRUCTURE CONTROLS]

// Select the production structural style theme geometry arrangement configuration layout
Base_Style = "Rounded Plate"; // [Rounded Plate, Sharp Backing Plate, Fused Cutout Word Only]

// Solid backing boundary baseline baseplate thickness footprint depth measurement scale values (in mm)
Plate_Thickness = 2.5; // [1.5:0.5:4.5]

// Outer parameter frame safety border padding margins edge cushion scale bounds metrics (in mm)
Border_Padding = 8; // [6:1:14]

// Attach a circular keychain hanger connector link loop ring component to the edge layout frame
Add_Hanger_Ring = "Yes"; // [Yes, No]


// ──── AUTOMATED DESIGN MATH ENGINE (DO NOT ALTER LOGIC ROWS) ────
Calculated_Length = (len(Customer_Name) * (Font_Size * 0.73)) + Border_Padding;
Plate_Width = Font_Size + Border_Padding;
Hanger_Diameter = Plate_Width * 0.55;
Corner_Radius = 4; // Controls the roundness smoothness of the plate corners

// Helper function to map text names to web colors inside the 3D viewer canvas
module apply_filament_color(color_name) {
    if (color_name == "Black") color([0.1, 0.1, 0.1]) children();
    else if (color_name == "White") color([0.95, 0.95, 0.95]) children();
    else if (color_name == "Red") color([0.85, 0.1, 0.1]) children();
    else if (color_name == "Blue") color([0.1, 0.4, 0.8]) children();
    else if (color_name == "Gold") color([0.85, 0.65, 0.15]) children();
    else if (color_name == "Silver") color([0.65, 0.65, 0.65]) children();
    else if (color_name == "Orange") color([0.95, 0.45, 0.1]) children();
    else if (color_name == "Pink") color([0.95, 0.5, 0.75]) children();
    else children();
}

union() {
    
    // SECTION A: BASE HOUSING GENERATOR STYLES
    if (Base_Style == "Sharp Backing Plate") {
        apply_filament_color(Base_Color)
        linear_extrude(height = Plate_Thickness) {
            square(size = [Calculated_Length, Plate_Width], center = true);
        }
    }
    
    if (Base_Style == "Rounded Plate") {
        apply_filament_color(Base_Color)
        linear_extrude(height = Plate_Thickness) {
            // Minkowski or offset trick to create smooth rounded corners for the slicer
            offset(r = Corner_Radius, $fn=30) {
                square(size = [Calculated_Length - (Corner_Radius*2), Plate_Width - (Corner_Radius*2)], center = true);
            }
        }
    }
    
    // SECTION B: HIGH-RELIEF TEXT STRUCTURE
    Text_Z_Offset = (Base_Style != "Fused Cutout Word Only") ? Plate_Thickness : 0;
    Text_Height_Value = (Base_Style != "Fused Cutout Word Only") ? 3.5 : 4.5;
    
    translate([0, 0, Text_Z_Offset])
    apply_filament_color(Text_Color)
    linear_extrude(height = Text_Height_Value) {
        text(
            text    = Customer_Name, 
            size    = Font_Size, 
            font    = Font_Style, 
            spacing = Letter_Spacing,
            halign  = "center", 
            valign  = "center"
        );
    }
    
    // SECTION C: OPTIONAL INTEGRATED HANGER CONNECTOR WIDGET LOOP
    if (Add_Hanger_Ring == "Yes") {
        Hanger_X_Position = -(Calculated_Length / 2);
        Hanger_Thickness_Z = (Base_Style != "Fused Cutout Word Only") ? Plate_Thickness : 4.5;
        
        translate([Hanger_X_Position, 0, 0])
        apply_filament_color(Base_Color)
        linear_extrude(height = Hanger_Thickness_Z) {
            difference() {
                circle(d = Hanger_Diameter, $fn = 40);
                circle(d = Hanger_Diameter * 0.55, $fn = 40);
            }
        }
    }
}
