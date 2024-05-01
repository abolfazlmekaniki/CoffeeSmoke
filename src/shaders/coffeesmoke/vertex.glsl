uniform float uTime ;
uniform sampler2D uPerlinTexture;

varying vec2 vUv;


vec2 rotate2D(vec2 value, float angle)
{
    float s = sin(angle);
    float c = cos(angle);
    mat2 m = mat2(c, s, -s, c);
    return m * value;
}

void main(){
     vec3 newposition=position;

     float twistPerlin = texture(uPerlinTexture,vec2(0.5,uv.y*0.2- uTime *0.005)).r;
     float angle = twistPerlin * 10.0;
     newposition.xz = rotate2D(newposition.xz,angle);

     vec2 wind = vec2(
        texture(uPerlinTexture,vec2(0.25,uTime*0.05)).r - 0.5
        ,texture(uPerlinTexture,vec2(0.75,uTime*0.05)).r - 0.5
     );
     wind *= pow(uv.y,4.0) * 5.0;
     newposition.xz += wind;
     gl_Position = projectionMatrix * modelViewMatrix * vec4(newposition, 1.0);
     vUv = uv;
}