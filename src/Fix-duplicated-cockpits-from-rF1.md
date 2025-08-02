# Fix duplicated cockpits from rF1 mods

## The issue

Some vehicle mods from rF1 (or same game engine) may consist 2 separated cockpit models: bigger model for cockpit view, and smaller for external view. It may also has 2 driver models, one for external view and can not move, and one that moves in cockpit view.

When converting those mods to rF2, it could result duplicated cockpits showing in game.

## The solution

You will need two `Instance=DRIVER` sections. One of the `Instance=DRIVER` that contains animated driver/arm GMT should be placed under `Instance=COCKPIT` section (make sure it is placed inside `Instance=COCKPIT` brackets). Another `Instance=DRIVER` is placed at normal position (anywhere inside `Instance=SLOT<ID>`) which contains static driver GMT.

## Additional notes

Anything inside `Instance=COCKPIT` section are only visible from cockpit view.
And any GMT lines placed between `Instance=SLOT<ID>` and `Actor=VEHICLE` are visible from all views.

The concept is to move rF1's "cockpit only" GMT into `Instance=COCKPIT` section, and keep "external only" GMT in separated own instance. And if you wish to show the same GMT for both view, either repeat it in both instance; Or, place it between `Instance=SLOT<ID>` and `Actor=VEHICLE`.
