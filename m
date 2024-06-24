Return-Path: <stable+bounces-55053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B0D9153DF
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC5A1C20DB5
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D835719DF93;
	Mon, 24 Jun 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nbaqyPuP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14D19DF88
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246757; cv=none; b=JlTKMKK9Bp0TK4LnHmv9bk87Do766tNPumpGYk1YpUaVJI6en4J41QGsEfiQ1BAecOpqdCr/Wa1h44LhBMnLB7U5lQ5LqWFX2nEnmsOlg0CdBamjuc4ZYaPkG9/e14Rr6Cis6xSgbJgsdUAHqtObscq6YbSU5JjlJl1IUwXUpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246757; c=relaxed/simple;
	bh=AMR78hDtxsW6d9j8plKsXCnurMEvSp1xC5T05AwEqok=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hbDVmC6LgA6SuFjcFBtfISk/42Iro7xk2PhMIn39dHgqMc4mtxna0dgL4juakpHk+UVGEzWWBALQ86xQURirXesL0bw4ZLuhUaDDhiZtmr+B/b/oazkg5JAyqlHyxa9swho0OsyMMprlurH2tG/WUkz1xRnEyITk4i13Ts80PCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nbaqyPuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7488C32789;
	Mon, 24 Jun 2024 16:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719246757;
	bh=AMR78hDtxsW6d9j8plKsXCnurMEvSp1xC5T05AwEqok=;
	h=Subject:To:Cc:From:Date:From;
	b=nbaqyPuPp9N8L+wsSno4cnRZMJVUPGJM3+ZgBH/hE3qYL9bmzxi8JcF05LKv+DKEG
	 tRshGtpn0F5EVHJqnEZcTZmrlR9vBhw26NRfcPnBpbwz3vX5WByazMwX8AVwdwtFQ9
	 sIT4hbX5b6jBgMFOHY2/brUP8KmGOP0+3Isc+Slk=
Subject: FAILED: patch "[PATCH] drm/amdgpu: revert "take runtime pm reference when we attach" failed to apply to 6.9-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:32:33 +0200
Message-ID: <2024062432-cinch-refining-262b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 8bd82363e2ee2eb3a9a8ea1fa94ebe1900d05a71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062432-cinch-refining-262b@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bd82363e2ee2eb3a9a8ea1fa94ebe1900d05a71 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Wed, 5 Jun 2024 13:27:20 +0200
Subject: [PATCH] drm/amdgpu: revert "take runtime pm reference when we attach
 a buffer" v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit b8c415e3bf98 ("drm/amdgpu: take runtime pm reference
when we attach a buffer") and commit 425285d39afd ("drm/amdgpu: add amdgpu
runpm usage trace for separate funcs").

Taking a runtime pm reference for DMA-buf is actually completely
unnecessary and even dangerous.

The problem is that calling pm_runtime_get_sync() from the DMA-buf
callbacks is illegal because we have the reservation locked here
which is also taken during resume. So this would deadlock.

When the buffer is in GTT it is still accessible even when the GPU
is powered down and when it is in VRAM the buffer gets migrated to
GTT before powering down.

The only use case which would make it mandatory to keep the runtime
pm reference would be if we pin the buffer into VRAM, and that's not
something we currently do.

v2: improve the commit message

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 055ba2ea4c12..662d0f28f358 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -41,8 +41,6 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
-#include <linux/pm_runtime.h>
-#include "amdgpu_trace.h"
 
 /**
  * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
@@ -58,42 +56,11 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	struct drm_gem_object *obj = dmabuf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	int r;
 
 	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	trace_amdgpu_runpm_reference_dumps(1, __func__);
-	if (r < 0)
-		goto out;
-
 	return 0;
-
-out:
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-	trace_amdgpu_runpm_reference_dumps(0, __func__);
-	return r;
-}
-
-/**
- * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
- *
- * @dmabuf: DMA-buf where we remove the attachment from
- * @attach: the attachment to remove
- *
- * Called when an attachment is removed from the DMA-buf.
- */
-static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
-				  struct dma_buf_attachment *attach)
-{
-	struct drm_gem_object *obj = dmabuf->priv;
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-	trace_amdgpu_runpm_reference_dumps(0, __func__);
 }
 
 /**
@@ -267,7 +234,6 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.attach = amdgpu_dma_buf_attach,
-	.detach = amdgpu_dma_buf_detach,
 	.pin = amdgpu_dma_buf_pin,
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 10832b470448..bc3ac73b6b8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -181,7 +181,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
-	trace_amdgpu_runpm_reference_dumps(1, __func__);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
 		struct dma_fence *old;
@@ -309,7 +308,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		dma_fence_put(fence);
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		trace_amdgpu_runpm_reference_dumps(0, __func__);
 	} while (last_seq != seq);
 
 	return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 7aafeb763e5d..383fce40d4dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -554,21 +554,6 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
 		      __entry->value)
 );
 
-TRACE_EVENT(amdgpu_runpm_reference_dumps,
-	    TP_PROTO(uint32_t index, const char *func),
-	    TP_ARGS(index, func),
-	    TP_STRUCT__entry(
-			     __field(uint32_t, index)
-			     __string(func, func)
-			     ),
-	    TP_fast_assign(
-			   __entry->index = index;
-			   __assign_str(func);
-			   ),
-	    TP_printk("amdgpu runpm reference dump 0x%x: 0x%s\n",
-		      __entry->index,
-		      __get_str(func))
-);
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 


