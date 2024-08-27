Return-Path: <stable+bounces-70927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 269DC9610BA
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89615B26382
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E591C5783;
	Tue, 27 Aug 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JCw7xDES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD573466;
	Tue, 27 Aug 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771525; cv=none; b=qmRztRf2twYplS+ndCkVUuD7LxGDomUuRHdgS5yA5niiNjBsrWLSgPB/ids24eFPKAgID11/JciXaOMQaIuOiHOXFhLlu7T8EEp1gGzpQsVwzVUMOVmWFM0DQXQRvc6O5MSoTmNBFp0ZtfQjYHVIzW5yyPspdkCS2YQfrSAq17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771525; c=relaxed/simple;
	bh=mrATL/p2kSO2vN21KUrddFyYZyLAWxdbb/TYJOHd2Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUW3+s0lSW0xd6WbKXcm81THlx+MfTknnqzkhOGATCZH+GmGCGrxrV/7diWxDvJuBBFP70QnCaqW1ZxSZrt23Hfy7/V2RY6K9SNBelZmX9kdMplhYdNWjOe3hhVN6clJL85vACLXAFf6yFj7qBEIngWTcoCU99qRDrgDAnZZFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JCw7xDES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289F6C4DDEE;
	Tue, 27 Aug 2024 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771525;
	bh=mrATL/p2kSO2vN21KUrddFyYZyLAWxdbb/TYJOHd2Gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCw7xDESE+yTue/kBNKq9zbZn6coJrnyicuhENWQi30xzsh36+ZEf1BZ4g8ww/ACW
	 fDTjPAukUDb4Lw97jjn4FsioUgf5SzNxbVl5U6V7r+vlwVISRCSKJ+CmsTk0pnSbJq
	 b/c8mVFUm1avb/ngsQYvtQQl4vFq0bK7JvFJi4sE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 215/273] drm/xe: Split lrc seqno fence creation up
Date: Tue, 27 Aug 2024 16:38:59 +0200
Message-ID: <20240827143841.589467068@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

[ Upstream commit e183910ae4015214475b3248ce0b4c70f104f254 ]

Since sometimes a lock is required to initialize a seqno fence,
and it might be desirable not to hold that lock while performing
memory allocations, split the lrc seqno fence creation up into an
allocation phase and an initialization phase.

Since lrc seqno fences under the hood are hw_fences, do the same
for these and remove the xe_hw_fence_create() function since it
is not used anymore.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240527135912.152156-3-thomas.hellstrom@linux.intel.com
Stable-dep-of: 9e7f30563677 ("drm/xe: Free job before xe_exec_queue_put")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_hw_fence.c | 59 +++++++++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_hw_fence.h |  7 ++--
 drivers/gpu/drm/xe/xe_lrc.c      | 48 ++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_lrc.h      |  3 ++
 4 files changed, 101 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
index f872ef1031272..35c0063a831af 100644
--- a/drivers/gpu/drm/xe/xe_hw_fence.c
+++ b/drivers/gpu/drm/xe/xe_hw_fence.c
@@ -208,23 +208,58 @@ static struct xe_hw_fence *to_xe_hw_fence(struct dma_fence *fence)
 	return container_of(fence, struct xe_hw_fence, dma);
 }
 
-struct xe_hw_fence *xe_hw_fence_create(struct xe_hw_fence_ctx *ctx,
-				       struct iosys_map seqno_map)
+/**
+ * xe_hw_fence_alloc() -  Allocate an hw fence.
+ *
+ * Allocate but don't initialize an hw fence.
+ *
+ * Return: Pointer to the allocated fence or
+ * negative error pointer on error.
+ */
+struct dma_fence *xe_hw_fence_alloc(void)
 {
-	struct xe_hw_fence *fence;
+	struct xe_hw_fence *hw_fence = fence_alloc();
 
-	fence = fence_alloc();
-	if (!fence)
+	if (!hw_fence)
 		return ERR_PTR(-ENOMEM);
 
-	fence->ctx = ctx;
-	fence->seqno_map = seqno_map;
-	INIT_LIST_HEAD(&fence->irq_link);
+	return &hw_fence->dma;
+}
 
-	dma_fence_init(&fence->dma, &xe_hw_fence_ops, &ctx->irq->lock,
-		       ctx->dma_fence_ctx, ctx->next_seqno++);
+/**
+ * xe_hw_fence_free() - Free an hw fence.
+ * @fence: Pointer to the fence to free.
+ *
+ * Frees an hw fence that hasn't yet been
+ * initialized.
+ */
+void xe_hw_fence_free(struct dma_fence *fence)
+{
+	fence_free(&fence->rcu);
+}
 
-	trace_xe_hw_fence_create(fence);
+/**
+ * xe_hw_fence_init() - Initialize an hw fence.
+ * @fence: Pointer to the fence to initialize.
+ * @ctx: Pointer to the struct xe_hw_fence_ctx fence context.
+ * @seqno_map: Pointer to the map into where the seqno is blitted.
+ *
+ * Initializes a pre-allocated hw fence.
+ * After initialization, the fence is subject to normal
+ * dma-fence refcounting.
+ */
+void xe_hw_fence_init(struct dma_fence *fence, struct xe_hw_fence_ctx *ctx,
+		      struct iosys_map seqno_map)
+{
+	struct  xe_hw_fence *hw_fence =
+		container_of(fence, typeof(*hw_fence), dma);
+
+	hw_fence->ctx = ctx;
+	hw_fence->seqno_map = seqno_map;
+	INIT_LIST_HEAD(&hw_fence->irq_link);
+
+	dma_fence_init(fence, &xe_hw_fence_ops, &ctx->irq->lock,
+		       ctx->dma_fence_ctx, ctx->next_seqno++);
 
-	return fence;
+	trace_xe_hw_fence_create(hw_fence);
 }
diff --git a/drivers/gpu/drm/xe/xe_hw_fence.h b/drivers/gpu/drm/xe/xe_hw_fence.h
index cfe5fd603787e..f13a1c4982c73 100644
--- a/drivers/gpu/drm/xe/xe_hw_fence.h
+++ b/drivers/gpu/drm/xe/xe_hw_fence.h
@@ -24,7 +24,10 @@ void xe_hw_fence_ctx_init(struct xe_hw_fence_ctx *ctx, struct xe_gt *gt,
 			  struct xe_hw_fence_irq *irq, const char *name);
 void xe_hw_fence_ctx_finish(struct xe_hw_fence_ctx *ctx);
 
-struct xe_hw_fence *xe_hw_fence_create(struct xe_hw_fence_ctx *ctx,
-				       struct iosys_map seqno_map);
+struct dma_fence *xe_hw_fence_alloc(void);
 
+void xe_hw_fence_free(struct dma_fence *fence);
+
+void xe_hw_fence_init(struct dma_fence *fence, struct xe_hw_fence_ctx *ctx,
+		      struct iosys_map seqno_map);
 #endif
diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index d7bf7bc9dc145..995f47eb365c3 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -901,10 +901,54 @@ u32 xe_lrc_seqno_ggtt_addr(struct xe_lrc *lrc)
 	return __xe_lrc_seqno_ggtt_addr(lrc);
 }
 
+/**
+ * xe_lrc_alloc_seqno_fence() - Allocate an lrc seqno fence.
+ *
+ * Allocate but don't initialize an lrc seqno fence.
+ *
+ * Return: Pointer to the allocated fence or
+ * negative error pointer on error.
+ */
+struct dma_fence *xe_lrc_alloc_seqno_fence(void)
+{
+	return xe_hw_fence_alloc();
+}
+
+/**
+ * xe_lrc_free_seqno_fence() - Free an lrc seqno fence.
+ * @fence: Pointer to the fence to free.
+ *
+ * Frees an lrc seqno fence that hasn't yet been
+ * initialized.
+ */
+void xe_lrc_free_seqno_fence(struct dma_fence *fence)
+{
+	xe_hw_fence_free(fence);
+}
+
+/**
+ * xe_lrc_init_seqno_fence() - Initialize an lrc seqno fence.
+ * @lrc: Pointer to the lrc.
+ * @fence: Pointer to the fence to initialize.
+ *
+ * Initializes a pre-allocated lrc seqno fence.
+ * After initialization, the fence is subject to normal
+ * dma-fence refcounting.
+ */
+void xe_lrc_init_seqno_fence(struct xe_lrc *lrc, struct dma_fence *fence)
+{
+	xe_hw_fence_init(fence, &lrc->fence_ctx, __xe_lrc_seqno_map(lrc));
+}
+
 struct dma_fence *xe_lrc_create_seqno_fence(struct xe_lrc *lrc)
 {
-	return &xe_hw_fence_create(&lrc->fence_ctx,
-				   __xe_lrc_seqno_map(lrc))->dma;
+	struct dma_fence *fence = xe_lrc_alloc_seqno_fence();
+
+	if (IS_ERR(fence))
+		return fence;
+
+	xe_lrc_init_seqno_fence(lrc, fence);
+	return fence;
 }
 
 s32 xe_lrc_seqno(struct xe_lrc *lrc)
diff --git a/drivers/gpu/drm/xe/xe_lrc.h b/drivers/gpu/drm/xe/xe_lrc.h
index d32fa31faa2cf..f57c5836dab87 100644
--- a/drivers/gpu/drm/xe/xe_lrc.h
+++ b/drivers/gpu/drm/xe/xe_lrc.h
@@ -38,6 +38,9 @@ void xe_lrc_write_ctx_reg(struct xe_lrc *lrc, int reg_nr, u32 val);
 u64 xe_lrc_descriptor(struct xe_lrc *lrc);
 
 u32 xe_lrc_seqno_ggtt_addr(struct xe_lrc *lrc);
+struct dma_fence *xe_lrc_alloc_seqno_fence(void);
+void xe_lrc_free_seqno_fence(struct dma_fence *fence);
+void xe_lrc_init_seqno_fence(struct xe_lrc *lrc, struct dma_fence *fence);
 struct dma_fence *xe_lrc_create_seqno_fence(struct xe_lrc *lrc);
 s32 xe_lrc_seqno(struct xe_lrc *lrc);
 
-- 
2.43.0




