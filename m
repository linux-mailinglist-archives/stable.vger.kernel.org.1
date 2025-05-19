Return-Path: <stable+bounces-144779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4420ABBD2D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D6C3A2EDA
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25422690F9;
	Mon, 19 May 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sxF+Wl1+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CB13D52F
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656087; cv=none; b=tQF9OflO4Gr877ri4dXkXxoEQAvRFkByd+tlBHL2dqr3ALSjOKA6+IMRvdSLiV/5c96WJjsXo0sAzNfHJSrhc+xARZwCFmG6q3ogvccaNtAscpaKjE95iBRYCdpQOGD0pnSfxPjl5/YgkUIo44QuoH3DjyL86hambYSdPAFJT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656087; c=relaxed/simple;
	bh=GIxPQAUywBvHVFhJ2qAf9hVs2UDM0JuzXnzNkF3PaW4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P4O3in1MZD5ASEz1FIL1JL8LqoLVjMk2n6PX6ZM9TUYe8nulofszNntLNDKbIe8qrMTh7asxVeU1fjHlPIVKU8UA+uG8vInWVagc9LX94BeIGsgWDhRMxDoy0zz2LoV2xfy8vbNVZvzpEGvkvhCyKHtE+Tkbvh4xXPBYi2zAdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sxF+Wl1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FC3C4CEE4;
	Mon, 19 May 2025 12:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747656087;
	bh=GIxPQAUywBvHVFhJ2qAf9hVs2UDM0JuzXnzNkF3PaW4=;
	h=Subject:To:Cc:From:Date:From;
	b=sxF+Wl1+2kyk6ZyQ8C6RQyDg0PImv0Z8hMRfy1D6JlHgdh+LeF7ER9Fg7glrWBf5S
	 RLqS0jM7vVAe2RXBh53XvFjy7luYFdsgN/SYpXufrJLuCOVf5wAnUoiaFpO2yAsDZ5
	 0qMIs2kfk56ckFh8g9hQjbX0+MvnfGMZyH8UuUhY=
Subject: FAILED: patch "[PATCH] drm/xe: Add WA BB to capture active context utilization" failed to apply to 6.14-stable tree
To: umesh.nerlige.ramappa@intel.com,lucas.demarchi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:01:24 +0200
Message-ID: <2025051924-uptake-sacred-dd3a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 617d824c5323b8474b3665ae6c410c98b839e0b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051924-uptake-sacred-dd3a@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 617d824c5323b8474b3665ae6c410c98b839e0b0 Mon Sep 17 00:00:00 2001
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Date: Fri, 9 May 2025 09:12:03 -0700
Subject: [PATCH] drm/xe: Add WA BB to capture active context utilization

Context Timestamp (CTX_TIMESTAMP) in the LRC accumulates the run ticks
of the context, but only gets updated when the context switches out. In
order to check how long a context has been active before it switches
out, two things are required:

(1) Determine if the context is running:

To do so, we program the WA BB to set an initial value for CTX_TIMESTAMP
in the LRC. The value chosen is 1 since 0 is the initial value when the
LRC is initialized. During a query, we just check for this value to
determine if the context is active. If the context switched out, it
would overwrite this location with the actual CTX_TIMESTAMP MMIO value.
Note that WA BB runs as the last part of the context restore, so reusing
this LRC location will not clobber anything.

(2) Calculate the time that the context has been active for:

The CTX_TIMESTAMP ticks only when the context is active. If a context is
active, we just use the CTX_TIMESTAMP MMIO as the new value of
utilization. While doing so, we need to read the CTX_TIMESTAMP MMIO
for the specific engine instance. Since we do not know which instance
the context is running on until it is scheduled, we also read the
ENGINE_ID MMIO in the WA BB and store it in the PPHSWP.

Using the above 2 instructions in a WA BB, capture active context
utilization.

v2: (Matt Brost)
- This breaks TDR, fix it by saving the CTX_TIMESTAMP register
  "drm/xe: Save CTX_TIMESTAMP mmio value instead of LRC value"
- Drop tile from LRC if using gt
  "drm/xe: Save the gt pointer in LRC and drop the tile"

v3:
- Remove helpers for bb_per_ctx_ptr (Matt)
- Add define for context active value (Matt)
- Use 64 bit CTX TIMESTAMP for platforms that support it. For platforms
  that don't, live with the rare race. (Matt, Lucas)
- Convert engine id to hwe and get the MMIO value (Lucas)
- Correct commit message on when WA BB runs (Lucas)

v4:
- s/GRAPHICS_VER(...)/xe->info.has_64bit_timestamp/ (Matt)
- Drop support for active utilization on a VF (CI failure)
- In xe_lrc_init ensure the lrc value is 0 to begin with (CI regression)

v5:
- Minor checkpatch fix
- Squash into previous commit and make TDR use 32-bit time
- Update code comment to match commit msg

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4532
Cc: <stable@vger.kernel.org> # v6.13+
Suggested-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://lore.kernel.org/r/20250509161159.2173069-8-umesh.nerlige.ramappa@intel.com
(cherry picked from commit 82b98cadb01f63cdb159e596ec06866d00f8e8c7)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/regs/xe_engine_regs.h b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
index fb8ec317b6ee..891f928d80ce 100644
--- a/drivers/gpu/drm/xe/regs/xe_engine_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
@@ -43,6 +43,10 @@
 #define XEHPC_BCS8_RING_BASE			0x3ee000
 #define GSCCS_RING_BASE				0x11a000
 
+#define ENGINE_ID(base)				XE_REG((base) + 0x8c)
+#define   ENGINE_INSTANCE_ID			REG_GENMASK(9, 4)
+#define   ENGINE_CLASS_ID			REG_GENMASK(2, 0)
+
 #define RING_TAIL(base)				XE_REG((base) + 0x30)
 #define   TAIL_ADDR				REG_GENMASK(20, 3)
 
@@ -154,6 +158,7 @@
 #define   STOP_RING				REG_BIT(8)
 
 #define RING_CTX_TIMESTAMP(base)		XE_REG((base) + 0x3a8)
+#define RING_CTX_TIMESTAMP_UDW(base)		XE_REG((base) + 0x3ac)
 #define CSBE_DEBUG_STATUS(base)			XE_REG((base) + 0x3fc)
 
 #define RING_FORCE_TO_NONPRIV(base, i)		XE_REG(((base) + 0x4d0) + (i) * 4)
diff --git a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
index 57944f90bbf6..994af591a2e8 100644
--- a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
+++ b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
@@ -11,7 +11,9 @@
 #define CTX_RING_TAIL			(0x06 + 1)
 #define CTX_RING_START			(0x08 + 1)
 #define CTX_RING_CTL			(0x0a + 1)
+#define CTX_BB_PER_CTX_PTR		(0x12 + 1)
 #define CTX_TIMESTAMP			(0x22 + 1)
+#define CTX_TIMESTAMP_UDW		(0x24 + 1)
 #define CTX_INDIRECT_RING_STATE		(0x26 + 1)
 #define CTX_PDP0_UDW			(0x30 + 1)
 #define CTX_PDP0_LDW			(0x32 + 1)
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 9f8667ebba85..0482f26aa480 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -330,6 +330,8 @@ struct xe_device {
 		u8 has_sriov:1;
 		/** @info.has_usm: Device has unified shared memory support */
 		u8 has_usm:1;
+		/** @info.has_64bit_timestamp: Device supports 64-bit timestamps */
+		u8 has_64bit_timestamp:1;
 		/** @info.is_dgfx: is discrete device */
 		u8 is_dgfx:1;
 		/**
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 606922d9dd73..cd9b1c32f30f 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -830,7 +830,7 @@ void xe_exec_queue_update_run_ticks(struct xe_exec_queue *q)
 {
 	struct xe_device *xe = gt_to_xe(q->gt);
 	struct xe_lrc *lrc;
-	u32 old_ts, new_ts;
+	u64 old_ts, new_ts;
 	int idx;
 
 	/*
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 31bc2022bfc2..769781d577df 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -941,7 +941,7 @@ static bool check_timeout(struct xe_exec_queue *q, struct xe_sched_job *job)
 		return xe_sched_invalidate_job(job, 2);
 	}
 
-	ctx_timestamp = xe_lrc_ctx_timestamp(q->lrc[0]);
+	ctx_timestamp = lower_32_bits(xe_lrc_ctx_timestamp(q->lrc[0]));
 	ctx_job_timestamp = xe_lrc_ctx_job_timestamp(q->lrc[0]);
 
 	/*
diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 79b43fec4f79..03bfba696b37 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -24,6 +24,7 @@
 #include "xe_hw_fence.h"
 #include "xe_map.h"
 #include "xe_memirq.h"
+#include "xe_mmio.h"
 #include "xe_sriov.h"
 #include "xe_trace_lrc.h"
 #include "xe_vm.h"
@@ -650,6 +651,7 @@ u32 xe_lrc_pphwsp_offset(struct xe_lrc *lrc)
 #define LRC_START_SEQNO_PPHWSP_OFFSET (LRC_SEQNO_PPHWSP_OFFSET + 8)
 #define LRC_CTX_JOB_TIMESTAMP_OFFSET (LRC_START_SEQNO_PPHWSP_OFFSET + 8)
 #define LRC_PARALLEL_PPHWSP_OFFSET 2048
+#define LRC_ENGINE_ID_PPHWSP_OFFSET 2096
 #define LRC_PPHWSP_SIZE SZ_4K
 
 u32 xe_lrc_regs_offset(struct xe_lrc *lrc)
@@ -694,11 +696,21 @@ static inline u32 __xe_lrc_parallel_offset(struct xe_lrc *lrc)
 	return xe_lrc_pphwsp_offset(lrc) + LRC_PARALLEL_PPHWSP_OFFSET;
 }
 
+static inline u32 __xe_lrc_engine_id_offset(struct xe_lrc *lrc)
+{
+	return xe_lrc_pphwsp_offset(lrc) + LRC_ENGINE_ID_PPHWSP_OFFSET;
+}
+
 static u32 __xe_lrc_ctx_timestamp_offset(struct xe_lrc *lrc)
 {
 	return __xe_lrc_regs_offset(lrc) + CTX_TIMESTAMP * sizeof(u32);
 }
 
+static u32 __xe_lrc_ctx_timestamp_udw_offset(struct xe_lrc *lrc)
+{
+	return __xe_lrc_regs_offset(lrc) + CTX_TIMESTAMP_UDW * sizeof(u32);
+}
+
 static inline u32 __xe_lrc_indirect_ring_offset(struct xe_lrc *lrc)
 {
 	/* Indirect ring state page is at the very end of LRC */
@@ -726,8 +738,10 @@ DECL_MAP_ADDR_HELPERS(regs)
 DECL_MAP_ADDR_HELPERS(start_seqno)
 DECL_MAP_ADDR_HELPERS(ctx_job_timestamp)
 DECL_MAP_ADDR_HELPERS(ctx_timestamp)
+DECL_MAP_ADDR_HELPERS(ctx_timestamp_udw)
 DECL_MAP_ADDR_HELPERS(parallel)
 DECL_MAP_ADDR_HELPERS(indirect_ring)
+DECL_MAP_ADDR_HELPERS(engine_id)
 
 #undef DECL_MAP_ADDR_HELPERS
 
@@ -742,19 +756,38 @@ u32 xe_lrc_ctx_timestamp_ggtt_addr(struct xe_lrc *lrc)
 	return __xe_lrc_ctx_timestamp_ggtt_addr(lrc);
 }
 
+/**
+ * xe_lrc_ctx_timestamp_udw_ggtt_addr() - Get ctx timestamp udw GGTT address
+ * @lrc: Pointer to the lrc.
+ *
+ * Returns: ctx timestamp udw GGTT address
+ */
+u32 xe_lrc_ctx_timestamp_udw_ggtt_addr(struct xe_lrc *lrc)
+{
+	return __xe_lrc_ctx_timestamp_udw_ggtt_addr(lrc);
+}
+
 /**
  * xe_lrc_ctx_timestamp() - Read ctx timestamp value
  * @lrc: Pointer to the lrc.
  *
  * Returns: ctx timestamp value
  */
-u32 xe_lrc_ctx_timestamp(struct xe_lrc *lrc)
+u64 xe_lrc_ctx_timestamp(struct xe_lrc *lrc)
 {
 	struct xe_device *xe = lrc_to_xe(lrc);
 	struct iosys_map map;
+	u32 ldw, udw = 0;
 
 	map = __xe_lrc_ctx_timestamp_map(lrc);
-	return xe_map_read32(xe, &map);
+	ldw = xe_map_read32(xe, &map);
+
+	if (xe->info.has_64bit_timestamp) {
+		map = __xe_lrc_ctx_timestamp_udw_map(lrc);
+		udw = xe_map_read32(xe, &map);
+	}
+
+	return (u64)udw << 32 | ldw;
 }
 
 /**
@@ -877,6 +910,65 @@ static void xe_lrc_finish(struct xe_lrc *lrc)
 	xe_bo_unpin(lrc->bo);
 	xe_bo_unlock(lrc->bo);
 	xe_bo_put(lrc->bo);
+	xe_bo_unpin_map_no_vm(lrc->bb_per_ctx_bo);
+}
+
+/*
+ * xe_lrc_setup_utilization() - Setup wa bb to assist in calculating active
+ * context run ticks.
+ * @lrc: Pointer to the lrc.
+ *
+ * Context Timestamp (CTX_TIMESTAMP) in the LRC accumulates the run ticks of the
+ * context, but only gets updated when the context switches out. In order to
+ * check how long a context has been active before it switches out, two things
+ * are required:
+ *
+ * (1) Determine if the context is running:
+ * To do so, we program the WA BB to set an initial value for CTX_TIMESTAMP in
+ * the LRC. The value chosen is 1 since 0 is the initial value when the LRC is
+ * initialized. During a query, we just check for this value to determine if the
+ * context is active. If the context switched out, it would overwrite this
+ * location with the actual CTX_TIMESTAMP MMIO value. Note that WA BB runs as
+ * the last part of context restore, so reusing this LRC location will not
+ * clobber anything.
+ *
+ * (2) Calculate the time that the context has been active for:
+ * The CTX_TIMESTAMP ticks only when the context is active. If a context is
+ * active, we just use the CTX_TIMESTAMP MMIO as the new value of utilization.
+ * While doing so, we need to read the CTX_TIMESTAMP MMIO for the specific
+ * engine instance. Since we do not know which instance the context is running
+ * on until it is scheduled, we also read the ENGINE_ID MMIO in the WA BB and
+ * store it in the PPHSWP.
+ */
+#define CONTEXT_ACTIVE 1ULL
+static void xe_lrc_setup_utilization(struct xe_lrc *lrc)
+{
+	u32 *cmd;
+
+	cmd = lrc->bb_per_ctx_bo->vmap.vaddr;
+
+	*cmd++ = MI_STORE_REGISTER_MEM | MI_SRM_USE_GGTT | MI_SRM_ADD_CS_OFFSET;
+	*cmd++ = ENGINE_ID(0).addr;
+	*cmd++ = __xe_lrc_engine_id_ggtt_addr(lrc);
+	*cmd++ = 0;
+
+	*cmd++ = MI_STORE_DATA_IMM | MI_SDI_GGTT | MI_SDI_NUM_DW(1);
+	*cmd++ = __xe_lrc_ctx_timestamp_ggtt_addr(lrc);
+	*cmd++ = 0;
+	*cmd++ = lower_32_bits(CONTEXT_ACTIVE);
+
+	if (lrc_to_xe(lrc)->info.has_64bit_timestamp) {
+		*cmd++ = MI_STORE_DATA_IMM | MI_SDI_GGTT | MI_SDI_NUM_DW(1);
+		*cmd++ = __xe_lrc_ctx_timestamp_udw_ggtt_addr(lrc);
+		*cmd++ = 0;
+		*cmd++ = upper_32_bits(CONTEXT_ACTIVE);
+	}
+
+	*cmd++ = MI_BATCH_BUFFER_END;
+
+	xe_lrc_write_ctx_reg(lrc, CTX_BB_PER_CTX_PTR,
+			     xe_bo_ggtt_addr(lrc->bb_per_ctx_bo) | 1);
+
 }
 
 #define PVC_CTX_ASID		(0x2e + 1)
@@ -893,6 +985,7 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_hw_engine *hwe,
 	void *init_data = NULL;
 	u32 arb_enable;
 	u32 lrc_size;
+	u32 bo_flags;
 	int err;
 
 	kref_init(&lrc->refcount);
@@ -902,22 +995,30 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_hw_engine *hwe,
 	if (xe_gt_has_indirect_ring_state(gt))
 		lrc->flags |= XE_LRC_FLAG_INDIRECT_RING_STATE;
 
+	bo_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) | XE_BO_FLAG_GGTT |
+		   XE_BO_FLAG_GGTT_INVALIDATE;
+
 	/*
 	 * FIXME: Perma-pinning LRC as we don't yet support moving GGTT address
 	 * via VM bind calls.
 	 */
 	lrc->bo = xe_bo_create_pin_map(xe, tile, vm, lrc_size,
 				       ttm_bo_type_kernel,
-				       XE_BO_FLAG_VRAM_IF_DGFX(tile) |
-				       XE_BO_FLAG_GGTT |
-				       XE_BO_FLAG_GGTT_INVALIDATE);
+				       bo_flags);
 	if (IS_ERR(lrc->bo))
 		return PTR_ERR(lrc->bo);
 
+	lrc->bb_per_ctx_bo = xe_bo_create_pin_map(xe, tile, NULL, SZ_4K,
+						  ttm_bo_type_kernel,
+						  bo_flags);
+	if (IS_ERR(lrc->bb_per_ctx_bo)) {
+		err = PTR_ERR(lrc->bb_per_ctx_bo);
+		goto err_lrc_finish;
+	}
+
 	lrc->size = lrc_size;
 	lrc->ring.size = ring_size;
 	lrc->ring.tail = 0;
-	lrc->ctx_timestamp = 0;
 
 	xe_hw_fence_ctx_init(&lrc->fence_ctx, hwe->gt,
 			     hwe->fence_irq, hwe->name);
@@ -990,7 +1091,10 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_hw_engine *hwe,
 				     xe_lrc_read_ctx_reg(lrc, CTX_CONTEXT_CONTROL) |
 				     _MASKED_BIT_ENABLE(CTX_CTRL_PXP_ENABLE));
 
+	lrc->ctx_timestamp = 0;
 	xe_lrc_write_ctx_reg(lrc, CTX_TIMESTAMP, 0);
+	if (lrc_to_xe(lrc)->info.has_64bit_timestamp)
+		xe_lrc_write_ctx_reg(lrc, CTX_TIMESTAMP_UDW, 0);
 
 	if (xe->info.has_asid && vm)
 		xe_lrc_write_ctx_reg(lrc, PVC_CTX_ASID, vm->usm.asid);
@@ -1019,6 +1123,8 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_hw_engine *hwe,
 	map = __xe_lrc_start_seqno_map(lrc);
 	xe_map_write32(lrc_to_xe(lrc), &map, lrc->fence_ctx.next_seqno - 1);
 
+	xe_lrc_setup_utilization(lrc);
+
 	return 0;
 
 err_lrc_finish:
@@ -1238,6 +1344,21 @@ struct iosys_map xe_lrc_parallel_map(struct xe_lrc *lrc)
 	return __xe_lrc_parallel_map(lrc);
 }
 
+/**
+ * xe_lrc_engine_id() - Read engine id value
+ * @lrc: Pointer to the lrc.
+ *
+ * Returns: context id value
+ */
+static u32 xe_lrc_engine_id(struct xe_lrc *lrc)
+{
+	struct xe_device *xe = lrc_to_xe(lrc);
+	struct iosys_map map;
+
+	map = __xe_lrc_engine_id_map(lrc);
+	return xe_map_read32(xe, &map);
+}
+
 static int instr_dw(u32 cmd_header)
 {
 	/* GFXPIPE "SINGLE_DW" opcodes are a single dword */
@@ -1684,7 +1805,7 @@ struct xe_lrc_snapshot *xe_lrc_snapshot_capture(struct xe_lrc *lrc)
 	snapshot->lrc_offset = xe_lrc_pphwsp_offset(lrc);
 	snapshot->lrc_size = lrc->bo->size - snapshot->lrc_offset;
 	snapshot->lrc_snapshot = NULL;
-	snapshot->ctx_timestamp = xe_lrc_ctx_timestamp(lrc);
+	snapshot->ctx_timestamp = lower_32_bits(xe_lrc_ctx_timestamp(lrc));
 	snapshot->ctx_job_timestamp = xe_lrc_ctx_job_timestamp(lrc);
 	return snapshot;
 }
@@ -1784,22 +1905,74 @@ void xe_lrc_snapshot_free(struct xe_lrc_snapshot *snapshot)
 	kfree(snapshot);
 }
 
+static int get_ctx_timestamp(struct xe_lrc *lrc, u32 engine_id, u64 *reg_ctx_ts)
+{
+	u16 class = REG_FIELD_GET(ENGINE_CLASS_ID, engine_id);
+	u16 instance = REG_FIELD_GET(ENGINE_INSTANCE_ID, engine_id);
+	struct xe_hw_engine *hwe;
+	u64 val;
+
+	hwe = xe_gt_hw_engine(lrc->gt, class, instance, false);
+	if (xe_gt_WARN_ONCE(lrc->gt, !hwe || xe_hw_engine_is_reserved(hwe),
+			    "Unexpected engine class:instance %d:%d for context utilization\n",
+			    class, instance))
+		return -1;
+
+	if (lrc_to_xe(lrc)->info.has_64bit_timestamp)
+		val = xe_mmio_read64_2x32(&hwe->gt->mmio,
+					  RING_CTX_TIMESTAMP(hwe->mmio_base));
+	else
+		val = xe_mmio_read32(&hwe->gt->mmio,
+				     RING_CTX_TIMESTAMP(hwe->mmio_base));
+
+	*reg_ctx_ts = val;
+
+	return 0;
+}
+
 /**
  * xe_lrc_update_timestamp() - Update ctx timestamp
  * @lrc: Pointer to the lrc.
  * @old_ts: Old timestamp value
  *
  * Populate @old_ts current saved ctx timestamp, read new ctx timestamp and
- * update saved value.
+ * update saved value. With support for active contexts, the calculation may be
+ * slightly racy, so follow a read-again logic to ensure that the context is
+ * still active before returning the right timestamp.
  *
  * Returns: New ctx timestamp value
  */
-u32 xe_lrc_update_timestamp(struct xe_lrc *lrc, u32 *old_ts)
+u64 xe_lrc_update_timestamp(struct xe_lrc *lrc, u64 *old_ts)
 {
+	u64 lrc_ts, reg_ts;
+	u32 engine_id;
+
 	*old_ts = lrc->ctx_timestamp;
 
-	lrc->ctx_timestamp = xe_lrc_ctx_timestamp(lrc);
+	lrc_ts = xe_lrc_ctx_timestamp(lrc);
+	/* CTX_TIMESTAMP mmio read is invalid on VF, so return the LRC value */
+	if (IS_SRIOV_VF(lrc_to_xe(lrc))) {
+		lrc->ctx_timestamp = lrc_ts;
+		goto done;
+	}
 
+	if (lrc_ts == CONTEXT_ACTIVE) {
+		engine_id = xe_lrc_engine_id(lrc);
+		if (!get_ctx_timestamp(lrc, engine_id, &reg_ts))
+			lrc->ctx_timestamp = reg_ts;
+
+		/* read lrc again to ensure context is still active */
+		lrc_ts = xe_lrc_ctx_timestamp(lrc);
+	}
+
+	/*
+	 * If context switched out, just use the lrc_ts. Note that this needs to
+	 * be a separate if condition.
+	 */
+	if (lrc_ts != CONTEXT_ACTIVE)
+		lrc->ctx_timestamp = lrc_ts;
+
+done:
 	trace_xe_lrc_update_timestamp(lrc, *old_ts);
 
 	return lrc->ctx_timestamp;
diff --git a/drivers/gpu/drm/xe/xe_lrc.h b/drivers/gpu/drm/xe/xe_lrc.h
index 0b40f349ab95..eb6e8de8c939 100644
--- a/drivers/gpu/drm/xe/xe_lrc.h
+++ b/drivers/gpu/drm/xe/xe_lrc.h
@@ -120,7 +120,8 @@ void xe_lrc_snapshot_print(struct xe_lrc_snapshot *snapshot, struct drm_printer
 void xe_lrc_snapshot_free(struct xe_lrc_snapshot *snapshot);
 
 u32 xe_lrc_ctx_timestamp_ggtt_addr(struct xe_lrc *lrc);
-u32 xe_lrc_ctx_timestamp(struct xe_lrc *lrc);
+u32 xe_lrc_ctx_timestamp_udw_ggtt_addr(struct xe_lrc *lrc);
+u64 xe_lrc_ctx_timestamp(struct xe_lrc *lrc);
 u32 xe_lrc_ctx_job_timestamp_ggtt_addr(struct xe_lrc *lrc);
 u32 xe_lrc_ctx_job_timestamp(struct xe_lrc *lrc);
 
@@ -136,6 +137,6 @@ u32 xe_lrc_ctx_job_timestamp(struct xe_lrc *lrc);
  *
  * Returns the current LRC timestamp
  */
-u32 xe_lrc_update_timestamp(struct xe_lrc *lrc, u32 *old_ts);
+u64 xe_lrc_update_timestamp(struct xe_lrc *lrc, u64 *old_ts);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_lrc_types.h b/drivers/gpu/drm/xe/xe_lrc_types.h
index cd38586ae989..ae24cf6f8dd9 100644
--- a/drivers/gpu/drm/xe/xe_lrc_types.h
+++ b/drivers/gpu/drm/xe/xe_lrc_types.h
@@ -52,7 +52,10 @@ struct xe_lrc {
 	struct xe_hw_fence_ctx fence_ctx;
 
 	/** @ctx_timestamp: readout value of CTX_TIMESTAMP on last update */
-	u32 ctx_timestamp;
+	u64 ctx_timestamp;
+
+	/** @bb_per_ctx_bo: buffer object for per context batch wa buffer */
+	struct xe_bo *bb_per_ctx_bo;
 };
 
 struct xe_lrc_snapshot;
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 818f023166d5..f4d108dc49b1 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -140,6 +140,7 @@ static const struct xe_graphics_desc graphics_xelpg = {
 	.has_indirect_ring_state = 1, \
 	.has_range_tlb_invalidation = 1, \
 	.has_usm = 1, \
+	.has_64bit_timestamp = 1, \
 	.va_bits = 48, \
 	.vm_max_level = 4, \
 	.hw_engine_mask = \
@@ -668,6 +669,7 @@ static int xe_info_init(struct xe_device *xe,
 
 	xe->info.has_range_tlb_invalidation = graphics_desc->has_range_tlb_invalidation;
 	xe->info.has_usm = graphics_desc->has_usm;
+	xe->info.has_64bit_timestamp = graphics_desc->has_64bit_timestamp;
 
 	for_each_remote_tile(tile, xe, id) {
 		int err;
diff --git a/drivers/gpu/drm/xe/xe_pci_types.h b/drivers/gpu/drm/xe/xe_pci_types.h
index e9b9bbc138d3..ca6b10d35573 100644
--- a/drivers/gpu/drm/xe/xe_pci_types.h
+++ b/drivers/gpu/drm/xe/xe_pci_types.h
@@ -21,6 +21,7 @@ struct xe_graphics_desc {
 	u8 has_indirect_ring_state:1;
 	u8 has_range_tlb_invalidation:1;
 	u8 has_usm:1;
+	u8 has_64bit_timestamp:1;
 };
 
 struct xe_media_desc {
diff --git a/drivers/gpu/drm/xe/xe_trace_lrc.h b/drivers/gpu/drm/xe/xe_trace_lrc.h
index 5c669a0b2180..d525cbee1e34 100644
--- a/drivers/gpu/drm/xe/xe_trace_lrc.h
+++ b/drivers/gpu/drm/xe/xe_trace_lrc.h
@@ -19,12 +19,12 @@
 #define __dev_name_lrc(lrc)	dev_name(gt_to_xe((lrc)->fence_ctx.gt)->drm.dev)
 
 TRACE_EVENT(xe_lrc_update_timestamp,
-	    TP_PROTO(struct xe_lrc *lrc, uint32_t old),
+	    TP_PROTO(struct xe_lrc *lrc, uint64_t old),
 	    TP_ARGS(lrc, old),
 	    TP_STRUCT__entry(
 		     __field(struct xe_lrc *, lrc)
-		     __field(u32, old)
-		     __field(u32, new)
+		     __field(u64, old)
+		     __field(u64, new)
 		     __string(name, lrc->fence_ctx.name)
 		     __string(device_id, __dev_name_lrc(lrc))
 	    ),
@@ -36,7 +36,7 @@ TRACE_EVENT(xe_lrc_update_timestamp,
 		   __assign_str(name);
 		   __assign_str(device_id);
 		   ),
-	    TP_printk("lrc=:%p lrc->name=%s old=%u new=%u device_id:%s",
+	    TP_printk("lrc=:%p lrc->name=%s old=%llu new=%llu device_id:%s",
 		      __entry->lrc, __get_str(name),
 		      __entry->old, __entry->new,
 		      __get_str(device_id))


