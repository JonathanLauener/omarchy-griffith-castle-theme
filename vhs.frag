#version 300 es
// Griffith Castle · 1997 broadcast look. Off by default.
// Toggle with SUPER+CTRL+ALT+V (griffith-vhs). Animated grain keeps the
// compositor redrawing, so leave it off when you don't need it.
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
uniform float time;
out vec4 fragColor;

float hash(vec2 p) {
  p = fract(p * vec2(123.34, 456.21));
  p += dot(p, p + 45.32);
  return fract(p.x * p.y);
}

void main() {
  vec2 uv = v_texcoord;
  vec2 c = uv - 0.5;
  float r2 = dot(c, c);

  // colour fringe that grows toward the edges, like a worn broadcast tube
  vec2 off = c * r2 * 0.010;
  vec3 col = vec3(texture(tex, uv + off).r, texture(tex, uv).g, texture(tex, uv - off).b);

  // barely-there scanlines
  col *= 0.98 + 0.02 * sin(uv.y * 3392.0);

  // film grain, new every frame
  col += (hash(uv * vec2(1920.0, 1080.0) + fract(time * 0.37) * 917.0) - 0.5) * 0.032;

  // soft vignette
  col *= 1.0 - r2 * 0.32;

  // cel grade: lifted blacks, tamed whites
  col = mix(vec3(0.014, 0.009, 0.011), vec3(0.965, 0.95, 0.94), clamp(col, 0.0, 1.0));

  fragColor = vec4(col, 1.0);
}
