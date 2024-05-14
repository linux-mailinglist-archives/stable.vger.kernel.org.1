Return-Path: <stable+bounces-43999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D648C50B9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98B4B20B51
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D42074C1B;
	Tue, 14 May 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jfGalZ7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287016F077;
	Tue, 14 May 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683611; cv=none; b=QDh+cxwQccoAOMyfHs4IxW2rUCH7QR/UzN+rHejmwgdtfl0XfZwJyCvlacyH3F2hd/E5MTd2pVK6PbLYEvFVfUjz8dAzRIaQScdhjfqdICY4RZe9oLfQ6aHMBqHFYg1OwIFBoqhj3T923L7fMR56cVVKO0mWcX7waS7wjXjgd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683611; c=relaxed/simple;
	bh=iifXlqaiauf1Jx/T7aK8g4yqcBDsvOI2ccb/UEtvOLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcAwwXqynKPMkpOfcqAezjLoyXSeu3W1tNSOYK8LqcXR4LIX7VGBYin4mLQsAomOM3qbMcH5aMiM16CgNDUuBBMHvrGHywRcFAIWqbMWitti7KFQ1U/8yCz9NhbVTLfXbLNWPWxHD3LFCWLXwM9qQhabEOLTNwq0AcORlOw+Ao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jfGalZ7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89679C32782;
	Tue, 14 May 2024 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683611;
	bh=iifXlqaiauf1Jx/T7aK8g4yqcBDsvOI2ccb/UEtvOLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfGalZ7w5VMGV/uS3wexSrPs0qhHMF4OCbeALe7zAGy004G/EPAIVMXCJcFxD4Pcl
	 gw0aBeU/QNom4nPZbRGWm7cc5P9EbAvj5U8sE1PghY7AKuIxvwfdhgA/twt4hinNSB
	 BCnj8JNIKFaHvmFrznLpmG9j+Dieuk/a6r0dyXwo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.8 242/336] drm/amdgpu: once more fix the call oder in amdgpu_ttm_move() v2
Date: Tue, 14 May 2024 12:17:26 +0200
Message-ID: <20240514101047.751312429@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

commit d3a9331a6591e9df64791e076f6591f440af51c3 upstream.

This reverts drm/amdgpu: fix ftrace event amdgpu_bo_move always move
on same heap. The basic problem here is that after the move the old
location is simply not available any more.

Some fixes were suggested, but essentially we should call the move
notification before actually moving things because only this way we have
the correct order for DMA-buf and VM move notifications as well.

Also rework the statistic handling so that we don't update the eviction
counter before the move.

v2: add missing NULL check

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3171
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   14 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |   48 +++++++++++++++--------------
 3 files changed, 38 insertions(+), 28 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1244,14 +1244,18 @@ int amdgpu_bo_get_metadata(struct amdgpu
  * amdgpu_bo_move_notify - notification about a memory move
  * @bo: pointer to a buffer object
  * @evict: if this move is evicting the buffer from the graphics address space
+ * @new_mem: new resource for backing the BO
  *
  * Marks the corresponding &amdgpu_bo buffer object as invalid, also performs
  * bookkeeping.
  * TTM driver callback which is called when ttm moves a buffer.
  */
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
+			   bool evict,
+			   struct ttm_resource *new_mem)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
+	struct ttm_resource *old_mem = bo->resource;
 	struct amdgpu_bo *abo;
 
 	if (!amdgpu_bo_is_amdgpu_bo(bo))
@@ -1263,12 +1267,12 @@ void amdgpu_bo_move_notify(struct ttm_bu
 	amdgpu_bo_kunmap(abo);
 
 	if (abo->tbo.base.dma_buf && !abo->tbo.base.import_attach &&
-	    bo->resource->mem_type != TTM_PL_SYSTEM)
+	    old_mem && old_mem->mem_type != TTM_PL_SYSTEM)
 		dma_buf_move_notify(abo->tbo.base.dma_buf);
 
-	/* remember the eviction */
-	if (evict)
-		atomic64_inc(&adev->num_evictions);
+	/* move_notify is called before move happens */
+	trace_amdgpu_bo_move(abo, new_mem ? new_mem->mem_type : -1,
+			     old_mem ? old_mem->mem_type : -1);
 }
 
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -328,7 +328,9 @@ int amdgpu_bo_set_metadata (struct amdgp
 int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			   size_t buffer_size, uint32_t *metadata_size,
 			   uint64_t *flags);
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
+			   bool evict,
+			   struct ttm_resource *new_mem);
 void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
 vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
 void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -486,14 +486,16 @@ static int amdgpu_bo_move(struct ttm_buf
 
 	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
 			 bo->ttm == NULL)) {
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		goto out;
+		return 0;
 	}
 	if (old_mem->mem_type == TTM_PL_SYSTEM &&
 	    (new_mem->mem_type == TTM_PL_TT ||
 	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		goto out;
+		return 0;
 	}
 	if ((old_mem->mem_type == TTM_PL_TT ||
 	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
@@ -503,9 +505,10 @@ static int amdgpu_bo_move(struct ttm_buf
 			return r;
 
 		amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_resource_free(bo, &bo->resource);
 		ttm_bo_assign_mem(bo, new_mem);
-		goto out;
+		return 0;
 	}
 
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
@@ -517,8 +520,9 @@ static int amdgpu_bo_move(struct ttm_buf
 	    new_mem->mem_type == AMDGPU_PL_OA ||
 	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
 		/* Nothing to save here */
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		goto out;
+		return 0;
 	}
 
 	if (bo->type == ttm_bo_type_device &&
@@ -530,22 +534,23 @@ static int amdgpu_bo_move(struct ttm_buf
 		abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	}
 
-	if (adev->mman.buffer_funcs_enabled) {
-		if (((old_mem->mem_type == TTM_PL_SYSTEM &&
-		      new_mem->mem_type == TTM_PL_VRAM) ||
-		     (old_mem->mem_type == TTM_PL_VRAM &&
-		      new_mem->mem_type == TTM_PL_SYSTEM))) {
-			hop->fpfn = 0;
-			hop->lpfn = 0;
-			hop->mem_type = TTM_PL_TT;
-			hop->flags = TTM_PL_FLAG_TEMPORARY;
-			return -EMULTIHOP;
-		}
+	if (adev->mman.buffer_funcs_enabled &&
+	    ((old_mem->mem_type == TTM_PL_SYSTEM &&
+	      new_mem->mem_type == TTM_PL_VRAM) ||
+	     (old_mem->mem_type == TTM_PL_VRAM &&
+	      new_mem->mem_type == TTM_PL_SYSTEM))) {
+		hop->fpfn = 0;
+		hop->lpfn = 0;
+		hop->mem_type = TTM_PL_TT;
+		hop->flags = TTM_PL_FLAG_TEMPORARY;
+		return -EMULTIHOP;
+	}
 
+	amdgpu_bo_move_notify(bo, evict, new_mem);
+	if (adev->mman.buffer_funcs_enabled)
 		r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
-	} else {
+	else
 		r = -ENODEV;
-	}
 
 	if (r) {
 		/* Check that all memory is CPU accessible */
@@ -560,11 +565,10 @@ static int amdgpu_bo_move(struct ttm_buf
 			return r;
 	}
 
-	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
-out:
-	/* update statistics */
+	/* update statistics after the move */
+	if (evict)
+		atomic64_inc(&adev->num_evictions);
 	atomic64_add(bo->base.size, &adev->num_bytes_moved);
-	amdgpu_bo_move_notify(bo, evict);
 	return 0;
 }
 
@@ -1566,7 +1570,7 @@ static int amdgpu_ttm_access_memory(stru
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
-	amdgpu_bo_move_notify(bo, false);
+	amdgpu_bo_move_notify(bo, false, NULL);
 }
 
 static struct ttm_device_funcs amdgpu_bo_driver = {



