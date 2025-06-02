Return-Path: <stable+bounces-149147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F9ACB16D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F77194030D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F8242D67;
	Mon,  2 Jun 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x8sVH/U9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658DC22578D;
	Mon,  2 Jun 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873046; cv=none; b=tI+ry8MaKCZA7oq/2bJE7NTCmcGrn/OAMWMI3QQpsKiVg6gHs5UpP6KdrfgTmfEdUj4c3EHG5MkuWkIiJx1441h6mvkuHmmeDBxguQ0ihNo6bl1vgRIQ3zy8qx8SCTBSb9zgd7ijAqqzwwjyYNCN+tTnvtqtOsLH1bXEo/P8IL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873046; c=relaxed/simple;
	bh=/5J0F9AMB02SOB8fDoxCpx+dz0pYtXmp6Ga8QQ+A5nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID0aLy6OKcKYbHgBxgq4U/2h8l6zs5hj7R6Xea2G3SruMjdNI6q+Ub0N6T3i/xuiCX/rajTWroQT73SYX4ZOMHMwhNvHbhW23TCmZDygoqy1/wqMWZRt5xe6K0QdchGae9ljvotUA3eA7hwVVXLzRdtIO5sPMkDaeKlFEM3RKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x8sVH/U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BF8C4CEEB;
	Mon,  2 Jun 2025 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873045;
	bh=/5J0F9AMB02SOB8fDoxCpx+dz0pYtXmp6Ga8QQ+A5nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x8sVH/U9zWKud2ufTeCHVNT1ydy3qZD1yePzPfysLKigslvxg1hSVz63XKNhGNYwB
	 gkF/5ZtxAbrJf3pZHwOrTJ1cOvYO4Y1YazEdKmKCNP/OR6fIk85Y6MMaPAAPEUu5XW
	 Qc7RUKMDRjFoeoG+5WEYzdGQk64F4+ObceK6bk3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 021/444] intel_th: avoid using deprecated page->mapping, index fields
Date: Mon,  2 Jun 2025 15:41:25 +0200
Message-ID: <20250602134341.775111723@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit 8e553520596bbd5ce832e26e9d721e6a0c797b8b ]

The struct page->mapping, index fields are deprecated and soon to be only
available as part of a folio.

It is likely the intel_th code which sets page->mapping, index is was
implemented out of concern that some aspect of the page fault logic may
encounter unexpected problems should they not.

However, the appropriate interface for inserting kernel-allocated memory is
vm_insert_page() in a VM_MIXEDMAP. By using the helper function
vmf_insert_mixed() we can do this with minimal churn in the existing fault
handler.

By doing so, we bypass the remainder of the faulting logic. The pages are
still pinned so there is no possibility of anything unexpected being done
with the pages once established.

It would also be reasonable to pre-map everything on fault, however to
minimise churn we retain the fault handler.

We also eliminate all code which clears page->mapping on teardown as this
has now become unnecessary.

The MSU code relies on faulting to function correctly, so is by definition
dependent on CONFIG_MMU. We avoid spurious reports about compilation
failure for unsupported platforms by making this requirement explicit in
Kconfig as part of this change too.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lore.kernel.org/r/20250331125608.60300-1-lorenzo.stoakes@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/intel_th/Kconfig |  1 +
 drivers/hwtracing/intel_th/msu.c   | 31 +++++++-----------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/intel_th/Kconfig b/drivers/hwtracing/intel_th/Kconfig
index 4b6359326ede9..4f7d2b6d79e29 100644
--- a/drivers/hwtracing/intel_th/Kconfig
+++ b/drivers/hwtracing/intel_th/Kconfig
@@ -60,6 +60,7 @@ config INTEL_TH_STH
 
 config INTEL_TH_MSU
 	tristate "Intel(R) Trace Hub Memory Storage Unit"
+	depends on MMU
 	help
 	  Memory Storage Unit (MSU) trace output device enables
 	  storing STP traces to system memory. It supports single
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 9621efe0e95c4..54629458fb710 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
+#include <linux/pfn_t.h>
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
@@ -965,7 +966,6 @@ static void msc_buffer_contig_free(struct msc *msc)
 	for (off = 0; off < msc->nr_pages << PAGE_SHIFT; off += PAGE_SIZE) {
 		struct page *page = virt_to_page(msc->base + off);
 
-		page->mapping = NULL;
 		__free_page(page);
 	}
 
@@ -1147,9 +1147,6 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 	int i;
 
 	for_each_sg(win->sgt->sgl, sg, win->nr_segs, i) {
-		struct page *page = msc_sg_page(sg);
-
-		page->mapping = NULL;
 		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
 				  sg_virt(sg), sg_dma_address(sg));
 	}
@@ -1584,22 +1581,10 @@ static void msc_mmap_close(struct vm_area_struct *vma)
 {
 	struct msc_iter *iter = vma->vm_file->private_data;
 	struct msc *msc = iter->msc;
-	unsigned long pg;
 
 	if (!atomic_dec_and_mutex_lock(&msc->mmap_count, &msc->buf_mutex))
 		return;
 
-	/* drop page _refcounts */
-	for (pg = 0; pg < msc->nr_pages; pg++) {
-		struct page *page = msc_buffer_get_page(msc, pg);
-
-		if (WARN_ON_ONCE(!page))
-			continue;
-
-		if (page->mapping)
-			page->mapping = NULL;
-	}
-
 	/* last mapping -- drop user_count */
 	atomic_dec(&msc->user_count);
 	mutex_unlock(&msc->buf_mutex);
@@ -1609,16 +1594,14 @@ static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
 {
 	struct msc_iter *iter = vmf->vma->vm_file->private_data;
 	struct msc *msc = iter->msc;
+	struct page *page;
 
-	vmf->page = msc_buffer_get_page(msc, vmf->pgoff);
-	if (!vmf->page)
+	page = msc_buffer_get_page(msc, vmf->pgoff);
+	if (!page)
 		return VM_FAULT_SIGBUS;
 
-	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index = vmf->pgoff;
-
-	return 0;
+	get_page(page);
+	return vmf_insert_mixed(vmf->vma, vmf->address, page_to_pfn_t(page));
 }
 
 static const struct vm_operations_struct msc_mmap_ops = {
@@ -1659,7 +1642,7 @@ static int intel_th_msc_mmap(struct file *file, struct vm_area_struct *vma)
 		atomic_dec(&msc->user_count);
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY | VM_MIXEDMAP);
 	vma->vm_ops = &msc_mmap_ops;
 	return ret;
 }
-- 
2.39.5




