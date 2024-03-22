Return-Path: <stable+bounces-28598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8299C8868C7
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 10:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1F4285232
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F01B819;
	Fri, 22 Mar 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQfYLmF+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245D199AD
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098149; cv=none; b=DW7uzcYefhc/oNA7YKRP2Al6Jfv7oTZBVi1jJypRayKwu0PQDWX1necVwewYHZQugmd/dv+RrC2Ge/xops9gHO3Y5UEernMhTN5km5aaWa5ag9R3uMCktmVs9oolKbNyCD968B0ZRPmaQezXReSTPPt0lX0GTiFXHyMXOGEQ8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098149; c=relaxed/simple;
	bh=8SQTCg/z0PXPCqninK66jaMkpzhSOMUYUgeULvUmpLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhVWstb8tquAU6WPBKD3uk1DHwLl3lCi7UXSQiBbjLGn1EmfqU172q/Wl9sylABfgrx47/fOce6NBMe0iTWgGONjWWm5f2RyqoJICms8pdlmWSY73HPsAuATQ8pUyYutX9BdLyZM8uoDIDYCqwoKER/6mlefKskXccxNMxmmrcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQfYLmF+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711098147; x=1742634147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8SQTCg/z0PXPCqninK66jaMkpzhSOMUYUgeULvUmpLM=;
  b=GQfYLmF+cqRUwuEs48d+2FUziSRpUUL+kyPUdK3DWlf8NSSrSiQPyup/
   MODqksO9mz/vaXWlabJMaFNra0XPlxo9dS689yUP2+IE50XW/3628w78E
   tLTWEy654Q4pRii9ClSFSETjP7ar+Z0fTAHH1swA6abL7rxrj3JPlSvI5
   +V1FG6TFBuoXbuUXDWNF6q4zbdCVTkX6a45ZgSNn2IygADSbZD2dw2x6U
   hXpvBsBPWZpaUVZ/9Y0AueDvBuTWpBpteeaCD9Ho8UF7aPoQa4Z7HOHW9
   qjCj8jlXHNPRzc6/H6togcDdtqRGkQvI3fWoqjX+NykVvW/JBrkvBilxE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9087167"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="9087167"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="15238770"
Received: from ettammin-desk.ger.corp.intel.com (HELO fedora..) ([10.249.254.178])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:02:26 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/7] drm/xe: Use ring ops TLB invalidation for rebinds
Date: Fri, 22 Mar 2024 10:02:07 +0100
Message-ID: <20240322090213.6091-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322090213.6091-1-thomas.hellstrom@linux.intel.com>
References: <20240322090213.6091-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For each rebind we insert a GuC TLB invalidation and add a
corresponding unordered TLB invalidation fence. This might
add a huge number of TLB invalidation fences to wait for so
rather than doing that, defer the TLB invalidation to the
next ring ops for each affected exec queue. Since the TLB
is invalidated on exec_queue switch, we need to invalidate
once for each affected exec_queue.

v2:
- Simplify if-statements around the tlb_flush_seqno.
  (Matthew Brost)
- Add some comments and asserts.

Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after rebinds issued from execs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue_types.h |  5 +++++
 drivers/gpu/drm/xe/xe_pt.c               |  6 ++++--
 drivers/gpu/drm/xe/xe_ring_ops.c         | 11 ++++-------
 drivers/gpu/drm/xe/xe_sched_job.c        | 10 ++++++++++
 drivers/gpu/drm/xe/xe_sched_job_types.h  |  2 ++
 drivers/gpu/drm/xe/xe_vm_types.h         |  5 +++++
 6 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index 62b3d9d1d7cd..462b33195032 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -148,6 +148,11 @@ struct xe_exec_queue {
 	const struct xe_ring_ops *ring_ops;
 	/** @entity: DRM sched entity for this exec queue (1 to 1 relationship) */
 	struct drm_sched_entity *entity;
+	/**
+	 * @tlb_flush_seqno: The seqno of the last rebind tlb flush performed
+	 * Protected by @vm's resv. Unused if @vm == NULL.
+	 */
+	u64 tlb_flush_seqno;
 	/** @lrc: logical ring context for this exec queue */
 	struct xe_lrc lrc[];
 };
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 8d3922d2206e..37117752cfc9 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1254,11 +1254,13 @@ __xe_pt_bind_vma(struct xe_tile *tile, struct xe_vma *vma, struct xe_exec_queue
 	 * non-faulting LR, in particular on user-space batch buffer chaining,
 	 * it needs to be done here.
 	 */
-	if ((rebind && !xe_vm_in_lr_mode(vm) && !vm->batch_invalidate_tlb) ||
-	    (!rebind && xe_vm_has_scratch(vm) && xe_vm_in_preempt_fence_mode(vm))) {
+	if ((!rebind && xe_vm_has_scratch(vm) && xe_vm_in_preempt_fence_mode(vm))) {
 		ifence = kzalloc(sizeof(*ifence), GFP_KERNEL);
 		if (!ifence)
 			return ERR_PTR(-ENOMEM);
+	} else if (rebind && !xe_vm_in_lr_mode(vm)) {
+		/* We bump also if batch_invalidate_tlb is true */
+		vm->tlb_flush_seqno++;
 	}
 
 	rfence = kzalloc(sizeof(*rfence), GFP_KERNEL);
diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index c4edffcd4a32..5b2b37b59813 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -219,10 +219,9 @@ static void __emit_job_gen12_simple(struct xe_sched_job *job, struct xe_lrc *lrc
 {
 	u32 dw[MAX_JOB_SIZE_DW], i = 0;
 	u32 ppgtt_flag = get_ppgtt_flag(job);
-	struct xe_vm *vm = job->q->vm;
 	struct xe_gt *gt = job->q->gt;
 
-	if (vm && vm->batch_invalidate_tlb) {
+	if (job->ring_ops_flush_tlb) {
 		dw[i++] = preparser_disable(true);
 		i = emit_flush_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
 					seqno, true, dw, i);
@@ -270,7 +269,6 @@ static void __emit_job_gen12_video(struct xe_sched_job *job, struct xe_lrc *lrc,
 	struct xe_gt *gt = job->q->gt;
 	struct xe_device *xe = gt_to_xe(gt);
 	bool decode = job->q->class == XE_ENGINE_CLASS_VIDEO_DECODE;
-	struct xe_vm *vm = job->q->vm;
 
 	dw[i++] = preparser_disable(true);
 
@@ -282,13 +280,13 @@ static void __emit_job_gen12_video(struct xe_sched_job *job, struct xe_lrc *lrc,
 			i = emit_aux_table_inv(gt, VE0_AUX_INV, dw, i);
 	}
 
-	if (vm && vm->batch_invalidate_tlb)
+	if (job->ring_ops_flush_tlb)
 		i = emit_flush_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
 					seqno, true, dw, i);
 
 	dw[i++] = preparser_disable(false);
 
-	if (!vm || !vm->batch_invalidate_tlb)
+	if (!job->ring_ops_flush_tlb)
 		i = emit_store_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
 					seqno, dw, i);
 
@@ -317,7 +315,6 @@ static void __emit_job_gen12_render_compute(struct xe_sched_job *job,
 	struct xe_gt *gt = job->q->gt;
 	struct xe_device *xe = gt_to_xe(gt);
 	bool lacks_render = !(gt->info.engine_mask & XE_HW_ENGINE_RCS_MASK);
-	struct xe_vm *vm = job->q->vm;
 	u32 mask_flags = 0;
 
 	dw[i++] = preparser_disable(true);
@@ -327,7 +324,7 @@ static void __emit_job_gen12_render_compute(struct xe_sched_job *job,
 		mask_flags = PIPE_CONTROL_3D_ENGINE_FLAGS;
 
 	/* See __xe_pt_bind_vma() for a discussion on TLB invalidations. */
-	i = emit_pipe_invalidate(mask_flags, vm && vm->batch_invalidate_tlb, dw, i);
+	i = emit_pipe_invalidate(mask_flags, job->ring_ops_flush_tlb, dw, i);
 
 	/* hsdes: 1809175790 */
 	if (has_aux_ccs(xe))
diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
index 8151ddafb940..b0c7fa4693cf 100644
--- a/drivers/gpu/drm/xe/xe_sched_job.c
+++ b/drivers/gpu/drm/xe/xe_sched_job.c
@@ -250,6 +250,16 @@ bool xe_sched_job_completed(struct xe_sched_job *job)
 
 void xe_sched_job_arm(struct xe_sched_job *job)
 {
+	struct xe_exec_queue *q = job->q;
+	struct xe_vm *vm = q->vm;
+
+	if (vm && !xe_sched_job_is_migration(q) && !xe_vm_in_lr_mode(vm) &&
+	    (vm->batch_invalidate_tlb || vm->tlb_flush_seqno != q->tlb_flush_seqno)) {
+		xe_vm_assert_held(vm);
+		q->tlb_flush_seqno = vm->tlb_flush_seqno;
+		job->ring_ops_flush_tlb = true;
+	}
+
 	drm_sched_job_arm(&job->drm);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_sched_job_types.h b/drivers/gpu/drm/xe/xe_sched_job_types.h
index b1d83da50a53..5e12724219fd 100644
--- a/drivers/gpu/drm/xe/xe_sched_job_types.h
+++ b/drivers/gpu/drm/xe/xe_sched_job_types.h
@@ -39,6 +39,8 @@ struct xe_sched_job {
 	} user_fence;
 	/** @migrate_flush_flags: Additional flush flags for migration jobs */
 	u32 migrate_flush_flags;
+	/** @ring_ops_flush_tlb: The ring ops need to flush TLB before payload. */
+	bool ring_ops_flush_tlb;
 	/** @batch_addr: batch buffer address of job */
 	u64 batch_addr[];
 };
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index ae5fb565f6bf..5747f136d24d 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -264,6 +264,11 @@ struct xe_vm {
 		bool capture_once;
 	} error_capture;
 
+	/**
+	 * @tlb_flush_seqno: Required TLB flush seqno for the next exec.
+	 * protected by the vm resv.
+	 */
+	u64 tlb_flush_seqno;
 	/** @batch_invalidate_tlb: Always invalidate TLB before batch start */
 	bool batch_invalidate_tlb;
 	/** @xef: XE file handle for tracking this VM's drm client */
-- 
2.44.0


