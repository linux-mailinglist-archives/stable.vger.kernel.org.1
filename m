Return-Path: <stable+bounces-139042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30AAA3F18
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DCB188537D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903572D0AAB;
	Tue, 29 Apr 2025 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHn1D2s+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FB2D0AAC;
	Tue, 29 Apr 2025 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970775; cv=none; b=qO0juIZ+Ulb0pvY3Ozu82ux73g/V5UQETFRDBOOB+u4EAwocHdu5leHnGE+hGOBXftqzVNpyqjDo8QvHwDO1Jdik/0D8EkvTftlGBo7tfsE5NMGQo4y+Aeb7zXyJ/ebBI38WUw1ZQgboOUSTkg37WDHiy9fHe80/lBNGx7Di2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970775; c=relaxed/simple;
	bh=vieBCkpTslcRyjg2/CG6L5eMnbdQc++DQ+Ktc8P7Nug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ehT0ASUnA9x25NOJbI95NFdbem+l88b/1cUqdHFUAjoKAr4LAaj4Jj2lclmdnpKZyyDKsQb4hgNVxh9+vvPpyiusGNvOH7RfGivzyBgLA13zxZyupiPpOqJjKQTJka4OSzx/FWFb/Ou9YpOhTCsooIAMVa6/DMUK+UQkYLCDWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHn1D2s+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABACC4CEEB;
	Tue, 29 Apr 2025 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970775;
	bh=vieBCkpTslcRyjg2/CG6L5eMnbdQc++DQ+Ktc8P7Nug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHn1D2s+BPEEYQnrOAeakEZ5rqc6DdXicvR6lkGp5fBE2vaFrir9I4zDhaBheSN83
	 G42tMeHhRyjhwf7zWZYGjnP498viF07XPJx1Ye4BFSJ0YW2EEg6zF+Be0yOKSTUmiU
	 pJ/owN7j4uUfbuqpNFJV23sRYBiWyw8g0O3iF6WCf1si7p7XnRdDDdk5FTiGV6yUDW
	 eoZqXDn+CqKiYuTIyV8JyoyblMKQfk4gncQ4by8FAxV5PX6KNR9W9uqVXNXnBdSB/y
	 Bb5WWkT6Dk6XmjseCYTLghjFDswlRn9GtDy+qQHQzYsavQq3EeUOE4afuEV5TXtF4e
	 0cYTXx/ak3jnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 10/21] intel_th: avoid using deprecated page->mapping, index fields
Date: Tue, 29 Apr 2025 19:52:22 -0400
Message-Id: <20250429235233.537828-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235233.537828-1-sashal@kernel.org>
References: <20250429235233.537828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.88
Content-Transfer-Encoding: 8bit

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


