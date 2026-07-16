// ──── ALLTHINGS3D PREMIUM RE-RENDER ENGINE BLUEPRINT ────

/* [1. Text & Typography Settings] */

// Type the lettering name for your custom order layout below
Text = "Elodie";

// Pick a professional fun font style typography template
Font_name = "Lobster"; // [Oswald, Chewy, Pacifico, Anton, Lobster, Luckiest Guy]

// Sizing height scale multiplier for your text lettering
Font_Size = 13; // [10:1:22]

// Global spacing gaps between text characters (Squeeze to safely overlap)
Letter_Spacing = 1.0; // [0.8:0.05:1.2]


/* [2. Dual-Filament Color Options] */

// Select the primary filament plastic color for the background base plate
Base_Color = "Black"; // [Black, White, Red, Blue, Gold, Silver, Orange, Pink]

// Select the accent filament plastic color for the raised lettering text
Text_Color = "Pink"; // [Black, White, Red, Blue, Gold, Silver, Orange, Pink]


/* [3. Base Plate Structure Controls] */

// Choose your overall background foundation shape style layout preference
Base_Style = "Text Contour Bubble"; // [Text Contour Bubble, Solid Rectangle Base, Word Only (No Base)]

// Foundation backing baseline footprint plate thickness measurement (in mm)
Plate_Thickness = 2.5; // [1.5:0.5:4.5]

// How far out the backing border bubble expands from the text edge bounds (in mm)
Border_Offset = 3.5; // [2:0.5:6]


/* [4. Keyring Hanger Hanger Ring Loop Settings] */

// Include an integrated circular hanger connector keyring loop on the left side
Add_Hanger_Ring = "Yes"; // [Yes, No]

// Shift the hanger link left or right to align it perfectly with the text edge
Hanger_X_Position = 12; // [5:1:30]


// ──── AUTOMATED ENGINE MODULE DESIGN MATH (SMOOTH CURVES PATCH) ────
Calculated_Length = (len(Text) * (Font_Size * 0.73)) + (Border_Offset * 2);
Plate_Width = Font_Size + (Border_Offset * 2);
Hanger_Diameter = Plate_Width * 0.55;
$fn = 45; // Smooth vector arc multiplier profiles

// SYSTEM FIX: Maps dropdown text options directly to real browser font paths
function resolve_font_path(font_selection) = 
    (font_selection == "Oswald") ? "fonts/Oswald.ttf" :
    (font_selection == "Chewy") ? "fonts/Chewy.ttf" :
    (font_selection == "Pacifico") ? "fonts/Pacifico.ttf" :
    (font_selection == "Anton") ? "fonts/Anton.ttf" :
    (font_selection == "Lobster") ? "fonts/Lobster.ttf" :
    (font_selection == "Luckiest Guy") ? "fonts/LuckiestGuy.ttf" : "Liberation Sans:style=Bold";

// SYSTEM FIX: Maps dropdown strings directly to true RGB canvas hex vectors
module apply_filament_color(color_name) {
    if (color_name == "Black") color([0.12, 0.12, 0.12]) children();
    else if (color_name == "White") color([0.95, 0.95, 0.95]) children();
    else if (color_name == "Red") color([0.85, 0.1, 0.1]) children();
    else if (color_name == "Blue") color([0.1, 0.4, 0.8]) children();
    else if (color_name == "Gold") color([0.85, 0.65, 0.15]) children();
    else if (color_name == "Silver") color([0.65, 0.65, 0.65]) children();
    else if (color_name == "Orange") color([0.95, 0.45, 0.1]) children();
    else if (color_name == "Pink") color([0.95, 0.55, 0.65]) children();
    else children();
}

Active_Font = resolve_font_path(Font_name);

// ──── FINAL RENDERING LOGIC LAYERS ────

// A. SOLID BACKING BASE PREVIEWS
if (Base_Style == "Solid Rectangle Base") {
    apply_filament_color(Base_Color)
    linear_extrude(height = Plate_Thickness) {
        offset(r = 3) {
            square(size = [Calculated_Length - 6, Plate_Width - 6], center = true);
        }
    }
}

if (Base_Style == "Text Contour Bubble") {
    apply_filament_color(Base_Color)
    linear_extrude(height = Plate_Thickness) {
        offset(r = Border_Offset) {
            text(text = Text, size = Font_Size, font = Active_Font, spacing = Letter_Spacing, halign = "center", valign = "center");
        }
    }
}

// B. RAISED FUSED TEXT CHARACTERS ON TOP
Text_Z_Shift = (Base_Style != "Word Only (No Base)") ? Plate_Thickness : 0;

translate([0, 0, Text_Z_Shift])
apply_filament_color(Text_Color)
linear_extrude(height = 3.5) {
    text(text = Text, size = Font_Size, font = Active_Font, spacing = Letter_Spacing, halign = "center", valign = "center");
}

// C. INTEGRATED HANGER KEYRING LOOP WIDGET
if (Add_Hanger_Ring == "Yes") {
    Loop_Placement_X = -(Calculated_Length / 2) + (Hanger_X_Position - 12);
    Hanger_Thickness_Z = (Base_Style != "Word Only (No Base)") ? Plate_Thickness : 3.5;
    
    translate([Loop_Placement_X, 0, 0])
    apply_filament_color(Base_Color)
    linear_extrude(height = Hanger_Thickness_Z) {
        difference() {
            circle(d = Hanger_Diameter);
            circle(d = Hanger_Diameter * 0.52);
        }
    }
}
