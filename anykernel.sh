# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=boot;
is_slot_device=auto;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;
no_block_display=1
list=$home/files

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## Select the correct image to flash
userflavor="$(file_getprop /system/build.prop "ro.build.flavor")";
case "$userflavor" in
    missi-user) os="miui"; os_string="MIUI ROM";;
    missi_phoneext4_cn-user) os="miui"; os_string="MIUI ROM";;
    missi_phone_cn-user) os="miui"; os_string="MIUI ROM";;
    qssi-user) os="miui"; os_string="MIUI ROM";;
    *) os="miui"; os_string="AOSP ROM";;
esac;
ui_print "  -> $os_string is detected!";

list=files
file=$(cat ${list} | awk 'NR=='$1' {print $1}')

prepare_files() {
for file in $(cat ${list}); do
    ui_print $file
	if [ -f $home/kernels/$os/$file ]; then
		mv $home/kernels/$os/$file $home/$file
	else
		ui_print "  -> There is no kernel for your OS in this zip! Aborting..."
		break
	fi
done;
}

prepare_files

## AnyKernel boot install
split_boot;

flash_boot;
flash_dtbo;
## end boot install

# Vendor boot
#block=vendor_boot;
#is_slot_device=1;
#ramdisk_compression=auto;
#patch_vbmeta_flag=auto;

# reset for vendor_boot patching
#reset_ak;

## AnyKernel vendor_boot install
#split_boot;

#flash_boot;
## end vendor_boot install
