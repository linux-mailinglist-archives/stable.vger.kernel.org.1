Return-Path: <stable+bounces-4463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E61804794
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0E61C20E17
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20248BF8;
	Tue,  5 Dec 2023 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLNvpzWI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9B6FB1;
	Tue,  5 Dec 2023 03:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA3AC433C9;
	Tue,  5 Dec 2023 03:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747618;
	bh=4lSkhlKctdxIlB5XmguWdDWiW6snkK3tcLopAKHZ3fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLNvpzWI+aLcwnn+XAeuJzIAP0Qh1eRIMndhgjhaIAyjGRoS4pGYAiil6Zl6wITf/
	 gPR3OQi0HFXzVXYoFQGz9hQuG0IQDPdBs2rtx7AacsYMUcO/4XXJmlEm5jSpUdakFH
	 Kqht9NmZgSXB7eBisDGY/epVsgVIHpApnrpeARAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 117/135] driver core: Move the "removable" attribute from USB to core
Date: Tue,  5 Dec 2023 12:17:18 +0900
Message-ID: <20231205031538.216869785@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rajat Jain <rajatja@google.com>

[ Upstream commit 70f400d4d957c2453c8689552ff212bc59f88938 ]

Move the "removable" attribute from USB to core in order to allow it to be
supported by other subsystem / buses. Individual buses that want to support
this attribute can populate the removable property of the device while
enumerating it with the 3 possible values -
 - "unknown"
 - "fixed"
 - "removable"
Leaving the field unchanged (i.e. "not supported") would mean that the
attribute would not show up in sysfs for that device. The UAPI (location,
symantics etc) for the attribute remains unchanged.

Move the "removable" attribute from USB to the device core so it can be
used by other subsystems / buses.

By default, devices do not have a "removable" attribute in sysfs.

If a subsystem or bus driver wants to support a "removable" attribute, it
should call device_set_removable() before calling device_register() or
device_add(), e.g.:

    device_set_removable(dev, DEVICE_REMOVABLE);
    device_register(dev);

The possible values and the resulting sysfs attribute contents are:

    DEVICE_REMOVABLE_UNKNOWN  ->  "unknown"
    DEVICE_REMOVABLE          ->  "removable"
    DEVICE_FIXED              ->  "fixed"

Convert the USB "removable" attribute to use this new device core
functionality.  There should be no user-visible change in the location or
semantics of attribute for USB devices.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rajat Jain <rajatja@google.com>
Link: https://lore.kernel.org/r/20210524171812.18095-1-rajatja@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 432e664e7c98 ("drm/amdgpu: don't use ATRM for external devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-usb       | 11 ------
 .../ABI/testing/sysfs-devices-removable       | 17 +++++++++
 drivers/base/core.c                           | 28 ++++++++++++++
 drivers/usb/core/hub.c                        | 13 ++++---
 drivers/usb/core/sysfs.c                      | 24 ------------
 include/linux/device.h                        | 37 +++++++++++++++++++
 include/linux/usb.h                           |  7 ----
 7 files changed, 89 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-removable

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index bf2c1968525f0..73eb23bc1f343 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -154,17 +154,6 @@ Description:
 		files hold a string value (enable or disable) indicating whether
 		or not USB3 hardware LPM U1 or U2 is enabled for the device.
 
-What:		/sys/bus/usb/devices/.../removable
-Date:		February 2012
-Contact:	Matthew Garrett <mjg@redhat.com>
-Description:
-		Some information about whether a given USB device is
-		physically fixed to the platform can be inferred from a
-		combination of hub descriptor bits and platform-specific data
-		such as ACPI. This file will read either "removable" or
-		"fixed" if the information is available, and "unknown"
-		otherwise.
-
 What:		/sys/bus/usb/devices/.../ltm_capable
 Date:		July 2012
 Contact:	Sarah Sharp <sarah.a.sharp@linux.intel.com>
diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
new file mode 100644
index 0000000000000..acf7766e800bd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-removable
@@ -0,0 +1,17 @@
+What:		/sys/devices/.../removable
+Date:		May 2021
+Contact:	Rajat Jain <rajatxjain@gmail.com>
+Description:
+		Information about whether a given device can be removed from the
+		platform by the	user. This is determined by its subsystem in a
+		bus / platform-specific way. This attribute is only present for
+		devices that can support determining such information:
+
+		"removable": device can be removed from the platform by the user
+		"fixed":     device is fixed to the platform / cannot be removed
+			     by the user.
+		"unknown":   The information is unavailable / cannot be deduced.
+
+		Currently this is only supported by USB (which infers the
+		information from a combination of hub descriptor bits and
+		platform-specific data such as ACPI).
diff --git a/drivers/base/core.c b/drivers/base/core.c
index cb859febd03cf..d98cab88c38af 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2053,6 +2053,25 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(online);
 
+static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	const char *loc;
+
+	switch (dev->removable) {
+	case DEVICE_REMOVABLE:
+		loc = "removable";
+		break;
+	case DEVICE_FIXED:
+		loc = "fixed";
+		break;
+	default:
+		loc = "unknown";
+	}
+	return sysfs_emit(buf, "%s\n", loc);
+}
+static DEVICE_ATTR_RO(removable);
+
 int device_add_groups(struct device *dev, const struct attribute_group **groups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -2230,8 +2249,16 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_online;
 	}
 
+	if (dev_removable_is_valid(dev)) {
+		error = device_create_file(dev, &dev_attr_removable);
+		if (error)
+			goto err_remove_dev_waiting_for_supplier;
+	}
+
 	return 0;
 
+ err_remove_dev_waiting_for_supplier:
+	device_remove_file(dev, &dev_attr_waiting_for_supplier);
  err_remove_dev_online:
 	device_remove_file(dev, &dev_attr_online);
  err_remove_dev_groups:
@@ -2251,6 +2278,7 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_file(dev, &dev_attr_removable);
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index cfcd4f2ffffaa..331f41c6cc75e 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2450,6 +2450,8 @@ static void set_usb_port_removable(struct usb_device *udev)
 	u16 wHubCharacteristics;
 	bool removable = true;
 
+	dev_set_removable(&udev->dev, DEVICE_REMOVABLE_UNKNOWN);
+
 	if (!hdev)
 		return;
 
@@ -2461,11 +2463,11 @@ static void set_usb_port_removable(struct usb_device *udev)
 	 */
 	switch (hub->ports[udev->portnum - 1]->connect_type) {
 	case USB_PORT_CONNECT_TYPE_HOT_PLUG:
-		udev->removable = USB_DEVICE_REMOVABLE;
+		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
 		return;
 	case USB_PORT_CONNECT_TYPE_HARD_WIRED:
 	case USB_PORT_NOT_USED:
-		udev->removable = USB_DEVICE_FIXED;
+		dev_set_removable(&udev->dev, DEVICE_FIXED);
 		return;
 	default:
 		break;
@@ -2490,9 +2492,9 @@ static void set_usb_port_removable(struct usb_device *udev)
 	}
 
 	if (removable)
-		udev->removable = USB_DEVICE_REMOVABLE;
+		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
 	else
-		udev->removable = USB_DEVICE_FIXED;
+		dev_set_removable(&udev->dev, DEVICE_FIXED);
 
 }
 
@@ -2564,8 +2566,7 @@ int usb_new_device(struct usb_device *udev)
 	device_enable_async_suspend(&udev->dev);
 
 	/* check whether the hub or firmware marks this port as non-removable */
-	if (udev->parent)
-		set_usb_port_removable(udev);
+	set_usb_port_removable(udev);
 
 	/* Register the device.  The device driver is responsible
 	 * for configuring the device and invoking the add-device
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index a2ca38e25e0c3..35ce8b87e9396 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -298,29 +298,6 @@ static ssize_t urbnum_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(urbnum);
 
-static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
-{
-	struct usb_device *udev;
-	char *state;
-
-	udev = to_usb_device(dev);
-
-	switch (udev->removable) {
-	case USB_DEVICE_REMOVABLE:
-		state = "removable";
-		break;
-	case USB_DEVICE_FIXED:
-		state = "fixed";
-		break;
-	default:
-		state = "unknown";
-	}
-
-	return sprintf(buf, "%s\n", state);
-}
-static DEVICE_ATTR_RO(removable);
-
 static ssize_t ltm_capable_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -825,7 +802,6 @@ static struct attribute *dev_attrs[] = {
 	&dev_attr_avoid_reset_quirk.attr,
 	&dev_attr_authorized.attr,
 	&dev_attr_remove.attr,
-	&dev_attr_removable.attr,
 	&dev_attr_ltm_capable.attr,
 #ifdef CONFIG_OF
 	&dev_attr_devspec.attr,
diff --git a/include/linux/device.h b/include/linux/device.h
index 4f7e0c85e11fa..6394c4b70a090 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -348,6 +348,22 @@ enum dl_dev_state {
 	DL_DEV_UNBINDING,
 };
 
+/**
+ * enum device_removable - Whether the device is removable. The criteria for a
+ * device to be classified as removable is determined by its subsystem or bus.
+ * @DEVICE_REMOVABLE_NOT_SUPPORTED: This attribute is not supported for this
+ *				    device (default).
+ * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown.
+ * @DEVICE_FIXED: Device is not removable by the user.
+ * @DEVICE_REMOVABLE: Device is removable by the user.
+ */
+enum device_removable {
+	DEVICE_REMOVABLE_NOT_SUPPORTED = 0, /* must be 0 */
+	DEVICE_REMOVABLE_UNKNOWN,
+	DEVICE_FIXED,
+	DEVICE_REMOVABLE,
+};
+
 /**
  * struct dev_links_info - Device data related to device links.
  * @suppliers: List of links to supplier devices.
@@ -435,6 +451,9 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu:	Per device generic IOMMU runtime data
+ * @removable:  Whether the device can be removed from the system. This
+ *              should be set by the subsystem / bus driver that discovered
+ *              the device.
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -546,6 +565,8 @@ struct device {
 	struct iommu_group	*iommu_group;
 	struct dev_iommu	*iommu;
 
+	enum device_removable	removable;
+
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
@@ -781,6 +802,22 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline void dev_set_removable(struct device *dev,
+				     enum device_removable removable)
+{
+	dev->removable = removable;
+}
+
+static inline bool dev_is_removable(struct device *dev)
+{
+	return dev->removable == DEVICE_REMOVABLE;
+}
+
+static inline bool dev_removable_is_valid(struct device *dev)
+{
+	return dev->removable != DEVICE_REMOVABLE_NOT_SUPPORTED;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 8bc1119afc317..e02cf70ca52f6 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -478,12 +478,6 @@ struct usb_dev_state;
 
 struct usb_tt;
 
-enum usb_device_removable {
-	USB_DEVICE_REMOVABLE_UNKNOWN = 0,
-	USB_DEVICE_REMOVABLE,
-	USB_DEVICE_FIXED,
-};
-
 enum usb_port_connect_type {
 	USB_PORT_CONNECT_TYPE_UNKNOWN = 0,
 	USB_PORT_CONNECT_TYPE_HOT_PLUG,
@@ -710,7 +704,6 @@ struct usb_device {
 #endif
 	struct wusb_dev *wusb_dev;
 	int slot_id;
-	enum usb_device_removable removable;
 	struct usb2_lpm_parameters l1_params;
 	struct usb3_lpm_parameters u1_params;
 	struct usb3_lpm_parameters u2_params;
-- 
2.42.0




