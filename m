Return-Path: <stable+bounces-66513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981494ECB8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550C21C21B2F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B083D1E488;
	Mon, 12 Aug 2024 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ehrx6CKQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF1717ADF6
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465069; cv=none; b=pF3DJ0h9cWfdrNlFNh/9shANs9Q59WFIcBLU8IVOpYP0hT/6czywrc+P8U/XhpYgb0ToGpUdItyhvWxLFRkpudTqxIJ7msSD/EBpzWkDhVCGba3samLlTLrkgymsSZ7PJy64qo8oG/y+ThWozNAXhMcrAW3K3Ou/1TZ/f61xZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465069; c=relaxed/simple;
	bh=Txu5rR9d0b0wL1VUDUvTE8a+avJVh8Dv8qoRPZXE49w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VItW2YiFNaX3VgaZeFf7KM/NplsD1zCTQ4Ckk9E9AQLLEwkzpSlLnBzdA6Ozui91bbEkP3RIU3xifpY2VWXmQX8RYRG6OtdseNdWDPda6EZNggwoIcmQXF94cBAeugs9VMU0rmX5u8AthA980nAuyMywd2G7bOx/fDa+Vw5SGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ehrx6CKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88794C4AF11;
	Mon, 12 Aug 2024 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723465068;
	bh=Txu5rR9d0b0wL1VUDUvTE8a+avJVh8Dv8qoRPZXE49w=;
	h=Subject:To:Cc:From:Date:From;
	b=ehrx6CKQT+NSGZCv3/RThno+s7kPTZYdhoEt+1CxFQC67JoOWUIDVSDrhm88yq/YI
	 3UJLTkOa4kF4hiQG88v8Dr2kX1gjISM21WqmkyNkNCPxWyeGCg3llDOLRuAJIpADK7
	 dCtKVZ3FeDwdDoJ0Az6FoihxKoYXiW74GuiTvk5o=
Subject: FAILED: patch "[PATCH] drm/amdgpu: revert "take runtime pm reference when we attach" failed to apply to 5.15-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:17:38 +0200
Message-ID: <2024081238-circle-chug-01cb@gregkh>
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
git cherry-pick -x 030631e97b209481edbac38000d2a60fd340f6b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081238-circle-chug-01cb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
425285d39afd ("drm/amdgpu: add amdgpu runpm usage trace for separate funcs")
15fd09a05a66 ("drm/amdgpu: add reset register dump trace on GPU")
21a6732f4648 ("drm/amdgpu: don't skip runtime pm get on A+A config")

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
 


