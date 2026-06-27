#include "/lib/atmospherics/fog/waterFog.glsl"

#include "/lib/atmospherics/sky.glsl"
void DoBorderFog(inout vec3 color, inout float skyFade, float lPlayerPosXZ, float VdotU, float VdotS, float dither) {
    // #if defined OVERWORLD || defined END
    //     float fog = lPlayerPosXZ / far;
    //     fog *= fog;
    //     fog *= fog;
    //     fog *= fog;
    //     fog *= fog;
    //     fog = 1.0 - exp(-3.0 * fog);
    // #endif

    float fog = lPlayerPosXZ / far;
    fog *= fog;
    fog *= fog;
    fog = 1.0 - exp(-8.0 * fog);

    if (fog > 0.0) {
        fog = clamp(fog, 0.0, 1.0);
        vec3 fogColorM = vec3(1.0, 1.0, 0.0);
            
        color = mix(color, fogColorM, fog);

        #ifndef GBUFFERS_WATER
            skyFade = fog;
        #else
            skyFade = fog * (1.0 - isEyeInWater);
        #endif
    }
}

void DoWaterFog(inout vec3 color, float lViewPos) {
    float fog = GetWaterFog(lViewPos);

    color = mix(color, waterFogColor, fog);
}

void DoLavaFog(inout vec3 color, float lViewPos) {
    float fog = (lViewPos * 3.0 - gl_Fog.start) * gl_Fog.scale;

    #ifdef LESS_LAVA_FOG
    fog = sqrt(fog) * 0.4;
    #endif

    fog = 1.0 - exp(-fog);

    fog = clamp(fog, 0.0, 1.0);
    color = mix(color, fogColor * 5.0, fog);
}

void DoPowderSnowFog(inout vec3 color, float lViewPos) {
    float fog = lViewPos;
    fog *= fog;
    fog = 1.0 - exp(-fog);

    fog = clamp(fog, 0.0, 1.0);
    color = mix(color, fogColor, fog);
}

void DoBlindnessFog(inout vec3 color, float lViewPos) {
    float fog = lViewPos * 0.3 * blindness;
    fog *= fog;
    fog = 1.0 - exp(-fog);

    fog = clamp(fog, 0.0, 1.0);
    color = mix(color, vec3(0.0), fog);
}

void DoDarknessFog(inout vec3 color, float lViewPos) {
    float fog = lViewPos * 0.075 * darknessFactor;
    fog *= fog;
    fog *= fog;
    color *= exp(-fog);
}

void DoFog(inout vec3 color, inout float skyFade, float lViewPos, vec3 playerPos, float VdotU, float VdotS, float dither) {
    // DoBorderFog(color, skyFade, length(playerPos.xz), VdotU, VdotS, dither);

    if (isEyeInWater == 1) DoWaterFog(color, lViewPos);
    else if (isEyeInWater == 2) DoLavaFog(color, lViewPos);
    else if (isEyeInWater == 3) DoPowderSnowFog(color, lViewPos);

    if (blindness > 0.00001) DoBlindnessFog(color, lViewPos);
    if (darknessFactor > 0.00001) DoDarknessFog(color, lViewPos);
}
