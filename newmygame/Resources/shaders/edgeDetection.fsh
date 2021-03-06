
#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

vec2 resolution;
uniform sampler2D CC_Texture0;

float lookup(vec2 p, float dx, float dy)
{
    vec2 uv = p.xy + vec2(dx , dy ) / resolution.xy;
    vec4 c = texture2D(CC_Texture0, uv.xy);
    return 0.2126*c.r + 0.7152*c.g + 0.0722*c.b;
}

void main(void)
{
    // simple sobel edge detection
    resolution=vec2(1024.0,768.0);
    vec2 p = v_texCoord.xy;
    // Gx matrix multiplication
    float gx = 0.0;
    gx += -1.0 * lookup(p, -1.0, -1.0);
    gx += -2.0 * lookup(p, -1.0,  0.0);
    gx += -1.0 * lookup(p, -1.0,  1.0);
    gx +=  1.0 * lookup(p,  1.0, -1.0);
    gx +=  2.0 * lookup(p,  1.0,  0.0);
    gx +=  1.0 * lookup(p,  1.0,  1.0);
    // Gy matrix multiplication
    float gy = 0.0;
    gy += -1.0 * lookup(p, -1.0, -1.0);
    gy += -2.0 * lookup(p,  0.0, -1.0);
    gy += -1.0 * lookup(p,  1.0, -1.0);
    gy +=  1.0 * lookup(p, -1.0,  1.0);
    gy +=  2.0 * lookup(p,  0.0,  1.0);
    gy +=  1.0 * lookup(p,  1.0,  1.0);
    
    float g = gx*gx + gy*gy;
    
    gl_FragColor.xyz = vec3(1.-g);
    gl_FragColor.w = 1.;
}

//This shader is referred to cocos2d-x official engine shader.
//Check http://www.cocos2d-x.org/ for detailed information.


