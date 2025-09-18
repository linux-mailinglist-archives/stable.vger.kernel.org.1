Return-Path: <stable+bounces-179927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE35CB7E19C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D0A622E02
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C071A2FBE19;
	Wed, 17 Sep 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lgI8IhC+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC03157487;
	Wed, 17 Sep 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112824; cv=none; b=LeRnPmcp8/nUeH6azNyjm17XenqtzeAHiqIY6OBBCFQ0MQHesE38FA8LW8k/jb+E9kz/wUDshjE/gVzaJZYIw63Od0H/EAwhjfDdNvbCEtdCfItyqhxeMd+XYKRCWq50R8SwJLXwmny1owbjLcHAkRE0xpu8+MP40JkZNZ21aeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112824; c=relaxed/simple;
	bh=4Sc2WYGuw9+rHPe7Ozrwxz44r1H8UIhcvktaIU6LGb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTPpfb0EsUHsR77BhIKbrOdB9gyP89DNmoHJ09livlOsMeVV7kVidRdAlm/rP3vqYBaZ3vSD0V4FsZVR3UUuEVQI6Zt3Z9j42wNrC7CN5Doetdw+SH4B3w87ZxI/P1S/9+ktrDFNMz+KCYDqr/r6g2uKV7vuTqUPXDwCY7KJV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lgI8IhC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18C5C4CEF0;
	Wed, 17 Sep 2025 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112824;
	bh=4Sc2WYGuw9+rHPe7Ozrwxz44r1H8UIhcvktaIU6LGb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lgI8IhC+qEBeqo8LzkTljDBEusPXtJTV9ZvLjpbMReN6Wcab4/H8i1E5oflBhlTg/
	 20Uoih2twItM44owIAWEL3ainIHpXNr/fSbnGpsxf6bpaCXKwSYBZPkIfyBUvwVDMu
	 KI6x/GDbEN98MJOtAlyBoL1uVZ3wPERJbB3K9dNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.16 087/189] drm/xe: Block exec and rebind worker while evicting for suspend / hibernate
Date: Wed, 17 Sep 2025 14:33:17 +0200
Message-ID: <20250917123353.983521203@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit eb5723a75104605b7d2207a7d598e314166fbef4 upstream.

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
v4:
- Fix some bad naming and leftover debug printouts.
- Fix kerneldoc.
- Use drmm_mutex_init() for the xe->rebind_resume_lock (Matt Auld).
- Rework the interface of xe_vm_rebind_resume_worker (Matt Auld).

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4288
Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://lore.kernel.org/r/20250904160715.2613-4-thomas.hellstrom@linux.intel.com
(cherry picked from commit 599334572a5a99111015fbbd5152ce4dedc2f8b7)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_device_types.h |    6 +++++
 drivers/gpu/drm/xe/xe_exec.c         |    9 +++++++
 drivers/gpu/drm/xe/xe_pm.c           |   25 ++++++++++++++++++++
 drivers/gpu/drm/xe/xe_vm.c           |   42 ++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_vm.h           |    2 +
 drivers/gpu/drm/xe/xe_vm_types.h     |    5 ++++
 6 files changed, 88 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -529,6 +529,12 @@ struct xe_device {
 
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
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -237,6 +237,15 @@ retry:
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
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -23,6 +23,7 @@
 #include "xe_pcode.h"
 #include "xe_pxp.h"
 #include "xe_trace.h"
+#include "xe_vm.h"
 #include "xe_wa.h"
 
 /**
@@ -285,6 +286,19 @@ static u32 vram_threshold_value(struct x
 	return DEFAULT_VRAM_THRESHOLD;
 }
 
+static void xe_pm_wake_rebind_workers(struct xe_device *xe)
+{
+	struct xe_vm *vm, *next;
+
+	mutex_lock(&xe->rebind_resume_lock);
+	list_for_each_entry_safe(vm, next, &xe->rebind_resume_list,
+				 preempt.pm_activate_link) {
+		list_del_init(&vm->preempt.pm_activate_link);
+		xe_vm_resume_rebind_worker(vm);
+	}
+	mutex_unlock(&xe->rebind_resume_lock);
+}
+
 static int xe_pm_notifier_callback(struct notifier_block *nb,
 				   unsigned long action, void *data)
 {
@@ -294,6 +308,7 @@ static int xe_pm_notifier_callback(struc
 	switch (action) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+		reinit_completion(&xe->pm_block);
 		xe_pm_runtime_get(xe);
 		err = xe_bo_evict_all_user(xe);
 		if (err)
@@ -310,6 +325,8 @@ static int xe_pm_notifier_callback(struc
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
+		complete_all(&xe->pm_block);
+		xe_pm_wake_rebind_workers(xe);
 		xe_bo_notifier_unprepare_all_pinned(xe);
 		xe_pm_runtime_put(xe);
 		break;
@@ -336,6 +353,14 @@ int xe_pm_init(struct xe_device *xe)
 	if (err)
 		return err;
 
+	err = drmm_mutex_init(&xe->drm, &xe->rebind_resume_lock);
+	if (err)
+		goto err_unregister;
+
+	init_completion(&xe->pm_block);
+	complete_all(&xe->pm_block);
+	INIT_LIST_HEAD(&xe->rebind_resume_list);
+
 	/* For now suspend/resume is only allowed with GuC */
 	if (!xe_device_uc_enabled(xe))
 		return 0;
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -393,6 +393,9 @@ static int xe_gpuvm_validate(struct drm_
 		list_move_tail(&gpuva_to_vma(gpuva)->combined_links.rebind,
 			       &vm->rebind_list);
 
+	if (!try_wait_for_completion(&vm->xe->pm_block))
+		return -EAGAIN;
+
 	ret = xe_bo_validate(gem_to_xe_bo(vm_bo->obj), vm, false);
 	if (ret)
 		return ret;
@@ -479,6 +482,33 @@ static int xe_preempt_work_begin(struct
 	return xe_vm_validate_rebind(vm, exec, vm->preempt.num_exec_queues);
 }
 
+static bool vm_suspend_rebind_worker(struct xe_vm *vm)
+{
+	struct xe_device *xe = vm->xe;
+	bool ret = false;
+
+	mutex_lock(&xe->rebind_resume_lock);
+	if (!try_wait_for_completion(&vm->xe->pm_block)) {
+		ret = true;
+		list_move_tail(&vm->preempt.pm_activate_link, &xe->rebind_resume_list);
+	}
+	mutex_unlock(&xe->rebind_resume_lock);
+
+	return ret;
+}
+
+/**
+ * xe_vm_resume_rebind_worker() - Resume the rebind worker.
+ * @vm: The vm whose preempt worker to resume.
+ *
+ * Resume a preempt worker that was previously suspended by
+ * vm_suspend_rebind_worker().
+ */
+void xe_vm_resume_rebind_worker(struct xe_vm *vm)
+{
+	queue_work(vm->xe->ordered_wq, &vm->preempt.rebind_work);
+}
+
 static void preempt_rebind_work_func(struct work_struct *w)
 {
 	struct xe_vm *vm = container_of(w, struct xe_vm, preempt.rebind_work);
@@ -502,6 +532,11 @@ static void preempt_rebind_work_func(str
 	}
 
 retry:
+	if (!try_wait_for_completion(&vm->xe->pm_block) && vm_suspend_rebind_worker(vm)) {
+		up_write(&vm->lock);
+		return;
+	}
+
 	if (xe_vm_userptr_check_repin(vm)) {
 		err = xe_vm_userptr_pin(vm);
 		if (err)
@@ -1686,6 +1721,7 @@ struct xe_vm *xe_vm_create(struct xe_dev
 	if (flags & XE_VM_FLAG_LR_MODE) {
 		INIT_WORK(&vm->preempt.rebind_work, preempt_rebind_work_func);
 		xe_pm_runtime_get_noresume(xe);
+		INIT_LIST_HEAD(&vm->preempt.pm_activate_link);
 	}
 
 	if (flags & XE_VM_FLAG_FAULT_MODE) {
@@ -1867,8 +1903,12 @@ void xe_vm_close_and_put(struct xe_vm *v
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
 
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -268,6 +268,8 @@ struct dma_fence *xe_vm_bind_kernel_bo(s
 				       struct xe_exec_queue *q, u64 addr,
 				       enum xe_cache_level cache_lvl);
 
+void xe_vm_resume_rebind_worker(struct xe_vm *vm);
+
 /**
  * xe_vm_resv() - Return's the vm's reservation object
  * @vm: The vm
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -286,6 +286,11 @@ struct xe_vm {
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



