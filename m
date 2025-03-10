Return-Path: <stable+bounces-121779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EE4A59C67
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10563A8C89
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D57922D4D0;
	Mon, 10 Mar 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rm0pXZrs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC31E519;
	Mon, 10 Mar 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626604; cv=none; b=CiPR5r/D5KCVZxabE6FHhc93aP9v14Jfe6u7Q3v5q1pLN1X+QcqyoToeyAG10rwRJP2D+0zun3ik8bE7L7P4ITyEQu2+vE7oY4zLs/iV/RNqSj7zZjX3tNCz1uvawQeE8t4SkFkIkI9fyXtVZwFMo1LIgKgFkt+tXCRPdO5G5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626604; c=relaxed/simple;
	bh=yQ3Fo+g5PKr5ttCGfQ9Cn12uEOBsigEFdJrxfO5Q+6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dB4zqsvX0cKkDRyI2pBj7qq7tx/5tXFTnHRbj3N3WyP3C1FHcsxB3JJKKto7g6DO5lI2CY6nu056qmWIBaJK/V70sqPRLmTOQNC8NybLX9PpL40rKWxxJ+377ElJDTYyLs1vXFEeilAIbe0jJYwUUzgeHZc5IxATPsGwTzvDLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rm0pXZrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583C0C4CEE5;
	Mon, 10 Mar 2025 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626604;
	bh=yQ3Fo+g5PKr5ttCGfQ9Cn12uEOBsigEFdJrxfO5Q+6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rm0pXZrsDRgqj+D5bJNpUV0hN90kzet/tABrWQrrGlE04MRekDa9k8HZJceX+aeyw
	 vCWQ9QO4WE2uUEk+OvjTSmaHVyXTFEotrAjynn8Z6NB3JYrNzZeY2lC/JlfDmS8jHB
	 8vROQCGajgUBR+tvba4MRvoMft8Pmr/cdNPLGMLY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oak Zeng <oak.zeng@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.13 050/207] drm/xe/hmm: Dont dereference struct page pointers without notifier lock
Date: Mon, 10 Mar 2025 18:04:03 +0100
Message-ID: <20250310170449.758277082@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit 0a98219bcc961edd3388960576e4353e123b4a51 upstream.

The pnfs that we obtain from hmm_range_fault() point to pages that
we don't have a reference on, and the guarantee that they are still
in the cpu page-tables is that the notifier lock must be held and the
notifier seqno is still valid.

So while building the sg table and marking the pages accesses / dirty
we need to hold this lock with a validated seqno.

However, the lock is reclaim tainted which makes
sg_alloc_table_from_pages_segment() unusable, since it internally
allocates memory.

Instead build the sg-table manually. For the non-iommu case
this might lead to fewer coalesces, but if that's a problem it can
be fixed up later in the resource cursor code. For the iommu case,
the whole sg-table may still be coalesced to a single contigous
device va region.

This avoids marking pages that we don't own dirty and accessed, and
it also avoid dereferencing struct pages that we don't own.

v2:
- Use assert to check whether hmm pfns are valid (Matthew Auld)
- Take into account that large pages may cross range boundaries
  (Matthew Auld)

v3:
- Don't unnecessarily check for a non-freed sg-table. (Matthew Auld)
- Add a missing up_read() in an error path. (Matthew Auld)

Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
Cc: Oak Zeng <oak.zeng@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Acked-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250304173342.22009-3-thomas.hellstrom@linux.intel.com
(cherry picked from commit ea3e66d280ce2576664a862693d1da8fd324c317)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_hmm.c |  120 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 30 deletions(-)

--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -42,6 +42,42 @@ static void xe_mark_range_accessed(struc
 	}
 }
 
+static int xe_alloc_sg(struct xe_device *xe, struct sg_table *st,
+		       struct hmm_range *range, struct rw_semaphore *notifier_sem)
+{
+	unsigned long i, npages, hmm_pfn;
+	unsigned long num_chunks = 0;
+	int ret;
+
+	/* HMM docs says this is needed. */
+	ret = down_read_interruptible(notifier_sem);
+	if (ret)
+		return ret;
+
+	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
+		up_read(notifier_sem);
+		return -EAGAIN;
+	}
+
+	npages = xe_npages_in_range(range->start, range->end);
+	for (i = 0; i < npages;) {
+		unsigned long len;
+
+		hmm_pfn = range->hmm_pfns[i];
+		xe_assert(xe, hmm_pfn & HMM_PFN_VALID);
+
+		len = 1UL << hmm_pfn_to_map_order(hmm_pfn);
+
+		/* If order > 0 the page may extend beyond range->start */
+		len -= (hmm_pfn & ~HMM_PFN_FLAGS) & (len - 1);
+		i += len;
+		num_chunks++;
+	}
+	up_read(notifier_sem);
+
+	return sg_alloc_table(st, num_chunks, GFP_KERNEL);
+}
+
 /**
  * xe_build_sg() - build a scatter gather table for all the physical pages/pfn
  * in a hmm_range. dma-map pages if necessary. dma-address is save in sg table
@@ -50,6 +86,7 @@ static void xe_mark_range_accessed(struc
  * @range: the hmm range that we build the sg table from. range->hmm_pfns[]
  * has the pfn numbers of pages that back up this hmm address range.
  * @st: pointer to the sg table.
+ * @notifier_sem: The xe notifier lock.
  * @write: whether we write to this range. This decides dma map direction
  * for system pages. If write we map it bi-diretional; otherwise
  * DMA_TO_DEVICE
@@ -76,38 +113,41 @@ static void xe_mark_range_accessed(struc
  * Returns 0 if successful; -ENOMEM if fails to allocate memory
  */
 static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
-		       struct sg_table *st, bool write)
+		       struct sg_table *st,
+		       struct rw_semaphore *notifier_sem,
+		       bool write)
 {
+	unsigned long npages = xe_npages_in_range(range->start, range->end);
 	struct device *dev = xe->drm.dev;
-	struct page **pages;
-	u64 i, npages;
-	int ret;
-
-	npages = xe_npages_in_range(range->start, range->end);
-	pages = kvmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-
-	for (i = 0; i < npages; i++) {
-		pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
-		xe_assert(xe, !is_device_private_page(pages[i]));
-	}
-
-	ret = sg_alloc_table_from_pages_segment(st, pages, npages, 0, npages << PAGE_SHIFT,
-						xe_sg_segment_size(dev), GFP_KERNEL);
-	if (ret)
-		goto free_pages;
-
-	ret = dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
-			      DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
-	if (ret) {
-		sg_free_table(st);
-		st = NULL;
+	struct scatterlist *sgl;
+	struct page *page;
+	unsigned long i, j;
+
+	lockdep_assert_held(notifier_sem);
+
+	i = 0;
+	for_each_sg(st->sgl, sgl, st->nents, j) {
+		unsigned long hmm_pfn, size;
+
+		hmm_pfn = range->hmm_pfns[i];
+		page = hmm_pfn_to_page(hmm_pfn);
+		xe_assert(xe, !is_device_private_page(page));
+
+		size = 1UL << hmm_pfn_to_map_order(hmm_pfn);
+		size -= page_to_pfn(page) & (size - 1);
+		i += size;
+
+		if (unlikely(j == st->nents - 1)) {
+			if (i > npages)
+				size -= (i - npages);
+			sg_mark_end(sgl);
+		}
+		sg_set_page(sgl, page, size << PAGE_SHIFT, 0);
 	}
+	xe_assert(xe, i == npages);
 
-free_pages:
-	kvfree(pages);
-	return ret;
+	return dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
+			       DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
 }
 
 /**
@@ -235,16 +275,36 @@ int xe_hmm_userptr_populate_range(struct
 	if (ret)
 		goto free_pfns;
 
-	ret = xe_build_sg(vm->xe, &hmm_range, &userptr->sgt, write);
+	ret = xe_alloc_sg(vm->xe, &userptr->sgt, &hmm_range, &vm->userptr.notifier_lock);
 	if (ret)
 		goto free_pfns;
 
+	ret = down_read_interruptible(&vm->userptr.notifier_lock);
+	if (ret)
+		goto free_st;
+
+	if (mmu_interval_read_retry(hmm_range.notifier, hmm_range.notifier_seq)) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
+	ret = xe_build_sg(vm->xe, &hmm_range, &userptr->sgt,
+			  &vm->userptr.notifier_lock, write);
+	if (ret)
+		goto out_unlock;
+
 	xe_mark_range_accessed(&hmm_range, write);
 	userptr->sg = &userptr->sgt;
 	userptr->notifier_seq = hmm_range.notifier_seq;
+	up_read(&vm->userptr.notifier_lock);
+	kvfree(pfns);
+	return 0;
 
+out_unlock:
+	up_read(&vm->userptr.notifier_lock);
+free_st:
+	sg_free_table(&userptr->sgt);
 free_pfns:
 	kvfree(pfns);
 	return ret;
 }
-



