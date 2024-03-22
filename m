Return-Path: <stable+bounces-28599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0900D8868C8
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 10:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4AB1F255B2
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E51B95F;
	Fri, 22 Mar 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvWi++mM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356D1B7F1
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098150; cv=none; b=ap4itVOYUD5JwySglvfnyWPKZvWtuRD2Isz/YF4Rty97tKIECdLwZ9oNEHWIWmpLHX1Z1Km1ZULJFebmFxr6Goe2Ql0gzG7X+qWmN0OJiVbNXggviO1JP0/UZSDpA9vlpk29XUqD8s97k5T73u2TjMEEkwLj3HjI2igRwJyJV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098150; c=relaxed/simple;
	bh=P3AocF4DT9PnyX4yPjTrF0nVYVPOvKfT+qS74GsgM7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfqCkgpQNoHESz1wAQYXVe9U5pmLlGxZKgFx/xKUm2q8wI6h3NaSV/WCLAOHjxuI1FtM4g7ACBd2Y3ZOkMO4OA59CHto4/tqxenujTb2ZY6BgwQdGDqjjHvMJvLcMy914WNOZAgmOoxxgMkdNPRuj9qLTU1IZGdL4c6Dnx+8sqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvWi++mM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711098149; x=1742634149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P3AocF4DT9PnyX4yPjTrF0nVYVPOvKfT+qS74GsgM7U=;
  b=QvWi++mMu0eHRz1C1GQrjLH6UVuZm232mrTRBbTLt/1g/umsrImgtP42
   SivxztW/Y2NRMkJk8p4ykT0JYVumuAccgA2wjiQCMUFlKxnJn6OfedcUt
   Suqo/6xsipDq4UxhELMVphvO2+UrmCaCQmh9bmsXOULcRE0l3c2Chr1wA
   7mu6Psa4M+OSAEbJwmZ7kHRy0OjaDKWiKWfDh5ypELlM2AyIXyzeFIl6t
   O5bM/kylEgFhvlRVfQj5dOSKqK7yCegKgxcc7YfTy0RaCBLX7mXViBS6F
   +ulIoaONVLFe9eJcfiltdv4Bp0k6p36KwXKIFaXD8DCXmO+11mrkY7Ib0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9087170"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="9087170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="15238778"
Received: from ettammin-desk.ger.corp.intel.com (HELO fedora..) ([10.249.254.178])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:02:27 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/7] drm/xe: Rework rebinding
Date: Fri, 22 Mar 2024 10:02:08 +0100
Message-ID: <20240322090213.6091-3-thomas.hellstrom@linux.intel.com>
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

Instead of handling the vm's rebind fence separately,
which is error prone if they are not strictly ordered,
attach rebind fences as kernel fences to the vm's resv.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_exec.c     | 31 +++----------------------------
 drivers/gpu/drm/xe/xe_pt.c       |  2 +-
 drivers/gpu/drm/xe/xe_vm.c       | 27 +++++++++------------------
 drivers/gpu/drm/xe/xe_vm.h       |  2 +-
 drivers/gpu/drm/xe/xe_vm_types.h |  3 ---
 5 files changed, 14 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 7692ebfe7d47..759497d4a102 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -152,7 +152,6 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	struct drm_exec *exec = &vm_exec.exec;
 	u32 i, num_syncs = 0, num_ufence = 0;
 	struct xe_sched_job *job;
-	struct dma_fence *rebind_fence;
 	struct xe_vm *vm;
 	bool write_locked, skip_retry = false;
 	ktime_t end = 0;
@@ -294,35 +293,11 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	 * Rebind any invalidated userptr or evicted BOs in the VM, non-compute
 	 * VM mode only.
 	 */
-	rebind_fence = xe_vm_rebind(vm, false);
-	if (IS_ERR(rebind_fence)) {
-		err = PTR_ERR(rebind_fence);
+	err = xe_vm_rebind(vm, false);
+	if (err)
 		goto err_put_job;
-	}
-
-	/*
-	 * We store the rebind_fence in the VM so subsequent execs don't get
-	 * scheduled before the rebinds of userptrs / evicted BOs is complete.
-	 */
-	if (rebind_fence) {
-		dma_fence_put(vm->rebind_fence);
-		vm->rebind_fence = rebind_fence;
-	}
-	if (vm->rebind_fence) {
-		if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
-			     &vm->rebind_fence->flags)) {
-			dma_fence_put(vm->rebind_fence);
-			vm->rebind_fence = NULL;
-		} else {
-			dma_fence_get(vm->rebind_fence);
-			err = drm_sched_job_add_dependency(&job->drm,
-							   vm->rebind_fence);
-			if (err)
-				goto err_put_job;
-		}
-	}
 
-	/* Wait behind munmap style rebinds */
+	/* Wait behind rebinds */
 	if (!xe_vm_in_lr_mode(vm)) {
 		err = drm_sched_job_add_resv_dependencies(&job->drm,
 							  xe_vm_resv(vm),
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 37117752cfc9..632c1919471d 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1299,7 +1299,7 @@ __xe_pt_bind_vma(struct xe_tile *tile, struct xe_vma *vma, struct xe_exec_queue
 		}
 
 		/* add shared fence now for pagetable delayed destroy */
-		dma_resv_add_fence(xe_vm_resv(vm), fence, !rebind &&
+		dma_resv_add_fence(xe_vm_resv(vm), fence, rebind ||
 				   last_munmap_rebind ?
 				   DMA_RESV_USAGE_KERNEL :
 				   DMA_RESV_USAGE_BOOKKEEP);
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index e3692b7e1711..4cf49437bcd8 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -522,7 +522,6 @@ static void preempt_rebind_work_func(struct work_struct *w)
 {
 	struct xe_vm *vm = container_of(w, struct xe_vm, preempt.rebind_work);
 	struct drm_exec exec;
-	struct dma_fence *rebind_fence;
 	unsigned int fence_count = 0;
 	LIST_HEAD(preempt_fences);
 	ktime_t end = 0;
@@ -568,18 +567,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	if (err)
 		goto out_unlock;
 
-	rebind_fence = xe_vm_rebind(vm, true);
-	if (IS_ERR(rebind_fence)) {
-		err = PTR_ERR(rebind_fence);
+	err = xe_vm_rebind(vm, true);
+	if (err)
 		goto out_unlock;
-	}
-
-	if (rebind_fence) {
-		dma_fence_wait(rebind_fence, false);
-		dma_fence_put(rebind_fence);
-	}
 
-	/* Wait on munmap style VM unbinds */
+	/* Wait on rebinds and munmap style VM unbinds */
 	wait = dma_resv_wait_timeout(xe_vm_resv(vm),
 				     DMA_RESV_USAGE_KERNEL,
 				     false, MAX_SCHEDULE_TIMEOUT);
@@ -777,14 +769,14 @@ xe_vm_bind_vma(struct xe_vma *vma, struct xe_exec_queue *q,
 	       struct xe_sync_entry *syncs, u32 num_syncs,
 	       bool first_op, bool last_op);
 
-struct dma_fence *xe_vm_rebind(struct xe_vm *vm, bool rebind_worker)
+int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker)
 {
-	struct dma_fence *fence = NULL;
+	struct dma_fence *fence;
 	struct xe_vma *vma, *next;
 
 	lockdep_assert_held(&vm->lock);
 	if (xe_vm_in_lr_mode(vm) && !rebind_worker)
-		return NULL;
+		return 0;
 
 	xe_vm_assert_held(vm);
 	list_for_each_entry_safe(vma, next, &vm->rebind_list,
@@ -792,17 +784,17 @@ struct dma_fence *xe_vm_rebind(struct xe_vm *vm, bool rebind_worker)
 		xe_assert(vm->xe, vma->tile_present);
 
 		list_del_init(&vma->combined_links.rebind);
-		dma_fence_put(fence);
 		if (rebind_worker)
 			trace_xe_vma_rebind_worker(vma);
 		else
 			trace_xe_vma_rebind_exec(vma);
 		fence = xe_vm_bind_vma(vma, NULL, NULL, 0, false, false);
 		if (IS_ERR(fence))
-			return fence;
+			return PTR_ERR(fence);
+		dma_fence_put(fence);
 	}
 
-	return fence;
+	return 0;
 }
 
 static void xe_vma_free(struct xe_vma *vma)
@@ -1592,7 +1584,6 @@ static void vm_destroy_work_func(struct work_struct *w)
 		XE_WARN_ON(vm->pt_root[id]);
 
 	trace_xe_vm_free(vm);
-	dma_fence_put(vm->rebind_fence);
 	kfree(vm);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index 6df1f1c7f85d..4853354336f2 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -207,7 +207,7 @@ int __xe_vm_userptr_needs_repin(struct xe_vm *vm);
 
 int xe_vm_userptr_check_repin(struct xe_vm *vm);
 
-struct dma_fence *xe_vm_rebind(struct xe_vm *vm, bool rebind_worker);
+int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker);
 
 int xe_vm_invalidate_vma(struct xe_vma *vma);
 
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 5747f136d24d..badf3945083d 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -177,9 +177,6 @@ struct xe_vm {
 	 */
 	struct list_head rebind_list;
 
-	/** @rebind_fence: rebind fence from execbuf */
-	struct dma_fence *rebind_fence;
-
 	/**
 	 * @destroy_work: worker to destroy VM, needed as a dma_fence signaling
 	 * from an irq context can be last put and the destroy needs to be able
-- 
2.44.0


