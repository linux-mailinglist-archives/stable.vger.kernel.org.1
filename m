Return-Path: <stable+bounces-147977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE9AC6D1A
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1543AC19E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF8D2868BA;
	Wed, 28 May 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSWN8yDc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F2C2D1
	for <stable@vger.kernel.org>; Wed, 28 May 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447011; cv=none; b=WjbC/JRkajqDGfTDLosxAMfyw4sW9GouOozYJ6KWDjGacDb0o52jwliT0hhMSuSN2agx1FRikAlOb9N060YWiGbY+8B3MLQK+UjIT8EFQLe7jZ7nm5U9LqZLmrZ+uTiTDConsW5Rex4LZQOXj54wUjx/wYN9OoMqwFWDzzoz2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447011; c=relaxed/simple;
	bh=lMdhBWmyG+BIB+Hqln8cDc+dIqqbg6EYjzu02ojwL7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JquylvKkMjkJeuVJS6KrOcHW6dI2/FmrHZGeJNH8s9Boh1xEShrDkr4OPSLtwVCv7bo6Qg2o4bwa0NiB2K9c39NWodC33+DmhLAg57RLRtrYI90UoyDrBLW8Hr1ZasIAU9Mr87CHWMzvOn6B04VWBPsArKoyPqJwUeeUDBbqw3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSWN8yDc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748447010; x=1779983010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lMdhBWmyG+BIB+Hqln8cDc+dIqqbg6EYjzu02ojwL7I=;
  b=KSWN8yDcCNjMpQexsJf93atCZ5w49ZnJAlvSF7E7akAK4mhlAMcDhEBN
   J3V7yq8N2E2wzPxG43fP0lFTHt99h9GjSD1/Dx8acPe8NyOcIA42K1gcq
   cyrhgfmavrDtRY1Kd+o885XETFKJdWHe0svKTM4q+c04ZqOcF7cp2gOWx
   XCuOzVpzW1W2nEOwvybtdTAOdcqigtE4M2oNsopdP8SIjEiCJt8UtydZg
   4vq+k5lQtz1slGA9PG0nIQoTJcwmxKawma1742xrb7wFPnJN3kDWLt1hw
   CAlVFYgPqUgGII7lgRX+bLIWVNmIl6XJt5+qKiGxMn6sU76eFI/wkr32M
   g==;
X-CSE-ConnectionGUID: qXwx3E4iTBSj0vn7NDLTug==
X-CSE-MsgGUID: glP/l4tvSyWdHDr2QUauRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="73011137"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="73011137"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:43:29 -0700
X-CSE-ConnectionGUID: nVquKOM7RbmcKtmN11kaNw==
X-CSE-MsgGUID: JFhAzIBWT6OPtli7B2wGfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143195450"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:43:27 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Use dma_resv_lock() instead of a custom mutex
Date: Wed, 28 May 2025 17:43:25 +0200
Message-ID: <20250528154325.500684-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a potential race conditions in:
 - ivpu_bo_unbind_locked() where we modified the shmem->sgt without
   holding the dma_resv_lock().
 - ivpu_bo_print_info() where we read the shmem->pages without
   holding the dma_resv_lock().

Using dma_resv_lock() also protects against future syncronisation
issues that may arise when accessing drm_gem_shmem_object or
drm_gem_object members.

Fixes: 42328003ecb6 ("accel/ivpu: Refactor BO creation functions")
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_gem.c | 63 +++++++++++++++++++----------------
 drivers/accel/ivpu/ivpu_gem.h |  1 -
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index c193a80241f5f..5908268ca45e9 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -33,6 +33,16 @@ static inline void ivpu_dbg_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, con
 		 (bool)bo->base.base.import_attach);
 }
 
+static inline int ivpu_bo_lock(struct ivpu_bo *bo)
+{
+	return dma_resv_lock(bo->base.base.resv, NULL);
+}
+
+static inline void ivpu_bo_unlock(struct ivpu_bo *bo)
+{
+	dma_resv_unlock(bo->base.base.resv);
+}
+
 /*
  * ivpu_bo_pin() - pin the backing physical pages and map them to VPU.
  *
@@ -43,22 +53,22 @@ static inline void ivpu_dbg_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, con
 int __must_check ivpu_bo_pin(struct ivpu_bo *bo)
 {
 	struct ivpu_device *vdev = ivpu_bo_to_vdev(bo);
+	struct sg_table *sgt;
 	int ret = 0;
 
-	mutex_lock(&bo->lock);
-
 	ivpu_dbg_bo(vdev, bo, "pin");
-	drm_WARN_ON(&vdev->drm, !bo->ctx);
 
-	if (!bo->mmu_mapped) {
-		struct sg_table *sgt = drm_gem_shmem_get_pages_sgt(&bo->base);
+	sgt = drm_gem_shmem_get_pages_sgt(&bo->base);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		ivpu_err(vdev, "Failed to map BO in IOMMU: %d\n", ret);
+		return ret;
+	}
 
-		if (IS_ERR(sgt)) {
-			ret = PTR_ERR(sgt);
-			ivpu_err(vdev, "Failed to map BO in IOMMU: %d\n", ret);
-			goto unlock;
-		}
+	ivpu_bo_lock(bo);
 
+	if (!bo->mmu_mapped) {
+		drm_WARN_ON(&vdev->drm, !bo->ctx);
 		ret = ivpu_mmu_context_map_sgt(vdev, bo->ctx, bo->vpu_addr, sgt,
 					       ivpu_bo_is_snooped(bo));
 		if (ret) {
@@ -69,7 +79,7 @@ int __must_check ivpu_bo_pin(struct ivpu_bo *bo)
 	}
 
 unlock:
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 
 	return ret;
 }
@@ -84,7 +94,7 @@ ivpu_bo_alloc_vpu_addr(struct ivpu_bo *bo, struct ivpu_mmu_context *ctx,
 	if (!drm_dev_enter(&vdev->drm, &idx))
 		return -ENODEV;
 
-	mutex_lock(&bo->lock);
+	ivpu_bo_lock(bo);
 
 	ret = ivpu_mmu_context_insert_node(ctx, range, ivpu_bo_size(bo), &bo->mm_node);
 	if (!ret) {
@@ -94,7 +104,7 @@ ivpu_bo_alloc_vpu_addr(struct ivpu_bo *bo, struct ivpu_mmu_context *ctx,
 		ivpu_err(vdev, "Failed to add BO to context %u: %d\n", ctx->id, ret);
 	}
 
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 
 	drm_dev_exit(idx);
 
@@ -105,7 +115,7 @@ static void ivpu_bo_unbind_locked(struct ivpu_bo *bo)
 {
 	struct ivpu_device *vdev = ivpu_bo_to_vdev(bo);
 
-	lockdep_assert(lockdep_is_held(&bo->lock) || !kref_read(&bo->base.base.refcount));
+	lockdep_assert(dma_resv_held(bo->base.base.resv) || !kref_read(&bo->base.base.refcount));
 
 	if (bo->mmu_mapped) {
 		drm_WARN_ON(&vdev->drm, !bo->ctx);
@@ -123,14 +133,12 @@ static void ivpu_bo_unbind_locked(struct ivpu_bo *bo)
 	if (bo->base.base.import_attach)
 		return;
 
-	dma_resv_lock(bo->base.base.resv, NULL);
 	if (bo->base.sgt) {
 		dma_unmap_sgtable(vdev->drm.dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
 		sg_free_table(bo->base.sgt);
 		kfree(bo->base.sgt);
 		bo->base.sgt = NULL;
 	}
-	dma_resv_unlock(bo->base.base.resv);
 }
 
 void ivpu_bo_unbind_all_bos_from_context(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx)
@@ -142,12 +150,12 @@ void ivpu_bo_unbind_all_bos_from_context(struct ivpu_device *vdev, struct ivpu_m
 
 	mutex_lock(&vdev->bo_list_lock);
 	list_for_each_entry(bo, &vdev->bo_list, bo_list_node) {
-		mutex_lock(&bo->lock);
+		ivpu_bo_lock(bo);
 		if (bo->ctx == ctx) {
 			ivpu_dbg_bo(vdev, bo, "unbind");
 			ivpu_bo_unbind_locked(bo);
 		}
-		mutex_unlock(&bo->lock);
+		ivpu_bo_unlock(bo);
 	}
 	mutex_unlock(&vdev->bo_list_lock);
 }
@@ -167,7 +175,6 @@ struct drm_gem_object *ivpu_gem_create_object(struct drm_device *dev, size_t siz
 	bo->base.pages_mark_dirty_on_put = true; /* VPU can dirty a BO anytime */
 
 	INIT_LIST_HEAD(&bo->bo_list_node);
-	mutex_init(&bo->lock);
 
 	return &bo->base.base;
 }
@@ -286,8 +293,6 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
 	drm_WARN_ON(&vdev->drm, bo->mmu_mapped);
 	drm_WARN_ON(&vdev->drm, bo->ctx);
 
-	mutex_destroy(&bo->lock);
-
 	drm_WARN_ON(obj->dev, bo->base.pages_use_count > 1);
 	drm_gem_shmem_free(&bo->base);
 }
@@ -370,9 +375,9 @@ ivpu_bo_create(struct ivpu_device *vdev, struct ivpu_mmu_context *ctx,
 		goto err_put;
 
 	if (flags & DRM_IVPU_BO_MAPPABLE) {
-		dma_resv_lock(bo->base.base.resv, NULL);
+		ivpu_bo_lock(bo);
 		ret = drm_gem_shmem_vmap(&bo->base, &map);
-		dma_resv_unlock(bo->base.base.resv);
+		ivpu_bo_unlock(bo);
 
 		if (ret)
 			goto err_put;
@@ -395,9 +400,9 @@ void ivpu_bo_free(struct ivpu_bo *bo)
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(bo->base.vaddr);
 
 	if (bo->flags & DRM_IVPU_BO_MAPPABLE) {
-		dma_resv_lock(bo->base.base.resv, NULL);
+		ivpu_bo_lock(bo);
 		drm_gem_shmem_vunmap(&bo->base, &map);
-		dma_resv_unlock(bo->base.base.resv);
+		ivpu_bo_unlock(bo);
 	}
 
 	drm_gem_object_put(&bo->base.base);
@@ -416,12 +421,12 @@ int ivpu_bo_info_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 
 	bo = to_ivpu_bo(obj);
 
-	mutex_lock(&bo->lock);
+	ivpu_bo_lock(bo);
 	args->flags = bo->flags;
 	args->mmap_offset = drm_vma_node_offset_addr(&obj->vma_node);
 	args->vpu_addr = bo->vpu_addr;
 	args->size = obj->size;
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 
 	drm_gem_object_put(obj);
 	return ret;
@@ -458,7 +463,7 @@ int ivpu_bo_wait_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 
 static void ivpu_bo_print_info(struct ivpu_bo *bo, struct drm_printer *p)
 {
-	mutex_lock(&bo->lock);
+	ivpu_bo_lock(bo);
 
 	drm_printf(p, "%-9p %-3u 0x%-12llx %-10lu 0x%-8x %-4u",
 		   bo, bo->ctx_id, bo->vpu_addr, bo->base.base.size,
@@ -475,7 +480,7 @@ static void ivpu_bo_print_info(struct ivpu_bo *bo, struct drm_printer *p)
 
 	drm_printf(p, "\n");
 
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 }
 
 void ivpu_bo_list(struct drm_device *dev, struct drm_printer *p)
diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index 0c93118c85bd3..aa8ff14f7aae1 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -17,7 +17,6 @@ struct ivpu_bo {
 	struct list_head bo_list_node;
 	struct drm_mm_node mm_node;
 
-	struct mutex lock; /* Protects: ctx, mmu_mapped, vpu_addr */
 	u64 vpu_addr;
 	u32 flags;
 	u32 job_status; /* Valid only for command buffer */
-- 
2.45.1


