# Copyright (C) 2016 Daniel Calviño Sánchez <danxuliu@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

PRODUCT_NAME := twrp_g700
PRODUCT_DEVICE := g700
PRODUCT_BRAND := TWRP
PRODUCT_MODEL := Team Win Recovery Project on g700
PRODUCT_MANUFACTURER := Huawei

# The standard configuration builds a kernel too large that causes the recovery
# image to not fit in the recovery partition. Therefore, a specific
# configuration that builds a smaller kernel targeted at recovery images is
# needed.
TARGET_KERNEL_CONFIG := fp1recovery_defconfig

# TWRP reads the partition configuration, which uses a TWRP-specific format,
# from "/etc/twrp.fstab", so the TWRP-specific fstab file has to be copied to
# "recovery/root/etc/twrp.fstab".
#
# TWRP does not use Vold, so there is no need to copy the recovery.fstab file to
# "root/fstab.mt6589" or "recovery/root/fstab.mt6589".
PRODUCT_COPY_FILES += \
	device/huawei/g700/twrp.fstab:recovery/root/etc/twrp.fstab

# As this is a minimal TWRP product Makefile it does not inherit from other
# common product configurations like "$(SRC_TARGET_DIR)/product/base.mk", so the
# ADB daemon must be explicitly included in the recovery.
PRODUCT_PACKAGES += \
	adbd

# The Fairphone 1 display has a resolution of 540x960, which is one of the
# values associated to PORTRAIT_MDPI in "bootable/recovery/gui/Android.mk" in
# the conversion from the old DEVICE_RESOLUTION flag to the new TW_THEME flag.
TW_THEME := portrait_hdpi

# The Fairphone 1 comes already rooted, so there is no need to install SuperSu.
# Moreover, as far as I know, SuperSu is proprietary software, and I would like
# to keep proprietary software to a minimum, specially when there are Free/Open
# Source Software alternatives.
TW_EXCLUDE_SUPERSU := true

# The default LUN file path used by TWRP is
# "/sys/class/android_usb/android0/f_mass_storage/lun%d/file". However, the LUN
# files in the Fairphone 1 are located in "[...]/lun/file" and
# "[...]/lun1/file"; although the second one matches the default path the first
# one does not, which causes an error when trying to mount the storage and also
# prevents the second one from being used. Therefore, a custom LUN file path
# that matches the path to the first LUN file must be used.
#
# As the code expects the path to contain no regular expression or a regular
# expression with a replaceable digit it is not possible to match both the first
# and second LUN file paths with a single path. Due to this only one storage can
# be mounted at a time (using the first LUN), but this does not limit which
# storages can be mounted; simply changing the current storage before mounting
# it is enough to mount a different one.
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun%d/file"
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720
TW_THEME := portrait_hdpi
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
TW_INTERNAL_STORAGE_PATH := "/sdcard"
TW_INTERNAL_STORAGE_MOUNT_POINT := "sdcard"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_INCLUDE_JB_CRYPTO := true
TW_CRYPTO_FS_TYPE := "ext4"
TW_CRYPTO_REAL_BLKDEV := "/dev/block/mmcblk0p8"
TW_CRYPTO_MNT_POINT := "/data"
TW_CRYPTO_FS_OPTIONS := "nosuid,nodev,noatime,discard,noauto_da_alloc,data=ordered"
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone1/temp
TW_BRIGHTNESS_PATH := /sys/devices/platform/leds-mt65xx/leds/lcd-backlight/brightness
TW_NO_SCREEN_BLANK := true
TW_EXTRA_LANGUAGES := true
TW_BUILD_ZH_CN_SUPPORT := false
TW_DEFAULT_LANGUAGE := en_EN
TARGET_RECOVERY_FSTAB := $(DEVICE_FOLDER)/rootdir/recovery.fstab
TARGET_PREBUILT_RECOVERY_KERNEL := $(DEVICE_FOLDER)/prebuilt/kernel_rec
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true
TW_NO_REBOOT_BOOTLOADER := true
TW_CUSTOM_BATTERY_PATH := /sys/devices/platform/mt6320-battery/power_supply/battery
