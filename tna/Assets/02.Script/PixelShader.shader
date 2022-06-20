Shader "Custom/PixelShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        //_Glossiness ("Smoothness", Range(0,1)) = 0.5
        //_Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        cull front //면 뒤집기

        //1 면을 뒤집은 다음 노말 방향으로 확대
        //2 원본 오브젝트를 한 번 더 그려 합치기

        CGPROGRAM //1번
        // 버텍스 쉐이더 사용
        #pragma surface surf Lambert
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            
        };

        void vert (inout appdata_full v)
        {
            v.vertex.xyz = v.vertex.xyz + v.normal;
            //노말 방향으로 버텍스 이동. 스케일로 하면 달라질 수 있음.
        }

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        ENDCG

        //2번
        
        CGPROGRAM
        // 버텍스 쉐이더 사용
        #pragma surface surf Lambert
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        ENDCG
}