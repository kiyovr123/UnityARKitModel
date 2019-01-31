Shader "Unlit/AcidShader"
{
 Properties
 {
 }
 SubShader
 {
     Tags { "RenderType"="Opaque" }
     LOD 100

     Pass
     {
         CGPROGRAM
         #pragma vertex vert
         #pragma fragment frag         
         #include "UnityCG.cginc"

         struct appdata
         {
             float4 vertex : POSITION;
             float2 uv : TEXCOORD0;
         };

         struct v2f
         {
             float2 uv : TEXCOORD0;
             float4 vertex : SV_POSITION;
         };

         v2f vert (appdata v)
         {
             v2f o;
             o.vertex = UnityObjectToClipPos(v.vertex);  
             o.uv=v.uv;
             return o;
         }
         
         fixed4 frag (v2f i) : SV_Target
         {
            float2 st=i.uv*2.0-1.0;

            for(int j=1;j<=4;j++)
            {
                st=abs(st*1.5)-0.8;
                float b=float(j)*_Time.w*0.5;
                float c=cos(b);
                float s=sin(b);
                float2x2 rot=float2x2(c,-s,s,c);
                st= mul(rot,st);
            }

             float2 axis=1.0-smoothstep(0.01,0.05,abs(st));
             float2 col=lerp(st,float2(1.0,1.0),axis.x+axis.y);
             return float4(col,0.4,1.0);

         }
         ENDCG
     }
 }
}
