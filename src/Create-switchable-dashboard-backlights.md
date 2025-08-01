# Create switchable dashboard backlights

In some sim-racing titles, they usually allow player to turn on & off dashboard backlights during night or day. This feature is not supported in RF2 by default (or in a normal way). But there is a workaround to make it possible in RF2.

## The issue

Normally, RF2 doesn't support switchable lights in "Cockpit" instance. Using "DashboardElementShader" will only make all dash elements visible in all condition.

One idea is to put the dash elements into headlights instance such as "HLIGHTDS" or "HLIGHTPS", so when you switched on headlights, dashboard will also light up. However, while it works from outside view (such as swingman), this method will not work for "Cockpit" instance.

## The solution

The solution is to put one of the headlights instance code into the "Cockpit" instance, and use this headlights instance for your dashboard, it will light up in cockpit when you switch on headlights.

Note that there are a few problems or limitation with this method, which requires some specific setup to make it working properly.

1
---
You create this dashboard the same way as you create headlights, which requires at least 2 textures and set their animation frame to (0, 1).

For example, the first texture will be named "dashlights00.dds" and should be totally transparent, and second texture should be named "dashlights01.dds" which contains the dash image. (dashlights.dds can be omitted)

2
---
All "dashboard" materials used in "headlights" instance must have "_HLGLO" suffix, same as how you make headlights.

3
---
All "dashboard" materials used in "headlights" instance should either use "High luminance sun" shader, or IBL standard shader with night Emissive enabled, and MUST set "Blending" to either "Alpha Blending Transparent" or "Alpha Chroma".

### Example

1
---
Assume you have "hlglo_DS.gmt" as right-side headlight, and "hlglo_PS.gmt" as left-side headlight.
Copy all the mesh from "hlglo_DS.gmt" into "hlglo_PS.gmt", then save "hlglo_PS.gmt"

2
---
Open your dashboard GMT, copy the background mesh and paste into a new GMT file, add a little offset to the mesh so it won't clip with other mesh, then save this file as "hlglo_DS.gmt".

3
---
Prepare 2 textures for your dashboard background lights, assume the main texture is called dashlights.dds. Then the first texture will be named "dashlights00.dds" and should be totally transparent, and second texture should be named "dashlights01.dds" which contains the dash image.

Note: if using "High luminance sun" shader, it will be too bright by default. To fix brightness, you will need to adjust texture opacity for "dashlights01.dds", usually change the opacity to 25% is good enough (remember to merge visible layer after changing layer opacity). Alternatively, IBL standard shader is recommended for experienced modder.

4
---
Open "hlglo_DS.gmt" that we just saved, do the following:

- Change its "material name" to "dashboardlights_HLGLO"
- Set "texture map" to "dashlights.dds". Then set "Blending" to "Alpha Chroma".
- Change "Animation Type" to "Event", set "Frames" to "0, 1"
- Save "hlglo_DS.gmt"

5
---
Open your GEN file, find the line with "HLIGHTDS", cut this "HLIGHTDS" instance and paste it into "COCKPIT" instance, such as below:

    Instance=COCKPIT
    {
        Moveable=True
        MeshFile=your_gauge.gmt CollTarget=False HATTarget=False LODIn=(0.0) LODOut=(10.0)

        Instance=HLIGHTDS // Used for dash lights
        {
            Moveable=True
            MeshFile=hlglo_DS.gmt CollTarget=False HATTarget=False LODIn=(0.0) LODOut=(10.0)
        }
    }

6
---
Save GEN, and open RF2 to test result, you may need to adjust shader emissive color (or texture opacity of "dashlights01.dds") to have proper brightness in night.

7
---
Limitation: This switchable dashboard lights will only be visible in cockpit. And since all headlights moved into one .GMT, when hit a wall, left & right headlights may come off the same time.
