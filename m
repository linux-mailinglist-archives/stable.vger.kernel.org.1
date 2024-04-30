Return-Path: <stable+bounces-42033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C756C8B710A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA5288BE0
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC212C487;
	Tue, 30 Apr 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZSuJ4z/U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D344176D;
	Tue, 30 Apr 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474342; cv=none; b=QcAUbWeheCAt0FF0sI2N70jwatdhLJEOhWKAWM4Wi1v+ZouExjUdKnb47ufdk1WLsJbmQ5b1sbNWhyb9NKSwT1N5XSz1J3Tb/uHSKHT0SUPoS7m9QVQy0X0oemZJKsE+KVlhlBpBaRsdw10uiKOOcrsNrUSLCRIGexA2a7aQuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474342; c=relaxed/simple;
	bh=qNUwWqB5U8yXSkoEeVBeYItBzSeFkcDb+cTpHCulG/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trmATZIiNv0MObeEGwu/dCxBdgh1ObAtX2n8BmPNLLf+k+1ZKCLLvFdYQUFSZGCAXoW3i5GZDjp1IveQNbHT23pfqjMFiBxy6W0tqCT/u+JPeNwUKEGvskuXSNZNx2KjC3HNfaCyFnvNrHJLRNjRwBCo6PP9Z3/RY8bc/u9DEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZSuJ4z/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE3FC2BBFC;
	Tue, 30 Apr 2024 10:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474342;
	bh=qNUwWqB5U8yXSkoEeVBeYItBzSeFkcDb+cTpHCulG/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSuJ4z/Uq1bPqyxkZ/6fmjg4qDRu5zW7AMOlbPSj3jlHgEwCEEuflX+yzO38aq08w
	 ofJzhgwNu5QS3oTi7l8yR5MUbZgreeGcHyw3+/d3sYSBnju0068WS4d719GRrYnOtZ
	 Qweods3D6ryrrRBAmHXJ+RiFDq2bNmsetXDcIkuU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 128/228] drm/amdgpu: fix visible VRAM handling during faults
Date: Tue, 30 Apr 2024 12:38:26 +0200
Message-ID: <20240430103107.499564922@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

[ Upstream commit a6ff969fe9cbf369e3cd0ac54261fec1122682ec ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 22 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 22 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 61 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 ++
 5 files changed, 53 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 6adeddfb3d564..116d3756c9c35 100644
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
index e6f69fce539b5..866bfde1ca6f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -620,8 +620,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		return r;
 
 	if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
-	    bo->tbo.resource->mem_type == TTM_PL_VRAM &&
-	    amdgpu_bo_in_cpu_visible_vram(bo))
+	    amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 		amdgpu_cs_report_moved_bytes(adev, ctx.bytes_moved,
 					     ctx.bytes_moved);
 	else
@@ -1275,23 +1274,25 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
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
@@ -1392,10 +1393,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 	/* Remember that this BO was accessed by the CPU */
 	abo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
-	if (bo->resource->mem_type != TTM_PL_VRAM)
-		return 0;
-
-	if (amdgpu_bo_in_cpu_visible_vram(abo))
+	if (amdgpu_res_cpu_visible(adev, bo->resource))
 		return 0;
 
 	/* Can't move a pinned BO to visible VRAM */
@@ -1419,7 +1417,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 
 	/* this should never happen */
 	if (bo->resource->mem_type == TTM_PL_VRAM &&
-	    !amdgpu_bo_in_cpu_visible_vram(abo))
+	    !amdgpu_res_cpu_visible(adev, bo->resource))
 		return VM_FAULT_SIGBUS;
 
 	ttm_bo_move_to_lru_tail_unlocked(bo);
@@ -1583,6 +1581,7 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
  */
 u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 {
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_buf_attachment *attachment;
 	struct dma_buf *dma_buf;
 	const char *placement;
@@ -1591,10 +1590,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 
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
index be679c42b0b8c..fa03d9e4874cc 100644
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
index a5ceec7820cfa..851509c6e90eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -137,7 +137,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 			amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
 		} else if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
 			   !(abo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) &&
-			   amdgpu_bo_in_cpu_visible_vram(abo)) {
+			   amdgpu_res_cpu_visible(adev, bo->resource)) {
 
 			/* Try evicting to the CPU inaccessible part of VRAM
 			 * first, but only set GTT as busy placement, so this
@@ -408,40 +408,55 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 	return r;
 }
 
-/*
- * amdgpu_mem_visible - Check that memory can be accessed by ttm_bo_move_memcpy
+/**
+ * amdgpu_res_cpu_visible - Check that resource can be accessed by CPU
+ * @adev: amdgpu device
+ * @res: the resource to check
  *
- * Called by amdgpu_bo_move()
+ * Returns: true if the full resource is CPU visible, false otherwise.
  */
-static bool amdgpu_mem_visible(struct amdgpu_device *adev,
-			       struct ttm_resource *mem)
+bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
+			    struct ttm_resource *res)
 {
-	u64 mem_size = (u64)mem->size;
 	struct amdgpu_res_cursor cursor;
-	u64 end;
 
-	if (mem->mem_type == TTM_PL_SYSTEM ||
-	    mem->mem_type == TTM_PL_TT)
+	if (!res)
+		return false;
+
+	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
+	    res->mem_type == AMDGPU_PL_PREEMPT)
 		return true;
-	if (mem->mem_type != TTM_PL_VRAM)
+
+	if (res->mem_type != TTM_PL_VRAM)
 		return false;
 
-	amdgpu_res_first(mem, 0, mem_size, &cursor);
-	end = cursor.start + cursor.size;
+	amdgpu_res_first(res, 0, res->size, &cursor);
 	while (cursor.remaining) {
+		if ((cursor.start + cursor.size) >= adev->gmc.visible_vram_size)
+			return false;
 		amdgpu_res_next(&cursor, cursor.size);
+	}
 
-		if (!cursor.remaining)
-			break;
+	return true;
+}
 
-		/* ttm_resource_ioremap only supports contiguous memory */
-		if (end != cursor.start)
-			return false;
+/*
+ * amdgpu_res_copyable - Check that memory can be accessed by ttm_bo_move_memcpy
+ *
+ * Called by amdgpu_bo_move()
+ */
+static bool amdgpu_res_copyable(struct amdgpu_device *adev,
+				struct ttm_resource *mem)
+{
+	if (!amdgpu_res_cpu_visible(adev, mem))
+		return false;
 
-		end = cursor.start + cursor.size;
-	}
+	/* ttm_resource_ioremap only supports contiguous memory */
+	if (mem->mem_type == TTM_PL_VRAM &&
+	    !(mem->placement & TTM_PL_FLAG_CONTIGUOUS))
+		return false;
 
-	return end <= adev->gmc.visible_vram_size;
+	return true;
 }
 
 /*
@@ -534,8 +549,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
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
index 65ec82141a8e0..32cf6b6f6efd9 100644
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
-- 
2.43.0




