/**
 * Reads model-specific configuration from `window.__WOSE_MODEL__`.
 */
export function getModelConfig() {
    const cfg = window.__WOSE_MODEL__;
    if (!cfg || typeof cfg !== "object") {
        throw new Error("window.__WOSE_MODEL__ is missing or invalid");
    }
    return cfg;
}

/**
 * Builds the SCAD code string using config values.
 */
export function buildKeychainScad(cfg) {
  const nameText   = cfg.text || "Sample";
  const fontChoice = cfg.font || "Liberation Sans:style=Bold";
  const textColor  = cfg.textColor || [1, 1, 1];
  const baseColor  = cfg.baseColor || [0, 0, 0];
  const length     = cfg.length || 100;
  const height     = cfg.height || 35;
  const raised     = cfg.raised || 2;

  return `
    color([${baseColor[0]}, ${baseColor[1]}, ${baseColor[2]}])
    cube([${length}, ${height}, 2]);

    translate([5, 5, 2])
    color([${textColor[0]}, ${textColor[1]}, ${textColor[2]}])
    text("${nameText}",
         size=${raised},
         font="${fontChoice}",
         halign="center",
         valign="center");
  `;
}

