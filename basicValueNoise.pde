
int y = 0;
boolean done = false;

float fract(float in)
{
  return in - floor(in);
}

float rnd(PVector p) // use some prime numbers
{
  float t = p.dot( new PVector(2053,2909) );
  return fract( sin(t) * 173 );
}

float interpolate(float x, float y)
{
  PVector iv = new PVector(floor(x), floor(y));
  PVector fv = new PVector(fract(x), fract(y));
  
  // 'zero' vector is just for show
  float x1 = lerp(rnd(new PVector(0.,0.).add(iv)),
                  rnd(new PVector(1.,0.).add(iv)),
                  fv.x);
  float x2 = lerp(rnd(new PVector(0.,1.).add(iv)),
                  rnd(new PVector(1.,1.).add(iv)),
                  fv.x);
  
  return lerp(x1, x2, fv.y);
}


float valueNoise(float x, float y)
{
  float sum = 0.0;
  float f = 4.0;
  float m = 0.5;
  for (int i=0; i<8; i++)
  {
    sum += interpolate((x)*f,(y)*f)*m;
    f *= 2.0;
    m *= 0.5;
  }
  return sum * 0.7;
}

void mouseClicked()
{
  // store values to repeat later
  println(mouseX + ", " + mouseY);
}

void setup()
{
  size(128,128,P2D);
}

void draw()
{
  loadPixels();
  for (int y=0; y<height; y++)
  {
    for (int x=0; x<width; x++)
    {
      // arbitrary scaling
      float n = valueNoise(0.01*(x+mouseX), 0.01*(y+mouseY));
      int col = color(int(n*255));
      int idx = y * width + x;
      pixels[idx] = col;
    }
  }
  updatePixels();
}