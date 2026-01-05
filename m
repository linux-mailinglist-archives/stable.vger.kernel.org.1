Return-Path: <stable+bounces-204731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFECF358C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C6A230274CB
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056F3191DE;
	Mon,  5 Jan 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YkLG5S/b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17963191B0
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613704; cv=none; b=rr8cAeBk7fNqE583/aUXlvLmMKnBYST/RrHBdDGsnYEKpfvhywdFea2hWMlu2/hmks28W9XcTtkM7mjdNc7I+sEW3uKQjr9VqY9Zs4MP6Pzn2W09cNvjsY0BkR3mAEXkPxfqrbHnqNz1v6x/xHwd5lcF3cnjd68Aq/XcrTDAGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613704; c=relaxed/simple;
	bh=kuuC146pzTI/C7pKeCu1YxbgnVd1mYG7vY9skUDqVFU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GKL9PYtS8JIoxp+SqFl8Ek/PYKZYNhLJxKaakVhSoUCpJG0GEuDWEOD1cwaCBxS09T+bWXWmyJLW/O+kBqGhqRDTKe+mkkXPd1Vj8qgSJNFmFkPMhAph7WzY3TBTsHuxV9qiCMAl15SjCKGknkvgAxPK0qxlnkNSz0bzwVkzH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YkLG5S/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE19C116D0;
	Mon,  5 Jan 2026 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613704;
	bh=kuuC146pzTI/C7pKeCu1YxbgnVd1mYG7vY9skUDqVFU=;
	h=Subject:To:Cc:From:Date:From;
	b=YkLG5S/bvsSBB8mqja5l14skspY+Fn37+j2sOLb6eqFHOQ/xBfO88+D473Pmpz1Q+
	 AVmpxm3puF0qfnCOKGuzx1p9MlYts86wpoguyfhfYSqg6rIBVQ5/5p2lIqEkA79twk
	 0YXKk5rRj3ws5D0EDyXbKPN7TLfjb/VVOVTOHqu0=
Subject: FAILED: patch "[PATCH] vfio/pci: Disable qword access to the PCI ROM bar" failed to apply to 5.15-stable tree
To: kevin.tian@intel.com,alex@shazbot.org,farrah.chen@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:48:02 +0100
Message-ID: <2026010502-immersion-jogging-5b58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x dc85a46928c41423ad89869baf05a589e2975575
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010502-immersion-jogging-5b58@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc85a46928c41423ad89869baf05a589e2975575 Mon Sep 17 00:00:00 2001
From: Kevin Tian <kevin.tian@intel.com>
Date: Thu, 18 Dec 2025 08:16:49 +0000
Subject: [PATCH] vfio/pci: Disable qword access to the PCI ROM bar

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

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index 84d142a47ec6..b45a24d00387 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -561,7 +561,7 @@ nvgrace_gpu_map_and_read(struct nvgrace_gpu_pci_core_device *nvdev,
 		ret = vfio_pci_core_do_io_rw(&nvdev->core_device, false,
 					     nvdev->resmem.ioaddr,
 					     buf, offset, mem_count,
-					     0, 0, false);
+					     0, 0, false, VFIO_PCI_IO_WIDTH_8);
 	}
 
 	return ret;
@@ -693,7 +693,7 @@ nvgrace_gpu_map_and_write(struct nvgrace_gpu_pci_core_device *nvdev,
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
index 706877f998ff..1ac86896875c 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -145,6 +145,13 @@ struct vfio_pci_core_device {
 	struct list_head	dmabufs;
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
@@ -188,7 +195,8 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			       void __iomem *io, char __user *buf,
 			       loff_t off, size_t count, size_t x_start,
-			       size_t x_end, bool iswrite);
+			       size_t x_end, bool iswrite,
+			       enum vfio_pci_io_width max_width);
 bool __vfio_pci_memory_enabled(struct vfio_pci_core_device *vdev);
 bool vfio_pci_core_range_intersect_range(loff_t buf_start, size_t buf_cnt,
 					 loff_t reg_start, size_t reg_cnt,


