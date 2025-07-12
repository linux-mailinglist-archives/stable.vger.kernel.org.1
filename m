Return-Path: <stable+bounces-161737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F58AB02B69
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 16:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C23816E78E
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC896149C55;
	Sat, 12 Jul 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HNTY7JZj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12C8BEC
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752330662; cv=none; b=L1xcj1sArZJNXITOHK0dofqrKdgu1+IvawPp9i4m7yeZYgANPpTpCUgTu8m1ewLUi4ba++NnrFNV/8UYtaMPoVyPMXmaFva7jtivJYFEKsZFzjtMiq5nWTot/iN/mVtObdgD08eZWQKJP3UDlgyF4pnzTh+HbU8qovjc3Ujzmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752330662; c=relaxed/simple;
	bh=iNOJLo5pXY5JOmA2EaSqC4tjGTeyB7klWzD79kKPgTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kjhQIKbIrCc6dWboQkgXfbsjiYJ7tO+QrjHR7D3KTqKQc6SXaSO7RqzBW8cQtwJuED1ASDhwtsbToR3YULsYrzBNPyEN74gWNPvHY+f6IHZM9HFF+tHG930mErSgRhaGQjLQj+PgclzleFoWGlVZr9W08ZNywvryv9Rv41XdQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HNTY7JZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15034C4CEEF;
	Sat, 12 Jul 2025 14:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752330662;
	bh=iNOJLo5pXY5JOmA2EaSqC4tjGTeyB7klWzD79kKPgTc=;
	h=Subject:To:Cc:From:Date:From;
	b=HNTY7JZjEcUmIJLg/3ZByiYtNtFAJLaNDMP0IhAuPrdow4B/ODMVtdv4qeAb5jn3J
	 0f7W1Bw4qtLCi8PlWz4uhNIkSnZCY8uOIAthQ+kSyqDDNdE1VBMVPLYkS3PCJybFUe
	 qzTY3dKgBk4tbtxQZt8Y/U6xrL06MFDlupftu5mA=
Subject: FAILED: patch "[PATCH] drm/xe: Make WA BB part of LRC BO" failed to apply to 6.15-stable tree
To: matthew.brost@intel.com,lucas.demarchi@intel.com,shuicheng.lin@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 12 Jul 2025 16:30:59 +0200
Message-ID: <2025071259-unrelated-extrovert-b5a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x afcad92411772a1f361339f22c49f855c6cc7d0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071259-unrelated-extrovert-b5a9@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From afcad92411772a1f361339f22c49f855c6cc7d0f Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Wed, 11 Jun 2025 20:19:25 -0700
Subject: [PATCH] drm/xe: Make WA BB part of LRC BO

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

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index bf7c3981897d..6e7b70532d11 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -40,6 +40,7 @@
 
 #define LRC_PPHWSP_SIZE				SZ_4K
 #define LRC_INDIRECT_RING_STATE_SIZE		SZ_4K
+#define LRC_WA_BB_SIZE				SZ_4K
 
 static struct xe_device *
 lrc_to_xe(struct xe_lrc *lrc)
@@ -910,7 +911,11 @@ static void xe_lrc_finish(struct xe_lrc *lrc)
 {
 	xe_hw_fence_ctx_finish(&lrc->fence_ctx);
 	xe_bo_unpin_map_no_vm(lrc->bo);
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
@@ -1018,20 +1025,13 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_hw_engine *hwe,
 	 * FIXME: Perma-pinning LRC as we don't yet support moving GGTT address
 	 * via VM bind calls.
 	 */
-	lrc->bo = xe_bo_create_pin_map(xe, tile, NULL, lrc_size,
+	lrc->bo = xe_bo_create_pin_map(xe, tile, NULL,
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
index ae24cf6f8dd9..883e550a9423 100644
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


