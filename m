Return-Path: <stable+bounces-177726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92724B43C8A
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56321884131
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44CE2FF671;
	Thu,  4 Sep 2025 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCjYEDcw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00712FF654
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991216; cv=none; b=B0i1W1jukXrL/DpzRbH2OlriOgxu0RpSRJ3COK0UXZMv8H2fqVv5uVxcClmfj5AnMbLX25fYo66J1xiWSeumP97TRzDymcpgwf4/50Tzq7uB6kMTP6XdIYcn6dGLz2dWjnquKAkw1YWVN80jLPETk4w6F+ZNGPdaQMQRMR/Qleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991216; c=relaxed/simple;
	bh=Nqw/Z++NaAMgi1mLbAHVxkQ+2bWDUVaEq2bEN6Umxb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5cw44nl88VkwLkZSd1VetF0yYhmPU+WqmtiQpVOMLFM7GXK/Hj+oB7kQQJt5Wv0KawxH5eTfcZJI5j8+v+kbSPm2bISgIDyD+foCQOQTQq+Q6pZXxAJ3dgo4XLN61okndS3rqSVNwt3zf3Btm+Zu+fk0mMji38OYAbqI165pCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCjYEDcw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756991215; x=1788527215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nqw/Z++NaAMgi1mLbAHVxkQ+2bWDUVaEq2bEN6Umxb0=;
  b=MCjYEDcwlrc6dX2NXnxnVh6WOkfzHjOxIXaYCLqHwPtOvkpDP8sybvW/
   ablepaUEVfYxhGe2WnVTOcF1igo9u1M6JraPur+hO3vUtM94HNfWQ4l0e
   tJoTt855W+I8RB/48D9bX7+Oj88HNARoQiBv63z571ulhWmiCeVmiYE3B
   tnV3P5WiEl7XYJAvZWhODkndSgbj3BeLWN5lvSnAJnMaD6A5iQ43zRd3j
   ql2EppQHMvL7tlPeqLpWokTPahnUIaPdAh/xLTbelaaRNHMInl+3T8uW5
   nMH+GtrYOR8BoVUlwqNr6X0+3xR5qjoUn/qf9NjNGQSszeqgkUiwlf1Ph
   g==;
X-CSE-ConnectionGUID: qR3ARKJjSaCUPEbNr9lvVA==
X-CSE-MsgGUID: gKtnvYWBT02mg5PIxUHPNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="76930839"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="76930839"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:06:54 -0700
X-CSE-ConnectionGUID: +QmlO2qURWyJg/352bSNSA==
X-CSE-MsgGUID: uztr/ZTAShSqwKyLD61v5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171459090"
Received: from abityuts-desk.ger.corp.intel.com (HELO fedora) ([10.245.244.98])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:06:52 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v3 3/3] drm/xe: Block exec and rebind worker while evicting for suspend / hibernate
Date: Thu,  4 Sep 2025 15:06:05 +0200
Message-ID: <20250904130614.3212-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904130614.3212-1-thomas.hellstrom@linux.intel.com>
References: <20250904130614.3212-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the xe pm_notifier evicts for suspend / hibernate, there might be
racing tasks trying to re-validate again. This can lead to suspend taking
excessive time or get stuck in a live-lock. This behaviour becomes
much worse with the fix that actually makes re-validation bring back
bos to VRAM rather than letting them remain in TT.

Prevent that by having exec and the rebind worker waiting for a completion
that is set to block by the pm_notifier before suspend and is signaled
by the pm_notifier after resume / wakeup.

It's probably still possible to craft malicious applications that block
suspending. More work is pending to fix that.

v3:
- Avoid wait_for_completion() in the kernel worker since it could
  potentially cause work item flushes from freezable processes to
  wait forever. Instead terminate the rebind workers if needed and
  re-launch at resume. (Matt Auld)

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4288
Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  6 ++++
 drivers/gpu/drm/xe/xe_exec.c         |  9 ++++++
 drivers/gpu/drm/xe/xe_pm.c           | 20 ++++++++++++
 drivers/gpu/drm/xe/xe_vm.c           | 46 +++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_vm.h           |  2 ++
 drivers/gpu/drm/xe/xe_vm_types.h     |  5 +++
 6 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 092004d14db2..1e780f8a2a8c 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -507,6 +507,12 @@ struct xe_device {
 
 	/** @pm_notifier: Our PM notifier to perform actions in response to various PM events. */
 	struct notifier_block pm_notifier;
+	/** @pm_block: Completion to block validating tasks on suspend / hibernate prepare */
+	struct completion pm_block;
+	/** @rebind_resume_list: List of wq items to kick on resume. */
+	struct list_head rebind_resume_list;
+	/** @rebind_resume_lock: Lock to protect the rebind_resume_list */
+	struct mutex rebind_resume_lock;
 
 	/** @pmt: Support the PMT driver callback interface */
 	struct {
diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 44364c042ad7..374c831e691b 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -237,6 +237,15 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		goto err_unlock_list;
 	}
 
+	/*
+	 * It's OK to block interruptible here with the vm lock held, since
+	 * on task freezing during suspend / hibernate, the call will
+	 * return -ERESTARTSYS and the IOCTL will be rerun.
+	 */
+	err = wait_for_completion_interruptible(&xe->pm_block);
+	if (err)
+		goto err_unlock_list;
+
 	vm_exec.vm = &vm->gpuvm;
 	vm_exec.flags = DRM_EXEC_INTERRUPTIBLE_WAIT;
 	if (xe_vm_in_lr_mode(vm)) {
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index bee9aacd82e7..6d59990ff6ba 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -297,6 +297,18 @@ static u32 vram_threshold_value(struct xe_device *xe)
 	return DEFAULT_VRAM_THRESHOLD;
 }
 
+static void xe_pm_wake_preempt_workers(struct xe_device *xe)
+{
+	struct list_head *link, *next;
+
+	mutex_lock(&xe->rebind_resume_lock);
+	list_for_each_safe(link, next, &xe->rebind_resume_list) {
+		list_del_init(link);
+		xe_vm_resume_preempt_worker(link);
+	}
+	mutex_unlock(&xe->rebind_resume_lock);
+}
+
 static int xe_pm_notifier_callback(struct notifier_block *nb,
 				   unsigned long action, void *data)
 {
@@ -306,6 +318,7 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 	switch (action) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+		reinit_completion(&xe->pm_block);
 		xe_pm_runtime_get(xe);
 		err = xe_bo_evict_all_user(xe);
 		if (err)
@@ -322,6 +335,8 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
+		complete_all(&xe->pm_block);
+		xe_pm_wake_preempt_workers(xe);
 		xe_bo_notifier_unprepare_all_pinned(xe);
 		xe_pm_runtime_put(xe);
 		break;
@@ -348,6 +363,11 @@ int xe_pm_init(struct xe_device *xe)
 	if (err)
 		return err;
 
+	init_completion(&xe->pm_block);
+	complete_all(&xe->pm_block);
+	mutex_init(&xe->rebind_resume_lock);
+	INIT_LIST_HEAD(&xe->rebind_resume_list);
+
 	/* For now suspend/resume is only allowed with GuC */
 	if (!xe_device_uc_enabled(xe))
 		return 0;
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index f55f96bb240a..97aad1d53a8c 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -394,6 +394,9 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
 		list_move_tail(&gpuva_to_vma(gpuva)->combined_links.rebind,
 			       &vm->rebind_list);
 
+	if (!try_wait_for_completion(&vm->xe->pm_block))
+		return -EAGAIN;
+
 	ret = xe_bo_validate(gem_to_xe_bo(vm_bo->obj), vm, false);
 	if (ret)
 		return ret;
@@ -480,6 +483,37 @@ static int xe_preempt_work_begin(struct drm_exec *exec, struct xe_vm *vm,
 	return xe_vm_validate_rebind(vm, exec, vm->preempt.num_exec_queues);
 }
 
+static bool vm_suspend_preempt_worker(struct xe_vm *vm)
+{
+	struct xe_device *xe = vm->xe;
+	bool ret = false;
+
+	mutex_lock(&xe->rebind_resume_lock);
+	if (!try_wait_for_completion(&vm->xe->pm_block)) {
+		ret = true;
+		list_move_tail(&vm->preempt.pm_activate_link, &xe->rebind_resume_list);
+	}
+	pr_info("Suspending %p\n", vm);
+	mutex_unlock(&xe->rebind_resume_lock);
+
+	return ret;
+}
+
+/**
+ * xe_vm_resume_preempt_worker() - Resume the preempt worker.
+ * @vm: The vm whose preempt worker to resume.
+ *
+ * Resume a preempt worker that was previously suspended by
+ * vm_suspend_preempt_worker().
+ */
+void xe_vm_resume_preempt_worker(struct list_head *link)
+{
+	struct xe_vm *vm = container_of(link, typeof(*vm), preempt.pm_activate_link);
+
+	pr_info("Resuming %p\n", vm);
+	queue_work(vm->xe->ordered_wq, &vm->preempt.rebind_work);
+}
+
 static void preempt_rebind_work_func(struct work_struct *w)
 {
 	struct xe_vm *vm = container_of(w, struct xe_vm, preempt.rebind_work);
@@ -503,6 +537,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	}
 
 retry:
+	if (!try_wait_for_completion(&vm->xe->pm_block) && vm_suspend_preempt_worker(vm)) {
+		up_write(&vm->lock);
+		return;
+	}
+
 	if (xe_vm_userptr_check_repin(vm)) {
 		err = xe_vm_userptr_pin(vm);
 		if (err)
@@ -1741,6 +1780,7 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 	if (flags & XE_VM_FLAG_LR_MODE) {
 		INIT_WORK(&vm->preempt.rebind_work, preempt_rebind_work_func);
 		xe_pm_runtime_get_noresume(xe);
+		INIT_LIST_HEAD(&vm->preempt.pm_activate_link);
 	}
 
 	if (flags & XE_VM_FLAG_FAULT_MODE) {
@@ -1922,8 +1962,12 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 	xe_assert(xe, !vm->preempt.num_exec_queues);
 
 	xe_vm_close(vm);
-	if (xe_vm_in_preempt_fence_mode(vm))
+	if (xe_vm_in_preempt_fence_mode(vm)) {
+		mutex_lock(&xe->rebind_resume_lock);
+		list_del_init(&vm->preempt.pm_activate_link);
+		mutex_unlock(&xe->rebind_resume_lock);
 		flush_work(&vm->preempt.rebind_work);
+	}
 	if (xe_vm_in_fault_mode(vm))
 		xe_svm_close(vm);
 
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index b3e5bec0fa58..f2639794278b 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -281,6 +281,8 @@ struct dma_fence *xe_vm_bind_kernel_bo(struct xe_vm *vm, struct xe_bo *bo,
 				       struct xe_exec_queue *q, u64 addr,
 				       enum xe_cache_level cache_lvl);
 
+void xe_vm_resume_preempt_worker(struct list_head *link);
+
 /**
  * xe_vm_resv() - Return's the vm's reservation object
  * @vm: The vm
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index b5108d010786..e1a786db5f89 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -338,6 +338,11 @@ struct xe_vm {
 		 * BOs
 		 */
 		struct work_struct rebind_work;
+		/**
+		 * @preempt.pm_activate_link: Link to list of rebind workers to be
+		 * kicked on resume.
+		 */
+		struct list_head pm_activate_link;
 	} preempt;
 
 	/** @um: unified memory state */
-- 
2.50.1


