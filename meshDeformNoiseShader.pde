
PShape plane;
PShader shad;
float t = 0;
float dt = 0.0005;

int S = 5;
int K = 512;

float px = 0;
float py = 0;
float deltaview = 0.0005; // 1.0 / 256.;

float ZOOMSCALE = 0.0001;

void setup()
{
  size(1024, 768, P3D);
  
  plane = createShape();
  plane.beginShape(TRIANGLES);
  plane.fill(0,255,0);
  plane.noStroke();
  for (int py=0; py<K; py++)
  {
    for (int px=0; px<K*2; px++)
    {
      plane.vertex(S*(px-K/2),   0, S*(py-K/2)+S);
      plane.vertex(S*(px-K/2),   0, S*(py-K/2));
      plane.vertex(S*(px-K/2)+S, 0, S*(py-K/2));
      plane.vertex(S*(px-K/2),   0, S*(py-K/2)+S);
      plane.vertex(S*(px-K/2)+S, 0, S*(py-K/2)+S);
      plane.vertex(S*(px-K/2)+S, 0, S*(py-K/2));
    }
  }
  plane.endShape();
  
  shad = loadShader("frag.glsl", "vert.glsl");
  shad.set("viewscale", deltaview);
  shad.set("landHeight", -1024.);
  shad.set("offset", 11.0, 11.0);
  shad.set("primes", 71., 63., 787.);
  shad.set("lamp", 50., 50., 50.);
}

void mousePressed()
{
  px = mouseX;
  py = mouseY;
}

void mouseDragged()
{
  if (mouseButton == RIGHT)
  {
    float dy = float(mouseY) - py;
    shad.set("viewscale", deltaview+(dy*ZOOMSCALE));
  }
}

void mouseReleased()
{
  if (mouseButton == RIGHT)
  {
    float dy = float(mouseY) - py;
    deltaview += dy*ZOOMSCALE;
  }
  else
  {
    println(deltaview);
  }
}

void draw()
{
  background(0,0,255);
  pushMatrix();
  translate(-100, 1*height/1-100, -1000);
  rotateX(-PI/7);
  
  shader(shad);
  shad.set("offset", 32.0+t, 32.0+t);
  shad.set("t", t*10);
  shad.set("lamp", 150.*cos(t), 150., 150.*sin(t));
  t += dt;
  
  shape(plane);
  
  resetShader();
  popMatrix();
  
  for (int dy=0; dy<512; dy++)
  {
    stroke(32, 255-dy/2);
    line(0,dy, width,dy);
  }
  
}
