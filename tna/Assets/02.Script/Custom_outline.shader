Shader "Custom/Custom_outline"{
    Properties    {
        _MainTex ("Base (RGB)", 2D) = "white" {}        
    }
    SubShader
    {   
        Tags { "RenderType"="Opaque" }
        LOD 200

        cull front
        ZWrite Off
        ZTest Always
        
        CGPROGRAM       
        #pragma surface surf Lambert vertex:vert noambient //occlusion
        struct Input        {
            float4 Color:color;
        };
        void vert(inout appdata_full v)        
        {
            v.vertex.xyz += v.normal * 0.05;
        }
        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = 0;
            o.Alpha = 1;
        }        
        ENDCG

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input {
            float2 uv_MainTex;
        };
       
        void surf (Input IN, inout SurfaceOutput o)
        {
            half4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }        
        ENDCG
    }
    FallBack "Diffuse"
}


