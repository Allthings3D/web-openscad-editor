// ──── ALLTHINGS3D COMPACT MULTI-FONT GENERATOR ENGINE ────

/* [1. Text & Typography Settings] */

// Type the lettering name for your custom order layout below
Text = "Elodie";

// Pick a professional fun font style typography template
Font_name = "Chewy"; // [Anton, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extra Bold, Oswald]

// Sizing height scale multiplier for your text lettering
Font_Size = 13; // [10:1:22]

// Global spacing gaps between text characters (Squeeze to safely overlap)
Letter_Spacing = 1.0; // [0.8:0.05:1.2]

/* [Filament Color Selector Controls] */

// Select the primary filament color for the base plate foundation
Base_Color = "Black"; // [Black, White, Red, Blue, Gold, Silver, Orange, Pink]

// Select the accent filament color for the raised lettering text characters
Text_Color = "Pink"; // [Black, White, Red, Blue, Gold, Silver, Orange, Pink]

/* [Base Structure Styles Configuration] */

// Choose your overall structural shape style preference layout
Base_Style = "Text Contour Bubble"; // [Text Contour Bubble, Solid Rectangle Base, Word Only (No Base)]

// Foundation backing baseline footprint plate thickness measurement (in mm)
Plate_Thickness = 2.5; // [1.5:0.5:4.5]

// How far out the backing border bubble expands from the text edge bounds (in mm)
Border_Offset = 4.0; // [2:0.5:8]

/* [Spacing and Height Options] */

letter_1_height = 6; // [-20:1:20]
letter_1_space = 10; // [-20:1:20]

letter_2_height = 6; // [-20:1:20]
letter_2_space = 8; // [-20:1:20]

letter_3_height = 6; // [-20:1:20]
letter_3_space = 9; // [-20:1:20]

letter_4_height = 6; // [-20:1:20]
letter_4_space = 9; // [-20:1:20]

letter_5_height = 6; // [-20:1:20]
letter_5_space = 8.6; // [-20:1:20]

letter_6_height = 6; // [-20:1:20]
letter_6_space = 14; // [-20:1:20]

letter_7_height = 6; // [-20:1:20]
letter_7_space = 9.5; // [-20:1:20]

letter_8_height = 6; // [-20:1:20]
letter_8_space = 9.7; // [-20:1:20]

letter_9_height = 6; // [-20:1:20]
letter_9_space = 9.6; // [-20:1:20]

letter_10_height = 6; // [-20:1:20]
letter_10_space = 9.6; // [-20:1:20]

letter_11_height = 6; // [-20:1:20]
letter_11_space = 9.4; // [-20:1:20]

letter_12_height = 6; // [-20:1:20]
letter_12_space = 9.5; // [-20:1:20]

letter_13_height = 6; // [-20:1:20]
letter_13_space = 20; // [-20:1:20]

/* [ Twist ] */

// angle in degrees
twist = 0; // [-10:0.5:10]

// of twist rotation
center = 30; // [0:1:70]

/* [ Loop Settings ] */

// Horizontal attachment coordinate layout adjustment offsets
Loop_x_position = 10; // [-150:1:50]

// Vertical attachment coordinate layout adjustment offsets
Loop_y_position = 0; // [-20:1:20]

// Hanger loop internal symbol or alpha vector text string to use
Loop_character = "o";


// ──── AUTOMATED ENGINE MODULE DESIGN MATH (DO NOT CHANGE) ────
spacing = [0,letter_1_space,letter_2_space,letter_3_space,letter_4_space,letter_5_space,letter_6_space,letter_7_space, letter_8_space,letter_9_space,letter_10_space,letter_11_space,letter_12_space,letter_13_space];
height = [letter_1_height,letter_2_height,letter_3_height,letter_4_height,letter_5_height,letter_6_height,letter_7_height,letter_8_height,letter_9_height,letter_10_height,letter_11_height,letter_12_height,letter_13_height];

module apply_filament_color(color_name) {
    if (color_name == "Black") color([0.15, 0.15, 0.15]) children();
    else if (color_name == "White") color([0.95, 0.95, 0.95]) children();
    else if (color_name == "Red") color([0.85, 0.1, 0.1]) children();
    else if (color_name == "Blue") color([0.1, 0.4, 0.8]) children();
    else if (color_name == "Gold") color([0.85, 0.65, 0.15]) children();
    else if (color_name == "Silver") color([0.65, 0.65, 0.65]) children();
    else if (color_name == "Orange") color([0.95, 0.45, 0.1]) children();
    else if (color_name == "Pink") color([0.95, 0.55, 0.65]) children();
    else children();
}

// 2D Profile representation generator loop module
module raw_2d_text_layout() {
    for (i = [0 : len(Text) - 1]) {
        translate([(spacing[i]*i)-center, 0, 0])
        text(size = 25, text = Text[i], font = Font_name, halign = "center", valign = "center", $fn = 12);
    }
}

// ──── FINAL PREVIEW RENDER BLOCKS LAYER ────
rotate([0, 0, Rotation]) {

    // STEP A: FOUNDATION BASE COATING GENERATION TARGETS
    if (Base_Style == "Solid Rectangle Base") {
        apply_filament_color(Base_Color)
        linear_extrude(height = Plate_Thickness) {
            offset(r = 4, $fn=12) {
                square(size = [(len(Text)*10)+15, 30], center = true);
            }
        }
    }

    if (Base_Style == "Text Contour Bubble") {
        apply_filament_color(Base_Color)
        linear_extrude(height = Plate_Thickness) {
            offset(r = Border_Offset, $fn = 12) {
                raw_2d_text_layout();
            }
        }
    }

    // STEP B: RAISED EMBOSSED INDIVIDUAL TEXT LAYERING
    Text_Z_Shift = (Base_Style != "Word Only (No Base)") ? Plate_Thickness : 0;
    
    translate([0, 0, Text_Z_Shift])
    apply_filament_color(Text_Color) {
        for (i = [0 : len(Text) - 1]) {
            linear_extrude(height = height[i], twist = twist, $fn = 12) {
                translate([(spacing[i]*i)-center, 0, 0])
                text(size = 25, text = Text[i], font = Font_name, halign = "center", valign = "center", $fn = 12);
            }
        }
    }

    // STEP C: ATTACH HANGER WIDGET CONNECTOR LOOP RING
    apply_filament_color(Base_Color) {
        linear_extrude(height = Plate_Thickness, $fn = 12) {
            translate ([-center-Loop_x_position, Loop_y_position, 0]) rotate([0, 0, -90]) 
            text(size = 20, text = Loop_character, font = Font_name, halign = "center", valign = "center", $fn = 12);
        }
    }
}
