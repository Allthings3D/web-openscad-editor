// ──── AllThings3D Keychain Engine ────

// Parameters (these match customization.js)
Text = "Tammy";
Font_name = "Chewy";
Font_Size = 16;
Letter_Spacing = 1;
Base_Color = "Black";
Text_Color = "Pink";
Base_Style = "Text Contour Bubble"; // [Text Contour Bubble, Solid Rectangle Base, Word Only]
Plate_Thickness = 2.5;
Border_Offset = 3.5;
Add_Hanger_Ring = "Yes"; // [Yes, No]
Hanger_X_Position = 12;

// Derived values
Calculated_Length = (len(Text) * (Font_Size * 0.73)) + (Border_Offset * 2);
Plate_Width = Font_Size + (Border_Offset * 2);
Hanger_Diameter = Plate_Width * 0.55;
$fn = 45;

// Font resolver
function resolve_font_path(font_selection) =
    (font_selection == "Oswald") ? "fonts/Oswald.ttf" :
    (font_selection == "Chewy") ? "fonts/Chewy.ttf" :
    (font_selection == "Pacifico") ? "fonts/Pacifico.ttf" :
    (font_selection == "Anton") ? "fonts/Anton.ttf" :
    (font_selection == "Lobster") ? "fonts/Lobster.ttf" :
    (font_selection == "Luckiest Guy") ? "fonts/LuckiestGuy.ttf" :
    "Liberation Sans:style=Bold";

Active_Font = resolve_font_path(Font_name);

// Color resolver
module apply_filament_color(color_name) {
    if (color_name == "Black") color([0.12,0.12,0.12]) children();
    else if (color_name == "White") color([0.95,0.95,0.95]) children();
    else if (color_name == "Red") color([0.85,0.1,0.1]) children();
    else if (color_name == "Blue") color([0.1,0.4,0.8]) children();
    else if (color_name == "Gold") color([0.85,0.65,0.15]) children();
    else if (color_name == "Silver") color([0.65,0.65,0.65]) children();
    else if (color_name == "Orange") color([0.95,0.45,0.1]) children();
    else if (color_name == "Pink") color([0.95,0.55,0.65]) children();
    else children();
}

// ──── Baseplate ────
if (Base_Style == "Solid Rectangle Base") {
    apply_filament_color(Base_Color)
    linear_extrude(height = Plate_Thickness)
        offset(r = Border_Offset)
            square([Calculated_Length, Plate_Width], center = true);
}

if (Base_Style == "Text Contour Bubble") {
    apply_filament_color(Base_Color)
    linear_extrude(height = Plate_Thickness)
        offset(r = Border_Offset)
            text(Text, size = Font_Size, font = Active_Font,
                 spacing = Letter_Spacing, halign="center", valign="center");
}

// ──── Raised Text ────
Text_Z_Shift = (Base_Style != "Word Only") ? Plate_Thickness : 0;

translate([0,0,Text_Z_Shift])
apply_filament_color(Text_Color)
linear_extrude(height = 3.5)
    text(Text, size = Font_Size, font = Active_Font,
         spacing = Letter_Spacing, halign="center", valign="center");

// ──── Hanger Loop ────
if (Add_Hanger_Ring == "Yes") {
    Loop_X = -(Calculated_Length / 2) + Hanger_X_Position;
    Hanger_Thickness_Z = (Base_Style != "Word Only") ? Plate_Thickness : 3.5;

    translate([Loop_X,0,0])
    apply_filament_color(Base_Color)
    linear_extrude(height = Hanger_Thickness_Z)
        difference() {
            circle(d = Hanger_Diameter);
            circle(d = Hanger_Diameter * 0.52);
        }
}
