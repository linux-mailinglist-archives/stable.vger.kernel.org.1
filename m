Return-Path: <stable+bounces-17494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F11C843A3C
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 10:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA061F2B78F
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 09:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090797868E;
	Wed, 31 Jan 2024 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJlt/Yed"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848F768FB
	for <stable@vger.kernel.org>; Wed, 31 Jan 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691655; cv=none; b=G/VWr4Luzvnw1M+C/10Mjr6/i8wa1Wzrtk9TS+L95XEJs15Qdq9uRBonFa+6sqeMk+liU/vVoQUuvAX0QYdur4oXoFDzcpTD32q5wcAC3kCh00PAz7JoLQC9ZZAxSWkxtj7PeA4gqTc5FgchcIEZyrrQE0PrB5y7b7I43TSB04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691655; c=relaxed/simple;
	bh=napUZlUpob+viRPbJpwd5ak2Yx3rjWNTl4igoalCzt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKKJkf4C3eGKVxniFcNMfuOO59R8NQnuGECZnlyhFiY0SifEf13/+eoEjCb/Qvlp9Njgp3DHJri4av6Q9xSx0P0VDXnDhmeyCghHd4pWaDgPA64S5kafuV32o6bo9CaMag4pp2UBCTbLeZpRWBxfNsN+dqc83U9/49bV0eSm+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJlt/Yed; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706691652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCaIjT9n/jT9jWXXB3bhE2fYRwtAU/53x+dDT51fiBg=;
	b=UJlt/YedA1SNwVlAujZ8E/XcKmVC669mX6WY0BsmjJHdhhG6ZGM2Cr/6BBEolahO1wQjD/
	FN0sMOC9IY2cvMfUU6A5zLcZk5/vTwjLtQBR/PV5Z1Gl2+9xO5THc2noeVG5yPLu7uMqPu
	/Ud/QjS81a/XiH/RgvTXoI11Jdc+C+A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-QoHLNmGRMx6s-5D1R6T3-Q-1; Wed, 31 Jan 2024 04:00:51 -0500
X-MC-Unique: QoHLNmGRMx6s-5D1R6T3-Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33af8509325so236026f8f.0
        for <stable@vger.kernel.org>; Wed, 31 Jan 2024 01:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691650; x=1707296450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCaIjT9n/jT9jWXXB3bhE2fYRwtAU/53x+dDT51fiBg=;
        b=U+C4XVESWUIFBMupw2dD25pISIfrPw472EDlYzYpB9DN6Y5LtG/U/qFT43dzQwvKf4
         xY/PawkwpgxN5RbW5h+rdeT0LHkI5+X9rFzGMxssY+t14Meeb9jzCBLGr0PPcPFiK5P8
         N1Mjb+nr4A8TdTp7XhwEFz3g/WDOAC51mIyZ6jeWKRhP4kb4GdFO2Ci6nTIVaO5Vot8g
         NxrqAZYg1LY3vdwaAkrGdqWg008XoSJySZVWgCmXnmCGqoB1DHJnXb9giUfhd2HdJ5nw
         mEWiOQNL9w3OzHepL/GdgTxMkpBM37oLZg8YVJSE/I5Jw4S4AxZwHcYMBdObbhb1wM1e
         y1yg==
X-Gm-Message-State: AOJu0YwP4bUwhABI3Le5xA5L3CumSr4fuE27jx40GqwadKC/F0lr6HVF
	tNQh0tGFnTVjz6/1rv7pH7tzq1bF6DoNiEQ5fBQX6brb92FFyly+IpGcOPbxxu0WX1nL4G3/feI
	3bfwR2hSc8+D7soHo+/iXDncwRxhNb5vG0284oN9UC/Idqqifor5zdA==
X-Received: by 2002:a05:600c:6003:b0:40e:f6f1:804 with SMTP id az3-20020a05600c600300b0040ef6f10804mr789801wmb.3.1706691649086;
        Wed, 31 Jan 2024 01:00:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzy+dJzlDcIY7zXJ0lWqG+d5XFkucyi8BgmpyLSLpmqxP9FSys/o/DfM2F8WDBwD+uvKc2Tw==
X-Received: by 2002:a05:600c:6003:b0:40e:f6f1:804 with SMTP id az3-20020a05600c600300b0040ef6f10804mr789762wmb.3.1706691648655;
        Wed, 31 Jan 2024 01:00:48 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040ee51f1025sm940261wmq.43.2024.01.31.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:00:48 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6 3/4] lib: move pci-specific devres code to drivers/pci/
Date: Wed, 31 Jan 2024 10:00:22 +0100
Message-ID: <20240131090023.12331-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131090023.12331-1-pstanner@redhat.com>
References: <20240131090023.12331-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pcim_*() functions in lib/devres.c are guarded by an #ifdef
CONFIG_PCI and, thus, don't belong to this file. They are only ever used
for pci and are not generic infrastructure.

Move all pcim_*() functions in lib/devres.c to drivers/pci/devres.c.
Adjust the Makefile.

Add drivers/pci/devres.c to Documentation.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 Documentation/driver-api/pci/pci.rst |   3 +
 drivers/pci/Makefile                 |   2 +-
 drivers/pci/devres.c                 | 207 ++++++++++++++++++++++++++
 lib/devres.c                         | 208 +--------------------------
 4 files changed, 212 insertions(+), 208 deletions(-)
 create mode 100644 drivers/pci/devres.c

diff --git a/Documentation/driver-api/pci/pci.rst b/Documentation/driver-api/pci/pci.rst
index bacf23bf1343..aa40b1cc243b 100644
--- a/Documentation/driver-api/pci/pci.rst
+++ b/Documentation/driver-api/pci/pci.rst
@@ -7,6 +7,9 @@ PCI Support Library
 .. kernel-doc:: drivers/pci/iomap.c
    :export:
 
+.. kernel-doc:: drivers/pci/devres.c
+   :export:
+
 .. kernel-doc:: drivers/pci/pci-driver.c
    :export:
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 64dcedccfc87..ed65299b42b5 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -5,7 +5,7 @@
 obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 				   remove.o pci.o pci-driver.o search.o \
 				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
-				   setup-bus.o vc.o mmap.o setup-irq.o
+				   setup-bus.o vc.o mmap.o setup-irq.o devres.o
 
 obj-$(CONFIG_PCI)		+= msi/
 obj-$(CONFIG_PCI)		+= pcie/
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
new file mode 100644
index 000000000000..a3fd0d65cef1
--- /dev/null
+++ b/drivers/pci/devres.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/pci.h>
+#include "pci.h"
+
+/*
+ * PCI iomap devres
+ */
+#define PCIM_IOMAP_MAX	PCI_STD_NUM_BARS
+
+struct pcim_iomap_devres {
+	void __iomem *table[PCIM_IOMAP_MAX];
+};
+
+static void pcim_iomap_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = to_pci_dev(gendev);
+	struct pcim_iomap_devres *this = res;
+	int i;
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (this->table[i])
+			pci_iounmap(dev, this->table[i]);
+}
+
+/**
+ * pcim_iomap_table - access iomap allocation table
+ * @pdev: PCI device to access iomap table for
+ *
+ * Access iomap allocation table for @dev.  If iomap table doesn't
+ * exist and @pdev is managed, it will be allocated.  All iomaps
+ * recorded in the iomap table are automatically unmapped on driver
+ * detach.
+ *
+ * This function might sleep when the table is first allocated but can
+ * be safely called without context and guaranteed to succeed once
+ * allocated.
+ */
+void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
+{
+	struct pcim_iomap_devres *dr, *new_dr;
+
+	dr = devres_find(&pdev->dev, pcim_iomap_release, NULL, NULL);
+	if (dr)
+		return dr->table;
+
+	new_dr = devres_alloc_node(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL,
+				   dev_to_node(&pdev->dev));
+	if (!new_dr)
+		return NULL;
+	dr = devres_get(&pdev->dev, new_dr, NULL, NULL);
+	return dr->table;
+}
+EXPORT_SYMBOL(pcim_iomap_table);
+
+/**
+ * pcim_iomap - Managed pcim_iomap()
+ * @pdev: PCI device to iomap for
+ * @bar: BAR to iomap
+ * @maxlen: Maximum length of iomap
+ *
+ * Managed pci_iomap().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
+{
+	void __iomem **tbl;
+
+	BUG_ON(bar >= PCIM_IOMAP_MAX);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+		return NULL;
+
+	tbl[bar] = pci_iomap(pdev, bar, maxlen);
+	return tbl[bar];
+}
+EXPORT_SYMBOL(pcim_iomap);
+
+/**
+ * pcim_iounmap - Managed pci_iounmap()
+ * @pdev: PCI device to iounmap for
+ * @addr: Address to unmap
+ *
+ * Managed pci_iounmap().  @addr must have been mapped using pcim_iomap().
+ */
+void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
+{
+	void __iomem **tbl;
+	int i;
+
+	pci_iounmap(pdev, addr);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	BUG_ON(!tbl);
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (tbl[i] == addr) {
+			tbl[i] = NULL;
+			return;
+		}
+	WARN_ON(1);
+}
+EXPORT_SYMBOL(pcim_iounmap);
+
+/**
+ * pcim_iomap_regions - Request and iomap PCI BARs
+ * @pdev: PCI device to map IO resources for
+ * @mask: Mask of BARs to request and iomap
+ * @name: Name used when requesting regions
+ *
+ * Request and iomap regions specified by @mask.
+ */
+int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
+{
+	void __iomem * const *iomap;
+	int i, rc;
+
+	iomap = pcim_iomap_table(pdev);
+	if (!iomap)
+		return -ENOMEM;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		unsigned long len;
+
+		if (!(mask & (1 << i)))
+			continue;
+
+		rc = -EINVAL;
+		len = pci_resource_len(pdev, i);
+		if (!len)
+			goto err_inval;
+
+		rc = pci_request_region(pdev, i, name);
+		if (rc)
+			goto err_inval;
+
+		rc = -ENOMEM;
+		if (!pcim_iomap(pdev, i, 0))
+			goto err_region;
+	}
+
+	return 0;
+
+ err_region:
+	pci_release_region(pdev, i);
+ err_inval:
+	while (--i >= 0) {
+		if (!(mask & (1 << i)))
+			continue;
+		pcim_iounmap(pdev, iomap[i]);
+		pci_release_region(pdev, i);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(pcim_iomap_regions);
+
+/**
+ * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
+ * @pdev: PCI device to map IO resources for
+ * @mask: Mask of BARs to iomap
+ * @name: Name used when requesting regions
+ *
+ * Request all PCI BARs and iomap regions specified by @mask.
+ */
+int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
+				   const char *name)
+{
+	int request_mask = ((1 << 6) - 1) & ~mask;
+	int rc;
+
+	rc = pci_request_selected_regions(pdev, request_mask, name);
+	if (rc)
+		return rc;
+
+	rc = pcim_iomap_regions(pdev, mask, name);
+	if (rc)
+		pci_release_selected_regions(pdev, request_mask);
+	return rc;
+}
+EXPORT_SYMBOL(pcim_iomap_regions_request_all);
+
+/**
+ * pcim_iounmap_regions - Unmap and release PCI BARs
+ * @pdev: PCI device to map IO resources for
+ * @mask: Mask of BARs to unmap and release
+ *
+ * Unmap and release regions specified by @mask.
+ */
+void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
+{
+	void __iomem * const *iomap;
+	int i;
+
+	iomap = pcim_iomap_table(pdev);
+	if (!iomap)
+		return;
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
+		if (!(mask & (1 << i)))
+			continue;
+
+		pcim_iounmap(pdev, iomap[i]);
+		pci_release_region(pdev, i);
+	}
+}
+EXPORT_SYMBOL(pcim_iounmap_regions);
diff --git a/lib/devres.c b/lib/devres.c
index c44f104b58d5..fe0c63caeb68 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
 #include <linux/err.h>
-#include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
@@ -311,212 +311,6 @@ void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 EXPORT_SYMBOL(devm_ioport_unmap);
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifdef CONFIG_PCI
-/*
- * PCI iomap devres
- */
-#define PCIM_IOMAP_MAX	PCI_STD_NUM_BARS
-
-struct pcim_iomap_devres {
-	void __iomem *table[PCIM_IOMAP_MAX];
-};
-
-static void pcim_iomap_release(struct device *gendev, void *res)
-{
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pcim_iomap_devres *this = res;
-	int i;
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (this->table[i])
-			pci_iounmap(dev, this->table[i]);
-}
-
-/**
- * pcim_iomap_table - access iomap allocation table
- * @pdev: PCI device to access iomap table for
- *
- * Access iomap allocation table for @dev.  If iomap table doesn't
- * exist and @pdev is managed, it will be allocated.  All iomaps
- * recorded in the iomap table are automatically unmapped on driver
- * detach.
- *
- * This function might sleep when the table is first allocated but can
- * be safely called without context and guaranteed to succeed once
- * allocated.
- */
-void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
-{
-	struct pcim_iomap_devres *dr, *new_dr;
-
-	dr = devres_find(&pdev->dev, pcim_iomap_release, NULL, NULL);
-	if (dr)
-		return dr->table;
-
-	new_dr = devres_alloc_node(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL,
-				   dev_to_node(&pdev->dev));
-	if (!new_dr)
-		return NULL;
-	dr = devres_get(&pdev->dev, new_dr, NULL, NULL);
-	return dr->table;
-}
-EXPORT_SYMBOL(pcim_iomap_table);
-
-/**
- * pcim_iomap - Managed pcim_iomap()
- * @pdev: PCI device to iomap for
- * @bar: BAR to iomap
- * @maxlen: Maximum length of iomap
- *
- * Managed pci_iomap().  Map is automatically unmapped on driver
- * detach.
- */
-void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
-{
-	void __iomem **tbl;
-
-	BUG_ON(bar >= PCIM_IOMAP_MAX);
-
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
-		return NULL;
-
-	tbl[bar] = pci_iomap(pdev, bar, maxlen);
-	return tbl[bar];
-}
-EXPORT_SYMBOL(pcim_iomap);
-
-/**
- * pcim_iounmap - Managed pci_iounmap()
- * @pdev: PCI device to iounmap for
- * @addr: Address to unmap
- *
- * Managed pci_iounmap().  @addr must have been mapped using pcim_iomap().
- */
-void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
-{
-	void __iomem **tbl;
-	int i;
-
-	pci_iounmap(pdev, addr);
-
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	BUG_ON(!tbl);
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (tbl[i] == addr) {
-			tbl[i] = NULL;
-			return;
-		}
-	WARN_ON(1);
-}
-EXPORT_SYMBOL(pcim_iounmap);
-
-/**
- * pcim_iomap_regions - Request and iomap PCI BARs
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to request and iomap
- * @name: Name used when requesting regions
- *
- * Request and iomap regions specified by @mask.
- */
-int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
-{
-	void __iomem * const *iomap;
-	int i, rc;
-
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
-		return -ENOMEM;
-
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		unsigned long len;
-
-		if (!(mask & (1 << i)))
-			continue;
-
-		rc = -EINVAL;
-		len = pci_resource_len(pdev, i);
-		if (!len)
-			goto err_inval;
-
-		rc = pci_request_region(pdev, i, name);
-		if (rc)
-			goto err_inval;
-
-		rc = -ENOMEM;
-		if (!pcim_iomap(pdev, i, 0))
-			goto err_region;
-	}
-
-	return 0;
-
- err_region:
-	pci_release_region(pdev, i);
- err_inval:
-	while (--i >= 0) {
-		if (!(mask & (1 << i)))
-			continue;
-		pcim_iounmap(pdev, iomap[i]);
-		pci_release_region(pdev, i);
-	}
-
-	return rc;
-}
-EXPORT_SYMBOL(pcim_iomap_regions);
-
-/**
- * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to iomap
- * @name: Name used when requesting regions
- *
- * Request all PCI BARs and iomap regions specified by @mask.
- */
-int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
-				   const char *name)
-{
-	int request_mask = ((1 << 6) - 1) & ~mask;
-	int rc;
-
-	rc = pci_request_selected_regions(pdev, request_mask, name);
-	if (rc)
-		return rc;
-
-	rc = pcim_iomap_regions(pdev, mask, name);
-	if (rc)
-		pci_release_selected_regions(pdev, request_mask);
-	return rc;
-}
-EXPORT_SYMBOL(pcim_iomap_regions_request_all);
-
-/**
- * pcim_iounmap_regions - Unmap and release PCI BARs
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to unmap and release
- *
- * Unmap and release regions specified by @mask.
- */
-void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
-{
-	void __iomem * const *iomap;
-	int i;
-
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
-		return;
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
-		if (!(mask & (1 << i)))
-			continue;
-
-		pcim_iounmap(pdev, iomap[i]);
-		pci_release_region(pdev, i);
-	}
-}
-EXPORT_SYMBOL(pcim_iounmap_regions);
-#endif /* CONFIG_PCI */
-
 static void devm_arch_phys_ac_add_release(struct device *dev, void *res)
 {
 	arch_phys_wc_del(*((int *)res));
-- 
2.43.0


