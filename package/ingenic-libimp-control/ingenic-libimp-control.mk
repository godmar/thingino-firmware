################################################################################
#
# ingenic-libimp-control
#
################################################################################

INGENIC_LIBIMP_CONTROL_SITE_METHOD = git
INGENIC_LIBIMP_CONTROL_SITE = https://github.com/gtxaspec/libimp_control
INGENIC_LIBIMP_CONTROL_VERSION = $(shell git ls-remote $(INGENIC_LIBIMP_CONTROL_SITE) HEAD | head -1 | cut -f1)

define INGENIC_LIBIMP_CONTROL_BUILD_CMDS
	$(MAKE) CONFIG_SOC=$(SOC_FAMILY) CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)
endef

define INGENIC_LIBIMP_CONTROL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libimp_control.so $(TARGET_DIR)/usr/lib
	$(INSTALL) -m 755 -t $(TARGET_DIR)/usr/sbin $(INGENIC_LIBIMP_CONTROL_PKGDIR)/src/imp-control
	$(INSTALL) -m 755 -d $(TARGET_DIR)/etc/init.d
	$(INSTALL) -m 755 -t $(TARGET_DIR)/etc/init.d $(INGENIC_LIBIMP_CONTROL_PKGDIR)/src/S96impconfig
endef

$(eval $(generic-package))
