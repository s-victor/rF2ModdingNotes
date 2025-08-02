# Common modding issues

This note lists some common modding issues.

## Load track mod crashes server

This can be caused by missing "cap end of path segment" from track AIW file. To fix, mark "cap end of path segment" on the "end node" of each pit lane extension path.

## Shadow flickering or missing

This can happen if the shadow is cast from a single big object. To fix, split the single object into multiple smaller objects.

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
