#include "/lib/colors/skyColors.glsl"

float GetStarNoise(vec2 pos) {
    return fract(sin(dot(pos, vec2(12.9898, 4.1414))) * 43758.54953);
}

vec3 GetStars(vec3 viewPos, float VdotU, float VdotS) {
    return vec3(0.0);
}