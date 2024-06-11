GADGET_SERIAL_VERSION = 1.0
GADGET_SERIAL_SITE_METHOD = local
GADGET_SERIAL_SITE = $(LINUX_DIR)/drivers/usb/gadget

GADGET_SERIAL_MODULE_MAKE_OPTS = \
	KSRC=$(LINUX_DIR) \
	KVERSION=$(LINUX_VERSION_PROBED) \
	CONFIG_USB_GADGET=y \
	CONFIG_USB_OTG=y \
	CONFIG_USB_DWC2_DEVICE_ONLY=y \
	CONFIG_USB_DWC3=y \
	CONFIG_USB_G_SERIAL=m \
	CONFIG_USB_LIBCOMPOSITE=m \
	CONFIG_USB_GADGET_VBUS_DRAW=2 \
	CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

define GADGET_SERIAL_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_GADGET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_DWC2_DEVICE_ONLY)
        $(call KCONFIG_SET_OPT,CONFIG_USB_GADGET_VBUS_DRAW,2)
#	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_OTG)
#        $(call KCONFIG_SET_OPT,CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS,2)
#        $(call KCONFIG_SET_OPT,CONFIG_USB_LIBCOMPOSITE,m)
#        $(call KCONFIG_ENABLE_OPT,CONFIG_USB_F_ACM)
#        $(call KCONFIG_ENABLE_OPT,CONFIG_USB_U_SERIAL)
#        $(call KCONFIG_ENABLE_OPT,CONFIG_USB_F_SERIAL)
#        $(call KCONFIG_ENABLE_OPT,CONFIG_USB_F_OBEX)
#        $(call KCONFIG_SET_OPT,CONFIG_USB_CONFIGFS,m)
#        $(call KCONFIG_SET_OPT,CONFIG_USB_GADGETFS,m)
#	$(call KCONFIG_SET_OPT,CONFIG_USB_G_SERIAL,m)
#	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_DWC3)
#        $(call KCONFIG_ENABLE_OPT,CONFIG_USB_CONFIGFS_SERIAL)
#        $(call KCONFIG_ENABLE_OPT,CONFIG_USB_CONFIGFS_ACM)
endef

define GADGET_SERIAL_INSTALL_SCRIPTS
	$(INSTALL) -m 755 -d $(TARGET_DIR)/etc/init.d
	$(INSTALL) -m 755 -t $(TARGET_DIR)/etc/init.d/ $(GADGET_SERIAL_PKGDIR)/files/S91gadget-serial
endef
GADGET_SERIAL_POST_INSTALL_TARGET_HOOKS += GADGET_SERIAL_INSTALL_SCRIPTS

$(eval $(kernel-module))
$(eval $(generic-package))
