# Create self-rotating billboards tree or similar objects using 3dsimed + gJED 

This is a quick method to create rF2's new self-rotating billboards tree using 3dsimed + gJED.

## Important note

All steps MUST be done in correct order, and do not skip any steps, else it will not work or resulting broken object.

"Stamp Vertex" shader MUST be assigned in 3dsimed because gJED needs it to properly convert object to billboards.

## In 3dsimed (must done this first)

1. Isolate all trees from other objects, then "explode" all objects into one piece. Then use "Purge vertices" & "Purge faces" function to make sure no broken vertices left in file.

2. "Batch" edit all material and set shader to any of the "Stamp Vertex" shaders, such as "T1 Stamp Vertex" or "Bump Specular Map T1 Stamp Vertex".

3. Press "Ctrl + A" and select "Faces > Vertices RGBA", change "Alpha" value to "254" then click OK.

4. Select "Save rFactor2 model" to export GMT.

## In gJED

1. Select "Open FBX/SCN" from menu, click "Open" and find the tree GMT file you saved (you maybe also need to set Path to texture folder). Then click "Load" at bottom.

2. On the tool bar, click 6th button "Pick instance from list", click the instance name (there should be only one in this example) and hit "OK".

3. On the tool bar, click 5th button "Open instance editor", find the section "Screen-Aligned Quads", and select "BB" box, then choose one of the 5 align methods button (they have different effects). You will see the tree rotating and facing you right way (if not, there must be something wrong with vertice alpha or shader setting, or the mesh is not a triangulated quad).

4. Last, on the tool bar, click 3rd button "Export meshes and mats to .gmt/.scn file", choose a folder, then hit Export All or Export Selected.
