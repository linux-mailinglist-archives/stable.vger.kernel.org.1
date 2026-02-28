Return-Path: <stable+bounces-220242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD9LHqgyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7071C5BA3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D91D31DA7ED
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493737313A;
	Sat, 28 Feb 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhmyZyFQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77041373132;
	Sat, 28 Feb 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300146; cv=none; b=PJx1xdozFPz2qKtTAj9IYLc6KaxEHQ+tzzF5QtCBa+kCN1UInq1KyBhqsMfUObZsV+BvYB+cjvJG9Rr8y71Zg4qg1MyQKaFklJ4xK6Li3CjyrPaaukceFG+S/3ZWyMG1tpwI4f9jd1nFAyrPjEWnV/yliMhpXVUhcpOvwMjLMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300146; c=relaxed/simple;
	bh=qaTnnGnv0qf7d3+3WaIFVnalRL3psPma1EcZJOwyL6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBJfvWLHslQcLlTU13ZxmqSU7kiUTefY2oP5aeB2YKYD7O4qYJUKyolAzN2Sat+8adMzOLFoqe0MmdkbHcfDyQef6JwfccfUZMqHLBW6pJtxZeFMkmBN6EbXgtRId+bGmq7GowUS+rgxkLAqB1dCnIOBbawhMkx2hOrcWjAXk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhmyZyFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B91C116D0;
	Sat, 28 Feb 2026 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300146;
	bh=qaTnnGnv0qf7d3+3WaIFVnalRL3psPma1EcZJOwyL6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhmyZyFQyvT8I/nWzrCULgAMEEOhLkK8knBROSlgMI5lPp4Sr0i2EUIpx1qbD6Ex7
	 pr5snq9Wm/W2pObcmk3qnhpyia8MhXu7gPcy3QpYUNVxDvqvPVsmbbfTpqmS0iXuO9
	 QVGJ+djHYdS8Xlt4kT/uyUD1gcjQCFd76Y/mA4a50uBqyKJi5lBXsBhuHbrmieIy1z
	 uckVwDEl5Pofg8icinndPl1cLxINlaXOhhnL+KRXU/hy0SAoKye0dcCDsOIKavMkaX
	 Nn4L69qyQtqGLwn3IzRIP4ZyF4nj6F2SK4n/NzsQnwQKtNz+SnCmFoUhH+KOWms0NY
	 bdnZkVJ6uhA8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 164/844] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last Fence Update and Timeline Management v4
Date: Sat, 28 Feb 2026 12:21:17 -0500
Message-ID: <20260228173244.1509663-165-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220242-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF7071C5BA3
X-Rspamd-Action: no action

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit bd8150a1b3370a9f7761c5814202a3fe5a79f44f ]

This commit simplifies the amdgpu_gem_va_ioctl function, key updates
include:
 - Moved the logic for managing the last update fence directly into
   amdgpu_gem_va_update_vm.
 - Introduced checks for the timeline point to enable conditional
   replacement or addition of fences.

v2: Addressed review comments from Christian.
v3: Updated comments (Christian).
v4: The previous version selected the fence too early and did not manage its
    reference correctly, which could lead to stale or freed fences being used.
    This resulted in refcount underflows and could crash when updating GPU
    timelines.
    The fence is now chosen only after the VA mapping work is completed, and its
    reference is taken safely. After exporting it to the VM timeline syncobj, the
    driver always drops its local fence reference, ensuring balanced refcounting
    and avoiding use-after-free on dma_fence.

	Crash signature:
	[  205.828135] refcount_t: underflow; use-after-free.
	[  205.832963] WARNING: CPU: 30 PID: 7274 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
	...
	[  206.074014] Call Trace:
	[  206.076488]  <TASK>
	[  206.078608]  amdgpu_gem_va_ioctl+0x6ea/0x740 [amdgpu]
	[  206.084040]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
	[  206.089994]  drm_ioctl_kernel+0x86/0xe0 [drm]
	[  206.094415]  drm_ioctl+0x26e/0x520 [drm]
	[  206.098424]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
	[  206.104402]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
	[  206.109387]  __x64_sys_ioctl+0x96/0xe0
	[  206.113156]  do_syscall_64+0x66/0x2d0
	...
	[  206.553351] BUG: unable to handle page fault for address: ffffffffc0dfde90
	...
	[  206.553378] RIP: 0010:dma_fence_signal_timestamp_locked+0x39/0xe0
	...
	[  206.553405] Call Trace:
	[  206.553409]  <IRQ>
	[  206.553415]  ? __pfx_drm_sched_fence_free_rcu+0x10/0x10 [gpu_sched]
	[  206.553424]  dma_fence_signal+0x30/0x60
	[  206.553427]  drm_sched_job_done.isra.0+0x123/0x150 [gpu_sched]
	[  206.553434]  dma_fence_signal_timestamp_locked+0x6e/0xe0
	[  206.553437]  dma_fence_signal+0x30/0x60
	[  206.553441]  amdgpu_fence_process+0xd8/0x150 [amdgpu]
	[  206.553854]  sdma_v4_0_process_trap_irq+0x97/0xb0 [amdgpu]
	[  206.554353]  edac_mce_amd(E) ee1004(E)
	[  206.554270]  amdgpu_irq_dispatch+0x150/0x230 [amdgpu]
	[  206.554702]  amdgpu_ih_process+0x6a/0x180 [amdgpu]
	[  206.555101]  amdgpu_irq_handler+0x23/0x60 [amdgpu]
	[  206.555500]  __handle_irq_event_percpu+0x4a/0x1c0
	[  206.555506]  handle_irq_event+0x38/0x80
	[  206.555509]  handle_edge_irq+0x92/0x1e0
	[  206.555513]  __common_interrupt+0x3e/0xb0
	[  206.555519]  common_interrupt+0x80/0xa0
	[  206.555525]  </IRQ>
	[  206.555527]  <TASK>
	...
	[  206.555650] RIP: 0010:dma_fence_signal_timestamp_locked+0x39/0xe0
	...
	[  206.555667] Kernel panic - not syncing: Fatal exception in interrupt

Link: https://patchwork.freedesktop.org/patch/654669/
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 135 ++++++++++++++----------
 1 file changed, 82 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5a93cbadc4f44..f30e32fbff99a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -112,47 +112,6 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
 	return 0;
 }
 
-static void
-amdgpu_gem_update_bo_mapping(struct drm_file *filp,
-			     struct amdgpu_bo_va *bo_va,
-			     uint32_t operation,
-			     uint64_t point,
-			     struct dma_fence *fence,
-			     struct drm_syncobj *syncobj,
-			     struct dma_fence_chain *chain)
-{
-	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_vm *vm = &fpriv->vm;
-	struct dma_fence *last_update;
-
-	if (!syncobj)
-		return;
-
-	/* Find the last update fence */
-	switch (operation) {
-	case AMDGPU_VA_OP_MAP:
-	case AMDGPU_VA_OP_REPLACE:
-		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
-			last_update = vm->last_update;
-		else
-			last_update = bo_va->last_pt_update;
-		break;
-	case AMDGPU_VA_OP_UNMAP:
-	case AMDGPU_VA_OP_CLEAR:
-		last_update = fence;
-		break;
-	default:
-		return;
-	}
-
-	/* Add fence to timeline */
-	if (!point)
-		drm_syncobj_replace_fence(syncobj, last_update);
-	else
-		drm_syncobj_add_point(syncobj, chain, last_update, point);
-}
-
 static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
@@ -761,16 +720,19 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			uint32_t operation)
 {
-	struct dma_fence *fence = dma_fence_get_stub();
+	struct dma_fence *clear_fence = dma_fence_get_stub();
+	struct dma_fence *last_update = NULL;
 	int r;
 
 	if (!amdgpu_vm_ready(vm))
-		return fence;
+		return clear_fence;
 
-	r = amdgpu_vm_clear_freed(adev, vm, &fence);
+	/* First clear freed BOs and get a fence for that work, if any. */
+	r = amdgpu_vm_clear_freed(adev, vm, &clear_fence);
 	if (r)
 		goto error;
 
+	/* For MAP/REPLACE we also need to update the BO mappings. */
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
@@ -778,13 +740,59 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			goto error;
 	}
 
+	/* Always update PDEs after we touched the mappings. */
 	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r)
+		goto error;
+
+	/*
+	 * Decide which fence represents the "last update" for this VM/BO:
+	 *
+	 * - For MAP/REPLACE we want the PT update fence, which is tracked as
+	 *   either vm->last_update (for always-valid BOs) or bo_va->last_pt_update
+	 *   (for per-BO updates).
+	 *
+	 * - For UNMAP/CLEAR we rely on the fence returned by
+	 *   amdgpu_vm_clear_freed(), which already covers the page table work
+	 *   for the removed mappings.
+	 */
+	switch (operation) {
+	case AMDGPU_VA_OP_MAP:
+	case AMDGPU_VA_OP_REPLACE:
+		if (bo_va && bo_va->base.bo) {
+			if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
+				if (vm->last_update)
+					last_update = dma_fence_get(vm->last_update);
+			} else {
+				if (bo_va->last_pt_update)
+					last_update = dma_fence_get(bo_va->last_pt_update);
+			}
+		}
+		break;
+	case AMDGPU_VA_OP_UNMAP:
+	case AMDGPU_VA_OP_CLEAR:
+		if (clear_fence)
+			last_update = dma_fence_get(clear_fence);
+		break;
+	default:
+		break;
+	}
 
 error:
 	if (r && r != -ERESTARTSYS)
 		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
 
-	return fence;
+	/*
+	 * If we managed to pick a more specific last-update fence, prefer it
+	 * over the generic clear_fence and drop the extra reference to the
+	 * latter.
+	 */
+	if (last_update) {
+		dma_fence_put(clear_fence);
+		return last_update;
+	}
+
+	return clear_fence;
 }
 
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
@@ -810,6 +818,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	uint64_t vm_size;
 	int r = 0;
 
+	/* Validate virtual address range against reserved regions. */
 	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
 		dev_dbg(dev->dev,
 			"va_address 0x%llx is in reserved area 0x%llx\n",
@@ -843,6 +852,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* Validate operation type. */
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 	case AMDGPU_VA_OP_UNMAP:
@@ -866,6 +876,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		abo = NULL;
 	}
 
+	/* Add input syncobj fences (if any) for synchronization. */
 	r = amdgpu_gem_add_input_fence(filp,
 				       args->input_fence_syncobj_handles,
 				       args->num_syncobj_handles);
@@ -888,6 +899,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			goto error;
 	}
 
+	/* Resolve the BO-VA mapping for this VM/BO combination. */
 	if (abo) {
 		bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
 		if (!bo_va) {
@@ -900,6 +912,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	/*
+	 * Prepare the timeline syncobj node if the user requested a VM
+	 * timeline update. This only allocates/looks up the syncobj and
+	 * chain node; the actual fence is attached later.
+	 */
 	r = amdgpu_gem_update_timeline_node(filp,
 					    args->vm_timeline_syncobj_out,
 					    args->vm_timeline_point,
@@ -931,18 +948,30 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	default:
 		break;
 	}
+
+	/*
+	 * Once the VA operation is done, update the VM and obtain the fence
+	 * that represents the last relevant update for this mapping. This
+	 * fence can then be exported to the user-visible VM timeline.
+	 */
 	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
 		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
 						args->operation);
 
-		if (timeline_syncobj)
-			amdgpu_gem_update_bo_mapping(filp, bo_va,
-					     args->operation,
-					     args->vm_timeline_point,
-					     fence, timeline_syncobj,
-					     timeline_chain);
-		else
-			dma_fence_put(fence);
+		if (timeline_syncobj && fence) {
+			if (!args->vm_timeline_point) {
+				/* Replace the existing fence when no point is given. */
+				drm_syncobj_replace_fence(timeline_syncobj,
+							  fence);
+			} else {
+				/* Attach the last-update fence at a specific point. */
+				drm_syncobj_add_point(timeline_syncobj,
+						      timeline_chain,
+						      fence,
+						      args->vm_timeline_point);
+			}
+		}
+		dma_fence_put(fence);
 
 	}
 
-- 
2.51.0


