Return-Path: <stable+bounces-205024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC8CF67E8
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 794DB30069BD
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A822129F;
	Tue,  6 Jan 2026 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/oSeKGV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5113FEE
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667270; cv=none; b=MyEC1QsIskUzS+BYrI7LcBFtXw1mBO+p6dmjJbHeQP8sKyXWhJ1WsxuRcNkE9VrHbJuqrcyH+T4y7LJzj3K+fiNJ1hknlVn6P30TNZhgNkGUFyFoY0dAmZ7G/iFKgUM5AzgMBHha+eoK/rwWJ+YOZI05eSluTry08McDtgICrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667270; c=relaxed/simple;
	bh=+xf1e3F6RInCjVp6cdI7mE7vaeYsI81ZSm5fW+OttH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJnydtNSSwlqSmhNfo7HMn56noU7Icc1Hsz10rtMShJvj6pqwyGbNoM/MhjXO5dVRP3NeIQTGzMrnzleq8cwiyXKX3+WSV/QVblidDiTjAU0GekBdED+GeiXry1/aG6E/z6BSolRDoM2nwucZGduEDoWrSggdDq4Y9PewhJ+JCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/oSeKGV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767667269; x=1799203269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+xf1e3F6RInCjVp6cdI7mE7vaeYsI81ZSm5fW+OttH0=;
  b=J/oSeKGV0doyQJEJLWi98GvJClKRjpqJ79pXC0b6s7nCJjogPuQfkUWS
   PsbCKX4GiEgeL520eAlMSxTmMM71J8AiWewBSICWPNqNVqti0Qa8sfzgp
   etD4vtqyKsIrzPUlEmK8XZ1UJZANITVr/kSiSFytd7BqxO667lfxw5HJ7
   eXot2orpJzq5pzG7hnxAUNfq9altl2F0K0gr0nKUbwmC1UA+mXa2NWuzt
   MjLW3WTuaQtan3+gmdR0QrFBHO2aI+P4Wle/KzzPU5ZPRodwLJcqWij2Z
   Ecu+5zgFozCJNX/wj6mcmLNkixT2U3LLRtpiTqxNIlKPotOrZgIfjRqqP
   A==;
X-CSE-ConnectionGUID: EyfE/6UpRi2Xaklts0OkHw==
X-CSE-MsgGUID: YmWTDNceT42YU5Jk0NoXYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69015216"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="69015216"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 18:41:06 -0800
X-CSE-ConnectionGUID: a17uqA7+QouII50fYAEcpQ==
X-CSE-MsgGUID: 3lBlGfkpRKOVAXwVsOjU2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="203000573"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jan 2026 18:41:04 -0800
From: Kevin Tian <kevin.tian@intel.com>
To: stable@vger.kernel.org
Cc: Kevin Tian <kevin.tian@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH 6.12.y] vfio/pci: Disable qword access to the PCI ROM bar
Date: Tue,  6 Jan 2026 02:44:28 +0000
Message-ID: <20260106024428.1334406-1-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026010500-naturist-guts-b306@gregkh>
References: <2026010500-naturist-guts-b306@gregkh>
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
 drivers/vfio/pci/vfio_pci_rdwr.c    | 24 ++++++++++++++++++------
 include/linux/vfio_pci_core.h       | 10 +++++++++-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index 9e1c57baab64..9728840cbcc5 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -482,7 +482,7 @@ nvgrace_gpu_map_and_read(struct nvgrace_gpu_pci_core_device *nvdev,
 		ret = vfio_pci_core_do_io_rw(&nvdev->core_device, false,
 					     nvdev->resmem.ioaddr,
 					     buf, offset, mem_count,
-					     0, 0, false);
+					     0, 0, false, VFIO_PCI_IO_WIDTH_8);
 	}
 
 	return ret;
@@ -600,7 +600,7 @@ nvgrace_gpu_map_and_write(struct nvgrace_gpu_pci_core_device *nvdev,
 		ret = vfio_pci_core_do_io_rw(&nvdev->core_device, false,
 					     nvdev->resmem.ioaddr,
 					     (char __user *)buf, pos, mem_count,
-					     0, 0, true);
+					     0, 0, true, VFIO_PCI_IO_WIDTH_8);
 	}
 
 	return ret;
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index a0595c745732..03a84663db91 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -141,7 +141,8 @@ VFIO_IORDWR(64)
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			       void __iomem *io, char __user *buf,
 			       loff_t off, size_t count, size_t x_start,
-			       size_t x_end, bool iswrite)
+			       size_t x_end, bool iswrite,
+			       enum vfio_pci_io_width max_width)
 {
 	ssize_t done = 0;
 	int ret;
@@ -157,7 +158,7 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			fillable = 0;
 
 #if defined(ioread64) && defined(iowrite64)
-		if (fillable >= 8 && !(off % 8)) {
+		if (fillable >= 8 && !(off % 8) && max_width >= 8) {
 			ret = vfio_pci_iordwr64(vdev, iswrite, test_mem,
 						io, buf, off, &filled);
 			if (ret)
@@ -165,13 +166,13 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 
 		} else
 #endif
-		if (fillable >= 4 && !(off % 4)) {
+		if (fillable >= 4 && !(off % 4) && max_width >= 4) {
 			ret = vfio_pci_iordwr32(vdev, iswrite, test_mem,
 						io, buf, off, &filled);
 			if (ret)
 				return ret;
 
-		} else if (fillable >= 2 && !(off % 2)) {
+		} else if (fillable >= 2 && !(off % 2) && max_width >= 2) {
 			ret = vfio_pci_iordwr16(vdev, iswrite, test_mem,
 						io, buf, off, &filled);
 			if (ret)
@@ -242,6 +243,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	void __iomem *io;
 	struct resource *res = &vdev->pdev->resource[bar];
 	ssize_t done;
+	enum vfio_pci_io_width max_width = VFIO_PCI_IO_WIDTH_8;
 
 	if (pci_resource_start(pdev, bar))
 		end = pci_resource_len(pdev, bar);
@@ -268,6 +270,16 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			goto out;
 		}
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
@@ -284,7 +296,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	}
 
 	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
-				      count, x_start, x_end, iswrite);
+				      count, x_start, x_end, iswrite, max_width);
 
 	if (done >= 0)
 		*ppos += done;
@@ -353,7 +365,7 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	 * to the memory enable bit in the command register.
 	 */
 	done = vfio_pci_core_do_io_rw(vdev, false, iomem, buf, off, count,
-				      0, 0, iswrite);
+				      0, 0, iswrite, VFIO_PCI_IO_WIDTH_8);
 
 	vga_put(vdev->pdev, rsrc);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 99da27c032d7..f889be76eaff 100644
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
@@ -137,7 +144,8 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
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


