Return-Path: <stable+bounces-119897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D69A49231
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C453B7407
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C71AC42B;
	Fri, 28 Feb 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbGezJSb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0A18CC15
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727879; cv=none; b=o2/dYd//ODsfd44xE45WcyUX5YvpbH6Z8n4MShUc/IBCiV/HoAOw9r8a5Yt06yozLW+VOc7t5bHZEBn6sKySLGcEuuqVA7HX2aZ1jsWaTpiT8lg1yDoCLf9imRx+Ge3nysFMwCU+0E2lNkU2/xFM4trx99T9ynnd8qRV+MA+aWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727879; c=relaxed/simple;
	bh=BljVBXob2tV1ISSi/DWT9eYNz+GovkLlhDXmnpDP1qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqPKiEJyd9dytJCIy0HE7kdJ5P1/JgGGdvEyIRbYAxsrtHFkchfXXd0Dt98PhHyLNR3TtVCUcr1SpW9j08S0OKMuEjN6RfkOHfDaFf45tcPJmeo0XVo1vgRXCf0vnzIVePz+Q/i34t4/Mx4388pjWXkMXtNWsBEDHBM7ZjijJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbGezJSb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740727878; x=1772263878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BljVBXob2tV1ISSi/DWT9eYNz+GovkLlhDXmnpDP1qo=;
  b=lbGezJSbvwDIhipNkDRMehA6eXJKufaZZgmX+GX2QPW2+x1tjNQ5d9DK
   SUzU/p92H74KrlY18ktcQWEFh9HBL4tbEaZ3kyGV7Iet9U5/eQCnnbToi
   C7ddGwayyqLuFw4nLbbd6K/T1oDqjtD9bRm3vOt8X09/qCegld9hEEcet
   hQS0xZ3vnTNg/1Mb3cU90Vhgg3cDs7fUN95s7Jy24xwid/Qg3wm/FzJ0L
   Q8wDjJ7A/bQktRFaMTcQob98bQN5EqyN3mVYEpnamYyZKwWsdYkUoDdQj
   9jEeicO5tsQgfRZ0kqMmBwPgoOaPkKdDoiOxHmc69mruYEwNE5dTykqdh
   Q==;
X-CSE-ConnectionGUID: w1AmdArARM66nharvS7gUg==
X-CSE-MsgGUID: VqMuillbQ1+aCJ5v5kJM+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45297769"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45297769"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:31:18 -0800
X-CSE-ConnectionGUID: YKk0maGdR2uqA2b6ghi6IA==
X-CSE-MsgGUID: YwKhCAobSeacLkerTG+r1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121386250"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.232])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:31:16 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] drm/xe: Fix fault mode invalidation with unbind
Date: Fri, 28 Feb 2025 08:30:57 +0100
Message-ID: <20250228073058.59510-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228073058.59510-1-thomas.hellstrom@linux.intel.com>
References: <20250228073058.59510-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix fault mode invalidation racing with unbind leading to the
PTE zapping potentially traversing an invalid page-table tree.
Do this by holding the notifier lock across PTE zapping. This
might transfer any contention waiting on the notifier seqlock
read side to the notifier lock read side, but that shouldn't be
a major problem.

At the same time get rid of the open-coded invalidation in the bind
code by relying on the notifier even when the vma bind is not
yet committed.

Finally let userptr invalidation call a dedicated xe_vm function
performing a full invalidation.

Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_pt.c       | 38 ++++----------
 drivers/gpu/drm/xe/xe_vm.c       | 85 +++++++++++++++++++++-----------
 drivers/gpu/drm/xe/xe_vm.h       |  8 +++
 drivers/gpu/drm/xe/xe_vm_types.h |  4 +-
 4 files changed, 75 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 1ddcc7e79a93..12a627a23eb4 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1213,42 +1213,22 @@ static int vma_check_userptr(struct xe_vm *vm, struct xe_vma *vma,
 		return 0;
 
 	uvma = to_userptr_vma(vma);
-	notifier_seq = uvma->userptr.notifier_seq;
+	if (xe_pt_userptr_inject_eagain(uvma))
+		xe_vma_userptr_force_invalidate(uvma);
 
-	if (uvma->userptr.initial_bind && !xe_vm_in_fault_mode(vm))
-		return 0;
+	notifier_seq = uvma->userptr.notifier_seq;
 
 	if (!mmu_interval_read_retry(&uvma->userptr.notifier,
-				     notifier_seq) &&
-	    !xe_pt_userptr_inject_eagain(uvma))
+				     notifier_seq))
 		return 0;
 
-	if (xe_vm_in_fault_mode(vm)) {
+	if (xe_vm_in_fault_mode(vm))
 		return -EAGAIN;
-	} else {
-		spin_lock(&vm->userptr.invalidated_lock);
-		list_move_tail(&uvma->userptr.invalidate_link,
-			       &vm->userptr.invalidated);
-		spin_unlock(&vm->userptr.invalidated_lock);
-
-		if (xe_vm_in_preempt_fence_mode(vm)) {
-			struct dma_resv_iter cursor;
-			struct dma_fence *fence;
-			long err;
-
-			dma_resv_iter_begin(&cursor, xe_vm_resv(vm),
-					    DMA_RESV_USAGE_BOOKKEEP);
-			dma_resv_for_each_fence_unlocked(&cursor, fence)
-				dma_fence_enable_sw_signaling(fence);
-			dma_resv_iter_end(&cursor);
-
-			err = dma_resv_wait_timeout(xe_vm_resv(vm),
-						    DMA_RESV_USAGE_BOOKKEEP,
-						    false, MAX_SCHEDULE_TIMEOUT);
-			XE_WARN_ON(err <= 0);
-		}
-	}
 
+	/*
+	 * Just continue the operation since exec or rebind worker
+	 * will take care of rebinding.
+	 */
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 6fdc17be619e..dd422ac95dc0 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -580,51 +580,26 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	trace_xe_vm_rebind_worker_exit(vm);
 }
 
-static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
-				   const struct mmu_notifier_range *range,
-				   unsigned long cur_seq)
+static void __vma_userptr_invalidate(struct xe_vm *vm, struct xe_userptr_vma *uvma)
 {
-	struct xe_userptr *userptr = container_of(mni, typeof(*userptr), notifier);
-	struct xe_userptr_vma *uvma = container_of(userptr, typeof(*uvma), userptr);
+	struct xe_userptr *userptr = &uvma->userptr;
 	struct xe_vma *vma = &uvma->vma;
-	struct xe_vm *vm = xe_vma_vm(vma);
 	struct dma_resv_iter cursor;
 	struct dma_fence *fence;
 	long err;
 
-	xe_assert(vm->xe, xe_vma_is_userptr(vma));
-	trace_xe_vma_userptr_invalidate(vma);
-
-	if (!mmu_notifier_range_blockable(range))
-		return false;
-
-	vm_dbg(&xe_vma_vm(vma)->xe->drm,
-	       "NOTIFIER: addr=0x%016llx, range=0x%016llx",
-		xe_vma_start(vma), xe_vma_size(vma));
-
-	down_write(&vm->userptr.notifier_lock);
-	mmu_interval_set_seq(mni, cur_seq);
-
-	/* No need to stop gpu access if the userptr is not yet bound. */
-	if (!userptr->initial_bind) {
-		up_write(&vm->userptr.notifier_lock);
-		return true;
-	}
-
 	/*
 	 * Tell exec and rebind worker they need to repin and rebind this
 	 * userptr.
 	 */
 	if (!xe_vm_in_fault_mode(vm) &&
-	    !(vma->gpuva.flags & XE_VMA_DESTROYED) && vma->tile_present) {
+	    !(vma->gpuva.flags & XE_VMA_DESTROYED)) {
 		spin_lock(&vm->userptr.invalidated_lock);
 		list_move_tail(&userptr->invalidate_link,
 			       &vm->userptr.invalidated);
 		spin_unlock(&vm->userptr.invalidated_lock);
 	}
 
-	up_write(&vm->userptr.notifier_lock);
-
 	/*
 	 * Preempt fences turn into schedule disables, pipeline these.
 	 * Note that even in fault mode, we need to wait for binds and
@@ -642,11 +617,35 @@ static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
 				    false, MAX_SCHEDULE_TIMEOUT);
 	XE_WARN_ON(err <= 0);
 
-	if (xe_vm_in_fault_mode(vm)) {
+	if (xe_vm_in_fault_mode(vm) && userptr->initial_bind) {
 		err = xe_vm_invalidate_vma(vma);
 		XE_WARN_ON(err);
 	}
+}
 
+static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
+				   const struct mmu_notifier_range *range,
+				   unsigned long cur_seq)
+{
+	struct xe_userptr_vma *uvma = container_of(mni, typeof(*uvma), userptr.notifier);
+	struct xe_vma *vma = &uvma->vma;
+	struct xe_vm *vm = xe_vma_vm(vma);
+
+	xe_assert(vm->xe, xe_vma_is_userptr(vma));
+	trace_xe_vma_userptr_invalidate(vma);
+
+	if (!mmu_notifier_range_blockable(range))
+		return false;
+
+	vm_dbg(&xe_vma_vm(vma)->xe->drm,
+	       "NOTIFIER: addr=0x%016llx, range=0x%016llx",
+		xe_vma_start(vma), xe_vma_size(vma));
+
+	down_write(&vm->userptr.notifier_lock);
+	mmu_interval_set_seq(mni, cur_seq);
+
+	__vma_userptr_invalidate(vm, uvma);
+	up_write(&vm->userptr.notifier_lock);
 	trace_xe_vma_userptr_invalidate_complete(vma);
 
 	return true;
@@ -656,6 +655,34 @@ static const struct mmu_interval_notifier_ops vma_userptr_notifier_ops = {
 	.invalidate = vma_userptr_invalidate,
 };
 
+#if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
+/**
+ * xe_vma_userptr_force_invalidate() - force invalidate a userptr
+ * @uvma: The userptr vma to invalidate
+ *
+ * Perform a forced userptr invalidation for testing purposes.
+ */
+void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
+{
+	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
+
+	/* Protect against concurrent userptr pinning */
+	lockdep_assert_held(&vm->lock);
+	/* Protect against concurrent notifiers */
+	lockdep_assert_held(&vm->userptr.notifier_lock);
+	/*
+	 * Protect against concurrent instances of this function and
+	 * the critical exec sections
+	 */
+	xe_vm_assert_held(vm);
+
+	if (!mmu_interval_read_retry(&uvma->userptr.notifier,
+				     uvma->userptr.notifier_seq))
+		uvma->userptr.notifier_seq -= 2;
+	__vma_userptr_invalidate(vm, uvma);
+}
+#endif
+
 int xe_vm_userptr_pin(struct xe_vm *vm)
 {
 	struct xe_userptr_vma *uvma, *next;
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index 7c8e39049223..f5d835271350 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -287,4 +287,12 @@ struct xe_vm_snapshot *xe_vm_snapshot_capture(struct xe_vm *vm);
 void xe_vm_snapshot_capture_delayed(struct xe_vm_snapshot *snap);
 void xe_vm_snapshot_print(struct xe_vm_snapshot *snap, struct drm_printer *p);
 void xe_vm_snapshot_free(struct xe_vm_snapshot *snap);
+
+#if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
+void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma);
+#else
+static inline void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
+{
+}
+#endif
 #endif
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 52467b9b5348..1fe79bf23b6b 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -228,8 +228,8 @@ struct xe_vm {
 		 * up for revalidation. Protected from access with the
 		 * @invalidated_lock. Removing items from the list
 		 * additionally requires @lock in write mode, and adding
-		 * items to the list requires the @userptr.notifer_lock in
-		 * write mode.
+		 * items to the list requires either the @userptr.notifer_lock in
+		 * write mode, OR @lock in write mode.
 		 */
 		struct list_head invalidated;
 	} userptr;
-- 
2.48.1


