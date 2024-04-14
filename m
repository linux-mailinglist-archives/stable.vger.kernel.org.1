Return-Path: <stable+bounces-37399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7489C4B0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A083F1C21099
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DEB71B3D;
	Mon,  8 Apr 2024 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0VyBeTWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B576A352;
	Mon,  8 Apr 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584119; cv=none; b=e/kJ16KjKnpaMCVE+LDCPsJrHfymuYNXgzj5KI7zH5I1yP+OgIFZ6f8jtE/o/GHsGME9UJFd5RY/6svYO3x0yjmBv0KqXfTtVN5F/NZ2OzFnlf70W8AODDsV4GqWcwEHgPQW12LBnWlTNBkJtK3ky10TxmF8EA81Vg8SpyXHmBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584119; c=relaxed/simple;
	bh=ZDPr7JPWDc9dBZxxn4STGVF+K9HJY6iq32jVLKgFw4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Db7MPvI/Y95YgHsIf/k7y9I74aB4uR1Dj6ZyHRC4r03Y9YzHyPreSKSglqzhwUCBx00ZtU/wAhVt8cg4QE44h3Fsf9omoPjHIkL2j1/tOh4ZscL+Nd82EiG73VxDs0Zo+oorJQ92TYyrAzpvrKgsw+BUHWTS3gJz8nvD+9ICvuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0VyBeTWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034ACC433F1;
	Mon,  8 Apr 2024 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584118;
	bh=ZDPr7JPWDc9dBZxxn4STGVF+K9HJY6iq32jVLKgFw4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0VyBeTWlPHUCkQuD6RzkFA1R/8OeNhxJ9OrpE8MLJf/TxdLYGv1QRLv2WWkrvfRun
	 C6azKu61+7d7PErIIQolcr+2GZC+t4hxl9Lh7mx3OAFVTTz5COF4ARBHz29qQh2Eoy
	 745t2DXt8lpO/EHdEJYPeNsTzM84LfTBRyL6YZ2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.8 264/273] drm/xe: Use ring ops TLB invalidation for rebinds
Date: Mon,  8 Apr 2024 14:58:59 +0200
Message-ID: <20240408125317.696497974@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit 3c88b8f471ee9512bc4ef02bebafdc53fb7c5d9e upstream.

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
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240327091136.3271-2-thomas.hellstrom@linux.intel.com
(cherry picked from commit 4fc4899e86f7afbd09f4bcb899f0fc57e0296e62)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_exec_queue_types.h |    5 +++++
 drivers/gpu/drm/xe/xe_pt.c               |    6 ++++--
 drivers/gpu/drm/xe/xe_ring_ops.c         |   11 ++++-------
 drivers/gpu/drm/xe/xe_sched_job.c        |   10 ++++++++++
 drivers/gpu/drm/xe/xe_sched_job_types.h  |    2 ++
 drivers/gpu/drm/xe/xe_vm_types.h         |    5 +++++
 6 files changed, 30 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -159,6 +159,11 @@ struct xe_exec_queue {
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
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1255,11 +1255,13 @@ __xe_pt_bind_vma(struct xe_tile *tile, s
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
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -227,10 +227,9 @@ static void __emit_job_gen12_simple(stru
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
@@ -278,7 +277,6 @@ static void __emit_job_gen12_video(struc
 	struct xe_gt *gt = job->q->gt;
 	struct xe_device *xe = gt_to_xe(gt);
 	bool decode = job->q->class == XE_ENGINE_CLASS_VIDEO_DECODE;
-	struct xe_vm *vm = job->q->vm;
 
 	dw[i++] = preparser_disable(true);
 
@@ -290,13 +288,13 @@ static void __emit_job_gen12_video(struc
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
 
@@ -325,7 +323,6 @@ static void __emit_job_gen12_render_comp
 	struct xe_gt *gt = job->q->gt;
 	struct xe_device *xe = gt_to_xe(gt);
 	bool lacks_render = !(gt->info.engine_mask & XE_HW_ENGINE_RCS_MASK);
-	struct xe_vm *vm = job->q->vm;
 	u32 mask_flags = 0;
 
 	dw[i++] = preparser_disable(true);
@@ -335,7 +332,7 @@ static void __emit_job_gen12_render_comp
 		mask_flags = PIPE_CONTROL_3D_ENGINE_FLAGS;
 
 	/* See __xe_pt_bind_vma() for a discussion on TLB invalidations. */
-	i = emit_pipe_invalidate(mask_flags, vm && vm->batch_invalidate_tlb, dw, i);
+	i = emit_pipe_invalidate(mask_flags, job->ring_ops_flush_tlb, dw, i);
 
 	/* hsdes: 1809175790 */
 	if (has_aux_ccs(xe))
--- a/drivers/gpu/drm/xe/xe_sched_job.c
+++ b/drivers/gpu/drm/xe/xe_sched_job.c
@@ -250,6 +250,16 @@ bool xe_sched_job_completed(struct xe_sc
 
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
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -282,6 +282,11 @@ struct xe_vm {
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



