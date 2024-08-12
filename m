Return-Path: <stable+bounces-66568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DCD94F02F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01751281F5A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFA18452F;
	Mon, 12 Aug 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tg9CW1U1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9424187328
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474001; cv=none; b=X6xG6xBcpCAO957qBDlMnKweM+mXX9pDyKBTE29FHBuQjg01r9Q/FtOoG3dRxy5nV4aEvkJ2oUyNKr36Rb+LJ3pmdbrQKT0z9o4xwd/uYA+OKjUM+upCY8/1mM7L/qem/VasU1yA9apgm+g7MAgTTGErmpNEqLX5l7n9Pwmqzas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474001; c=relaxed/simple;
	bh=F/DwFkhCN5QLHiQEY1wdYnDhhwSWBVMCB+9dY9AjfFs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZvDlMrw422DTCHEPyFLMkilmNfKNW+ObB8B9s1cgT9HTGvMKGqzhrrpDBeUNTyhC6awzMvId7b3eun4qDtbIGGeDrp33syEMq9YUFRp9IDdSPonGXy+1HX3+abw9Q4ZTLfhhCCKRrHBcO2Sq+R6iUZFhRNhvOh3+LzSOq9fBtdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tg9CW1U1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CEAC4AF0F;
	Mon, 12 Aug 2024 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474000;
	bh=F/DwFkhCN5QLHiQEY1wdYnDhhwSWBVMCB+9dY9AjfFs=;
	h=Subject:To:Cc:From:Date:From;
	b=tg9CW1U1hYcosPQCd1ICuiuHfqka33tjk1FG64HBuMve0G5O13axif+dUwp/RTXEO
	 yc2gzdHF9ZkQMddk1INPgglaU5X4gyN9kD7AryK/pS910UaOIvNTdlEhPpwHHAI3g8
	 wPDu/DRJ00gihcxW+11riuc9AmDZGTytXNHi9vVY=
Subject: FAILED: patch "[PATCH] drm/amdgpu: once more fix the call oder in amdgpu_ttm_move()" failed to apply to 5.15-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:46:18 +0200
Message-ID: <2024081218-throng-try-3395@gregkh>
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
git cherry-pick -x ffda7081489b2c14650798b3b46fb76292f163a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081218-throng-try-3395@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ffda7081489b ("drm/amdgpu: once more fix the call oder in amdgpu_ttm_move() v2")
94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap")
63af82cf5e36 ("drm/amdgpu: audit bo->resource usage")
32f90e652519 ("drm/amdgpu: prevent memory wipe in suspend/shutdown stage")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffda7081489b2c14650798b3b46fb76292f163a3 Mon Sep 17 00:00:00 2001
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
index 706345ea1430..751443402ced 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1255,14 +1255,18 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
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
@@ -1274,12 +1278,12 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
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
index 7805ea4d82f2..923b20d3fdbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -486,14 +486,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
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
@@ -503,9 +505,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			return r;
 
 		amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_resource_free(bo, &bo->resource);
 		ttm_bo_assign_mem(bo, new_mem);
-		goto out;
+		return 0;
 	}
 
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
@@ -517,8 +520,9 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	    new_mem->mem_type == AMDGPU_PL_OA ||
 	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
 		/* Nothing to save here */
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		goto out;
+		return 0;
 	}
 
 	if (bo->type == ttm_bo_type_device &&
@@ -530,23 +534,24 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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
@@ -560,11 +565,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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
 
@@ -1564,7 +1568,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
-	amdgpu_bo_move_notify(bo, false);
+	amdgpu_bo_move_notify(bo, false, NULL);
 }
 
 static struct ttm_device_funcs amdgpu_bo_driver = {


