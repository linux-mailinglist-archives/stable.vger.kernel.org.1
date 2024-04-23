Return-Path: <stable+bounces-40683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C128AE76A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80E31C2352D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412D13473E;
	Tue, 23 Apr 2024 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FoCktR7v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9403745E2
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877658; cv=none; b=O7As/RTL1ugr/dgIUQhsi4zvxaODACkDmThmbig3UAR3IbwixUXT0aAlIbSIMVBSs4vD4AzwX7eZWOEmb3gt4GdSPBXYhchSWE1d6erpWFTmWdbt3RS11wC0BNVZpJqRjXi2z8iWK6QrPpZpzUnyaI2Pkkd80emT1/MALYMVRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877658; c=relaxed/simple;
	bh=Imxjxl0fv8x3y2cl0qUFI8UWI/VCFFcKPxxV0buazWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cvv1qyhPau3ZSKCJ91E6aaBAxH6SrSTGt7pvw1gSyVSxKY2y8B7QRkWHmd5CjOhi5q0cgvf4arxdJqeJ6OSxdcHHg9oVXzuJ8mfeE+CsDofEWMK+lISiN8NUZPNiQI1Tf0HCaoDxl5UZDgl3RUy2JydRlKGob6KZYR+YJftJDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FoCktR7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D8AC3277B;
	Tue, 23 Apr 2024 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877657;
	bh=Imxjxl0fv8x3y2cl0qUFI8UWI/VCFFcKPxxV0buazWE=;
	h=Subject:To:Cc:From:Date:From;
	b=FoCktR7vUirCiCaejcFDO1yY8nJ+CqkIaxCZkjTAXRgRM2eSW3ioDZD7VSAd8EWAe
	 LHGbknf+8LYKReZqg09MIeCBPpEAf6FZur3pydTma+NH5eiBCsI4iAusiqWGjy18A9
	 KNd8mhfLxy4Wj7dhRgb3NYO9eIdQZUxfTh0h/Y/M=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix visible VRAM handling during faults" failed to apply to 6.6-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:07:28 -0700
Message-ID: <2024042328-stubborn-willing-88ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a6ff969fe9cbf369e3cd0ac54261fec1122682ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042328-stubborn-willing-88ad@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

a6ff969fe9cb ("drm/amdgpu: fix visible VRAM handling during faults")
ba1a58d5b907 ("drm/amdgpu: add shared fdinfo stats")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6ff969fe9cbf369e3cd0ac54261fec1122682ec Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Thu, 4 Apr 2024 16:25:40 +0200
Subject: [PATCH] drm/amdgpu: fix visible VRAM handling during faults
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When we removed the hacky start code check we actually didn't took into
account that *all* VRAM pages needs to be CPU accessible.

Clean up the code and unify the handling into a single helper which
checks if the whole resource is CPU accessible.

The only place where a partial check would make sense is during
eviction, but that is neglitible.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: aed01a68047b ("drm/amdgpu: Remove TTM resource->start visible VRAM condition v2")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 0a4b09709cfb..ec888fc6ead8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -819,7 +819,7 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 
 	p->bytes_moved += ctx.bytes_moved;
 	if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
-	    amdgpu_bo_in_cpu_visible_vram(bo))
+	    amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 		p->bytes_moved_vis += ctx.bytes_moved;
 
 	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 010b0cb7693c..2099159a693f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -617,8 +617,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		return r;
 
 	if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
-	    bo->tbo.resource->mem_type == TTM_PL_VRAM &&
-	    amdgpu_bo_in_cpu_visible_vram(bo))
+	    amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 		amdgpu_cs_report_moved_bytes(adev, ctx.bytes_moved,
 					     ctx.bytes_moved);
 	else
@@ -1272,23 +1271,25 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats)
 {
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct ttm_resource *res = bo->tbo.resource;
 	uint64_t size = amdgpu_bo_size(bo);
 	struct drm_gem_object *obj;
 	unsigned int domain;
 	bool shared;
 
 	/* Abort if the BO doesn't currently have a backing store */
-	if (!bo->tbo.resource)
+	if (!res)
 		return;
 
 	obj = &bo->tbo.base;
 	shared = drm_gem_object_is_shared_for_memory_stats(obj);
 
-	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
+	domain = amdgpu_mem_type_to_domain(res->mem_type);
 	switch (domain) {
 	case AMDGPU_GEM_DOMAIN_VRAM:
 		stats->vram += size;
-		if (amdgpu_bo_in_cpu_visible_vram(bo))
+		if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 			stats->visible_vram += size;
 		if (shared)
 			stats->vram_shared += size;
@@ -1389,10 +1390,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 	/* Remember that this BO was accessed by the CPU */
 	abo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
-	if (bo->resource->mem_type != TTM_PL_VRAM)
-		return 0;
-
-	if (amdgpu_bo_in_cpu_visible_vram(abo))
+	if (amdgpu_res_cpu_visible(adev, bo->resource))
 		return 0;
 
 	/* Can't move a pinned BO to visible VRAM */
@@ -1415,7 +1413,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 
 	/* this should never happen */
 	if (bo->resource->mem_type == TTM_PL_VRAM &&
-	    !amdgpu_bo_in_cpu_visible_vram(abo))
+	    !amdgpu_res_cpu_visible(adev, bo->resource))
 		return VM_FAULT_SIGBUS;
 
 	ttm_bo_move_to_lru_tail_unlocked(bo);
@@ -1579,6 +1577,7 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
  */
 u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 {
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_buf_attachment *attachment;
 	struct dma_buf *dma_buf;
 	const char *placement;
@@ -1587,10 +1586,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
 		unsigned int domain;
+
 		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
 		switch (domain) {
 		case AMDGPU_GEM_DOMAIN_VRAM:
-			if (amdgpu_bo_in_cpu_visible_vram(bo))
+			if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 				placement = "VRAM VISIBLE";
 			else
 				placement = "VRAM";
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index be679c42b0b8..fa03d9e4874c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -250,28 +250,6 @@ static inline u64 amdgpu_bo_mmap_offset(struct amdgpu_bo *bo)
 	return drm_vma_node_offset_addr(&bo->tbo.base.vma_node);
 }
 
-/**
- * amdgpu_bo_in_cpu_visible_vram - check if BO is (partly) in visible VRAM
- */
-static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
-{
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	struct amdgpu_res_cursor cursor;
-
-	if (!bo->tbo.resource || bo->tbo.resource->mem_type != TTM_PL_VRAM)
-		return false;
-
-	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
-	while (cursor.remaining) {
-		if (cursor.start < adev->gmc.visible_vram_size)
-			return true;
-
-		amdgpu_res_next(&cursor, cursor.size);
-	}
-
-	return false;
-}
-
 /**
  * amdgpu_bo_explicit_sync - return whether the bo is explicitly synced
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6417cb76ccd4..1d71729e3f6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -133,7 +133,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 
 		} else if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
 			   !(abo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) &&
-			   amdgpu_bo_in_cpu_visible_vram(abo)) {
+			   amdgpu_res_cpu_visible(adev, bo->resource)) {
 
 			/* Try evicting to the CPU inaccessible part of VRAM
 			 * first, but only set GTT as busy placement, so this
@@ -403,40 +403,55 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 	return r;
 }
 
+/**
+ * amdgpu_res_cpu_visible - Check that resource can be accessed by CPU
+ * @adev: amdgpu device
+ * @res: the resource to check
+ *
+ * Returns: true if the full resource is CPU visible, false otherwise.
+ */
+bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
+			    struct ttm_resource *res)
+{
+	struct amdgpu_res_cursor cursor;
+
+	if (!res)
+		return false;
+
+	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
+	    res->mem_type == AMDGPU_PL_PREEMPT)
+		return true;
+
+	if (res->mem_type != TTM_PL_VRAM)
+		return false;
+
+	amdgpu_res_first(res, 0, res->size, &cursor);
+	while (cursor.remaining) {
+		if ((cursor.start + cursor.size) >= adev->gmc.visible_vram_size)
+			return false;
+		amdgpu_res_next(&cursor, cursor.size);
+	}
+
+	return true;
+}
+
 /*
- * amdgpu_mem_visible - Check that memory can be accessed by ttm_bo_move_memcpy
+ * amdgpu_res_copyable - Check that memory can be accessed by ttm_bo_move_memcpy
  *
  * Called by amdgpu_bo_move()
  */
-static bool amdgpu_mem_visible(struct amdgpu_device *adev,
-			       struct ttm_resource *mem)
+static bool amdgpu_res_copyable(struct amdgpu_device *adev,
+				struct ttm_resource *mem)
 {
-	u64 mem_size = (u64)mem->size;
-	struct amdgpu_res_cursor cursor;
-	u64 end;
-
-	if (mem->mem_type == TTM_PL_SYSTEM ||
-	    mem->mem_type == TTM_PL_TT)
-		return true;
-	if (mem->mem_type != TTM_PL_VRAM)
+	if (!amdgpu_res_cpu_visible(adev, mem))
 		return false;
 
-	amdgpu_res_first(mem, 0, mem_size, &cursor);
-	end = cursor.start + cursor.size;
-	while (cursor.remaining) {
-		amdgpu_res_next(&cursor, cursor.size);
+	/* ttm_resource_ioremap only supports contiguous memory */
+	if (mem->mem_type == TTM_PL_VRAM &&
+	    !(mem->placement & TTM_PL_FLAG_CONTIGUOUS))
+		return false;
 
-		if (!cursor.remaining)
-			break;
-
-		/* ttm_resource_ioremap only supports contiguous memory */
-		if (end != cursor.start)
-			return false;
-
-		end = cursor.start + cursor.size;
-	}
-
-	return end <= adev->gmc.visible_vram_size;
+	return true;
 }
 
 /*
@@ -529,8 +544,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
 	if (r) {
 		/* Check that all memory is CPU accessible */
-		if (!amdgpu_mem_visible(adev, old_mem) ||
-		    !amdgpu_mem_visible(adev, new_mem)) {
+		if (!amdgpu_res_copyable(adev, old_mem) ||
+		    !amdgpu_res_copyable(adev, new_mem)) {
 			pr_err("Move buffer fallback to memcpy unavailable\n");
 			return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 65ec82141a8e..32cf6b6f6efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -139,6 +139,9 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 				      uint64_t start);
 
+bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
+			    struct ttm_resource *res);
+
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
 void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,


