
##############################################################
#
# AESDCHAR
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESDCHAR_VERSION = 6a7cc27036a006040127809dc0b5215ec2e4dc23
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESDCHAR_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-DonavonFaceyCU.git
AESDCHAR_SITE_METHOD = git
AESDCHAR_GIT_SUBMODULES = YES

AESDCHAR_MODULE_SUBDIRS = aesd-char-driver
AESDCHAR_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

#TODO: Fix
#define LDD_BUILD_CMDS
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/scull
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(KERNEL_DIR) M=$(@D)/scull ARCH=arm64 CROSS_COMPILE=$(TARGET_CROSS) modules
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(KERNEL_DIR) M=$(@D)/misc-modules ARCH=arm64 CROSS_COMPILE=$(TARGET_CROSS) modules
#
#endef

# TODO: Fix
define AESDCHAR_INSTALL_TARGET_CMDS
	echo "Placing AESDCHAR FILES"
	$(INSTALL) -d 0755 $(BR2_EXTERNAL)/rootfs_overlay/etc/init.d/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/init $(BR2_EXTERNAL)/rootfs_overlay/etc/init.d/S97aesdcharmodule
	
	$(INSTALL) -d 0755 $(BR2_EXTERNAL)/rootfs_overlay/bin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(BR2_EXTERNAL)/rootfs_overlay/bin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(BR2_EXTERNAL)/rootfs_overlay/bin/
	
	$(INSTALL) -d 0755 $(BR2_EXTERNAL)/rootfs_overlay/lib/modules/$(LINUX_KERNEL_VERSION)/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar.ko $(BR2_EXTERNAL)/rootfs_overlay/lib/modules/$(LINUX_KERNEL_VERSION)/
endef

$(eval $(kernel-module))
$(eval $(generic-package))
