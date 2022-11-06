uniform sampler2D StudsMap;
uniform sampler2D NormalMap;
uniform sampler3D NoiseMap;
uniform sampler3D LightMap;
uniform vec4 LightConfig1;
uniform vec4 LightBorder;
uniform vec3 Lamp1Color;
uniform vec3 Lamp0Dir;
uniform vec3 Lamp0Color;
uniform vec3 FogColor;
uniform sampler2D DiffuseMap;
uniform vec3 AmbientColor;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = gl_TexCoord[2];
  vec4 tmpvar_2;
  tmpvar_2 = gl_TexCoord[4];
  vec4 tmpvar_3;
  tmpvar_3 = gl_TexCoord[5];
  vec4 tmpvar_4;
  tmpvar_4 = gl_TexCoord[6];
  vec4 oColor0_5;
  vec4 albedo_6;
  vec3 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (StudsMap, gl_TexCoord[1].xy);
  vec3 normal_9;
  vec3 tmpvar_10;
  tmpvar_10 = (texture2D (NormalMap, (gl_TexCoord[0].xy * 0.15)).xyz - 0.5);
  normal_9.z = tmpvar_10.z;
  float tmpvar_11;
  tmpvar_11 = ((texture3D (NoiseMap, (tmpvar_3.xyz * 0.06249)).x * 0.5) + ((texture3D (NoiseMap, (tmpvar_3.zyx * 0.2079)).x * 0.3) + (texture3D (NoiseMap, (tmpvar_3.zyx * 0.6249)).x * 0.2)));
  vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = (1.0 - tmpvar_11);
  float tmpvar_13;
  tmpvar_13 = clamp ((((((tmpvar_11 - 0.8) + 0.3) / 2.0) / 0.3) + 0.5), 0.0, 1.0);
  vec3 tmpvar_14;
  tmpvar_14 = mix (texture2D (DiffuseMap, tmpvar_12).xyz, (gl_Color.xyz * 1.3), vec3(tmpvar_13));
  normal_9.xy = (tmpvar_10.xy * (1.0 - tmpvar_13));
  tmpvar_7.z = normal_9.z;
  float tmpvar_15;
  tmpvar_15 = clamp (tmpvar_4.w, 0.0, 1.0);
  tmpvar_7.xy = (normal_9.xy * (1.0 - tmpvar_15));
  vec3 tmpvar_16;
  tmpvar_16 = mix (mix (mix (tmpvar_14, (tmpvar_14 * (0.65 + dot (tmpvar_10, vec3(0.35, 0.35, 0.35)))), vec3(tmpvar_13)), gl_Color.xyz, vec3(tmpvar_15)), tmpvar_8.xyz, tmpvar_8.www);
  vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_16;
  tmpvar_17.w = gl_Color.w;
  albedo_6.w = tmpvar_17.w;
  vec3 tmpvar_18;
  tmpvar_18 = normalize((((tmpvar_7.x * tmpvar_4.xyz) + (tmpvar_7.y * ((tmpvar_2.yzx * tmpvar_4.zxy) - (tmpvar_2.zxy * tmpvar_4.yzx)))) + (tmpvar_10.z * tmpvar_2.xyz)));
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_18, -(Lamp0Dir));
  vec4 tmpvar_20;
  tmpvar_20.xyz = ((clamp (tmpvar_19, 0.0, 1.0) * Lamp0Color) + (max (-(tmpvar_19), 0.0) * Lamp1Color));
  tmpvar_20.w = (float((tmpvar_19 >= 0.0)) * mix (0.12, 0.6, (tmpvar_13 * (1.0 - clamp (tmpvar_4.w, 0.0, 1.0)))));
  vec3 tmpvar_21;
  tmpvar_21 = clamp (tmpvar_1.xyz, 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = abs((tmpvar_21 - 0.5));
  vec4 tmpvar_23;
  tmpvar_23 = mix (LightBorder, texture3D (LightMap, (tmpvar_21 - LightConfig1.xyz)), vec4(float((0.49 >= max (tmpvar_22.x, max (tmpvar_22.y, tmpvar_22.z))))));
  albedo_6.xyz = tmpvar_16;
  oColor0_5.xyz = ((((AmbientColor + (tmpvar_20.xyz * tmpvar_23.w)) + tmpvar_23.xyz) * tmpvar_16) + (Lamp0Color * ((tmpvar_23.w * tmpvar_20.w) * pow (clamp (dot (tmpvar_18, normalize((-(Lamp0Dir) + normalize(gl_TexCoord[3].xyz)))), 0.0, 1.0), tmpvar_2.w))));
  oColor0_5.w = albedo_6.w;
  oColor0_5.xyz = mix (FogColor, oColor0_5.xyz, vec3(clamp (tmpvar_1.w, 0.0, 1.0)));
  gl_FragData[0] = oColor0_5;
}

