# Set initial garage position in AIW

Sometimes it is necessary to manually set initial garage position in AIW for a new track to avoid vehicle falling off track.

Open `*.AIW` file with notepad (if there is no AIW file, launch game to generate AIW first and save).

Find following section:

    [PITS]
    TeamIndex=0

Under TeamIndex=0, you can see 3 `GarPos` values. Each `GarPos` has 4 values, the first value should be left untouched. The 2nd 3rd 4th value are `XZY` position, which you just need to copy correct `XZY` value (the coordinates where you want to place the car) from 3dsimed or other 3d software. And remember to swap `Y` & `Z` value when copying `XYZ` value from 3d software (hence the order in AIW is `X Z Y` ), and also change `Z` value `0.5` meter higher to make sure car is above ground.

For example, before change:

    GarPos=(0,0.000,0.000,0.000)
    GarOri=(0,-0.005,-3.100,0.002)
    GarPos=(0,0.000,0.000,0.000)
    GarOri=(1,-0.004,-3.121,-0.001)
    GarPos=(0,0.000,0.000,0.000)
    GarOri=(2,-0.004,-3.121,-0.001)

After change:

    GarPos=(0,58.003,0.504,-19.204)
    GarOri=(0,-0.005,-3.100,0.002)
    GarPos=(1,56.164,0.507,-18.767)
    GarOri=(1,-0.004,-3.121,-0.001)
    GarPos=(2,54.364,0.510,-18.767)
    GarOri=(2,-0.004,-3.121,-0.001)
