Return-Path: <stable+bounces-66515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7404494ECBC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0AD28414B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10117B431;
	Mon, 12 Aug 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m3AUw/uZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E917B42E
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465076; cv=none; b=CkPRqJvzHytInXr8LFfmqcNBdY6k/oI7dY7I5IGAvgoilqcgeyT3Tsg4eQnUvCCxOYEVsH/byFBr5x47uFe/evj39wJmV6k1+6qo5GS8xYBc9m5hlCkSABQSYp4CEnAUWBGn8BEDuey3WQjpeBaMgf5WM5tebHKKYhAIGt4yEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465076; c=relaxed/simple;
	bh=P66d+FEQs8qyewN9jeVLnzX1gWnEk8nOdrzqlAgVlGc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bu+ZhK6qfwC9V4V/aJlZiWuB/BqxeNg1AErKoa5tZgVZfPhkshwcK+oj5zMm/voSu31LTrqRMP5d+/c+o+zO/1zEtGF6Tfjhjgnvyfs9yFRFYhr3mtd57/s//siM84NEKEFTwfSNVlVger6V3RF58sprBCAadkI5sFFhhpLqjQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m3AUw/uZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72873C4AF0F;
	Mon, 12 Aug 2024 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723465075;
	bh=P66d+FEQs8qyewN9jeVLnzX1gWnEk8nOdrzqlAgVlGc=;
	h=Subject:To:Cc:From:Date:From;
	b=m3AUw/uZaYyU6+vEWy1H3Lqaf+MsmIpVmhwuO+iUsTR/K+IFW4ml2Y/GsxKEnpVdO
	 ZWakXKgNS4+9cPPxH57036SlHPoZaOjc8NnSnXrZCpRsxarVXj+IgWojKFfZ+lFQaS
	 UpAYqMXz8Lj+r+J+8rGg/uS0iOyUxPp9dMzU+7oI=
Subject: FAILED: patch "[PATCH] drm/amdgpu: revert "take runtime pm reference when we attach" failed to apply to 5.4-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:17:40 +0200
Message-ID: <2024081240-achiness-vitalize-dd50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 030631e97b209481edbac38000d2a60fd340f6b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081240-achiness-vitalize-dd50@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
425285d39afd ("drm/amdgpu: add amdgpu runpm usage trace for separate funcs")
15fd09a05a66 ("drm/amdgpu: add reset register dump trace on GPU")
21a6732f4648 ("drm/amdgpu: don't skip runtime pm get on A+A config")
8c505bdc9c8b ("drm/amdgpu: rework dma_resv handling v3")
d3fae3b3daac ("dma-buf: drop the _rcu postfix on function names v3")
fb5ce730f214 ("dma-buf: rename and cleanup dma_resv_get_list v2")
6edbd6abb783 ("dma-buf: rename and cleanup dma_resv_get_excl v3")
0c6b522abc2a ("dma-buf: cleanup dma-resv shared fence debugging a bit v2")
068d9d754bc1 ("dma-buf: add SPDX header and fix style in dma-resv.c")
680753dd9d7d ("dma-buf: fix inconsistent debug print v2")
71df0368e9b6 ("drm/amdgpu: Implement mmap as GEM object function")
304ba5dca49a ("Merge drm/drm-next into drm-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 030631e97b209481edbac38000d2a60fd340f6b1 Mon Sep 17 00:00:00 2001
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
index 0b3b10d21952..8e81a83d37d8 100644
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
@@ -266,7 +233,6 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.attach = amdgpu_dma_buf_attach,
-	.detach = amdgpu_dma_buf_detach,
 	.pin = amdgpu_dma_buf_pin,
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3f492277d7d3..2f24a6aa13bf 100644
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
index f539b1d00234..2fd1bfb35916 100644
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
-			   __assign_str(func, func);
-			   ),
-	    TP_printk("amdgpu runpm reference dump 0x%x: 0x%s\n",
-		      __entry->index,
-		      __get_str(func))
-);
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 


