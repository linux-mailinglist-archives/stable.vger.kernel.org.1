Return-Path: <stable+bounces-120360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC6A4EA38
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9B3189DB29
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F393251791;
	Tue,  4 Mar 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKGMP8oh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392620A5C2
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109642; cv=none; b=Ivg11Q2Q4aG3cG/SKsyo0YMz78S1aRXz6QiJ0/yVfirb5k/He8/HT1vvc2jYKzHU51PPgD/+ISPj2IIeIBjxo8yaO2YbzB8rfAkzzFBYvxHDemdSfx8UVbeD+Y1EeVHOPDMzlm60MM/u2Wuja94XQrttNkLI1cq0mK1ETBSMnCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109642; c=relaxed/simple;
	bh=jOjJiRmMreBiZqD3KjYAAFx7jr+MUAyO281zdBk2WRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1q4qtzaS1K8c50dKy5R9w7F++DS6rOSBD4cTCmTe24hzAV5LYhTo6bautxysbdPnbFPATDVkTcd2XcuuMRke/ihrYak91NU+6ZZgOOcgmQqnoDNGx2w5Sn2qQtQKsvSTbKPR9fRqh/qPc3lQbrZi7tdYKExL/eiMwDyjoIySzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKGMP8oh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741109640; x=1772645640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jOjJiRmMreBiZqD3KjYAAFx7jr+MUAyO281zdBk2WRI=;
  b=PKGMP8ohT9kk2DAVK5ngi1/nQvPa8gV9heUd/QqTkBqmoU/0zSPKqR8X
   gl9yMYLDPn4C65pvnXNUx50gTZoQNnigIQwRxVcVIDtNjYKmCsTlxmnCk
   oVPNxSEOmEXWfUCB4Mcr3ibpHpOjKTrdDh0rbTS7RO42VZJIM75KOB8Rs
   2NKHq2bgviEOWyjSTL0RHgQDDt1CS127tQmTXdhTevAD99yhUHnE5rdzt
   X3nv2JyJCnZsSWnPts/CxUK56qr2DW7RMRaAuDCQ6BO0sEyG2vA4J/OWB
   Wp6OjVE4prfe7Yy+20H/AEx92G2WvbjTXZ1Z45sqeBn8pHyeTGatFpazQ
   A==;
X-CSE-ConnectionGUID: nLtv44l+QA6yQqakQlCLZw==
X-CSE-MsgGUID: +cYzKtBeS6aZSfIElkNQgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42172078"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42172078"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:33:59 -0800
X-CSE-ConnectionGUID: 8HhDwo6hTje2476BhLxwXw==
X-CSE-MsgGUID: adhS8BBUSzeltlWcRcZueg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="119123293"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.227])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:33:58 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Oak Zeng <oak.zeng@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v3 2/3] drm/xe/hmm: Don't dereference struct page pointers without notifier lock
Date: Tue,  4 Mar 2025 18:33:41 +0100
Message-ID: <20250304173342.22009-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304173342.22009-1-thomas.hellstrom@linux.intel.com>
References: <20250304173342.22009-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/gpu/drm/xe/xe_hmm.c | 112 +++++++++++++++++++++++++++---------
 1 file changed, 86 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index c56738fa713b..d33dd7bc3f41 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -42,6 +42,42 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
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
@@ -50,6 +86,7 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
  * @range: the hmm range that we build the sg table from. range->hmm_pfns[]
  * has the pfn numbers of pages that back up this hmm address range.
  * @st: pointer to the sg table.
+ * @notifier_sem: The xe notifier lock.
  * @write: whether we write to this range. This decides dma map direction
  * for system pages. If write we map it bi-diretional; otherwise
  * DMA_TO_DEVICE
@@ -76,38 +113,41 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
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
+	struct scatterlist *sgl;
+	struct page *page;
+	unsigned long i, j;
 
-	npages = xe_npages_in_range(range->start, range->end);
-	pages = kvmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	lockdep_assert_held(notifier_sem);
 
-	for (i = 0; i < npages; i++) {
-		pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
-		xe_assert(xe, !is_device_private_page(pages[i]));
-	}
+	i = 0;
+	for_each_sg(st->sgl, sgl, st->nents, j) {
+		unsigned long hmm_pfn, size;
 
-	ret = sg_alloc_table_from_pages_segment(st, pages, npages, 0, npages << PAGE_SHIFT,
-						xe_sg_segment_size(dev), GFP_KERNEL);
-	if (ret)
-		goto free_pages;
+		hmm_pfn = range->hmm_pfns[i];
+		page = hmm_pfn_to_page(hmm_pfn);
+		xe_assert(xe, !is_device_private_page(page));
+
+		size = 1UL << hmm_pfn_to_map_order(hmm_pfn);
+		size -= page_to_pfn(page) & (size - 1);
+		i += size;
 
-	ret = dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
-			      DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
-	if (ret) {
-		sg_free_table(st);
-		st = NULL;
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
@@ -235,16 +275,36 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
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
-- 
2.48.1


