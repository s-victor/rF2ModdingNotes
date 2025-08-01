# Fix showroom upgrades models overlapping

## The issue

If a car has multiple upgrades of a single part, let's say `"Front Bumper"` , and you go into showroom to select one of the "Front Bumper" upgrades that isn't the first one on the list, you will see this "Front Bumper" is overlapping with the first one/3D model, same applies to all the other upgrades that ain't the first one.

This overlap issue only happens in Showroom(Spinner), everything works fine on track.

## The cause

1. Some weird naming is forced on upgrades, if you choose the wrong naming format, your upgrades will overlap each other, but this is not the only cause.
2. The `<something>` substitute must be a complete substitute of a file name, otherwise your upgrades will also overlap each other.

## The solution

1
---
All of the `<something>` substitute **MUST contain/start with the same name** from that "Instance" in **SPINNER.gen**.

Example: if instance named `"Instance=FBUMPER"` , then `"FBUMPER"` will be the prefix that you have to use for every substitute, such as `<FBUMPER01>` , `<FBUMPER_BIG>` , `<FBUMPERCOOL>` .

What won't work: anything doesn't start with `"FBUMPER"` , such as `<01FBUMPER>` , `<FRONTBUMPER01>` , etc.

2
---
Next, you need to **fully substitute a file name** in **SPINNER.gen**.

Example:
1. In **SPINNER.gen** wrote: `MeshFile=<FBUMPER01> CollTarget......`
2. In **UPGRADES.ini** wrote: `GEN=<FBUMPER01>=CAR_FBUMPER_LODA.gmt`

What won't work: a common practice is partially substitute a file name, which will cause ovelapping in Showroom, such as `MeshFile=CAR_FBUMPER_<FBUMPER01>.gmt` .

3
---
Now if you really want to partially substitute a file name (which makes life a lot easier for main .gen file), you can just **replace the partial one with full substitution in SPINNER.gen**, then add a corresponding entry in **UPGRADES.ini** as showroom workaround.

### Example

In main .gen

    Instance=FBUMPER
    {
        Moveable=True
        <MAX> MeshFile=CAR_FBUMPER_LOD<FBUMPER_TYPE>.gmt
        <HIGH> MeshFile=CAR_FBUMPER_LOD<FBUMPER_TYPE>.gmt
        <MED> MeshFile=CAR_FBUMPER_LOD<FBUMPER_TYPE>.gmt
    }

in SPINNER.gen

    Instance=FBUMPER<UPNUMBER>
    {
        Moveable=True
        MeshFile=<FBUMPER01>
    }

in UPGRADES.ini

    UpgradeType="Front Bumper"
    {
        Instance="FBUMPER"
        UpgradeLevel="Type A"
        {
            GEN=<FBUMPER01>=CAR_FBUMPER_LODA.gmt // showroom workaround
            GEN=<FBUMPER_TYPE>=A // for main gen
        }
        UpgradeLevel="Type B"
        {
            GEN=<FBUMPER01>=CAR_FBUMPER_LODB.gmt // showroom workaround
            GEN=<FBUMPER_TYPE>=B // for main gen
        }
    }

There is also another workaround: just hide the model in first upgrade level, so nothing can be overlapped, but not really useful.

## Additional notes about GEN upgrades tags

There is a common missing understanding and use of `<STARTUPGRADES>` and `<STOPUPGRADES>` tags in **GEN** file, where some practices believe that those two tags are required for both main **XXX.GEN** and showroom **XXX_spinner.GEN** file.

However that is not necessary, those two `<STARTUPGRADES>` and `<STOPUPGRADES>` tags are only required for **showroom GEN file**, which is **XXX_spinner.GEN**. It is no use and can be safely omitted from the main **XXX.GEN** file.
