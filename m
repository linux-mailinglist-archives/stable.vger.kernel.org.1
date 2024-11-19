Return-Path: <stable+bounces-93909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D69D1F5D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFD31F22934
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666D1459F6;
	Tue, 19 Nov 2024 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fri4UgaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374614D2A0
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990999; cv=none; b=eb4IL9nArWw+xg20BEfU/y/NYhbAcXAPEws2mjRTpgXmQnPSB6xCGUEZ0GGYuCEESUVIErnKsb04nQ6UhORfFieDq/bWBkCCGEFg0baBU9GnUZ0zP5n/lfLcY6FjzV+x/FOLQOrU+e+Q4BRGbyFDWEWFmXrLbibkDtznSoVtIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990999; c=relaxed/simple;
	bh=TIQrN4u5St8hr/XS/vAatFzhQ0YrQPlJweX1Vbe9RpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ji5O8CTZ5gnVZAIDDhHN6aI87utj6fFNZtJyf1zM9oFUyudbLdmXS+OQDcsGai9mDrd80sVNJtH36QU/iu9IHKHEE+A/LJCWAbK0eFhy72hv/DHeIOBYrXXyetTkNsqOjioH9jCQFQztQ6+kFyS3lmN/wjfd7spWx7LpTCeUPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fri4UgaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAD8C4CECF;
	Tue, 19 Nov 2024 04:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990999;
	bh=TIQrN4u5St8hr/XS/vAatFzhQ0YrQPlJweX1Vbe9RpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fri4UgaIh7UjH4QsTBdfb3n2xc/Vou2Mh7sbxmaCbMdqrm2SZYT1X4L9J0xABMDV2
	 pOwVtrv2K3jYmfiH5FZeEEO2SDMj05XDGwN/69+RB/GvlBEttfVtFUKy2h1ZNSVLaz
	 jGbqFE50NRKQG74+n4ubHl8fdefGUMiAxF5meqeLLfLh46xFmUhhk2W6XoQh3kMmG/
	 k1OC6wFsJfko6X9yecx3BoMGJV/VYJjtJza0W1H0zeCWQ26AEDKczoxDjVyJihXgZH
	 RYFGptEpPjuAzvRd2ScccZ53sdMZnfy2L8ePcYcF/a6jM2I9DRZIsBC2ILVeESilie
	 DZir3y2oPtx4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2 1/4] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Mon, 18 Nov 2024 23:36:37 -0500
Message-ID: <d1cf846c2b9c5a2d9767ec128bbafedeaa6d2856.1731946386.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <d1cf846c2b9c5a2d9767ec128bbafedeaa6d2856.1731946386.git.lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Not found                                   |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 17:02:33.482808617 -0500
+++ /tmp/tmp.rwIAcuvh0T	2024-11-18 17:02:33.475556000 -0500
@@ -20,7 +20,6 @@
 series which goes further, separated out from the v1 series and sent and
 updated separately.
 
-
 This patch (of 5):
 
 After an attempted mmap() fails, we are no longer in a situation where we
@@ -41,14 +40,14 @@
 nested within the call_mmap() from mm, which we now replace.
 
 It is therefore safe to leave call_mmap() in place as a convenience
-function (and to avoid churn).  The invokers are:
+    function (and to avoid churn).  The invokers are:
 
      ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
     coda_file_operations -> mmap -> coda_file_mmap()
      shm_file_operations -> shm_mmap()
 shm_file_operations_huge -> shm_mmap()
             dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
-	                    -> i915_gem_dmabuf_mmap()
+                            -> i915_gem_dmabuf_mmap()
 
 None of these callers interact with vm_ops or mappings in a problematic
 way on error, quickly exiting out.
@@ -72,19 +71,21 @@
 Cc: Will Deacon <will@kernel.org>
 Cc: <stable@vger.kernel.org>
 Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
+Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 ---
- mm/internal.h | 27 +++++++++++++++++++++++++++
- mm/mmap.c     |  6 +++---
+ mm/internal.h | 12 ++++++++++++
+ mm/mmap.c     |  4 ++--
  mm/nommu.c    |  4 ++--
- 3 files changed, 32 insertions(+), 5 deletions(-)
+ mm/util.c     | 18 ++++++++++++++++++
+ 4 files changed, 34 insertions(+), 4 deletions(-)
 
 diff --git a/mm/internal.h b/mm/internal.h
-index 16c1f3cd599e5..4eab2961e69ce 100644
+index a50bc08337d2..85ac9c6a1393 100644
 --- a/mm/internal.h
 +++ b/mm/internal.h
-@@ -108,6 +108,33 @@ static inline void *folio_raw_mapping(const struct folio *folio)
- 	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
- }
+@@ -52,6 +52,18 @@ struct folio_batch;
+ 
+ void page_writeback_init(void);
  
 +/*
 + * This is a file-backed mapping, and is about to be memory mapped - invoke its
@@ -96,62 +97,38 @@
 + *
 + * Returns: 0 if success, error otherwise.
 + */
-+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
-+{
-+	int err = call_mmap(file, vma);
-+
-+	if (likely(!err))
-+		return 0;
-+
-+	/*
-+	 * OK, we tried to call the file hook for mmap(), but an error
-+	 * arose. The mapping is in an inconsistent state and we most not invoke
-+	 * any further hooks on it.
-+	 */
-+	vma->vm_ops = &vma_dummy_vm_ops;
++int mmap_file(struct file *file, struct vm_area_struct *vma);
 +
-+	return err;
-+}
-+
- #ifdef CONFIG_MMU
- 
- /* Flags for folio_pte_batch(). */
+ static inline void *folio_raw_mapping(struct folio *folio)
+ {
+ 	unsigned long mapping = (unsigned long)folio->mapping;
 diff --git a/mm/mmap.c b/mm/mmap.c
-index 9841b41e3c762..6e3b25f7728f9 100644
+index c0f9575493de..bf2f1ca87bef 100644
 --- a/mm/mmap.c
 +++ b/mm/mmap.c
-@@ -1422,7 +1422,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
- 	/*
- 	 * clear PTEs while the vma is still in the tree so that rmap
- 	 * cannot race with the freeing later in the truncate scenario.
--	 * This is also needed for call_mmap(), which is why vm_ops
-+	 * This is also needed for mmap_file(), which is why vm_ops
- 	 * close function is called.
- 	 */
- 	vms_clean_up_area(&vms, &mas_detach);
-@@ -1447,7 +1447,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
+@@ -2760,7 +2760,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
+ 		}
  
- 	if (file) {
  		vma->vm_file = get_file(file);
 -		error = call_mmap(file, vma);
 +		error = mmap_file(file, vma);
  		if (error)
  			goto unmap_and_free_vma;
  
-@@ -1470,7 +1470,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
+@@ -2775,7 +2775,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
+ 		mas_reset(&mas);
  
- 		vma_iter_config(&vmi, addr, end);
  		/*
 -		 * If vm_flags changed after call_mmap(), we should try merge
 +		 * If vm_flags changed after mmap_file(), we should try merge
  		 * vma again as we may succeed this time.
  		 */
- 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+ 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
 diff --git a/mm/nommu.c b/mm/nommu.c
-index 385b0c15add89..f9ccc02458ec6 100644
+index 8e8fe491d914..f09e798a4416 100644
 --- a/mm/nommu.c
 +++ b/mm/nommu.c
-@@ -885,7 +885,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
+@@ -939,7 +939,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
  {
  	int ret;
  
@@ -160,12 +137,44 @@
  	if (ret == 0) {
  		vma->vm_region->vm_top = vma->vm_region->vm_end;
  		return 0;
-@@ -918,7 +918,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
- 	 * happy.
+@@ -970,7 +970,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
+ 	 * - VM_MAYSHARE will be set if it may attempt to share
  	 */
  	if (capabilities & NOMMU_MAP_DIRECT) {
 -		ret = call_mmap(vma->vm_file, vma);
 +		ret = mmap_file(vma->vm_file, vma);
- 		/* shouldn't return success if we're not sharing */
- 		if (WARN_ON_ONCE(!is_nommu_shared_mapping(vma->vm_flags)))
- 			ret = -ENOSYS;
+ 		if (ret == 0) {
+ 			/* shouldn't return success if we're not sharing */
+ 			BUG_ON(!(vma->vm_flags & VM_MAYSHARE));
+diff --git a/mm/util.c b/mm/util.c
+index 94fff247831b..15f1970da665 100644
+--- a/mm/util.c
++++ b/mm/util.c
+@@ -1103,6 +1103,24 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
+ 	return ret;
+ }
+ 
++int mmap_file(struct file *file, struct vm_area_struct *vma)
++{
++	static const struct vm_operations_struct dummy_vm_ops = {};
++	int err = call_mmap(file, vma);
++
++	if (likely(!err))
++		return 0;
++
++	/*
++	 * OK, we tried to call the file hook for mmap(), but an error
++	 * arose. The mapping is in an inconsistent state and we most not invoke
++	 * any further hooks on it.
++	 */
++	vma->vm_ops = &dummy_vm_ops;
++
++	return err;
++}
++
+ #ifdef CONFIG_PRINTK
+ /**
+  * mem_dump_obj - Print available provenance information
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

