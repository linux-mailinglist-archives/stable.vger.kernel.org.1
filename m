Return-Path: <stable+bounces-254150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ly/HXRQFGryMQcAu9opvQ
	(envelope-from <stable+bounces-254150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:36:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB22A5CB3D6
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301743029750
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8423859E6;
	Mon, 25 May 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpqPlfCp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948903859F4
	for <stable@vger.kernel.org>; Mon, 25 May 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715970; cv=none; b=GZr/0HAxc8RU1xyG/uyVqiSNPcmoEtGzxhrgM6UhHpLFXZp9oFjbmGgHgoPANEscol9RQbTHlWbvp0IiX/fVSg17TvAAUoRv0mjC+hJc5YOBepoyG3IJt6K+M/UywNWmJTEMyM6r4ZZA6au96JNyq7pBItuzOuIsHuSxTXIlm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715970; c=relaxed/simple;
	bh=7rz8eaHJPWwN+sSoyDmi1mvzfdrgLzX/Hnug4rgQbgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkig95KyhRskrrm0IPrqojNgFwBQcDaOv35MjWt//F2d/hAD/1l18Z/flNARmqqCxjLoCul4x94DgALfYVxmFbbGR+FaQ8LG2Iq+Xn8ZtFJXCaHEmsFF6Y4SXwUVjzKcaXcPeR/ZZD1EAWi4fks/sDd9DSsAHNa8DVp1ia970aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpqPlfCp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779715969; x=1811251969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7rz8eaHJPWwN+sSoyDmi1mvzfdrgLzX/Hnug4rgQbgE=;
  b=JpqPlfCpNscdpsXsr9chmPjdp3x7b5HeX9WjReaRAE/wLJ74cOJUvV3d
   dbtal8Qjw9SFVg2waL7ZkKNbFjlj5FsSIT+ihv/Z7dLOqP83YlVZGj5wx
   l/fZ9Q5A7+oUpkcbK6/ZJgiu9xk7STM9FoySHSWzjbxtiFbj8L9al8jWf
   qaD9VpmYCTAJeWj+fk2wnu2fftWDWq91mn7B0x91EHaHAPfeqjBYeMyjF
   6HLQ/cu6z+aKEkTk6d1BPANN/ZSqNiknkMofoDEhEbMsgy1HEtNaTKD//
   pKVguuzxdW7m4V7n8DECqZ3nsOLZep1aAPq+blmH/Se3tFmP3oHg1S2xB
   w==;
X-CSE-ConnectionGUID: hEa3IacBQi2qe220IZNZFQ==
X-CSE-MsgGUID: nV5WlyTRT72yDioKtomr2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91225529"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="91225529"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:32:48 -0700
X-CSE-ConnectionGUID: oBjgL9arQoGT12V7crACdw==
X-CSE-MsgGUID: CDh1erJ3RQuPnl0ln41nzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="235242199"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.238])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:31:28 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v3 5/5] drm/xe: Suspend fault-mode LR jobs before VRAM eviction on S3/S4
Date: Mon, 25 May 2026 15:30:51 +0200
Message-ID: <20260525133051.91636-6-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525133051.91636-1-thomas.hellstrom@linux.intel.com>
References: <20260525133051.91636-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254150-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: DB22A5CB3D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fault-mode (SVM) exec queues run persistent LR jobs that can re-fault
GPU page table entries at any time. During S3/S4 suspend, VRAM eviction
unmaps GPU VMAs, but a running fault-mode job can immediately re-fault
those pages back in, racing with the eviction.

Fault-mode exec queues are suspended and drained before any VRAM
eviction begins, ensuring the GPU is quiescent before page tables or
BOs are invalidated. On resume, all previously suspended fault-mode
exec queues are re-registered and restarted once hardware is restored
and page fault handlers are ready to run.

Fault-mode exec queues created concurrently with PM suspend are
immediately suspended so the resume path picks them up, closing the
window where a newly-created queue could race with eviction.

Remove the stale "FIXME: Super racey..." comment from xe_pm_suspend():
the race it described is now prevented by suspending fault-mode jobs
before any eviction begins.

v2:
 - Add xe_device::pm_suspend_in_progress flag to suppress erroneous LR
   exec queue bans during PM suspend (now handled in a separate patch)
 - Rebase on exec queue suspend refcount and EXEC_MODE_LR rename patches

Fixes: eb5723a75104 ("drm/xe: Block exec and rebind worker while evicting for suspend / hibernate")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.17+
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue_types.h      |   7 +
 drivers/gpu/drm/xe/xe_guc_submit.c            |  25 +++
 drivers/gpu/drm/xe/xe_guc_submit.h            |   1 +
 drivers/gpu/drm/xe/xe_hw_engine_group.c       | 161 ++++++++++++++++--
 drivers/gpu/drm/xe/xe_hw_engine_group.h       |   3 +
 drivers/gpu/drm/xe/xe_hw_engine_group_types.h |   7 +
 drivers/gpu/drm/xe/xe_pm.c                    |  15 +-
 7 files changed, 206 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index 2f5ccf294675..77f2bc5ff2f6 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -200,6 +200,13 @@ struct xe_exec_queue {
 		u32 seqno;
 		/** @lr.link: link into VM's list of exec queues */
 		struct list_head link;
+		/**
+		 * @lr.pm_suspended: Marks that this fault-mode exec
+		 * queue was suspended for PM and must be resumed on
+		 * PM post-suspend. Protected by the hw engine group's
+		 * mode_sem.
+		 */
+		bool pm_suspended;
 	} lr;
 
 #define XE_EXEC_QUEUE_TLB_INVAL_PRIMARY_GT	0
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 7800a9d1d377..306d5ec7a44a 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2624,6 +2624,31 @@ void xe_guc_submit_start_user_queues(struct xe_guc *guc)
 	mutex_unlock(&guc->submission_state.lock);
 }
 
+/**
+ * xe_guc_submit_pm_resume_exec_queue() - Re-enable a fault-mode exec queue after PM resume
+ * @q: the exec queue to resume
+ *
+ * Re-enables a fault-mode LR exec queue for execution after PM resume.
+ * Has no effect if GuC is stopped or if the queue is in a terminal state
+ * (killed, banned, wedged, or destroyed).
+ */
+void xe_guc_submit_pm_resume_exec_queue(struct xe_exec_queue *q)
+{
+	struct xe_guc *guc = exec_queue_to_guc(q);
+
+	if (!guc->submission_state.initialized)
+		return;
+
+	mutex_lock(&guc->submission_state.lock);
+	if (!xe_guc_read_stopped(guc) &&
+	    !exec_queue_killed_or_banned_or_wedged(q) && !exec_queue_destroyed(q)) {
+		if (!exec_queue_registered(q))
+			register_exec_queue(q, GUC_CONTEXT_NORMAL);
+		q->ops->resume(q);
+	}
+	mutex_unlock(&guc->submission_state.lock);
+}
+
 static void guc_exec_queue_unpause_prepare(struct xe_guc *guc,
 					   struct xe_exec_queue *q)
 {
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.h b/drivers/gpu/drm/xe/xe_guc_submit.h
index b210b2f6cd2d..c312fe31d917 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.h
+++ b/drivers/gpu/drm/xe/xe_guc_submit.h
@@ -21,6 +21,7 @@ void xe_guc_submit_reset_wait(struct xe_guc *guc);
 void xe_guc_submit_stop(struct xe_guc *guc);
 int xe_guc_submit_start(struct xe_guc *guc);
 void xe_guc_submit_start_user_queues(struct xe_guc *guc);
+void xe_guc_submit_pm_resume_exec_queue(struct xe_exec_queue *q);
 void xe_guc_submit_pause(struct xe_guc *guc);
 void xe_guc_submit_pause_abort(struct xe_guc *guc);
 void xe_guc_submit_pause_vf(struct xe_guc *guc);
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_group.c b/drivers/gpu/drm/xe/xe_hw_engine_group.c
index fba0ed039bad..1561fb95fdcf 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_group.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine_group.c
@@ -6,11 +6,14 @@
 #include <drm/drm_managed.h>
 
 #include "xe_assert.h"
+#include "xe_device.h"
 #include "xe_device_types.h"
 #include "xe_exec_queue.h"
 #include "xe_gt.h"
 #include "xe_gt_stats.h"
+#include "xe_guc_submit.h"
 #include "xe_hw_engine_group.h"
+#include "xe_hw_engine_types.h"
 #include "xe_sync.h"
 #include "xe_vm.h"
 
@@ -126,11 +129,10 @@ int xe_hw_engine_setup_groups(struct xe_gt *gt)
 int xe_hw_engine_group_add_exec_queue(struct xe_hw_engine_group *group, struct xe_exec_queue *q)
 {
 	int err;
-	struct xe_device *xe = gt_to_xe(q->gt);
 
-	xe_assert(xe, group);
-	xe_assert(xe, !(q->flags & EXEC_QUEUE_FLAG_VM));
-	xe_assert(xe, q->vm);
+	xe_assert(gt_to_xe(q->gt), group);
+	xe_assert(gt_to_xe(q->gt), !(q->flags & EXEC_QUEUE_FLAG_VM));
+	xe_assert(gt_to_xe(q->gt), q->vm);
 
 	if (xe_vm_in_preempt_fence_mode(q->vm))
 		return 0;
@@ -139,13 +141,22 @@ int xe_hw_engine_group_add_exec_queue(struct xe_hw_engine_group *group, struct x
 	if (err)
 		return err;
 
-	if (xe_vm_in_fault_mode(q->vm) && group->cur_mode == EXEC_MODE_DMA_FENCE) {
-		q->ops->suspend(q);
-		err = q->ops->suspend_wait(q);
-		if (err)
-			goto err_suspend;
+	if (xe_vm_in_fault_mode(q->vm)) {
+		if (group->pm_suspended) {
+			q->lr.pm_suspended = true;
+			q->ops->suspend(q);
+			err = q->ops->suspend_wait(q);
+			if (err)
+				goto err_suspend;
+		}
+		if (group->cur_mode == EXEC_MODE_DMA_FENCE) {
+			q->ops->suspend(q);
+			err = q->ops->suspend_wait(q);
+			if (err)
+				goto err_suspend;
 
-		xe_hw_engine_group_resume_faulting_lr_jobs(group);
+			xe_hw_engine_group_resume_faulting_lr_jobs(group);
+		}
 	}
 
 	list_add(&q->hw_engine_group_link, &group->exec_queue_list);
@@ -176,6 +187,8 @@ void xe_hw_engine_group_del_exec_queue(struct xe_hw_engine_group *group, struct
 	if (!list_empty(&q->hw_engine_group_link))
 		list_del(&q->hw_engine_group_link);
 
+	q->lr.pm_suspended = false;
+
 	up_write(&group->mode_sem);
 }
 
@@ -189,6 +202,134 @@ void xe_hw_engine_group_resume_faulting_lr_jobs(struct xe_hw_engine_group *group
 	queue_work(group->resume_wq, &group->resume_work);
 }
 
+/**
+ * xe_suspend_all_faulting_lr_jobs() - Suspend all fault-mode exec queues on the device
+ * @xe: the xe device
+ *
+ * Suspends all fault-mode LR exec queues across all GTs before VRAM eviction
+ * during PM suspend. Fault-mode jobs can re-fault GPU page table entries at
+ * any time, racing with the eviction process. Must be paired with
+ * xe_resume_all_faulting_lr_jobs() after hardware is restored on resume.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int xe_suspend_all_faulting_lr_jobs(struct xe_device *xe)
+{
+	struct xe_hw_engine_group *visited[XE_ENGINE_CLASS_MAX] = {};
+	int n_visited = 0;
+	struct xe_gt *gt;
+	u8 gt_id;
+	int err;
+
+	for_each_gt(gt, xe, gt_id) {
+		struct xe_hw_engine *hwe;
+		enum xe_hw_engine_id hwe_id;
+
+		for_each_hw_engine(hwe, gt, hwe_id) {
+			struct xe_hw_engine_group *group = hwe->hw_engine_group;
+			struct xe_exec_queue *q;
+			bool already_seen = false;
+			int i;
+
+			if (!group)
+				continue;
+
+			for (i = 0; i < n_visited; i++) {
+				if (visited[i] == group) {
+					already_seen = true;
+					break;
+				}
+			}
+			if (already_seen)
+				continue;
+
+			visited[n_visited++] = group;
+
+			err = down_write_killable(&group->mode_sem);
+			if (err)
+				goto err_resume;
+
+			group->pm_suspended = true;
+			list_for_each_entry(q, &group->exec_queue_list, hw_engine_group_link) {
+				if (xe_vm_in_fault_mode(q->vm)) {
+					q->lr.pm_suspended = true;
+					q->ops->suspend(q);
+				}
+			}
+
+			list_for_each_entry(q, &group->exec_queue_list, hw_engine_group_link) {
+				if (!xe_vm_in_fault_mode(q->vm))
+					continue;
+
+				err = q->ops->suspend_wait(q);
+				if (err) {
+					up_write(&group->mode_sem);
+					goto err_resume;
+				}
+			}
+
+			up_write(&group->mode_sem);
+		}
+	}
+
+	return 0;
+
+err_resume:
+	xe_resume_all_faulting_lr_jobs(xe);
+	return err;
+}
+
+/**
+ * xe_resume_all_faulting_lr_jobs() - Resume all fault-mode exec queues on the device
+ * @xe: the xe device
+ *
+ * Re-enables all fault-mode LR exec queues that were suspended for PM. Must be
+ * called after hardware is restored and page fault handlers are free to run.
+ */
+void xe_resume_all_faulting_lr_jobs(struct xe_device *xe)
+{
+	struct xe_hw_engine_group *visited[XE_ENGINE_CLASS_MAX] = {};
+	int n_visited = 0;
+	struct xe_gt *gt;
+	u8 gt_id;
+
+	for_each_gt(gt, xe, gt_id) {
+		struct xe_hw_engine *hwe;
+		enum xe_hw_engine_id hwe_id;
+
+		for_each_hw_engine(hwe, gt, hwe_id) {
+			struct xe_hw_engine_group *group = hwe->hw_engine_group;
+			struct xe_exec_queue *q;
+			bool already_seen = false;
+			int i;
+
+			if (!group)
+				continue;
+
+			for (i = 0; i < n_visited; i++) {
+				if (visited[i] == group) {
+					already_seen = true;
+					break;
+				}
+			}
+			if (already_seen)
+				continue;
+
+			visited[n_visited++] = group;
+
+			down_write(&group->mode_sem);
+			group->pm_suspended = false;
+			list_for_each_entry(q, &group->exec_queue_list, hw_engine_group_link) {
+				if (!q->lr.pm_suspended)
+					continue;
+				q->lr.pm_suspended = false;
+				xe_guc_submit_pm_resume_exec_queue(q);
+			}
+			up_write(&group->mode_sem);
+		}
+	}
+}
+
 /**
  * xe_hw_engine_group_suspend_faulting_lr_jobs() - Suspend the faulting LR jobs of this group
  * @group: The hw engine group
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_group.h b/drivers/gpu/drm/xe/xe_hw_engine_group.h
index 8b17ccd30b70..67807d67530c 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_group.h
+++ b/drivers/gpu/drm/xe/xe_hw_engine_group.h
@@ -9,6 +9,7 @@
 #include "xe_hw_engine_group_types.h"
 
 struct drm_device;
+struct xe_device;
 struct xe_exec_queue;
 struct xe_gt;
 struct xe_sync_entry;
@@ -27,5 +28,7 @@ void xe_hw_engine_group_put(struct xe_hw_engine_group *group);
 enum xe_hw_engine_group_execution_mode
 xe_hw_engine_group_find_exec_mode(struct xe_exec_queue *q);
 void xe_hw_engine_group_resume_faulting_lr_jobs(struct xe_hw_engine_group *group);
+int xe_suspend_all_faulting_lr_jobs(struct xe_device *xe);
+void xe_resume_all_faulting_lr_jobs(struct xe_device *xe);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_group_types.h b/drivers/gpu/drm/xe/xe_hw_engine_group_types.h
index b4c41de6ba5f..090313da2f25 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_group_types.h
+++ b/drivers/gpu/drm/xe/xe_hw_engine_group_types.h
@@ -46,6 +46,13 @@ struct xe_hw_engine_group {
 	struct rw_semaphore mode_sem;
 	/** @cur_mode: current execution mode of this hw engine group */
 	enum xe_hw_engine_group_execution_mode cur_mode;
+	/**
+	 * @pm_suspended: true while PM suspend is in progress for this group.
+	 * New fault-mode exec queues added while this is set are immediately
+	 * suspended (with @lr.pm_suspended marked) and resumed by
+	 * xe_resume_all_faulting_lr_jobs(). Protected by @mode_sem.
+	 */
+	bool pm_suspended;
 };
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 76d211986822..58afb44b1b0c 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -20,6 +20,7 @@
 #include "xe_ggtt.h"
 #include "xe_gt.h"
 #include "xe_gt_idle.h"
+#include "xe_hw_engine_group.h"
 #include "xe_i2c.h"
 #include "xe_irq.h"
 #include "xe_late_bind_fw.h"
@@ -191,7 +192,6 @@ int xe_pm_suspend(struct xe_device *xe)
 
 	xe_display_pm_suspend(xe);
 
-	/* FIXME: Super racey... */
 	err = xe_bo_evict_all(xe);
 	if (err)
 		goto err_display;
@@ -414,9 +414,17 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 	{
 		struct xe_validation_ctx ctx;
 
-		reinit_completion(&xe->pm_block);
-		xe_pm_block_begin_signalling();
 		xe_pm_runtime_get(xe);
+
+		err = xe_suspend_all_faulting_lr_jobs(xe);
+		if (err) {
+			drm_err(&xe->drm, "Notifier suspend faulting LR jobs failed (%d)\n", err);
+			xe_pm_runtime_put(xe);
+			return notifier_from_errno(err);
+		}
+
+		xe_pm_block_begin_signalling();
+		reinit_completion(&xe->pm_block);
 		(void)xe_validation_ctx_init(&ctx, &xe->val, NULL,
 					     (struct xe_val_flags) {.exclusive = true});
 		err = xe_bo_evict_all_user(xe);
@@ -440,6 +448,7 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 		complete_all(&xe->pm_block);
 		xe_pm_wake_rebind_workers(xe);
 		xe_bo_notifier_unprepare_all_pinned(xe);
+		xe_resume_all_faulting_lr_jobs(xe);
 		xe_pm_runtime_put(xe);
 		break;
 	}
-- 
2.54.0


