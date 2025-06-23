Return-Path: <stable+bounces-157015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAE7AE521A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44F0443042
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7C221FCC;
	Mon, 23 Jun 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zt11wu07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A53C19D084;
	Mon, 23 Jun 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714826; cv=none; b=pZ8C98Du7y+zIzB4Fujw9P4gJRSF1HDH8Gz9IWQEgiWaee8rAhmIpGfRBBDd2s1tIxSaV/hZEyLmRu/p5B3xMpJ9S0oBF8by4dGWAGHAoYiz+PeEhL4DZsKCRx7c03SuQmT9msmg3l1MrLo350/OpVlcFe3Huz7ZJwkvDCwlDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714826; c=relaxed/simple;
	bh=lU0vzWIXNOMKb98GemLXhwtMdHsDPVqyo4wa4EbTyCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Okh92O7wdN3G2VFHMKN7j8ERf5UPMpu4v81FF1Lu23MEGaVhu+3t+vrt68i4y0J2BqRT0M6BqhS3jddmBNSbXQ7vh21MQZdjwwhFX+Ie58qoKCQajC6KdtvFIVu3AZX0Eu62CCzF9lWaGOQ/Buo0czGIBc/U1FIm53U5B1WtwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zt11wu07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B9DC4CEEA;
	Mon, 23 Jun 2025 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714826;
	bh=lU0vzWIXNOMKb98GemLXhwtMdHsDPVqyo4wa4EbTyCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zt11wu07D+skmkKzcw7sQu8q8NGBTL51tHHCgm7eTQhJJd++P8p9SMrhT1BMCXJjQ
	 GP1lspIaVGIckO6lsLNMwgPL1TKaoo3M2+Hj8uxuP1qmwZAiNeBLOimByoPb03Aoy2
	 eL7wJRMBSyL1KqETPhvvUdzybg4pUbMHs3kKDiTw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lizhi Hou <lizhi.hou@amd.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 6.12 159/414] accel/ivpu: Use dma_resv_lock() instead of a custom mutex
Date: Mon, 23 Jun 2025 15:04:56 +0200
Message-ID: <20250623130646.014468414@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

commit 98d3f772ca7d6822bdfc8c960f5f909574db97c9 upstream.

This fixes a potential race conditions in:
 - ivpu_bo_unbind_locked() where we modified the shmem->sgt without
   holding the dma_resv_lock().
 - ivpu_bo_print_info() where we read the shmem->pages without
   holding the dma_resv_lock().

Using dma_resv_lock() also protects against future syncronisation
issues that may arise when accessing drm_gem_shmem_object or
drm_gem_object members.

Fixes: 42328003ecb6 ("accel/ivpu: Refactor BO creation functions")
Cc: stable@vger.kernel.org # v6.9+
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://lore.kernel.org/r/20250528154325.500684-1-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_gem.c |   63 ++++++++++++++++++++++--------------------
 drivers/accel/ivpu/ivpu_gem.h |    1 
 2 files changed, 34 insertions(+), 30 deletions(-)

--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -31,6 +31,16 @@ static inline void ivpu_dbg_bo(struct iv
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
@@ -41,22 +51,22 @@ static inline void ivpu_dbg_bo(struct iv
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
@@ -67,7 +77,7 @@ int __must_check ivpu_bo_pin(struct ivpu
 	}
 
 unlock:
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 
 	return ret;
 }
@@ -82,7 +92,7 @@ ivpu_bo_alloc_vpu_addr(struct ivpu_bo *b
 	if (!drm_dev_enter(&vdev->drm, &idx))
 		return -ENODEV;
 
-	mutex_lock(&bo->lock);
+	ivpu_bo_lock(bo);
 
 	ret = ivpu_mmu_context_insert_node(ctx, range, ivpu_bo_size(bo), &bo->mm_node);
 	if (!ret) {
@@ -92,7 +102,7 @@ ivpu_bo_alloc_vpu_addr(struct ivpu_bo *b
 		ivpu_err(vdev, "Failed to add BO to context %u: %d\n", ctx->id, ret);
 	}
 
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 
 	drm_dev_exit(idx);
 
@@ -103,7 +113,7 @@ static void ivpu_bo_unbind_locked(struct
 {
 	struct ivpu_device *vdev = ivpu_bo_to_vdev(bo);
 
-	lockdep_assert(lockdep_is_held(&bo->lock) || !kref_read(&bo->base.base.refcount));
+	lockdep_assert(dma_resv_held(bo->base.base.resv) || !kref_read(&bo->base.base.refcount));
 
 	if (bo->mmu_mapped) {
 		drm_WARN_ON(&vdev->drm, !bo->ctx);
@@ -121,14 +131,12 @@ static void ivpu_bo_unbind_locked(struct
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
@@ -140,12 +148,12 @@ void ivpu_bo_unbind_all_bos_from_context
 
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
@@ -165,7 +173,6 @@ struct drm_gem_object *ivpu_gem_create_o
 	bo->base.pages_mark_dirty_on_put = true; /* VPU can dirty a BO anytime */
 
 	INIT_LIST_HEAD(&bo->bo_list_node);
-	mutex_init(&bo->lock);
 
 	return &bo->base.base;
 }
@@ -243,8 +250,6 @@ static void ivpu_gem_bo_free(struct drm_
 	drm_WARN_ON(&vdev->drm, bo->mmu_mapped);
 	drm_WARN_ON(&vdev->drm, bo->ctx);
 
-	mutex_destroy(&bo->lock);
-
 	drm_WARN_ON(obj->dev, bo->base.pages_use_count > 1);
 	drm_gem_shmem_free(&bo->base);
 }
@@ -327,9 +332,9 @@ ivpu_bo_create(struct ivpu_device *vdev,
 		goto err_put;
 
 	if (flags & DRM_IVPU_BO_MAPPABLE) {
-		dma_resv_lock(bo->base.base.resv, NULL);
+		ivpu_bo_lock(bo);
 		ret = drm_gem_shmem_vmap(&bo->base, &map);
-		dma_resv_unlock(bo->base.base.resv);
+		ivpu_bo_unlock(bo);
 
 		if (ret)
 			goto err_put;
@@ -352,9 +357,9 @@ void ivpu_bo_free(struct ivpu_bo *bo)
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(bo->base.vaddr);
 
 	if (bo->flags & DRM_IVPU_BO_MAPPABLE) {
-		dma_resv_lock(bo->base.base.resv, NULL);
+		ivpu_bo_lock(bo);
 		drm_gem_shmem_vunmap(&bo->base, &map);
-		dma_resv_unlock(bo->base.base.resv);
+		ivpu_bo_unlock(bo);
 	}
 
 	drm_gem_object_put(&bo->base.base);
@@ -373,12 +378,12 @@ int ivpu_bo_info_ioctl(struct drm_device
 
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
@@ -412,7 +417,7 @@ int ivpu_bo_wait_ioctl(struct drm_device
 
 static void ivpu_bo_print_info(struct ivpu_bo *bo, struct drm_printer *p)
 {
-	mutex_lock(&bo->lock);
+	ivpu_bo_lock(bo);
 
 	drm_printf(p, "%-9p %-3u 0x%-12llx %-10lu 0x%-8x %-4u",
 		   bo, bo->ctx_id, bo->vpu_addr, bo->base.base.size,
@@ -429,7 +434,7 @@ static void ivpu_bo_print_info(struct iv
 
 	drm_printf(p, "\n");
 
-	mutex_unlock(&bo->lock);
+	ivpu_bo_unlock(bo);
 }
 
 void ivpu_bo_list(struct drm_device *dev, struct drm_printer *p)
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -17,7 +17,6 @@ struct ivpu_bo {
 	struct list_head bo_list_node;
 	struct drm_mm_node mm_node;
 
-	struct mutex lock; /* Protects: ctx, mmu_mapped, vpu_addr */
 	u64 vpu_addr;
 	u32 flags;
 	u32 job_status; /* Valid only for command buffer */



