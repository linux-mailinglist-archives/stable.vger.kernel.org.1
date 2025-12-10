Return-Path: <stable+bounces-200706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B379ACB2C82
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CCD305D40B
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F13148B1;
	Wed, 10 Dec 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzAKE3j7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4883115B1
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364906; cv=none; b=HKtZtbUMxmCD4k1/0aKK5bg8WN0akoBfLbTtyIc5UtMGnkL8H1BWjScdP1Zd6na0VOEqI8tR1MKrVfHmv7mLPp7U8HVewseiVJDAZeNXtaiiRlBANnxwhVnrilCSKVh1pRh+lkcPmZCW2+BakEB+jYVPoEr8Jq+6XgmM98L/z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364906; c=relaxed/simple;
	bh=3loAR+8B7itrRGdZVg31I09E0F/iG/wNWI3Eh+Bw3zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlJxtdqURTAUhsmeTmu/kn9yeKGAbWs0dXGQoVJ+NvIeEDwBQAarnRWTJ04VHLQfxdU/WWtMs1Z7Q88pipOS6OYDhMbo5BSIEYYpnZJBUeWp6FzhC/zuekC2/agJ2N3hHT7AgLRlWy5ExqD3g1lt4dW3qX/FHXRZoDVIPp2Iw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzAKE3j7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765364903; x=1796900903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3loAR+8B7itrRGdZVg31I09E0F/iG/wNWI3Eh+Bw3zQ=;
  b=DzAKE3j7TEdJPTNE6F/07JMY97aGymJr79xceKQgtrNzsKOBGlPIj7e1
   58MlX5RApv4/ruNj4IxstXcQeV5+G2GNk23qnvZnrF/qzxUd/d5dBGUdA
   rv23TODiuLKJZgnw88trH1mwWItXDJQFzu9fC0pb7iJ0KoBqYP9Z0LJoW
   ufZQwx5csDK2zJBexMSKo792HXO8TlFRDZWI1BQ/TZ47AaPfuuNZybyOL
   KdSddply37szl8PiREEVlSYu3G80hiBUk+6XNBgduhHmvEo2lT/nFZnjl
   QK9fi7CIEzpfsXsyFP7YBQV1u+r+rFBLB5aV6DnDY4uHTr6wiuMD9axzd
   A==;
X-CSE-ConnectionGUID: oJLilDjRTBSiEzXFVW224g==
X-CSE-MsgGUID: N/5Go1J0RseF1+OHTa962w==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67221736"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="67221736"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 03:08:23 -0800
X-CSE-ConnectionGUID: iCT0491ZRYiV2BUerkx46Q==
X-CSE-MsgGUID: s+iLweilSNmzjzHyU8BeHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="196486935"
Received: from rvuia-mobl.ger.corp.intel.com (HELO fedora) ([10.245.244.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 03:08:20 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	himal.prasad.ghimiray@intel.com,
	apopple@nvidia.com,
	airlied@gmail.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	felix.kuehling@amd.com,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dakr@kernel.org,
	"Mrozek, Michal" <michal.mrozek@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v3 02/22] drm/pagemap, drm/xe: Ensure that the devmem allocation is idle before use
Date: Wed, 10 Dec 2025 12:07:22 +0100
Message-ID: <20251210110742.107575-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251210110742.107575-1-thomas.hellstrom@linux.intel.com>
References: <20251210110742.107575-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In situations where no system memory is migrated to devmem, and in
upcoming patches where another GPU is performing the migration to
the newly allocated devmem buffer, there is nothing to ensure any
ongoing clear to the devmem allocation or async eviction from the
devmem allocation is complete.

Address that by passing a struct dma_fence down to the copy
functions, and ensure it is waited for before migration is marked
complete.

v3:
- New patch.

Fixes: c5b3eb5a906c ("drm/xe: Add GPUSVM device memory copy vfunc functions")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 13 ++++---
 drivers/gpu/drm/xe/xe_svm.c   | 65 ++++++++++++++++++++++++++++++-----
 include/drm/drm_pagemap.h     | 17 +++++++--
 3 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 22c44807e3fe..864a73d019ed 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -408,7 +408,8 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 		drm_pagemap_get_devmem_page(page, zdd);
 	}
 
-	err = ops->copy_to_devmem(pages, pagemap_addr, npages);
+	err = ops->copy_to_devmem(pages, pagemap_addr, npages,
+				  devmem_allocation->pre_migrate_fence);
 	if (err)
 		goto err_finalize;
 
@@ -596,7 +597,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	for (i = 0; i < npages; ++i)
 		pages[i] = migrate_pfn_to_page(src[i]);
 
-	err = ops->copy_to_ram(pages, pagemap_addr, npages);
+	err = ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
 	if (err)
 		goto err_finalize;
 
@@ -732,7 +733,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	for (i = 0; i < npages; ++i)
 		pages[i] = migrate_pfn_to_page(migrate.src[i]);
 
-	err = ops->copy_to_ram(pages, pagemap_addr, npages);
+	err = ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
 	if (err)
 		goto err_finalize;
 
@@ -813,11 +814,14 @@ EXPORT_SYMBOL_GPL(drm_pagemap_pagemap_ops_get);
  * @ops: Pointer to the operations structure for GPU SVM device memory
  * @dpagemap: The struct drm_pagemap we're allocating from.
  * @size: Size of device memory allocation
+ * @pre_migrate_fence: Fence to wait for or pipeline behind before migration starts.
+ * (May be NULL).
  */
 void drm_pagemap_devmem_init(struct drm_pagemap_devmem *devmem_allocation,
 			     struct device *dev, struct mm_struct *mm,
 			     const struct drm_pagemap_devmem_ops *ops,
-			     struct drm_pagemap *dpagemap, size_t size)
+			     struct drm_pagemap *dpagemap, size_t size,
+			     struct dma_fence *pre_migrate_fence)
 {
 	init_completion(&devmem_allocation->detached);
 	devmem_allocation->dev = dev;
@@ -825,6 +829,7 @@ void drm_pagemap_devmem_init(struct drm_pagemap_devmem *devmem_allocation,
 	devmem_allocation->ops = ops;
 	devmem_allocation->dpagemap = dpagemap;
 	devmem_allocation->size = size;
+	devmem_allocation->pre_migrate_fence = pre_migrate_fence;
 }
 EXPORT_SYMBOL_GPL(drm_pagemap_devmem_init);
 
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 36634c84d148..34b4585412ef 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -483,11 +483,12 @@ static void xe_svm_copy_us_stats_incr(struct xe_gt *gt,
 
 static int xe_svm_copy(struct page **pages,
 		       struct drm_pagemap_addr *pagemap_addr,
-		       unsigned long npages, const enum xe_svm_copy_dir dir)
+		       unsigned long npages, const enum xe_svm_copy_dir dir,
+		       struct dma_fence *pre_migrate_fence)
 {
 	struct xe_vram_region *vr = NULL;
 	struct xe_gt *gt = NULL;
-	struct xe_device *xe;
+	struct xe_device *xe = NULL;
 	struct dma_fence *fence = NULL;
 	unsigned long i;
 #define XE_VRAM_ADDR_INVALID	~0x0ull
@@ -496,6 +497,17 @@ static int xe_svm_copy(struct page **pages,
 	bool sram = dir == XE_SVM_COPY_TO_SRAM;
 	ktime_t start = xe_svm_stats_ktime_get();
 
+	if (sram && pre_migrate_fence) {
+		/*
+		 * This would typically be a p2p migration from source.
+		 * Ensure that any other GPU operation on the destination
+		 * is complete.
+		 */
+		err = dma_fence_wait(pre_migrate_fence, true);
+		if (err)
+			return err;
+	}
+
 	/*
 	 * This flow is complex: it locates physically contiguous device pages,
 	 * derives the starting physical address, and performs a single GPU copy
@@ -632,10 +644,27 @@ static int xe_svm_copy(struct page **pages,
 
 err_out:
 	/* Wait for all copies to complete */
-	if (fence) {
+	if (fence)
 		dma_fence_wait(fence, false);
-		dma_fence_put(fence);
+
+	/*
+	 * If migrating to devmem, we should have pipelined the migration behind
+	 * the pre_migrate_fence. Verify that this is indeed likely. If we
+	 * didn't perform any copying, just wait for the pre_migrate_fence.
+	 */
+	if (!sram && pre_migrate_fence) {
+		if (!dma_fence_is_signaled(pre_migrate_fence)) {
+			if (xe && fence &&
+			    drm_WARN_ON(&xe->drm, "Unsignaled pre-migrate fence"))
+				drm_warn(&xe->drm, "fence contexts: %llu %llu. container %d\n",
+					 (unsigned long long)fence->context,
+					 (unsigned long long)pre_migrate_fence->context,
+					 dma_fence_is_container(pre_migrate_fence));
+
+			dma_fence_wait(pre_migrate_fence, false);
+		}
 	}
+	dma_fence_put(fence);
 
 	/*
 	 * XXX: We can't derive the GT here (or anywhere in this functions, but
@@ -652,16 +681,20 @@ static int xe_svm_copy(struct page **pages,
 
 static int xe_svm_copy_to_devmem(struct page **pages,
 				 struct drm_pagemap_addr *pagemap_addr,
-				 unsigned long npages)
+				 unsigned long npages,
+				 struct dma_fence *pre_migrate_fence)
 {
-	return xe_svm_copy(pages, pagemap_addr, npages, XE_SVM_COPY_TO_VRAM);
+	return xe_svm_copy(pages, pagemap_addr, npages, XE_SVM_COPY_TO_VRAM,
+			   pre_migrate_fence);
 }
 
 static int xe_svm_copy_to_ram(struct page **pages,
 			      struct drm_pagemap_addr *pagemap_addr,
-			      unsigned long npages)
+			      unsigned long npages,
+			      struct dma_fence *pre_migrate_fence)
 {
-	return xe_svm_copy(pages, pagemap_addr, npages, XE_SVM_COPY_TO_SRAM);
+	return xe_svm_copy(pages, pagemap_addr, npages, XE_SVM_COPY_TO_SRAM,
+			   pre_migrate_fence);
 }
 
 static struct xe_bo *to_xe_bo(struct drm_pagemap_devmem *devmem_allocation)
@@ -676,6 +709,7 @@ static void xe_svm_devmem_release(struct drm_pagemap_devmem *devmem_allocation)
 
 	xe_bo_put_async(bo);
 	xe_pm_runtime_put(xe);
+	dma_fence_put(devmem_allocation->pre_migrate_fence);
 }
 
 static u64 block_offset_to_pfn(struct xe_vram_region *vr, u64 offset)
@@ -868,6 +902,7 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 				      unsigned long timeslice_ms)
 {
 	struct xe_vram_region *vr = container_of(dpagemap, typeof(*vr), dpagemap);
+	struct dma_fence *pre_migrate_fence = NULL;
 	struct xe_device *xe = vr->xe;
 	struct device *dev = xe->drm.dev;
 	struct drm_buddy_block *block;
@@ -894,8 +929,20 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 			break;
 		}
 
+		/* Ensure that any clearing or async eviction will complete before migration. */
+		if (!dma_resv_test_signaled(bo->ttm.base.resv, DMA_RESV_USAGE_KERNEL)) {
+			err = dma_resv_get_singleton(bo->ttm.base.resv, DMA_RESV_USAGE_KERNEL,
+						     &pre_migrate_fence);
+			if (err)
+				dma_resv_wait_timeout(bo->ttm.base.resv, DMA_RESV_USAGE_KERNEL,
+						      false, MAX_SCHEDULE_TIMEOUT);
+			else if (pre_migrate_fence)
+				dma_fence_enable_sw_signaling(pre_migrate_fence);
+		}
+
 		drm_pagemap_devmem_init(&bo->devmem_allocation, dev, mm,
-					&dpagemap_devmem_ops, dpagemap, end - start);
+					&dpagemap_devmem_ops, dpagemap, end - start,
+					pre_migrate_fence);
 
 		blocks = &to_xe_ttm_vram_mgr_resource(bo->ttm.resource)->blocks;
 		list_for_each_entry(block, blocks, link)
diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
index f6e7e234c089..70a7991f784f 100644
--- a/include/drm/drm_pagemap.h
+++ b/include/drm/drm_pagemap.h
@@ -8,6 +8,7 @@
 
 #define NR_PAGES(order) (1U << (order))
 
+struct dma_fence;
 struct drm_pagemap;
 struct drm_pagemap_zdd;
 struct device;
@@ -174,6 +175,8 @@ struct drm_pagemap_devmem_ops {
 	 * @pages: Pointer to array of device memory pages (destination)
 	 * @pagemap_addr: Pointer to array of DMA information (source)
 	 * @npages: Number of pages to copy
+	 * @pre_migrate_fence: dma-fence to wait for before migration start.
+	 * May be NULL.
 	 *
 	 * Copy pages to device memory. If the order of a @pagemap_addr entry
 	 * is greater than 0, the entry is populated but subsequent entries
@@ -183,13 +186,16 @@ struct drm_pagemap_devmem_ops {
 	 */
 	int (*copy_to_devmem)(struct page **pages,
 			      struct drm_pagemap_addr *pagemap_addr,
-			      unsigned long npages);
+			      unsigned long npages,
+			      struct dma_fence *pre_migrate_fence);
 
 	/**
 	 * @copy_to_ram: Copy to system RAM (required for migration)
 	 * @pages: Pointer to array of device memory pages (source)
 	 * @pagemap_addr: Pointer to array of DMA information (destination)
 	 * @npages: Number of pages to copy
+	 * @pre_migrate_fence: dma-fence to wait for before migration start.
+	 * May be NULL.
 	 *
 	 * Copy pages to system RAM. If the order of a @pagemap_addr entry
 	 * is greater than 0, the entry is populated but subsequent entries
@@ -199,7 +205,8 @@ struct drm_pagemap_devmem_ops {
 	 */
 	int (*copy_to_ram)(struct page **pages,
 			   struct drm_pagemap_addr *pagemap_addr,
-			   unsigned long npages);
+			   unsigned long npages,
+			   struct dma_fence *pre_migrate_fence);
 };
 
 /**
@@ -212,6 +219,8 @@ struct drm_pagemap_devmem_ops {
  * @dpagemap: The struct drm_pagemap of the pages this allocation belongs to.
  * @size: Size of device memory allocation
  * @timeslice_expiration: Timeslice expiration in jiffies
+ * @pre_migrate_fence: Fence to wait for or pipeline behind before migration starts.
+ * (May be NULL).
  */
 struct drm_pagemap_devmem {
 	struct device *dev;
@@ -221,6 +230,7 @@ struct drm_pagemap_devmem {
 	struct drm_pagemap *dpagemap;
 	size_t size;
 	u64 timeslice_expiration;
+	struct dma_fence *pre_migrate_fence;
 };
 
 int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
@@ -238,7 +248,8 @@ struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page);
 void drm_pagemap_devmem_init(struct drm_pagemap_devmem *devmem_allocation,
 			     struct device *dev, struct mm_struct *mm,
 			     const struct drm_pagemap_devmem_ops *ops,
-			     struct drm_pagemap *dpagemap, size_t size);
+			     struct drm_pagemap *dpagemap, size_t size,
+			     struct dma_fence *pre_migrate_fence);
 
 int drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
 			    unsigned long start, unsigned long end,
-- 
2.51.1


