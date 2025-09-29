# Common modding issues

This note lists some common modding issues.

## Load track mod crashes server

This can be caused by missing "cap end of path segment" from track AIW file. To fix, mark "cap end of path segment" on the "end node" of each pit lane extension path.

## Shadow flickering or missing

This can happen if the shadow is cast from a single big object. To fix, split the single object into multiple smaller objects.

## Disable "Receive Shadows" in IBL Shader

There is a workaround to disable "receive shadows" for any IBL shaders material. Just set "NormalShadowInfluence" value to something like 1000 or 10000 (depends how much you want to hide shadows related to sun angle), which offsets shadow projection far away from object's surface so shadows don't show. This can be done in "material editor" or manually editing material JSON file.

## Car or track mod setting or file not taking effect after changed

There are several mod settings from car and track that require a full-restart of game's DEV MODE to take effect. Those includes:
- Certain entries in vehicle "HDV" file.
- Vehicle "TBC" file.
- Vehicle "Upgrades.ini" file.
- Vehicle "VEH" file.
- Vehicle "CAM" file.
- Track "TDF" file.
- Track "CAM" file.
- Track "GDB" file.
- Track "WET" file.

There is also a case where you have one or more mod files with the same file name but in different sub folders. This can cause loading conflicts (not load the file you wanted), and only one of the files will be loaded in game. This can happen if you make backup copies of files in the mod folder. To fix, make sure the mod folder doesn't contain any files with same name. If you wish to backup files, put them either outside of game folder in another place; or ZIP them so game cannot load the backup; or rename the backup file with a different name.

## DEV MODE crashes when loading a track or car

There are several things can cause crash:
- Some objects in GMT file are missing material assignment. To fix, make sure each object has a material.
- Car physics files are not unpacked.

## Car texture flickering after car crashed or damaged

This can happen if a damageable parts (model) shared the same material with other non-damageable parts. To fix, use/assign a separated material for non-damageable parts, and use the material with damage effect for damageable parts only.

## Car falling off invisible hole or hitting invisible wall on track

Some times a track can have invisible hole or wall on track, while the track model is correct. This is usually caused by giant and complex collision 3D model, which causes game to generate wrong collision cache and resulting invisible hole or wall. To fix, split giant or complex object into multiple smaller objects.

## Track wall-stuck issue

Wall-stuck issue is commonly seen on track mods, where vehicle body or wheels can clip into a wall and stuck. This issue is caused by object with double-side meshes (inner and outer faces). To fix, either remove the inner faces (if inner faces are invisible from view); or, separate inner faces from outer faces (as separated objects), then remove collision tag (set `CollTarget=False`) from inner faces GMT.

## Raindrops appear too big on car body

Raindrop size is determined by car body (WCCARBODY) UV map. If UV map on car parts is too small, it will cause big raindrops.

## DXT5 or BC7 DDS format?

Since rF2 introduced PBR rendering, BC7 DDS format becomes standard for Albedo map, along with BC5 for Nm/Aos/Mr map. While DXT5 (or DXT1) is mostly used in old mods which gives less quality than BC7/BC5.

The easiest way is to use rF2 "MapConverter" which takes care of all the DDS format issue automatically. Just make sure each texture has the correct naming convention (suffix) as outlined in rF2 official guide.

## Missing UV channels

A common issue when working with old mods is that, sometimes a model doesn't contain UV map in secondary UV channels (channel 2, 3 ,4). And those missing UV channels can cause certain material shader not working correctly. For example, if a shader uses channel 2 for mapping normal map texture, but the 3D model doesn't have UV map in channel 2, then normal map cannot be rendered correctly.

There are a few methods to add back missing UV channels.

In blender:
1. Delete all secondary UV channels with "-" button from UV channel panel.
2. Click "+" button 3 times from UV channel panel, which will duplicate first channel.
3. (Optional)Rename the 3 new UV channel names for consistency and readability.

In 3dsimed:
1. Select object material, open "Material Edit" panel on the right
2. Click "Edit Channel Texture Coordinates" button, select "Copy UV" and "Copy UV channel 0 > 1", repeat this for "Copy UV channel 0 > 2", "Copy UV channel 0 > 3".
3. Save and export GMT object.

## Floating wheels in showroom

This is caused by missing pivot point from tyre/wheel/spindle objects. While rF2 can automatically calculate and add missing pivot point to those objects, it will however not applied to showroom. So to fix, manually add pivot point (at the center of each tyre) those objects.

## Misaligned steering wheel rotation along the axis

To fix, first measure the steering wheel axis angle (degree) from side view.

Then open `cockpitinfo.ini` file, find `SteeringWheelAxis=` line, then calculate `Sine` and `Cosine` of the axis angle, and put then in second and third values.

For example, if steering wheel axis angle is 20 degrees, then it will be:

> sin(20deg) = 0.3420

> cos(20deg) = 0.9396

And final setting:

> SteeringWheelAxis=(0, 0.3420, 0.9396)
