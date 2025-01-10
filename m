Return-Path: <stable+bounces-108233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4F9A09CAB
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 21:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658F81887B4C
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918BE2147E3;
	Fri, 10 Jan 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JP6LzeX8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E002080CF
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736542429; cv=none; b=n+NM+/7/WGmOXwREXE8HMvN8mgr3Gvm25KVhGr7gEF+pBFWAdrVkrEtlYdhlhlK2L9gLXBH8GnzBdwazYywBt7g4zpAOy1S6MCwAu0GSRQsH+DQpvJ44LkLkcSUuVzvnUTAJfblMsyFQRShICRgBqEo9xVF+E/Ho6czGrIdmKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736542429; c=relaxed/simple;
	bh=TQPL+T66pHBo9X5YDIRhoT3GBS6plEQ10r9QmBOQoWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGIIq99B1Xd4buot+oLsSx8rh3gDFfFy6cEAEFeAnWNkWY3cAamlwmW837OqF6yVBOQuYLgg4XzngZUhbt51p802M53Ycqv8c91/991bEyKDtg/Bu42fWhWrYWPBzPvTOvUqMeOXA81RBVxaHJxQLGehNrn1taQU3rwa8xjy/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JP6LzeX8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736542428; x=1768078428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQPL+T66pHBo9X5YDIRhoT3GBS6plEQ10r9QmBOQoWI=;
  b=JP6LzeX8IwycLptmpQYOXcVs26fVknePyCMClWeqFQ3N6S/I0LOGbsWt
   UNdIlhny/cbQ4IvuA816f1pY4tcSj493ReFMudhjaLMOyiOUlhfVv0VRH
   K6VCcOLv9QHSFHMM6TQcMXXetFLHOrAqwiFki/AlcunZKl7KY6bS6Wuu8
   60dVEK3uMEUMLGitmHZ32xO3tvRT0aWkdgnRBf/ECacPToDdZE3S3oEmv
   BPSuRGruYRCclhzDeBMMwC5evrbHIjWUQ+nk161aqUsw00FXTiRGNGUJT
   gKs4ia5DpFOb/wL+aDhjhC/NObynxH3qE1p8w0Uf2s+pRRhxnLoraLzS3
   Q==;
X-CSE-ConnectionGUID: HGe0LAl2TZqkbvLrQP5I8g==
X-CSE-MsgGUID: E756kulIR2ev5TvWmJ3SiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="40531299"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="40531299"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 12:53:47 -0800
X-CSE-ConnectionGUID: rbJ9+4F+TvSCTilK1h27zQ==
X-CSE-MsgGUID: ffleEzQlQN2+fZAML3GdCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="134672114"
Received: from dut7231atsm.jf.intel.com ([10.75.202.213])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 12:53:47 -0800
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: stable@vger.kernel.org
Cc: ashutosh.dixit@intel.com
Subject: [PATCH 6.12.y] xe/oa: Fix query mode of operation for OAR/OAC
Date: Fri, 10 Jan 2025 12:53:41 -0800
Message-Id: <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025010650-tuesday-motivate-5cbb@gregkh>
References: <2025010650-tuesday-motivate-5cbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream

This is a set of squashed commits to facilitate smooth applying to
stable. Each commit message is retained for reference.

1) Allow a GGTT mapped batch to be submitted to user exec queue

For a OA use case, one of the HW registers needs to be modified by
submitting an MI_LOAD_REGISTER_IMM command to the users exec queue, so
that the register is modified in the user's hardware context. In order
to do this a batch that is mapped in GGTT, needs to be submitted to the
user exec queue. Since all user submissions use q->vm and hence PPGTT,
add some plumbing to enable submission of batches mapped in GGTT.

v2: ggtt is zero-initialized, so no need to set it false (Matt Brost)

2) xe/oa: Use MI_LOAD_REGISTER_IMMEDIATE to enable OAR/OAC

To enable OAR/OAC, a bit in RING_CONTEXT_CONTROL needs to be set.
Setting this bit cause the context image size to change and if not done
correct, can cause undesired hangs.

Current code uses a separate exec_queue to modify this bit and is
error-prone. As per HW recommendation, submit MI_LOAD_REGISTER_IMM to
the target hardware context to modify the relevant bit.

In v2 version, an attempt to submit everything to the user-queue was
made, but it failed the unprivileged-single-ctx-counters test. It
appears that the OACTXCONTROL must be modified from a remote context.

In v3 version, all context specific register configurations were moved
to use LOAD_REGISTER_IMMEDIATE and that seems to work well. This is a
cleaner way, since we can now submit all configuration to user
exec_queue and the fence handling is simplified.

v2:
(Matt)
- set job->ggtt to true if create job is successful
- unlock vm on job error

(Ashutosh)
- don't wait on job submission
- use kernel exec queue where possible

v3:
(Ashutosh)
- Fix checkpatch issues
- Remove extra spaces/new-lines
- Add Fixes: and Cc: tags
- Reset context control bit when OA stream is closed
- Submit all config via MI_LOAD_REGISTER_IMMEDIATE

(Umesh)
- Update commit message for v3 experiment
- Squash patches for easier port to stable

v4:
(Ashutosh)
- No need to pass q to xe_oa_submit_bb
- Do not support exec queues with width > 1
- Fix disabling of CTX_CTRL_OAC_CONTEXT_ENABLE

v5:
(Ashutosh)
- Drop reg_lri related comments
- Use XE_OA_SUBMIT_NO_DEPS in xe_oa_load_with_lri

v6:
Backport to linux-6.12.y (Umesh)

Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA stream close")
Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: stable@vger.kernel.org # 6.12+
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241220171919.571528-2-umesh.nerlige.ramappa@intel.com
(cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
(cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb56)
---
 drivers/gpu/drm/xe/xe_oa.c              | 124 +++++++++---------------
 drivers/gpu/drm/xe/xe_ring_ops.c        |   5 +-
 drivers/gpu/drm/xe/xe_sched_job_types.h |   2 +
 3 files changed, 51 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 78823f53d290..ddc3472a2506 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -63,12 +63,6 @@ struct xe_oa_config {
 	struct rcu_head rcu;
 };
 
-struct flex {
-	struct xe_reg reg;
-	u32 offset;
-	u32 value;
-};
-
 struct xe_oa_open_param {
 	u32 oa_unit_id;
 	bool sample;
@@ -567,24 +561,46 @@ static __poll_t xe_oa_poll(struct file *file, poll_table *wait)
 	return ret;
 }
 
+static void xe_oa_lock_vma(struct xe_exec_queue *q)
+{
+	if (q->vm) {
+		down_read(&q->vm->lock);
+		xe_vm_lock(q->vm, false);
+	}
+}
+
+static void xe_oa_unlock_vma(struct xe_exec_queue *q)
+{
+	if (q->vm) {
+		xe_vm_unlock(q->vm);
+		up_read(&q->vm->lock);
+	}
+}
+
 static int xe_oa_submit_bb(struct xe_oa_stream *stream, struct xe_bb *bb)
 {
+	struct xe_exec_queue *q = stream->exec_q ?: stream->k_exec_q;
 	struct xe_sched_job *job;
 	struct dma_fence *fence;
 	long timeout;
 	int err = 0;
 
-	/* Kernel configuration is issued on stream->k_exec_q, not stream->exec_q */
-	job = xe_bb_create_job(stream->k_exec_q, bb);
+	xe_oa_lock_vma(q);
+
+	job = xe_bb_create_job(q, bb);
 	if (IS_ERR(job)) {
 		err = PTR_ERR(job);
+		xe_oa_unlock_vma(q);
 		goto exit;
 	}
+	job->ggtt = true;
 
 	xe_sched_job_arm(job);
 	fence = dma_fence_get(&job->drm.s_fence->finished);
 	xe_sched_job_push(job);
 
+	xe_oa_unlock_vma(q);
+
 	timeout = dma_fence_wait_timeout(fence, false, HZ);
 	dma_fence_put(fence);
 	if (timeout < 0)
@@ -639,52 +655,18 @@ static void xe_oa_free_configs(struct xe_oa_stream *stream)
 		free_oa_config_bo(oa_bo);
 }
 
-static void xe_oa_store_flex(struct xe_oa_stream *stream, struct xe_lrc *lrc,
-			     struct xe_bb *bb, const struct flex *flex, u32 count)
-{
-	u32 offset = xe_bo_ggtt_addr(lrc->bo);
-
-	do {
-		bb->cs[bb->len++] = MI_STORE_DATA_IMM | MI_SDI_GGTT | MI_SDI_NUM_DW(1);
-		bb->cs[bb->len++] = offset + flex->offset * sizeof(u32);
-		bb->cs[bb->len++] = 0;
-		bb->cs[bb->len++] = flex->value;
-
-	} while (flex++, --count);
-}
-
-static int xe_oa_modify_ctx_image(struct xe_oa_stream *stream, struct xe_lrc *lrc,
-				  const struct flex *flex, u32 count)
-{
-	struct xe_bb *bb;
-	int err;
-
-	bb = xe_bb_new(stream->gt, 4 * count, false);
-	if (IS_ERR(bb)) {
-		err = PTR_ERR(bb);
-		goto exit;
-	}
-
-	xe_oa_store_flex(stream, lrc, bb, flex, count);
-
-	err = xe_oa_submit_bb(stream, bb);
-	xe_bb_free(bb, NULL);
-exit:
-	return err;
-}
-
-static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *reg_lri)
+static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *reg_lri, u32 count)
 {
 	struct xe_bb *bb;
 	int err;
 
-	bb = xe_bb_new(stream->gt, 3, false);
+	bb = xe_bb_new(stream->gt, 2 * count + 1, false);
 	if (IS_ERR(bb)) {
 		err = PTR_ERR(bb);
 		goto exit;
 	}
 
-	write_cs_mi_lri(bb, reg_lri, 1);
+	write_cs_mi_lri(bb, reg_lri, count);
 
 	err = xe_oa_submit_bb(stream, bb);
 	xe_bb_free(bb, NULL);
@@ -695,70 +677,54 @@ static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *re
 static int xe_oa_configure_oar_context(struct xe_oa_stream *stream, bool enable)
 {
 	const struct xe_oa_format *format = stream->oa_buffer.format;
-	struct xe_lrc *lrc = stream->exec_q->lrc[0];
-	u32 regs_offset = xe_lrc_regs_offset(lrc) / sizeof(u32);
 	u32 oacontrol = __format_to_oactrl(format, OAR_OACONTROL_COUNTER_SEL_MASK) |
 		(enable ? OAR_OACONTROL_COUNTER_ENABLE : 0);
 
-	struct flex regs_context[] = {
+	struct xe_oa_reg reg_lri[] = {
 		{
 			OACTXCONTROL(stream->hwe->mmio_base),
-			stream->oa->ctx_oactxctrl_offset[stream->hwe->class] + 1,
 			enable ? OA_COUNTER_RESUME : 0,
 		},
+		{
+			OAR_OACONTROL,
+			oacontrol,
+		},
 		{
 			RING_CONTEXT_CONTROL(stream->hwe->mmio_base),
-			regs_offset + CTX_CONTEXT_CONTROL,
-			_MASKED_BIT_ENABLE(CTX_CTRL_OAC_CONTEXT_ENABLE),
+			_MASKED_FIELD(CTX_CTRL_OAC_CONTEXT_ENABLE,
+				      enable ? CTX_CTRL_OAC_CONTEXT_ENABLE : 0)
 		},
 	};
-	struct xe_oa_reg reg_lri = { OAR_OACONTROL, oacontrol };
-	int err;
-
-	/* Modify stream hwe context image with regs_context */
-	err = xe_oa_modify_ctx_image(stream, stream->exec_q->lrc[0],
-				     regs_context, ARRAY_SIZE(regs_context));
-	if (err)
-		return err;
 
-	/* Apply reg_lri using LRI */
-	return xe_oa_load_with_lri(stream, &reg_lri);
+	return xe_oa_load_with_lri(stream, reg_lri, ARRAY_SIZE(reg_lri));
 }
 
 static int xe_oa_configure_oac_context(struct xe_oa_stream *stream, bool enable)
 {
 	const struct xe_oa_format *format = stream->oa_buffer.format;
-	struct xe_lrc *lrc = stream->exec_q->lrc[0];
-	u32 regs_offset = xe_lrc_regs_offset(lrc) / sizeof(u32);
 	u32 oacontrol = __format_to_oactrl(format, OAR_OACONTROL_COUNTER_SEL_MASK) |
 		(enable ? OAR_OACONTROL_COUNTER_ENABLE : 0);
-	struct flex regs_context[] = {
+	struct xe_oa_reg reg_lri[] = {
 		{
 			OACTXCONTROL(stream->hwe->mmio_base),
-			stream->oa->ctx_oactxctrl_offset[stream->hwe->class] + 1,
 			enable ? OA_COUNTER_RESUME : 0,
 		},
+		{
+			OAC_OACONTROL,
+			oacontrol
+		},
 		{
 			RING_CONTEXT_CONTROL(stream->hwe->mmio_base),
-			regs_offset + CTX_CONTEXT_CONTROL,
-			_MASKED_BIT_ENABLE(CTX_CTRL_OAC_CONTEXT_ENABLE) |
+			_MASKED_FIELD(CTX_CTRL_OAC_CONTEXT_ENABLE,
+				      enable ? CTX_CTRL_OAC_CONTEXT_ENABLE : 0) |
 			_MASKED_FIELD(CTX_CTRL_RUN_ALONE, enable ? CTX_CTRL_RUN_ALONE : 0),
 		},
 	};
-	struct xe_oa_reg reg_lri = { OAC_OACONTROL, oacontrol };
-	int err;
 
 	/* Set ccs select to enable programming of OAC_OACONTROL */
 	xe_mmio_write32(stream->gt, __oa_regs(stream)->oa_ctrl, __oa_ccs_select(stream));
 
-	/* Modify stream hwe context image with regs_context */
-	err = xe_oa_modify_ctx_image(stream, stream->exec_q->lrc[0],
-				     regs_context, ARRAY_SIZE(regs_context));
-	if (err)
-		return err;
-
-	/* Apply reg_lri using LRI */
-	return xe_oa_load_with_lri(stream, &reg_lri);
+	return xe_oa_load_with_lri(stream, reg_lri, ARRAY_SIZE(reg_lri));
 }
 
 static int xe_oa_configure_oa_context(struct xe_oa_stream *stream, bool enable)
@@ -1817,8 +1783,8 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 		if (XE_IOCTL_DBG(oa->xe, !param.exec_q))
 			return -ENOENT;
 
-		if (param.exec_q->width > 1)
-			drm_dbg(&oa->xe->drm, "exec_q->width > 1, programming only exec_q->lrc[0]\n");
+		if (XE_IOCTL_DBG(oa->xe, param.exec_q->width > 1))
+			return -EOPNOTSUPP;
 	}
 
 	/*
diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index 0be4f489d3e1..9f327f27c072 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -221,7 +221,10 @@ static int emit_pipe_imm_ggtt(u32 addr, u32 value, bool stall_only, u32 *dw,
 
 static u32 get_ppgtt_flag(struct xe_sched_job *job)
 {
-	return job->q->vm ? BIT(8) : 0;
+	if (job->q->vm && !job->ggtt)
+		return BIT(8);
+
+	return 0;
 }
 
 static int emit_copy_timestamp(struct xe_lrc *lrc, u32 *dw, int i)
diff --git a/drivers/gpu/drm/xe/xe_sched_job_types.h b/drivers/gpu/drm/xe/xe_sched_job_types.h
index 0d3f76fb05ce..c207361bf43e 100644
--- a/drivers/gpu/drm/xe/xe_sched_job_types.h
+++ b/drivers/gpu/drm/xe/xe_sched_job_types.h
@@ -57,6 +57,8 @@ struct xe_sched_job {
 	u32 migrate_flush_flags;
 	/** @ring_ops_flush_tlb: The ring ops need to flush TLB before payload. */
 	bool ring_ops_flush_tlb;
+	/** @ggtt: mapped in ggtt. */
+	bool ggtt;
 	/** @ptrs: per instance pointers. */
 	struct xe_job_ptrs ptrs[];
 };
-- 
2.34.1


