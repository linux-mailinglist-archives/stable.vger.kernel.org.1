Return-Path: <stable+bounces-134558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C2A93646
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 13:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD763BE758
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA320A5F8;
	Fri, 18 Apr 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+m5Zjof"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC851D5170
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974121; cv=none; b=jLOeLR6V3e811He3hi/CDX/A4UpwTfU6hJHwgU33tiULNzGHURuGQEflJROwYehnvEWlLctFWl3Ek+ORcpb2uXVe6Fufjh17RUA//s7AKcKSD3N+L/f5abLippQ9T0ms1z1C0dlvsyp/yJU9hGX31D2WmAnBrNVTxQX9bW2ned0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974121; c=relaxed/simple;
	bh=vcAJ7BjULUmeZsVD2rq6V2e9geog0+cIeKX0eSlzDHM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sn0lndcmnLVp27Tzu8tyIfnMajsrm0DO6nPy35Z9UIsYQTLlfBycEGWm5snvOXrYRHW8MMt1B9trN/kVG56zzNg3lH5Wk1QFOx2/mjQJGu6fyLPdHdPjDuQ/P1sxe0rDBW+bDNFEQKFxRXZsAa6xF/L2RgnMGYNhujRBRopcJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+m5Zjof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A43C4CEE2;
	Fri, 18 Apr 2025 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744974120;
	bh=vcAJ7BjULUmeZsVD2rq6V2e9geog0+cIeKX0eSlzDHM=;
	h=Subject:To:Cc:From:Date:From;
	b=1+m5ZjofKDtDg5OrxXm3SDsiaNYAsfQ+Q5qMVQe6ttvhpgKp/nC4w8NqSdxvtDH2W
	 0jM5YG7Ze8CsgVOFRYYP6/LnkCNeYsWXF+LZjdg33m9WKSpW6rs5sZYvroNNRPutHa
	 e5TW4qO88dxgmuH4MAq+Vvho5fO103Ns8vRPzQog=
Subject: FAILED: patch "[PATCH] s390/pci: Support mmap() of PCI resources except for ISM" failed to apply to 6.14-stable tree
To: schnelle@linux.ibm.com,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Apr 2025 13:01:57 +0200
Message-ID: <2025041857-overshoot-recast-f09d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x aa9f168d55dc47c0de564f7dfe0e90467c9fee71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041857-overshoot-recast-f09d@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa9f168d55dc47c0de564f7dfe0e90467c9fee71 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 26 Feb 2025 13:07:47 +0100
Subject: [PATCH] s390/pci: Support mmap() of PCI resources except for ISM
 devices

So far s390 does not allow mmap() of PCI resources to user-space via the
usual mechanisms, though it does use it for RDMA. For the PCI sysfs
resource files and /proc/bus/pci it defines neither HAVE_PCI_MMAP nor
ARCH_GENERIC_PCI_MMAP_RESOURCE. For vfio-pci s390 previously relied on
disabled VFIO_PCI_MMAP and now relies on setting pdev->non_mappable_bars
for all devices.

This is partly because access to mapped PCI resources from user-space
requires special PCI load/store memory-I/O (MIO) instructions, or the
special MMIO syscalls when these are not available. Still, such access is
possible and useful not just for RDMA, in fact not being able to mmap() PCI
resources has previously caused extra work when testing devices.

One thing that doesn't work with PCI resources mapped to user-space though
is the s390 specific virtual ISM device. Not only because the BAR size of
256 TiB prevents mapping the whole BAR but also because access requires use
of the legacy PCI instructions which are not accessible to user-space on
systems with the newer MIO PCI instructions.

Now with the pdev->non_mappable_bars flag ISM can be excluded from mapping
its resources while making this functionality available for all other PCI
devices. To this end introduce a minimal implementation of PCI_QUIRKS and
use that to set pdev->non_mappable_bars for ISM devices only. Then also set
ARCH_GENERIC_PCI_MMAP_RESOURCE to take advantage of the generic
implementation of pci_mmap_resource_range() enabling only the newer sysfs
mmap() interface. This follows the recommendation in
Documentation/PCI/sysfs-pci.rst.

Link: https://lore.kernel.org/r/20250226-vfio_pci_mmap-v7-3-c5c0f1d26efd@linux.ibm.com
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9c9ec08d78c7..e48741e00147 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -41,9 +41,6 @@ config AUDIT_ARCH
 config NO_IOPORT_MAP
 	def_bool y
 
-config PCI_QUIRKS
-	def_bool n
-
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
@@ -258,6 +255,7 @@ config S390
 	select PCI_DOMAINS		if PCI
 	select PCI_MSI			if PCI
 	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
+	select PCI_QUIRKS		if PCI
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 474e1f8d1d3c..d2086af3434c 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -11,6 +11,9 @@
 #include <asm/pci_insn.h>
 #include <asm/sclp.h>
 
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
+#define arch_can_pci_mmap_wc()		1
+
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
index df73c5182990..1810e0944a4e 100644
--- a/arch/s390/pci/Makefile
+++ b/arch/s390/pci/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o \
 			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
-			   pci_bus.o pci_kvm_hook.o pci_report.o
+			   pci_bus.o pci_kvm_hook.o pci_report.o pci_fixup.o
 obj-$(CONFIG_PCI_IOV)	+= pci_iov.o
 obj-$(CONFIG_SYSFS)	+= pci_sysfs.o
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index d14b8605a32c..88f72745fa59 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -590,7 +590,6 @@ int pcibios_device_add(struct pci_dev *pdev)
 	zpci_zdev_get(zdev);
 	if (pdev->is_physfn)
 		pdev->no_vf_scan = 1;
-	pdev->non_mappable_bars = 1;
 
 	zpci_map_resources(pdev);
 
diff --git a/arch/s390/pci/pci_fixup.c b/arch/s390/pci/pci_fixup.c
new file mode 100644
index 000000000000..35688b645098
--- /dev/null
+++ b/arch/s390/pci/pci_fixup.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Exceptions for specific devices,
+ *
+ * Copyright IBM Corp. 2025
+ *
+ * Author(s):
+ *   Niklas Schnelle <schnelle@linux.ibm.com>
+ */
+#include <linux/pci.h>
+
+static void zpci_ism_bar_no_mmap(struct pci_dev *pdev)
+{
+	/*
+	 * ISM's BAR is special. Drivers written for ISM know
+	 * how to handle this but others need to be aware of their
+	 * special nature e.g. to prevent attempts to mmap() it.
+	 */
+	pdev->non_mappable_bars = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM,
+			PCI_DEVICE_ID_IBM_ISM,
+			zpci_ism_bar_no_mmap);
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index e36e3ea165d3..d32633ed9fa8 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -20,7 +20,6 @@
 MODULE_DESCRIPTION("ISM driver for s390");
 MODULE_LICENSE("GPL");
 
-#define PCI_DEVICE_ID_IBM_ISM 0x04ED
 #define DRV_NAME "ism"
 
 static const struct pci_device_id ism_device_table[] = {
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index de5deb1a0118..e0cdc290dff5 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -518,6 +518,7 @@
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM_PCIE 0x0361
 #define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252
+#define PCI_DEVICE_ID_IBM_ISM		0x04ed
 
 #define PCI_SUBVENDOR_ID_IBM		0x1014
 #define PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT	0x03d4


