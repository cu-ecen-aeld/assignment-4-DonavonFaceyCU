
##############################################################
#
# LDD3
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = 97f9a73e29c8902dbab0b562682b94ad45b84065
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-DonavonFaceyCU.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

LDD_MODULE_SUBDIRS = misc-modules scull
LDD_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

#TODO: Fix
#define LDD_BUILD_CMDS
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/scull
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(KERNEL_DIR) M=$(@D)/scull ARCH=arm64 CROSS_COMPILE=$(TARGET_CROSS) modules
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(KERNEL_DIR) M=$(@D)/misc-modules ARCH=arm64 CROSS_COMPILE=$(TARGET_CROSS) modules
#
#endef

# TODO: Fix
define LDD_INSTALL_TARGET_CMDS

	$(INSTALL) -d 0755 $(BR2_EXTERNAL)/rootfs_overlay/etc/init.d/
	$(INSTALL) -m 0755 $(@D)/init $(BR2_EXTERNAL)/rootfs_overlay/etc/init.d/S98lddmodules
	
	$(INSTALL) -d 0755 $(BR2_EXTERNAL)/rootfs_overlay/bin/
	$(INSTALL) -m 0755 $(@D)/scull/scull_load $(BR2_EXTERNAL)/rootfs_overlay/bin/
	$(INSTALL) -m 0755 $(@D)/scull/scull_unload $(BR2_EXTERNAL)/rootfs_overlay/bin/
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(BR2_EXTERNAL)/rootfs_overlay/bin/
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(BR2_EXTERNAL)/rootfs_overlay/bin/
	
	$(INSTALL) -d 0755 $(BR2_EXTERNAL)/rootfs_overlay/lib/modules/$(LINUX_KERNEL_VERSION)/
	$(INSTALL) -m 0755 $(@D)/scull/scull.ko $(BR2_EXTERNAL)/rootfs_overlay/lib/modules/$(LINUX_KERNEL_VERSION)/
	$(INSTALL) -m 0755 $(@D)/misc-modules/hello.ko $(BR2_EXTERNAL)/rootfs_overlay/lib/modules/$(LINUX_KERNEL_VERSION)/
endef

$(eval $(kernel-module))
$(eval $(generic-package))
