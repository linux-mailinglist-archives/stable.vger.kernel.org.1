Return-Path: <stable+bounces-98496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BDF9E43A8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 19:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC62B82B9E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682122EBCE;
	Wed,  4 Dec 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dytM1TlO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635B22EBC6;
	Wed,  4 Dec 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332341; cv=none; b=EX2Z7MCnRr7ehomjx+mCwjWQaydtSS6VwxlY0yqr2hON8xvyNB8vNirucfXJFYVwCECPAG7xNxPlMKyvElx9KOi3/i8Jvq8+NBnjvQFPlJa1tD85rYoOUy2zwSx7dTFm5HiMDGuH4E/0BORwg8gUVfpNi3P1pFkPx+s5+C/axgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332341; c=relaxed/simple;
	bh=R7psb2xCKVEVit1/Dw8mwbZOfN0k/ZJzdByyo0dt3vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSnF2DZ2UUFRhDp5CUbDESEJxEZ4b9gj4FaOALJw2CNnMgqdqlo4u+h6AmW9BRS+bwTrtOQc2wXl4biyWonh0L3MdorOuel5sKfqNf9KUNOv8rYmIgCd8V8PKOPzsrVnaYQ5z388mMGW/dFjIBNCo7ENyYtPFE9SIbyeh2t4E8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dytM1TlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30DBC4CECD;
	Wed,  4 Dec 2024 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332341;
	bh=R7psb2xCKVEVit1/Dw8mwbZOfN0k/ZJzdByyo0dt3vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dytM1TlOZ67V9iD8hoE7fqOhffjd0LAGxZdgIvLZyb8QvXmhk6URbzXyPEFiii9xV
	 asCsFZEloaXFyBg3oncqyFDTVTtgvvggJ6Vur/fsX4EV4F/QgvKrP6b19vFu9tpkM5
	 b+cDxYepLeoT+sASplB6pzeuV3G/kZy6WZdTWpD+9UWUBiXlk4gTaQqR1aLS63ZvFO
	 4GxvQeU0uf7quaS66iMXXtNnKmxhZpfz0b3tkrqpdsB6QCqqXnKR3midZEwWrdgtR3
	 VqZ+A0LbSYEB8yIAqkg4m0DYtbTnwb/ywCEOwpd2CiDU/ip/fcILLq0G4xsZwgjG6r
	 sba+DN9pU7TzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Amey Narkhede <ameynarkhede03@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	mariusz.tkaczyk@linux.intel.com,
	stuart.w.hayes@gmail.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 09/13] PCI: Add 'reset_subordinate' to reset hierarchy below bridge
Date: Wed,  4 Dec 2024 11:00:34 -0500
Message-ID: <20241204160044.2216380-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160044.2216380-1-sashal@kernel.org>
References: <20241204160044.2216380-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 2fa046449a82a7d0f6d9721dd83e348816038444 ]

The "bus" and "cxl_bus" reset methods reset a device by asserting Secondary
Bus Reset on the bridge leading to the device.  These only work if the
device is the only device below the bridge.

Add a sysfs 'reset_subordinate' attribute on bridges that can assert
Secondary Bus Reset regardless of how many devices are below the bridge.

This resets all the devices below a bridge in a single command, including
the locking and config space save/restore that reset methods normally do.

This may be the only way to reset devices that don't support other reset
methods (ACPI, FLR, PM reset, etc).

Link: https://lore.kernel.org/r/20241025222755.3756162-1-kbusch@meta.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
[bhelgaas: commit log, add capable(CAP_SYS_ADMIN) check]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Amey Narkhede <ameynarkhede03@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci | 11 +++++++++++
 drivers/pci/pci-sysfs.c                 | 26 +++++++++++++++++++++++++
 drivers/pci/pci.c                       |  2 +-
 drivers/pci/pci.h                       |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495b..7f3e6bc3ff0ff 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -163,6 +163,17 @@ Description:
 		will be present in sysfs.  Writing 1 to this file
 		will perform reset.
 
+What:		/sys/bus/pci/devices/.../reset_subordinate
+Date:		October 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		This is visible only for bridge devices. If you want to reset
+		all devices attached through the subordinate bus of a specific
+		bridge device, writing 1 to this will try to do it.  This will
+		affect all devices attached to the system through this bridge
+		similiar to writing 1 to their individual "reset" file, so use
+		with caution.
+
 What:		/sys/bus/pci/devices/.../vpd
 Date:		February 2008
 Contact:	Ben Hutchings <bwh@kernel.org>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 40cfa716392fb..4c6ff5249a953 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -517,6 +517,31 @@ static ssize_t bus_rescan_store(struct device *dev,
 static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
 							    bus_rescan_store);
 
+static ssize_t reset_subordinate_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *bus = pdev->subordinate;
+	unsigned long val;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val) {
+		int ret = __pci_reset_bus(bus);
+
+		if (ret)
+			return ret;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset_subordinate);
+
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -621,6 +646,7 @@ static struct attribute *pci_dev_attrs[] = {
 static struct attribute *pci_bridge_attrs[] = {
 	&dev_attr_subordinate_bus_number.attr,
 	&dev_attr_secondary_bus_number.attr,
+	&dev_attr_reset_subordinate.attr,
 	NULL,
 };
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 51407c376a222..50868daaecdcf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5869,7 +5869,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-static int __pci_reset_bus(struct pci_bus *bus)
+int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7c06e55c5072e..822269cd67bed 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -89,6 +89,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
+int __pci_reset_bus(struct pci_bus *bus);
 
 struct pci_cap_saved_data {
 	u16		cap_nr;
-- 
2.43.0


