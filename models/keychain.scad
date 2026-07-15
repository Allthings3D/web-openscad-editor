// ──── CUSTOMIZER INPUTS (Type your order info here) ────

// [ORDER PROCESSING]
Customer_Name = "NAME"; 
Font_Size = 12; // [10:1:20]

// [KEYCHAIN DESIGN]
Plate_Thickness = 2.5; // [1.5:0.5:5]
Border_Padding = 6; // [4:1:12]


// ──── AUTOMATED DESIGN MATH (Do not change) ────
Calculated_Length = (len(Customer_Name) * (Font_Size * 0.75)) + Border_Padding;
Plate_Width = Font_Size + Border_Padding;

union() {
    // 1. DYNAMIC BASE PLATE
    linear_extrude(height = Plate_Thickness) {
        square(size = [Calculated_Length, Plate_Width], center = true);
    }
    
    // 2. FUSED TEXT LAYOUT
    translate([0, 0, Plate_Thickness])
    linear_extrude(height = 3.5) {
        text(
            text    = Customer_Name, 
            size    = Font_Size, 
            font    = "Liberation Sans:style=Bold", 
            halign  = "center", 
            valign  = "center"
        );
    }
}
