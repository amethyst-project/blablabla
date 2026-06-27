#include "/lib/atmospherics/clouds/cloudCoord.glsl"

vec3 cloudRainColor = mix(nightMiddleSkyColor, dayMiddleSkyColor, sunFactor) * 0.7;
vec3 cloudAmbientColor = mix(ambientColor * (sunVisibility2 * 0.65 + 0.35), cloudRainColor * 0.5, rainFactor);
vec3 cloudLightColor   = mix(lightColor * (0.9 + 0.2 * noonFactor), cloudRainColor, rainFactor);

const float cloudStretch = CLOUD_STRETCH;
const float cloudHeight  = cloudStretch * 2.0;

float InterleavedGradientNoise() {
    return 0.0f;
}

#ifdef REALTIME_SHADOWS
vec3 GetShadowOnCloudPosition(vec3 tracePos) {
    return vec3(0.0);
}

bool GetShadowOnCloud(vec3 tracePos, float cloudAltitude, float lowerPlaneAltitude, float higherPlaneAltitude) {
    return false;
}
#endif

bool GetCloudNoise(vec3 tracePos, float cloudAltitude) {
    return false;
}

vec4 GetVolumetricClouds(float cloudAltitude, float distanceThreshold, inout float cloudLinearDepth, float skyFade, float skyMult0, vec3 nPlayerPos, float lViewPosM, float VdotS, float VdotU, float dither) {
    return volumetricClouds = vec4(0.0);
}
