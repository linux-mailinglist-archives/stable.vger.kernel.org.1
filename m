Return-Path: <stable+bounces-43608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A988C3D73
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 10:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B184B20A03
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16338147C78;
	Mon, 13 May 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqRecYfB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A73146D4E
	for <stable@vger.kernel.org>; Mon, 13 May 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589736; cv=none; b=JTXvHl2EJrxUhePdVpk4cQJOBc6n+oLmWJsZI5yKZIM855C6HQinWvUsq6FL2k9E0vp27YwTdW4hIByh9WjRNz/fbIeirHswgy0e7kdIFnBR3a8EbXBIYaHGJKeQcdlJSVD6DcjqxcKCK11RgIXXxsxVcuQDN4PRpHTtPHg4rzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589736; c=relaxed/simple;
	bh=gPvqdFyODG0HIYTs20HyCZ02XmMXXHrKj7ti4wOAdc0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=grJAfzluyb/LqHxUmK3ptjpMMmYRx5l5C4BABJzfrLISjo4foAmJlWYXPzhBn5sPqkAkTTNIsZrIa6zun9Lsan7sQ5pvFJ8h/dnilOpZKOiDwUQqTURek3yxmi4zdWn95gP26CROpOBvTeZqd7YEKoZdnyY5daPDDJ74z3zOWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqRecYfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DEBC113CC;
	Mon, 13 May 2024 08:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715589735;
	bh=gPvqdFyODG0HIYTs20HyCZ02XmMXXHrKj7ti4wOAdc0=;
	h=Subject:To:Cc:From:Date:From;
	b=eqRecYfBDnnYZ7lstP6IxRaVhqRMx4BgLXS1t2NYEZqTc2LLjd7tFdNjdGkh4TLQm
	 7Gv4VsOtnEwY2GYdgOVxSi4e4HYfJWSNKgFeiCtW4ilXjw9gAuRKWICWrQkRhuGQAq
	 W0IAPjlvJUD3QAicVupqtjvs93BjEnJKULubcXvY=
Subject: FAILED: patch "[PATCH] drm/amdgpu: once more fix the call oder in amdgpu_ttm_move()" failed to apply to 5.15-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 10:42:12 +0200
Message-ID: <2024051312-abide-backlit-0647@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d3a9331a6591e9df64791e076f6591f440af51c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051312-abide-backlit-0647@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d3a9331a6591 ("drm/amdgpu: once more fix the call oder in amdgpu_ttm_move() v2")
94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap")
63af82cf5e36 ("drm/amdgpu: audit bo->resource usage")
32f90e652519 ("drm/amdgpu: prevent memory wipe in suspend/shutdown stage")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d3a9331a6591e9df64791e076f6591f440af51c3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Thu, 21 Mar 2024 11:32:02 +0100
Subject: [PATCH] drm/amdgpu: once more fix the call oder in amdgpu_ttm_move()
 v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ce733e3cb35d..f6d503432a9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1243,14 +1243,18 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
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
@@ -1262,12 +1266,12 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index fa03d9e4874c..bc42ccbde659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -328,7 +328,9 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 1d71729e3f6b..4ffee5545265 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -481,14 +481,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
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
@@ -498,9 +500,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			return r;
 
 		amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_resource_free(bo, &bo->resource);
 		ttm_bo_assign_mem(bo, new_mem);
-		goto out;
+		return 0;
 	}
 
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
@@ -512,8 +515,9 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	    new_mem->mem_type == AMDGPU_PL_OA ||
 	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
 		/* Nothing to save here */
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		goto out;
+		return 0;
 	}
 
 	if (bo->type == ttm_bo_type_device &&
@@ -525,23 +529,24 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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
-
-		r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
-	} else {
-		r = -ENODEV;
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
 	}
 
+	amdgpu_bo_move_notify(bo, evict, new_mem);
+	if (adev->mman.buffer_funcs_enabled)
+		r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
+	else
+		r = -ENODEV;
+
 	if (r) {
 		/* Check that all memory is CPU accessible */
 		if (!amdgpu_res_copyable(adev, old_mem) ||
@@ -555,11 +560,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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
 
@@ -1559,7 +1563,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
-	amdgpu_bo_move_notify(bo, false);
+	amdgpu_bo_move_notify(bo, false, NULL);
 }
 
 static struct ttm_device_funcs amdgpu_bo_driver = {


