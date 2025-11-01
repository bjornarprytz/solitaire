shader_type canvas_item;

// Adjust these values to taste
uniform float line_density : hint_range(1.0, 50.0) = 10.0; // lines per unit
uniform float speed : hint_range(0.0, 1.0) = 0.05;         // scroll speed
uniform float line_opacity : hint_range(0.0, 1.0) = 0.1;   // how visible the lines are
uniform float line_thickness : hint_range(0.001, 0.4) = 0.05; // width of the lines
uniform float angle : hint_range(0.0, 6.28318) = 0.785398; // rotation angle in radians (default: 45 degrees)
uniform vec4 background_color: source_color = vec4(0.2, 0.4, 0.2, 1.0); // fallback background color
uniform vec3 line_color : source_color = vec3(0.0, 0.0, 0.0); // color of the lines

void fragment() {
    vec2 uv = UV;

    // Rotate coordinates by the specified angle
    mat2 rot = mat2(vec2(cos(angle), -sin(angle)), vec2(sin(angle), cos(angle)));
    uv = rot * (uv - 0.5) + 0.5;

    // Animate motion
    uv.y += TIME * speed;

    // Create repeating stripes
    float stripe = fract(uv.y * line_density);

    // Draw lines with sharp edges
    float line = step(0.0, stripe) * (1.0 - step(line_thickness, stripe));

    // Sample the node's texture color, fallback to background_color if no texture
    vec4 base_color = texture(TEXTURE, UV);
    if (base_color.a == 0.0) {
        base_color = background_color;
    }

    // Blend line overlay on top
    vec3 final_color = mix(base_color.rgb, line_color, line * line_opacity);

    COLOR = vec4(final_color, base_color.a);
}