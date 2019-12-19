

PShader shad;
void setup()
{
  size(768, 768, P3D);
  
  final String[] vert = {
    "in vec4 position;",
    "void main() {",
    "  gl_Position = vec4(position.xy,0.,1.);",
    "}"
  };
  
  final String[] frag = {
    "uniform vec2 offset;",
    "uniform vec3 primes;",
    
    "float rnd(vec2 p) {",
    "  float v = dot(p, primes.xy);",
    "  return fract( sin( v ) * primes.z);",
    "}",
    
    "float interpolate(vec2 p) {",
    "  vec2 iv = floor(p);",
    "  vec2 fv = fract(p);",
       // add smoothing function here?
       // 'zero' vector is just for aligning text
    "  float x1 = mix(rnd(vec2(0.,0.)+iv), rnd(vec2(1.,0.)+iv), fv.x);",
    "  float x2 = mix(rnd(vec2(0.,1.)+iv), rnd(vec2(1.,1.)+iv), fv.x);",
    "  return mix(x1, x2, fv.y);",
    "}",
    
    "float valueNoise(vec2 p) {",
    "  float sum = 0.0;",
    "  float freq = 4.0;",
    "  float mult = 0.5;",
    "  for (int i=0; i<4; i++) {",
    "    sum += mult * interpolate( freq*(p + offset) );",
    "    freq *= 2.0;",
    "    mult *= 0.5;",
    "  }",
    "  return sum * 0.7;",
    "}",
    
    "void main() {",
    "  vec2 p = gl_FragCoord.xy/vec2("+width+"., "+height+".);",
    "  vec3 col = vec3(valueNoise(p));",
    "  gl_FragColor = vec4(col, 1.0);",
    "}"
  };

  shad = new PShader(this, vert, frag);
  shad.set("primes", 2053.0, 2909.0, 173.0);
}

void draw()
{
  shad.set("offset", 0.001*mouseX, -0.001*mouseY);
  shader(shad);
  rect(0,0, width,height);
}