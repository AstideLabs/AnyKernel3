### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=APTKernel by ApartTUSITU @ AstideLabs
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=alioth
device.name2=aliothin
device.name3=apollo
device.name4=apolloin
device.name5=lmi
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties


### AnyKernel install

# boot shell variables
BLOCK=boot;
IS_SLOT_DEVICE=auto;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

NO_BLOCK_DISPLAY=1

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

## Select the correct image to flash
userflavor="$(file_getprop /system/build.prop "ro.build.flavor")";
case "$userflavor" in
    missi*|qssi*) os="miui"; os_string="MIUI ROM";;
    *) os="aosp"; os_string="AOSP ROM";;
esac;
ui_print "  -> $os_string is detected!";
if [ -f $AKHOME/kernels/$os/Image ] && [ -f $AKHOME/kernels/$os/dtb ] && [ -f $AKHOME/kernels/$os/dtbo.img ]; then
    mv $AKHOME/kernels/$os/Image $AKHOME/Image;
    #mv $AKHOME/kernels/$os/dtb $AKHOME/dtb; # uncomment this
    #mv $AKHOME/kernels/$os/dtbo.img $AKHOME/dtbo.img; # uncomment this
else
    ui_print "  -> There is no kernel for $os_string in this zip! Aborting...";
    ui_print "  -> Please check that you have the correct kernel zip!";
    exit 1;
fi;
ui_print "  -> Flashing DTB and DTBO is not recommended by default.";
ui_print "  -> If you need to flash them, please uncomment the code in the script.";

# boot install
split_boot;
flash_boot;
#flash_dtbo; # uncomment this
## end boot install
