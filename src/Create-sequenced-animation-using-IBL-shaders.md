# Create sequenced animation using IBL shaders

RF2's new IBL shaders has support for "sequenced animation", which a series of sequenced textures get played. However current "Material Editor" doesn't include options to enable and adjust this function.

Here is a method to enable "sequenced animation" for IBL shaders by manually editing material JSON file.

1
---
You will need to generate material JSON file using "Material Editor". Once saved, exit to main screen of DEV mode.

2
---
Open JSON file with notepad, find a line called "FrameCount":1, 

Note: there may be a few FrameCount lines, but each should be contained in their own section (inside brackets). You will need to find one of the section that also contains "Name":"albedoMap", it will looks like this:

    {
        "AnisoLevel": 0,
        "ChromaColor": 0,
        "Flags": [
            "CUBETF_AUTOMIPMAP",
            "CUBETF_TRILINEAR",
            "CUBETF_CHROMAKEY",
            "CUBETF_OWNEDBYMATERIAL",
            "CUBETF_NOZBUFFERREQUIRED"
        ],
        "FrameCount": 1,
        "MipBias": 0,
        "MipLevels": -1,
        "Name": "albedoMap",
        "ShaderPass": 0,
        "ShadowMipBias": 0,
        "StageType": "CUBETST_SRGB",
        "TexChannel": 0,
        "Texture": "bird",
        "hasDefault": true,
        "inactive": false,
        "runtime": false
    },

3
---
Now you need to add a few extra lines into above code, see code below:

    {
        "AnisoLevel": 0,
        "ChromaColor": 0,
        "Flags": [
            "CUBETF_AUTOMIPMAP",
            "CUBETF_TRILINEAR",
            "CUBETF_CHROMAKEY",
            "CUBETF_OWNEDBYMATERIAL",
            "CUBETF_NOZBUFFERREQUIRED"
        ],
        "FrameCount": 14,
        "Method": "CUBETAM_CYCLE",
        "MipBias": 0,
        "MipLevels": -1,
        "Name": "albedoMap",
        "Rate": 6,
        "Sequence": [
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13
        ],
        "ShaderPass": 0,
        "ShadowMipBias": 0,
        "SkipFrame0": false,
        "StageType": "CUBETST_SRGB",
        "TexChannel": 0,
        "Texture": "bird",
        "hasDefault": true,
        "inactive": false,
        "runtime": false
    },

## Parameter explain

### "FrameCount":14

This is the total different amount sequenced textures, and this must set correctly, otherwise game crashes.

### "Method":"CUBETAM_CYCLE"

This is the type of animation, there are total 6 types (info extracted from UI file), which are Cycle, Pendulum, One Shot, Transient, Random, Manual. For normal looping animation, only Cycle is needed, which writes as CUBETAM_CYCLE.

### "Rate":6

This is the update frequency (play speed), value 1 = 1 texture per second, value 2 = 2 texture per sec, value 0.5 = 1 texture per 2 seconds.

### "Sequence"

Is a list of texture frame index that plays in listed order, value 0 means texture name + 00. In this case, 0 = bird00.dds, and 5 = bird05.dds, etc. You can add as many sequence as you want, but all frame index must have its corresponding texture. Note that last line of number does not have a comma. (JSON file must be written with correct format)

### "SkipFrame0":false

This line determines whether skip frame 0, and must be added to JSON, otherwise game crashes. If you set this value to "true", it will skip bird00.dds in this case.

### "Texture":"bird"

This is the prefix of sequenced textures, in this case, all your textures will be named as bird00.dds bird01.dds bird02.dds , etc.

## Additional notes

Once added those lines, and have done preparing textures with correct names, it should work in game. If it doesn't, check JSON format for possible typing error or missing lines. This method is only a temporally workaround until 397 would add "sequenced animation" options to Material Editor.

Note there is a line called "CUBETF_CHROMAKEY", this line is used to add "alpha chroma blending" transparency to material. If you don't need transparency, then you can safely remove this line.

Also note that you can add sequenced animation to other material, such as normal map for water animation (you will add all those lines into sections that contains "Name":"normalMap", )

## Important notes

Currently for JSON file with sequenced animation, material editor can not edit them.

Changing any parameter in material editor will cause animation to stop playing, and requires reloading track to get animation playing again.

Changing shader type in material editor may result lossing the manually added animation code.

## Add Doubleside property to IBL shaders

In old shaders, there is an property to turn a single side face object as Doubleside. For new IBL shaders, you can do this by manually add "CUBEMAT_TWOSIDED", line in the beginning of JSON file's "flags" section, such as:

    {
        "dstBlend":"CUBEAB_ZERO",
        "flags":[
        "CUBEMAT_AMBIENTMAT",
        "CUBEMAT_TWOSIDED",
        "CUBEMAT_DIFFUSEMAT",
        "CUBEMAT_SPECLARDIR",
        "CUBEMAT_EMISSIVMAT",
        "CUBEMAT_EMISSIVDIR"
    ],
