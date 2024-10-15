Return-Path: <stable+bounces-85948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D799EAEF
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5FD1F223BA
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD031C07F2;
	Tue, 15 Oct 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oyr1PUCB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987681C07C4;
	Tue, 15 Oct 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997253; cv=none; b=akC5KOji/CtTQAROqNCAeNbkI3DuVHmqRPAUsFIcKKik1Wox9n+jGq7zfMe4Y7vAdKK1BpNv03TcSyLOlAnT/tBd6mNBxWBA+UPHq3Gng3JKX4ZUAAnWzbZIybQUU4YjLkEA02j3RlnXLmhIOGQghF3XPC+xN3Y4Om7aHClg3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997253; c=relaxed/simple;
	bh=VSdw01JeNtHHdRGJb0p3K/RyYouCeSF/v1u0SjX1IB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+FX1ib256/vHilu+F0kzjL7h+P7GeLn/9RwzDTwujcUpdSMtpGuUsbKVEgaIW0LUelTCtfsZps1FJ6eOY1QWoX1q9BU+eD7MCD4qqvSWrnbuJV/o6jy1RzEc+hZJTNtv9pgiJt+cIVRzf3BF49WS65T24d46O/jzjdaWQmeZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oyr1PUCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2724C4CEC6;
	Tue, 15 Oct 2024 13:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997253;
	bh=VSdw01JeNtHHdRGJb0p3K/RyYouCeSF/v1u0SjX1IB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oyr1PUCB2EPjpSO2jtq6b7QMUYiSHFCRdu6D17B+TJ9dcLBQQo904k7wOE2E05WqP
	 DyN80kuO091JfntmLSgD4sfrPILQEnQyuknfvZ7mmKrtqmag2YBeDpWMUjC8WhKhML
	 QpY+ypTEBqIFKRzIHgU71XUol7mIRRGcUU2Q4YcA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	Akhil P Oommen <akhilpo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 128/518] drm/msm: Drop priv->lastctx
Date: Tue, 15 Oct 2024 14:40:32 +0200
Message-ID: <20241015123921.934832106@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 1d054c9b8457b56a651109fac21f56f46ccd46b2 ]

cur_ctx_seqno already does the same thing, but handles the edge cases
where a refcnt'd context can live after lastclose.  So let's not have
two ways to do the same thing.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Akhil P Oommen <akhilpo@codeaurora.org>
Link: https://lore.kernel.org/r/20211109181117.591148-3-robdclark@gmail.com
Signed-off-by: Rob Clark <robdclark@chromium.org>
Stable-dep-of: a30f9f65b5ac ("drm/msm/a5xx: workaround early ring-buffer emptiness check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c |  3 +--
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c |  3 +--
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c |  3 +--
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  8 +++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  9 +++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 10 ----------
 drivers/gpu/drm/msm/msm_drv.c         |  6 ------
 drivers/gpu/drm/msm/msm_drv.h         |  2 +-
 drivers/gpu/drm/msm/msm_gpu.c         |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h         | 11 +++++++++++
 10 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index 64ee63dcdb7c9..caa791eb746f0 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -12,7 +12,6 @@ static bool a2xx_idle(struct msm_gpu *gpu);
 
 static void a2xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
-	struct msm_drm_private *priv = gpu->dev->dev_private;
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i;
 
@@ -23,7 +22,7 @@ static void a2xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
 			/* ignore if there has not been a ctx switch: */
-			if (priv->lastctx == submit->queue->ctx)
+			if (gpu->cur_ctx_seqno == submit->queue->ctx->seqno)
 				break;
 			fallthrough;
 		case MSM_SUBMIT_CMD_BUF:
diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index f29c77d9cd42d..7e5d0afa05db0 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -30,7 +30,6 @@ static bool a3xx_idle(struct msm_gpu *gpu);
 
 static void a3xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
-	struct msm_drm_private *priv = gpu->dev->dev_private;
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i;
 
@@ -41,7 +40,7 @@ static void a3xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
 			/* ignore if there has not been a ctx switch: */
-			if (priv->lastctx == submit->queue->ctx)
+			if (gpu->cur_ctx_seqno == submit->queue->ctx->seqno)
 				break;
 			fallthrough;
 		case MSM_SUBMIT_CMD_BUF:
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index 2b93b33b05e45..f6d22fba9c1bb 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -24,7 +24,6 @@ static bool a4xx_idle(struct msm_gpu *gpu);
 
 static void a4xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
-	struct msm_drm_private *priv = gpu->dev->dev_private;
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i;
 
@@ -35,7 +34,7 @@ static void a4xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
 			/* ignore if there has not been a ctx switch: */
-			if (priv->lastctx == submit->queue->ctx)
+			if (gpu->cur_ctx_seqno == submit->queue->ctx->seqno)
 				break;
 			fallthrough;
 		case MSM_SUBMIT_CMD_BUF:
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 00e591ffc1914..aa2b2958237f4 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -56,7 +56,6 @@ void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 
 static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
-	struct msm_drm_private *priv = gpu->dev->dev_private;
 	struct msm_ringbuffer *ring = submit->ring;
 	struct msm_gem_object *obj;
 	uint32_t *ptr, dwords;
@@ -67,7 +66,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
-			if (priv->lastctx == submit->queue->ctx)
+			if (gpu->cur_ctx_seqno == submit->queue->ctx->seqno)
 				break;
 			fallthrough;
 		case MSM_SUBMIT_CMD_BUF:
@@ -117,12 +116,11 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
-	struct msm_drm_private *priv = gpu->dev->dev_private;
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i, ibs = 0;
 
 	if (IS_ENABLED(CONFIG_DRM_MSM_GPU_SUDO) && submit->in_rb) {
-		priv->lastctx = NULL;
+		gpu->cur_ctx_seqno = 0;
 		a5xx_submit_in_rb(gpu, submit);
 		return;
 	}
@@ -161,7 +159,7 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
-			if (priv->lastctx == submit->queue->ctx)
+			if (gpu->cur_ctx_seqno == submit->queue->ctx->seqno)
 				break;
 			fallthrough;
 		case MSM_SUBMIT_CMD_BUF:
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 29b40acedb389..a78f47a788f7b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -99,7 +99,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	u32 asid;
 	u64 memptr = rbmemptr(ring, ttbr0);
 
-	if (ctx->seqno == a6xx_gpu->cur_ctx_seqno)
+	if (ctx->seqno == a6xx_gpu->base.base.cur_ctx_seqno)
 		return;
 
 	if (msm_iommu_pagetable_params(ctx->aspace->mmu, &ttbr, &asid))
@@ -131,14 +131,11 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 
 	OUT_PKT7(ring, CP_EVENT_WRITE, 1);
 	OUT_RING(ring, 0x31);
-
-	a6xx_gpu->cur_ctx_seqno = ctx->seqno;
 }
 
 static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
 	unsigned int index = submit->seqno % MSM_GPU_SUBMIT_STATS_COUNT;
-	struct msm_drm_private *priv = gpu->dev->dev_private;
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = submit->ring;
@@ -170,7 +167,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
 			break;
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
-			if (priv->lastctx == submit->queue->ctx)
+			if (gpu->cur_ctx_seqno == submit->queue->ctx->seqno)
 				break;
 			fallthrough;
 		case MSM_SUBMIT_CMD_BUF:
@@ -887,7 +884,7 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	/* Always come up on rb 0 */
 	a6xx_gpu->cur_ring = gpu->rb[0];
 
-	a6xx_gpu->cur_ctx_seqno = 0;
+	gpu->cur_ctx_seqno = 0;
 
 	/* Enable the SQE_to start the CP engine */
 	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index f923edbd5daaf..189daaf77744f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -20,16 +20,6 @@ struct a6xx_gpu {
 
 	struct msm_ringbuffer *cur_ring;
 
-	/**
-	 * cur_ctx_seqno:
-	 *
-	 * The ctx->seqno value of the context with current pgtables
-	 * installed.  Tracked by seqno rather than pointer value to
-	 * avoid dangling pointers, and cases where a ctx can be freed
-	 * and a new one created with the same address.
-	 */
-	int cur_ctx_seqno;
-
 	struct a6xx_gmu gmu;
 
 	struct drm_gem_object *shadow_bo;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 130c721fcd4e6..d7a7113dcafaf 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -626,14 +626,8 @@ static void context_close(struct msm_file_private *ctx)
 
 static void msm_postclose(struct drm_device *dev, struct drm_file *file)
 {
-	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_file_private *ctx = file->driver_priv;
 
-	mutex_lock(&dev->struct_mutex);
-	if (ctx == priv->lastctx)
-		priv->lastctx = NULL;
-	mutex_unlock(&dev->struct_mutex);
-
 	context_close(ctx);
 }
 
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 3a49e8eb338c0..52da60bbf6b3a 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -165,7 +165,7 @@ struct msm_drm_private {
 
 	/* when we have more than one 'msm_gpu' these need to be an array: */
 	struct msm_gpu *gpu;
-	struct msm_file_private *lastctx;
+
 	/* gpu is only set on open(), but we need this info earlier */
 	bool is_a2xx;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 90c26da109026..c5f3c561ecc6a 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -795,7 +795,7 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	}
 
 	gpu->funcs->submit(gpu, submit);
-	priv->lastctx = submit->queue->ctx;
+	gpu->cur_ctx_seqno = submit->queue->ctx->seqno;
 
 	hangcheck_timer_reset(gpu);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 1806e87600c0e..b1feaae50b9e7 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -94,6 +94,17 @@ struct msm_gpu {
 	struct msm_ringbuffer *rb[MSM_GPU_MAX_RINGS];
 	int nr_rings;
 
+	/**
+	 * cur_ctx_seqno:
+	 *
+	 * The ctx->seqno value of the last context to submit rendering,
+	 * and the one with current pgtables installed (for generations
+	 * that support per-context pgtables).  Tracked by seqno rather
+	 * than pointer value to avoid dangling pointers, and cases where
+	 * a ctx can be freed and a new one created with the same address.
+	 */
+	int cur_ctx_seqno;
+
 	/*
 	 * List of GEM active objects on this gpu.  Protected by
 	 * msm_drm_private::mm_lock
-- 
2.43.0




