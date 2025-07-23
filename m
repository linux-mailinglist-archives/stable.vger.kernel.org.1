Return-Path: <stable+bounces-164469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179B2B0F6C4
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610F83B58AB
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DE62E8E05;
	Wed, 23 Jul 2025 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEJTSd05"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F82E62C6
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283420; cv=none; b=o1ipCDj0DXHfEvNk3DAGf7kBcKNQBWXGLaTYrFaIBvuZIdyh9aJvYnjKTxnEaiu9fsA4+hpPLFQJxHk1dAD6byFKn2uwqP3z5KH01ANWwxf0BgtWkcDOPB52T88NyxqKzmzqypHQ8jPBAGySqJhCh3B/6smoq7zAgroH4o7IeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283420; c=relaxed/simple;
	bh=QEizif9soLhCvUCHl39ScfhlfJp6dByjyDpk5XLBhnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MelmAMpEq30FYh1HM6rKpOVMQ7W9tTQnI/BdGUo4h980eoKjT1S9jy3CF52OTpDpBHIyS7/OQJvfTr93QiUI9GJcagVb4eh2vdE+y9s4NAGwrclsmKXXMgQHN+MWrhCD2q3trntcqOnP7jZDHRpYhd5sip3XyBQFf/O/7GDo/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEJTSd05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11068C4CEE7;
	Wed, 23 Jul 2025 15:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283416;
	bh=QEizif9soLhCvUCHl39ScfhlfJp6dByjyDpk5XLBhnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEJTSd05qzcQQyahmBtJ6RaSJxL94/IhM8/OEImpR/uZ5MOf9HJcV4Cq91zJgKbha
	 qw52GHsn7lVJEOkidMEj/A6vQYMr4Q2JZ183zWi7/r3HMFm9EWoLEmPgusYBx2yLTG
	 hkWUjpHdrMKpfNiVGnb4ZLNnBCVVf62GuNEEdjaY+Cmj7Nspbz/xFhadK0/HvMh8Qn
	 A2Zb3RB1CuZ1DLo6+Wzhscnhi7rBhXkcU0a51s+SFTzGxB2epfpqvtRg3C/kfBsoOf
	 m/LGH3lSgHF55WTTfmPbovhUa6o4A9shRecDWhHfDPe26N03Nd9vGJPICmCPvRRENK
	 I7GxVy0+Rmimg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y] drm/xe: Make WA BB part of LRC BO
Date: Wed, 23 Jul 2025 11:10:10 -0400
Message-Id: <20250723151010.1092266-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071259-unrelated-extrovert-b5a9@gregkh>
References: <2025071259-unrelated-extrovert-b5a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit afcad92411772a1f361339f22c49f855c6cc7d0f ]

No idea why, but without this GuC context switches randomly fail when
running IGTs in a loop. Need to follow up why this fixes the
aforementioned issue but can live with a stable driver for now.

Fixes: 617d824c5323 ("drm/xe: Add WA BB to capture active context utilization")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Tested-by: Shuicheng Lin <shuicheng.lin@intel.com>
Link: https://lore.kernel.org/r/20250612031925.4009701-1-matthew.brost@intel.com
(cherry picked from commit 3a1edef8f4b58b0ba826bc68bf4bce4bdf59ecf3)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
[ adapted xe_bo_create_pin_map() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_lrc.c       | 37 ++++++++++++++++---------------
 drivers/gpu/drm/xe/xe_lrc_types.h |  3 ---
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 16e20b5ad325f..c3c9df8ba7bbf 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -39,6 +39,7 @@
 #define LRC_ENGINE_INSTANCE			GENMASK_ULL(53, 48)
 
 #define LRC_INDIRECT_RING_STATE_SIZE		SZ_4K
+#define LRC_WA_BB_SIZE				SZ_4K
 
 static struct xe_device *
 lrc_to_xe(struct xe_lrc *lrc)
@@ -910,7 +911,11 @@ static void xe_lrc_finish(struct xe_lrc *lrc)
 	xe_bo_unpin(lrc->bo);
 	xe_bo_unlock(lrc->bo);
 	xe_bo_put(lrc->bo);
-	xe_bo_unpin_map_no_vm(lrc->bb_per_ctx_bo);
+}
+
+static size_t wa_bb_offset(struct xe_lrc *lrc)
+{
+	return lrc->bo->size - LRC_WA_BB_SIZE;
 }
 
 /*
@@ -943,15 +948,16 @@ static void xe_lrc_finish(struct xe_lrc *lrc)
 #define CONTEXT_ACTIVE 1ULL
 static int xe_lrc_setup_utilization(struct xe_lrc *lrc)
 {
+	const size_t max_size = LRC_WA_BB_SIZE;
 	u32 *cmd, *buf = NULL;
 
-	if (lrc->bb_per_ctx_bo->vmap.is_iomem) {
-		buf = kmalloc(lrc->bb_per_ctx_bo->size, GFP_KERNEL);
+	if (lrc->bo->vmap.is_iomem) {
+		buf = kmalloc(max_size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 		cmd = buf;
 	} else {
-		cmd = lrc->bb_per_ctx_bo->vmap.vaddr;
+		cmd = lrc->bo->vmap.vaddr + wa_bb_offset(lrc);
 	}
 
 	*cmd++ = MI_STORE_REGISTER_MEM | MI_SRM_USE_GGTT | MI_SRM_ADD_CS_OFFSET;
@@ -974,13 +980,14 @@ static int xe_lrc_setup_utilization(struct xe_lrc *lrc)
 	*cmd++ = MI_BATCH_BUFFER_END;
 
 	if (buf) {
-		xe_map_memcpy_to(gt_to_xe(lrc->gt), &lrc->bb_per_ctx_bo->vmap, 0,
-				 buf, (cmd - buf) * sizeof(*cmd));
+		xe_map_memcpy_to(gt_to_xe(lrc->gt), &lrc->bo->vmap,
+				 wa_bb_offset(lrc), buf,
+				 (cmd - buf) * sizeof(*cmd));
 		kfree(buf);
 	}
 
-	xe_lrc_write_ctx_reg(lrc, CTX_BB_PER_CTX_PTR,
-			     xe_bo_ggtt_addr(lrc->bb_per_ctx_bo) | 1);
+	xe_lrc_write_ctx_reg(lrc, CTX_BB_PER_CTX_PTR, xe_bo_ggtt_addr(lrc->bo) +
+			     wa_bb_offset(lrc) + 1);
 
 	return 0;
 }
@@ -1016,20 +1023,13 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_hw_engine *hwe,
 	 * FIXME: Perma-pinning LRC as we don't yet support moving GGTT address
 	 * via VM bind calls.
 	 */
-	lrc->bo = xe_bo_create_pin_map(xe, tile, vm, lrc_size,
+	lrc->bo = xe_bo_create_pin_map(xe, tile, vm,
+				       lrc_size + LRC_WA_BB_SIZE,
 				       ttm_bo_type_kernel,
 				       bo_flags);
 	if (IS_ERR(lrc->bo))
 		return PTR_ERR(lrc->bo);
 
-	lrc->bb_per_ctx_bo = xe_bo_create_pin_map(xe, tile, NULL, SZ_4K,
-						  ttm_bo_type_kernel,
-						  bo_flags);
-	if (IS_ERR(lrc->bb_per_ctx_bo)) {
-		err = PTR_ERR(lrc->bb_per_ctx_bo);
-		goto err_lrc_finish;
-	}
-
 	lrc->size = lrc_size;
 	lrc->ring.size = ring_size;
 	lrc->ring.tail = 0;
@@ -1819,7 +1819,8 @@ struct xe_lrc_snapshot *xe_lrc_snapshot_capture(struct xe_lrc *lrc)
 	snapshot->seqno = xe_lrc_seqno(lrc);
 	snapshot->lrc_bo = xe_bo_get(lrc->bo);
 	snapshot->lrc_offset = xe_lrc_pphwsp_offset(lrc);
-	snapshot->lrc_size = lrc->bo->size - snapshot->lrc_offset;
+	snapshot->lrc_size = lrc->bo->size - snapshot->lrc_offset -
+		LRC_WA_BB_SIZE;
 	snapshot->lrc_snapshot = NULL;
 	snapshot->ctx_timestamp = lower_32_bits(xe_lrc_ctx_timestamp(lrc));
 	snapshot->ctx_job_timestamp = xe_lrc_ctx_job_timestamp(lrc);
diff --git a/drivers/gpu/drm/xe/xe_lrc_types.h b/drivers/gpu/drm/xe/xe_lrc_types.h
index ae24cf6f8dd99..883e550a94234 100644
--- a/drivers/gpu/drm/xe/xe_lrc_types.h
+++ b/drivers/gpu/drm/xe/xe_lrc_types.h
@@ -53,9 +53,6 @@ struct xe_lrc {
 
 	/** @ctx_timestamp: readout value of CTX_TIMESTAMP on last update */
 	u64 ctx_timestamp;
-
-	/** @bb_per_ctx_bo: buffer object for per context batch wa buffer */
-	struct xe_bo *bb_per_ctx_bo;
 };
 
 struct xe_lrc_snapshot;
-- 
2.39.5


