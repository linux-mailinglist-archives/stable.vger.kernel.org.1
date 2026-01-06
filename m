Return-Path: <stable+bounces-205011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17353CF66CD
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8130E3029D1A
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45392135D7;
	Tue,  6 Jan 2026 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itMiSEND"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA1B53E0B
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665304; cv=none; b=l0DqoFEWX95Y9gcumgteASni9kEp7F/v50axt0RS4ZdSQoQw51KKJDlaWfZbcQRtGrtlPotyFq06y07w/P9V05qAqD6KAosFEW6IZkBiyLVBE2rhmn0YleD6bKc1O96UHNvGQYFPtasjZv7J5Nz2HIOwQJFYf7/whNv+bYVR914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665304; c=relaxed/simple;
	bh=p0NOdjCf2RuAyQ8eEe+RbC1wg9IkQQ9K00+T5Lw31mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC9niTDfXMXxKi/YS1oYHNTsapxGvfhLkfLFdxWfypONNl4UOk/oC/BjF1WLjfF4QZ+f4AagKkgr9mLFKmb66TG+VmKYO1CH5tKWaO/+wfIXCa8WJOsfcHajg04Zx2AUZ3NGcJuPS6VE0lnnDI6f7ausAEIacImI6Jh6p7WEyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itMiSEND; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767665302; x=1799201302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p0NOdjCf2RuAyQ8eEe+RbC1wg9IkQQ9K00+T5Lw31mA=;
  b=itMiSENDn9dGkWNBK+SoXOExYsLjCzCX7ALfTZpG5uM4VPxYV6UHZdPQ
   sEHs0y04S4Ievgkjc2pfzE2hXu4IF9QI+W96GYQNV0wbG6e0RCGYsn5pe
   JiW5+vleS4oXUYYcD7102a7GNdI0UrCT/KCMeL43TC+4kkTJcqHgwkxvF
   v9KiCzAsQRqouiQ3DJn/m9vcktO253b/ikFwiHOUKaxxLOC9tdhOjtlth
   C5xX0Wvdi0VjJguYRXK2lOvS4JBF5ekwwcPC2Jk2sfeUA0TK7E0/9Aynv
   XoMWl7Fd5lAURT0zbMtzF53F0Z9pzObzfFEpCFgRey8eM4u+XIvQmbvq9
   Q==;
X-CSE-ConnectionGUID: SYDWQ3HaTH64PTJoviPzZQ==
X-CSE-MsgGUID: 4KzofdxoRcqVu1sSjBRvzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="71612983"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="71612983"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 18:08:22 -0800
X-CSE-ConnectionGUID: BVQsMZvzSEm3UJmZaVaDNQ==
X-CSE-MsgGUID: JO31iHZ4RrawHWqmapyOlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="201669094"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa006.jf.intel.com with ESMTP; 05 Jan 2026 18:08:20 -0800
From: Kevin Tian <kevin.tian@intel.com>
To: stable@vger.kernel.org
Cc: Kevin Tian <kevin.tian@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH 6.18.y] vfio/pci: Disable qword access to the PCI ROM bar
Date: Tue,  6 Jan 2026 02:11:44 +0000
Message-ID: <20260106021144.1231645-1-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026010559-recreate-attribute-0072@gregkh>
References: <2026010559-recreate-attribute-0072@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit dc85a46928c41423ad89869baf05a589e2975575 ]

Commit 2b938e3db335 ("vfio/pci: Enable iowrite64 and ioread64 for vfio
pci") enables qword access to the PCI bar resources. However certain
devices (e.g. Intel X710) are observed with problem upon qword accesses
to the rom bar, e.g. triggering PCI aer errors.

This is triggered by Qemu which caches the rom content by simply does a
pread() of the remaining size until it gets the full contents. The other
bars would only perform operations at the same access width as their
guest drivers.

Instead of trying to identify all broken devices, universally disable
qword access to the rom bar i.e. going back to the old way which worked
reliably for years.

Reported-by: Farrah Chen <farrah.chen@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220740
Fixes: 2b938e3db335 ("vfio/pci: Enable iowrite64 and ioread64 for vfio pci")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://lore.kernel.org/r/20251218081650.555015-2-kevin.tian@intel.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
---
 drivers/vfio/pci/nvgrace-gpu/main.c |  4 ++--
 drivers/vfio/pci/vfio_pci_rdwr.c    | 25 ++++++++++++++++++-------
 include/linux/vfio_pci_core.h       | 10 +++++++++-
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index e346392b72f6..3dc3c2432b5e 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -491,7 +491,7 @@ nvgrace_gpu_map_and_read(struct nvgrace_gpu_pci_core_device *nvdev,
 		ret = vfio_pci_core_do_io_rw(&nvdev->core_device, false,
 					     nvdev->resmem.ioaddr,
 					     buf, offset, mem_count,
-					     0, 0, false);
+					     0, 0, false, VFIO_PCI_IO_WIDTH_8);
 	}
 
 	return ret;
@@ -609,7 +609,7 @@ nvgrace_gpu_map_and_write(struct nvgrace_gpu_pci_core_device *nvdev,
 		ret = vfio_pci_core_do_io_rw(&nvdev->core_device, false,
 					     nvdev->resmem.ioaddr,
 					     (char __user *)buf, pos, mem_count,
-					     0, 0, true);
+					     0, 0, true, VFIO_PCI_IO_WIDTH_8);
 	}
 
 	return ret;
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 6192788c8ba3..25380b7dfe18 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -135,7 +135,8 @@ VFIO_IORDWR(64)
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			       void __iomem *io, char __user *buf,
 			       loff_t off, size_t count, size_t x_start,
-			       size_t x_end, bool iswrite)
+			       size_t x_end, bool iswrite,
+			       enum vfio_pci_io_width max_width)
 {
 	ssize_t done = 0;
 	int ret;
@@ -150,20 +151,19 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 		else
 			fillable = 0;
 
-		if (fillable >= 8 && !(off % 8)) {
+		if (fillable >= 8 && !(off % 8) && max_width >= 8) {
 			ret = vfio_pci_iordwr64(vdev, iswrite, test_mem,
 						io, buf, off, &filled);
 			if (ret)
 				return ret;
 
-		} else
-		if (fillable >= 4 && !(off % 4)) {
+		} else if (fillable >= 4 && !(off % 4) && max_width >= 4) {
 			ret = vfio_pci_iordwr32(vdev, iswrite, test_mem,
 						io, buf, off, &filled);
 			if (ret)
 				return ret;
 
-		} else if (fillable >= 2 && !(off % 2)) {
+		} else if (fillable >= 2 && !(off % 2) && max_width >= 2) {
 			ret = vfio_pci_iordwr16(vdev, iswrite, test_mem,
 						io, buf, off, &filled);
 			if (ret)
@@ -234,6 +234,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	void __iomem *io;
 	struct resource *res = &vdev->pdev->resource[bar];
 	ssize_t done;
+	enum vfio_pci_io_width max_width = VFIO_PCI_IO_WIDTH_8;
 
 	if (pci_resource_start(pdev, bar))
 		end = pci_resource_len(pdev, bar);
@@ -262,6 +263,16 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		if (!io)
 			return -ENOMEM;
 		x_end = end;
+
+		/*
+		 * Certain devices (e.g. Intel X710) don't support qword
+		 * access to the ROM bar. Otherwise PCI AER errors might be
+		 * triggered.
+		 *
+		 * Disable qword access to the ROM bar universally, which
+		 * worked reliably for years before qword access is enabled.
+		 */
+		max_width = VFIO_PCI_IO_WIDTH_4;
 	} else {
 		int ret = vfio_pci_core_setup_barmap(vdev, bar);
 		if (ret) {
@@ -278,7 +289,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	}
 
 	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
-				      count, x_start, x_end, iswrite);
+				      count, x_start, x_end, iswrite, max_width);
 
 	if (done >= 0)
 		*ppos += done;
@@ -352,7 +363,7 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	 * to the memory enable bit in the command register.
 	 */
 	done = vfio_pci_core_do_io_rw(vdev, false, iomem, buf, off, count,
-				      0, 0, iswrite);
+				      0, 0, iswrite, VFIO_PCI_IO_WIDTH_8);
 
 	vga_put(vdev->pdev, rsrc);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index f5c93787f8e0..7aa29428982a 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -102,6 +102,13 @@ struct vfio_pci_core_device {
 	struct rw_semaphore	memory_lock;
 };
 
+enum vfio_pci_io_width {
+	VFIO_PCI_IO_WIDTH_1 = 1,
+	VFIO_PCI_IO_WIDTH_2 = 2,
+	VFIO_PCI_IO_WIDTH_4 = 4,
+	VFIO_PCI_IO_WIDTH_8 = 8,
+};
+
 /* Will be exported for vfio pci drivers usage */
 int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
@@ -139,7 +146,8 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			       void __iomem *io, char __user *buf,
 			       loff_t off, size_t count, size_t x_start,
-			       size_t x_end, bool iswrite);
+			       size_t x_end, bool iswrite,
+			       enum vfio_pci_io_width max_width);
 bool vfio_pci_core_range_intersect_range(loff_t buf_start, size_t buf_cnt,
 					 loff_t reg_start, size_t reg_cnt,
 					 loff_t *buf_offset,
-- 
2.43.0


