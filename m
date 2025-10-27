Return-Path: <stable+bounces-190158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49BC10131
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7647C4FDFE3
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2B31D36F;
	Mon, 27 Oct 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2O8E0tC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7331B82C
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590574; cv=none; b=ZSzIiN4XUzl3dpFj+0vFc/mn3snWJQZs9RAX+Mr5lcTjsR286wmGCJACLYvnGxIzwXz9i+G3cWCpTbtAv61Zaxu6++jR3Ld/xMaQ6MLmshQez5TE/Hk0Z3AHIF5F5rfMVq4s4v+oG/CVRsdpc54paa/RKxV4JrZjpxrEuMlMfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590574; c=relaxed/simple;
	bh=X7jgqmL9jvy58Cga2uMsGGkQHKbNvqujn2EX/euXAYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrgozwVsf42jsN8q3VOvUYKuX1JoYo2pZ+Sjz528xxGbQpQgtaWlEwbUSs3zt1TFcC8tYbjY/kdlyifI5p+42V4w4lleOyiYjW5Ksi/Baqwh/S5BoykouR0Q1wIyzOXDoBe9sX0WMQHjcnaGqC2MRWbBB+Bh4A3hWpVrm+CZdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2O8E0tC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2EDC4CEF1;
	Mon, 27 Oct 2025 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590574;
	bh=X7jgqmL9jvy58Cga2uMsGGkQHKbNvqujn2EX/euXAYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2O8E0tCjE9lR/LgsdB8ltz7EN3dcvJpxHSXly9+D9b0t4HV+5YQxMme9O2LUdFvC
	 bQ1ULX1q6ysgrYODOSB5muNSQio07POcoMXM2KzqsvdgrqRyXaRKL1hA036zcyqKqq
	 JM5CNDRoUS9B+gF8j8ghWl/hfsM44pPS4YS7MpUEiy7c6OWlaxZ7xeNL09hBrBX3rt
	 brIsX5tk8DoO0/svxj+F61BhVOoU8TCrnoFE8/ze68oe6rAB/c6qHryr+xUaQSHWzJ
	 vVVysldN3mJYbR8Ygmwx1QXrTAia07Zszf/EexPY2nv39jv4zWIDDxAZs5oyWGlVkc
	 6oNwMklZO19AA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] xhci: dbc: Provide sysfs option to configure dbc descriptors
Date: Mon, 27 Oct 2025 14:42:47 -0400
Message-ID: <20251027184252.639069-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102714-patriot-eel-32c8@gregkh>
References: <2025102714-patriot-eel-32c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit edf1664f3249a091a2b91182fc087b3253b0b4c2 ]

When DbC is enabled the first port on the xHC host acts as a usb device.
xHC provides the descriptors automatically when the DbC device is
enumerated. Most of the values are hardcoded, but some fields such as
idProduct, idVendor, bcdDevice and bInterfaceProtocol can be modified.

Add sysfs entries that allow userspace to change these.
User can only change them before dbc is enabled, i.e. before writing
"enable" to dbc sysfs file as we don't want these values to change while
device is connected, or during  enumeration.

Add documentation for these entries in
Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230317154715.535523-9-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f3d12ec847b9 ("xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/sysfs-bus-pci-drivers-xhci_hcd    |  52 +++++
 drivers/usb/host/xhci-dbgcap.c                | 191 +++++++++++++++++-
 drivers/usb/host/xhci-dbgcap.h                |   4 +
 3 files changed, 243 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd b/Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd
index 0088aba4caa86..5a775b8f65435 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd
+++ b/Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd
@@ -23,3 +23,55 @@ Description:
 		Reading this attribute gives the state of the DbC. It
 		can be one of the following states: disabled, enabled,
 		initialized, connected, configured and stalled.
+
+What:		/sys/bus/pci/drivers/xhci_hcd/.../dbc_idVendor
+Date:		March 2023
+Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
+Description:
+		This dbc_idVendor attribute lets us change the idVendor field
+		presented in the USB device descriptor by this xhci debug
+		device.
+		Value can only be changed while debug capability (DbC) is in
+		disabled state to prevent USB device descriptor change while
+		connected to a USB host.
+		The default value is 0x1d6b (Linux Foundation).
+		It can be any 16-bit integer.
+
+What:		/sys/bus/pci/drivers/xhci_hcd/.../dbc_idProduct
+Date:		March 2023
+Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
+Description:
+		This dbc_idProduct attribute lets us change the idProduct field
+		presented in the USB device descriptor by this xhci debug
+		device.
+		Value can only be changed while debug capability (DbC) is in
+		disabled state to prevent USB device descriptor change while
+		connected to a USB host.
+		The default value is 0x0010. It can be any 16-bit integer.
+
+What:		/sys/bus/pci/drivers/xhci_hcd/.../dbc_bcdDevice
+Date:		March 2023
+Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
+Description:
+		This dbc_bcdDevice attribute lets us change the bcdDevice field
+		presented in the USB device descriptor by this xhci debug
+		device.
+		Value can only be changed while debug capability (DbC) is in
+		disabled state to prevent USB device descriptor change while
+		connected to a USB host.
+		The default value is 0x0010. (device rev 0.10)
+		It can be any 16-bit integer.
+
+What:		/sys/bus/pci/drivers/xhci_hcd/.../dbc_bInterfaceProtocol
+Date:		March 2023
+Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
+Description:
+		This attribute lets us change the bInterfaceProtocol field
+		presented in the USB Interface descriptor by the xhci debug
+		device.
+		Value can only be changed while debug capability (DbC) is in
+		disabled state to prevent USB descriptor change while
+		connected to a USB host.
+		The default value is 1  (GNU Remote Debug command).
+		Other permissible value is 0 which is for vendor defined debug
+		target.
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 51a5767d3ece2..9a1728333affa 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -133,10 +133,10 @@ static void xhci_dbc_init_contexts(struct xhci_dbc *dbc, u32 string_length)
 	/* Set DbC context and info registers: */
 	lo_hi_writeq(dbc->ctx->dma, &dbc->regs->dccp);
 
-	dev_info = cpu_to_le32((DBC_VENDOR_ID << 16) | DBC_PROTOCOL);
+	dev_info = (dbc->idVendor << 16) | dbc->bInterfaceProtocol;
 	writel(dev_info, &dbc->regs->devinfo1);
 
-	dev_info = cpu_to_le32((DBC_DEVICE_REV << 16) | DBC_PRODUCT_ID);
+	dev_info = (dbc->bcdDevice << 16) | dbc->idProduct;
 	writel(dev_info, &dbc->regs->devinfo2);
 }
 
@@ -1044,7 +1044,186 @@ static ssize_t dbc_store(struct device *dev,
 	return count;
 }
 
+static ssize_t dbc_idVendor_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct xhci_dbc		*dbc;
+	struct xhci_hcd		*xhci;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+
+	return sprintf(buf, "%04x\n", dbc->idVendor);
+}
+
+static ssize_t dbc_idVendor_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t size)
+{
+	struct xhci_dbc		*dbc;
+	struct xhci_hcd		*xhci;
+	void __iomem		*ptr;
+	u16			value;
+	u32			dev_info;
+
+	if (kstrtou16(buf, 0, &value))
+		return -EINVAL;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+	if (dbc->state != DS_DISABLED)
+		return -EBUSY;
+
+	dbc->idVendor = value;
+	ptr = &dbc->regs->devinfo1;
+	dev_info = readl(ptr);
+	dev_info = (dev_info & ~(0xffffu << 16)) | (value << 16);
+	writel(dev_info, ptr);
+
+	return size;
+}
+
+static ssize_t dbc_idProduct_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct xhci_dbc         *dbc;
+	struct xhci_hcd         *xhci;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+
+	return sprintf(buf, "%04x\n", dbc->idProduct);
+}
+
+static ssize_t dbc_idProduct_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t size)
+{
+	struct xhci_dbc         *dbc;
+	struct xhci_hcd         *xhci;
+	void __iomem		*ptr;
+	u32			dev_info;
+	u16			value;
+
+	if (kstrtou16(buf, 0, &value))
+		return -EINVAL;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+	if (dbc->state != DS_DISABLED)
+		return -EBUSY;
+
+	dbc->idProduct = value;
+	ptr = &dbc->regs->devinfo2;
+	dev_info = readl(ptr);
+	dev_info = (dev_info & ~(0xffffu)) | value;
+	writel(dev_info, ptr);
+	return size;
+}
+
+static ssize_t dbc_bcdDevice_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct xhci_dbc	*dbc;
+	struct xhci_hcd	*xhci;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+
+	return sprintf(buf, "%04x\n", dbc->bcdDevice);
+}
+
+static ssize_t dbc_bcdDevice_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct xhci_dbc	*dbc;
+	struct xhci_hcd	*xhci;
+	void __iomem *ptr;
+	u32 dev_info;
+	u16 value;
+
+	if (kstrtou16(buf, 0, &value))
+		return -EINVAL;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+	if (dbc->state != DS_DISABLED)
+		return -EBUSY;
+
+	dbc->bcdDevice = value;
+	ptr = &dbc->regs->devinfo2;
+	dev_info = readl(ptr);
+	dev_info = (dev_info & ~(0xffffu << 16)) | (value << 16);
+	writel(dev_info, ptr);
+
+	return size;
+}
+
+static ssize_t dbc_bInterfaceProtocol_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct xhci_dbc	*dbc;
+	struct xhci_hcd	*xhci;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+
+	return sprintf(buf, "%02x\n", dbc->bInterfaceProtocol);
+}
+
+static ssize_t dbc_bInterfaceProtocol_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct xhci_dbc *dbc;
+	struct xhci_hcd *xhci;
+	void __iomem *ptr;
+	u32 dev_info;
+	u8 value;
+	int ret;
+
+	/* bInterfaceProtocol is 8 bit, but xhci only supports values 0 and 1 */
+	ret = kstrtou8(buf, 0, &value);
+	if (ret || value > 1)
+		return -EINVAL;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	dbc = xhci->dbc;
+	if (dbc->state != DS_DISABLED)
+		return -EBUSY;
+
+	dbc->bInterfaceProtocol = value;
+	ptr = &dbc->regs->devinfo1;
+	dev_info = readl(ptr);
+	dev_info = (dev_info & ~(0xffu)) | value;
+	writel(dev_info, ptr);
+
+	return size;
+}
+
 static DEVICE_ATTR_RW(dbc);
+static DEVICE_ATTR_RW(dbc_idVendor);
+static DEVICE_ATTR_RW(dbc_idProduct);
+static DEVICE_ATTR_RW(dbc_bcdDevice);
+static DEVICE_ATTR_RW(dbc_bInterfaceProtocol);
+
+static struct attribute *dbc_dev_attributes[] = {
+	&dev_attr_dbc.attr,
+	&dev_attr_dbc_idVendor.attr,
+	&dev_attr_dbc_idProduct.attr,
+	&dev_attr_dbc_bcdDevice.attr,
+	&dev_attr_dbc_bInterfaceProtocol.attr,
+	NULL
+};
+
+static const struct attribute_group dbc_dev_attrib_grp = {
+	.attrs = dbc_dev_attributes,
+};
 
 struct xhci_dbc *
 xhci_alloc_dbc(struct device *dev, void __iomem *base, const struct dbc_driver *driver)
@@ -1059,6 +1238,10 @@ xhci_alloc_dbc(struct device *dev, void __iomem *base, const struct dbc_driver *
 	dbc->regs = base;
 	dbc->dev = dev;
 	dbc->driver = driver;
+	dbc->idProduct = DBC_PRODUCT_ID;
+	dbc->idVendor = DBC_VENDOR_ID;
+	dbc->bcdDevice = DBC_DEVICE_REV;
+	dbc->bInterfaceProtocol = DBC_PROTOCOL;
 
 	if (readl(&dbc->regs->control) & DBC_CTRL_DBC_ENABLE)
 		goto err;
@@ -1066,7 +1249,7 @@ xhci_alloc_dbc(struct device *dev, void __iomem *base, const struct dbc_driver *
 	INIT_DELAYED_WORK(&dbc->event_work, xhci_dbc_handle_events);
 	spin_lock_init(&dbc->lock);
 
-	ret = device_create_file(dev, &dev_attr_dbc);
+	ret = sysfs_create_group(&dev->kobj, &dbc_dev_attrib_grp);
 	if (ret)
 		goto err;
 
@@ -1085,7 +1268,7 @@ void xhci_dbc_remove(struct xhci_dbc *dbc)
 	xhci_dbc_stop(dbc);
 
 	/* remove sysfs files */
-	device_remove_file(dbc->dev, &dev_attr_dbc);
+	sysfs_remove_group(&dbc->dev->kobj, &dbc_dev_attrib_grp);
 
 	kfree(dbc);
 }
diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index cdc22e8a752fb..34c20d6c9e559 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -131,6 +131,10 @@ struct xhci_dbc {
 	struct dbc_str_descs		*string;
 	dma_addr_t			string_dma;
 	size_t				string_size;
+	u16				idVendor;
+	u16				idProduct;
+	u16				bcdDevice;
+	u8				bInterfaceProtocol;
 
 	enum dbc_state			state;
 	struct delayed_work		event_work;
-- 
2.51.0


