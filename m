Return-Path: <stable+bounces-28536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C539388586F
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 12:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DD31F224BE
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA76A59151;
	Thu, 21 Mar 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFTXuGPW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971658AC0
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021063; cv=none; b=eFThZL6DCu6yGnJHXUERmOQOZP08z0k+M2PySp5QLBmPCOGXPqLzhQyShoDQvxdW+qsb9qnS6MRiDgeWZdNerpi4kvmaUCj/NiDoErBgPcOHJoqFXlXob8mq6mjl4ejd3LZlXEsVgewK5Lip2R/PO5tWBTbhhKyFZQmeTnlRZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021063; c=relaxed/simple;
	bh=UoiS4tT5T2Z1seeS+HeBnQ01mNYMkgnqf699qHypV8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpB1R8Ck8ryEWTlMXNEL0fBK7CXPVqhVsD7qtj/3Bk6eU05N3ZxdBzj9IdfOD87IFgQJRsvscEE5YeiJt7f32ojacrxtRCQhMPJAAwutrkLgO9Rxuz/m8skrUxmkkXDjA2dXMEG1FvrohAzZXcqFolhZOJ0cjy38In16HzPRZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFTXuGPW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711021062; x=1742557062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UoiS4tT5T2Z1seeS+HeBnQ01mNYMkgnqf699qHypV8g=;
  b=DFTXuGPWxwzo7q9W29uGzMTaEA/vEwxBIEeJFop52HmE8NyoAV2FeMAZ
   D7LEBfz82wmsANZkdPMBXLJGrqy6vJHFW8Syn9pOantyW3XqRD2cH7Ihy
   77jGY3CiiPAp8h/J/HDUFpd5H4lxcHN0f7RyD+nX6uKbBgBUlLl9sQSXi
   vHP+UkoUinhXt+VaRTO0OIckekyvQU/hIslHSl9dKMdtcYYd4KuOIRVIw
   tbB16LRCakag0eONObnbwwlK9rBT8urgR0oeCbr9kOWII6SBKyLiu/Rjo
   maEmvAleyKKn1xW71pKypVia5ZUwpkM4BuxedHqMc5tTZUywSSs35S2Sy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127345"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127345"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="19053259"
Received: from dinieasx-mobl1.gar.corp.intel.com (HELO fedora..) ([10.249.254.100])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:37:40 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] drm/xe: Use ring ops TLB invalidation for rebinds
Date: Thu, 21 Mar 2024 12:37:13 +0100
Message-ID: <20240321113720.120865-5-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
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

Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after rebinds issued from execs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue_types.h |  2 ++
 drivers/gpu/drm/xe/xe_pt.c               |  5 +++--
 drivers/gpu/drm/xe/xe_ring_ops.c         | 11 ++++-------
 drivers/gpu/drm/xe/xe_sched_job.c        | 11 +++++++++++
 drivers/gpu/drm/xe/xe_sched_job_types.h  |  2 ++
 drivers/gpu/drm/xe/xe_vm_types.h         |  5 +++++
 6 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index 62b3d9d1d7cd..891ad30e906f 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -148,6 +148,8 @@ struct xe_exec_queue {
 	const struct xe_ring_ops *ring_ops;
 	/** @entity: DRM sched entity for this exec queue (1 to 1 relationship) */
 	struct drm_sched_entity *entity;
+	/** @tlb_flush_seqno: The seqno of the last rebind tlb flush performed */
+	u64 tlb_flush_seqno;
 	/** @lrc: logical ring context for this exec queue */
 	struct xe_lrc lrc[];
 };
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index a5bb8d20f815..109c26e5689e 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1253,11 +1253,12 @@ __xe_pt_bind_vma(struct xe_tile *tile, struct xe_vma *vma, struct xe_exec_queue
 	 * non-faulting LR, in particular on user-space batch buffer chaining,
 	 * it needs to be done here.
 	 */
-	if ((rebind && !xe_vm_in_lr_mode(vm) && !vm->batch_invalidate_tlb) ||
-	    (!rebind && xe_vm_has_scratch(vm) && xe_vm_in_preempt_fence_mode(vm))) {
+	if ((!rebind && xe_vm_has_scratch(vm) && xe_vm_in_preempt_fence_mode(vm))) {
 		ifence = kzalloc(sizeof(*ifence), GFP_KERNEL);
 		if (!ifence)
 			return ERR_PTR(-ENOMEM);
+	} else if (rebind && !xe_vm_in_lr_mode(vm) && !vm->batch_invalidate_tlb) {
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
index 8151ddafb940..d55458d915a9 100644
--- a/drivers/gpu/drm/xe/xe_sched_job.c
+++ b/drivers/gpu/drm/xe/xe_sched_job.c
@@ -250,6 +250,17 @@ bool xe_sched_job_completed(struct xe_sched_job *job)
 
 void xe_sched_job_arm(struct xe_sched_job *job)
 {
+	struct xe_exec_queue *q = job->q;
+	struct xe_vm *vm = q->vm;
+
+	if (vm && !xe_sched_job_is_migration(q) && !xe_vm_in_lr_mode(vm) &&
+	    vm->tlb_flush_seqno != q->tlb_flush_seqno) {
+		q->tlb_flush_seqno = vm->tlb_flush_seqno;
+		job->ring_ops_flush_tlb = true;
+	} else if (vm && vm->batch_invalidate_tlb) {
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


