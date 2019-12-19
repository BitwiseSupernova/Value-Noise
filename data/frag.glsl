#ifdef GL_ES
precision highp float;
precision highp int;
#endif

varying vec4 vertexColor; // calculate this based on ?
uniform float t;
uniform float S;
uniform vec3 lamp;

void main()
{
  gl_FragColor = vertexColor;
}
