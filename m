Return-Path: <stable+bounces-254148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNcMJ01QFGrmMQcAu9opvQ
	(envelope-from <stable+bounces-254148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:36:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0805CB389
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C023044F34
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9643385D7B;
	Mon, 25 May 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcAK7dHM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F75405E7
	for <stable@vger.kernel.org>; Mon, 25 May 2026 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715883; cv=none; b=BcqGh23KWkbLCzSNzl6Vg54imrZ3FMQZeqg593QqoSjTHGEuiEeaitZ4izQ1TT+pC29/xA3KCifPn0aDPSxru1p5ikZGbkCy+gTi6JoVtnjo7tDPhz9pOS5qjl/43JhzVRBTz35MCHXNM1oY+uaODxkWFavgF3VtV7GWR5LzQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715883; c=relaxed/simple;
	bh=44tAvD4jsSRTFpG9jOWODd+7jiWIsWpBQMVmqQGXcoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGlXkhh8GMEB3NIdxhhLpickdKptMFa+54T1XOt/M52LH84Ry098h5F/ay6KDiYqigQM+nvI4mFhw2su2tz9Peh70sIUNfTcQm65rwAm5XwqztOdg0fgYiBV3Vq2tOftQoH4tXqcmjnFpsGS/1g0Zjpkb+qoHvbCc6o2WCROaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcAK7dHM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779715881; x=1811251881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=44tAvD4jsSRTFpG9jOWODd+7jiWIsWpBQMVmqQGXcoc=;
  b=FcAK7dHMng/x9glUWZ4URy/lPdUbbX4f2lPX/jQFaz81X6K7o6a8rX5n
   Rno9Bd3LcaYhTuhgFfywg96q78xR+efDuJYltU49j6Woo07FUsaGgQPmV
   +IrQnfZeXTPhzl+AqNKjEBcoS6f4f/sw4cDCsozJPd9SsWwfK34wYhTwb
   fMRBT4Anf1+lrMiZEers/4HRWTb1NHJPxeR7M95DpVG+iCa/nvgELHVtR
   FWrDHL+aLQNXmfuAEky5McbJdoYfCPw3NXIdi2NqyJznOqahFxNunjdif
   Wt4EDqJQsCTvY7eW0qgev3IyVjsEVmUs+bBFTdn2i82KiJhkRSDr7lOMc
   Q==;
X-CSE-ConnectionGUID: OrXUwD5hS+KTU+DifsvPiw==
X-CSE-MsgGUID: bfpSRKPOR9WHV2N48lZxag==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91225456"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="91225456"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:31:20 -0700
X-CSE-ConnectionGUID: k6t8dsULQQmj/ZqrraXkLw==
X-CSE-MsgGUID: RsISK2NoTwCUVhefk0rqjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="235241825"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.238])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:31:17 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v3 1/5] drm/xe/guc: Defer user exec queue scheduler start until after page table restore
Date: Mon, 25 May 2026 15:30:47 +0200
Message-ID: <20260525133051.91636-2-thomas.hellstrom@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-254148-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF0805CB389
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On S3/S4 and d3cold runtime PM resume, exec queue schedulers are
restarted before xe_bo_restore_late() has restored userspace VM page
table BOs and LRC BOs. If a pending job is submitted in this window,
GuC will attempt to load the context using stale or invalid data in
VRAM, leading to GuC exceptions.

Defer user exec queue scheduler start until after page tables and LRC
BOs are restored, ensuring no job can be submitted before the backing
storage is valid. Migrate and kernel VM exec queues are still started
immediately as they are required by the restore process itself.

For GT reset, VRAM is not evicted and all BOs remain valid, so user
exec queue schedulers are started without deferral.

This covers both LR and non-LR userspace exec queues.

v3:
- Skip queues with a running scheduler in xe_guc_submit_start_user_queues()
  to avoid a WARN_ON in drm_sched_for_each_pending_job() when a new user
  exec queue is created in the window between xe_guc_submit_start() and
  xe_guc_submit_start_user_queues(). (Intel CI)

Fixes: 7f387e6012b6 ("drm/xe: add XE_BO_FLAG_PINNED_LATE_RESTORE")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_gt.c         | 16 +++++++++
 drivers/gpu/drm/xe/xe_gt.h         |  2 ++
 drivers/gpu/drm/xe/xe_guc.c        | 13 ++++++++
 drivers/gpu/drm/xe/xe_guc.h        |  1 +
 drivers/gpu/drm/xe/xe_guc_submit.c | 52 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_guc_submit.h |  1 +
 drivers/gpu/drm/xe/xe_pm.c         |  6 ++++
 drivers/gpu/drm/xe/xe_uc.c         | 16 +++++++++
 drivers/gpu/drm/xe/xe_uc.h         |  1 +
 9 files changed, 108 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 783eb6d631b5..2c63e4d6a649 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -955,6 +955,8 @@ static void gt_reset_worker(struct work_struct *w)
 	if (err)
 		goto err_out;
 
+	xe_uc_start_user_queues(&gt->uc);
+
 	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 
 	/* Pair with get while enqueueing the work in xe_gt_reset_async() */
@@ -967,6 +969,7 @@ static void gt_reset_worker(struct work_struct *w)
 err_out:
 	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	XE_WARN_ON(xe_uc_start(&gt->uc));
+	xe_uc_start_user_queues(&gt->uc);
 
 err_fail:
 	xe_gt_err(gt, "reset failed (%pe)\n", ERR_PTR(err));
@@ -1050,6 +1053,19 @@ int xe_gt_sanitize_freq(struct xe_gt *gt)
 	return ret;
 }
 
+/**
+ * xe_gt_start_user_queues() - Start user exec queues after page table restore
+ * @gt: the GT object
+ *
+ * Starts the DRM schedulers for all user exec queues on the GT. This must be
+ * called after xe_bo_restore_late() to ensure that userspace page table BOs
+ * are valid before any job submission triggers GuC context registration.
+ */
+void xe_gt_start_user_queues(struct xe_gt *gt)
+{
+	xe_uc_start_user_queues(&gt->uc);
+}
+
 int xe_gt_resume(struct xe_gt *gt)
 {
 	int err;
diff --git a/drivers/gpu/drm/xe/xe_gt.h b/drivers/gpu/drm/xe/xe_gt.h
index 4150aa594f05..b6ba05a317f7 100644
--- a/drivers/gpu/drm/xe/xe_gt.h
+++ b/drivers/gpu/drm/xe/xe_gt.h
@@ -170,4 +170,6 @@ static inline bool xe_gt_supports_multi_queue(const struct xe_gt *gt,
 	return gt->info.multi_queue_engine_class_mask & BIT(class);
 }
 
+void xe_gt_start_user_queues(struct xe_gt *gt);
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 4023700ff2a9..0359909b8b27 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -1717,6 +1717,19 @@ int xe_guc_start(struct xe_guc *guc)
 	return xe_guc_submit_start(guc);
 }
 
+/**
+ * xe_guc_start_user_queues() - Start user exec queue schedulers on the GuC
+ * @guc: the GuC object
+ *
+ * Starts the DRM schedulers for all user exec queues managed by this GuC.
+ * Must be called after xe_bo_restore_late() to ensure page tables are valid
+ * before any job submission triggers GuC context registration.
+ */
+void xe_guc_start_user_queues(struct xe_guc *guc)
+{
+	xe_guc_submit_start_user_queues(guc);
+}
+
 /**
  * xe_guc_runtime_suspend() - GuC runtime suspend
  * @guc: The GuC object
diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
index 02514914f404..ad2a6521852c 100644
--- a/drivers/gpu/drm/xe/xe_guc.h
+++ b/drivers/gpu/drm/xe/xe_guc.h
@@ -60,6 +60,7 @@ void xe_guc_reset_wait(struct xe_guc *guc);
 void xe_guc_stop_prepare(struct xe_guc *guc);
 void xe_guc_stop(struct xe_guc *guc);
 int xe_guc_start(struct xe_guc *guc);
+void xe_guc_start_user_queues(struct xe_guc *guc);
 void xe_guc_declare_wedged(struct xe_guc *guc);
 bool xe_guc_using_main_gamctrl_queues(struct xe_guc *guc);
 
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 4d32b430bc15..2b8b316c0ca3 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2535,6 +2535,16 @@ static void guc_exec_queue_start(struct xe_exec_queue *q)
 	xe_sched_submission_resume_tdr(sched);
 }
 
+/*
+ * Returns true for user exec queues whose page tables may not yet be
+ * restored when xe_guc_submit_start() is called during GT resume.
+ * These queues must be started later, after xe_bo_restore_late().
+ */
+static bool exec_queue_needs_late_start(const struct xe_exec_queue *q)
+{
+	return !(q->flags & (EXEC_QUEUE_FLAG_MIGRATE | EXEC_QUEUE_FLAG_VM));
+}
+
 int xe_guc_submit_start(struct xe_guc *guc)
 {
 	struct xe_exec_queue *q;
@@ -2549,6 +2559,10 @@ int xe_guc_submit_start(struct xe_guc *guc)
 		if (q->guc->id != index)
 			continue;
 
+		/* User queues are deferred until page tables are restored */
+		if (exec_queue_needs_late_start(q))
+			continue;
+
 		guc_exec_queue_start(q);
 	}
 	mutex_unlock(&guc->submission_state.lock);
@@ -2558,6 +2572,44 @@ int xe_guc_submit_start(struct xe_guc *guc)
 	return 0;
 }
 
+/**
+ * xe_guc_submit_start_user_queues() - Start user exec queues after late restore
+ * @guc: the GuC object
+ *
+ * Starts the DRM schedulers for all user exec queues (those not flagged as
+ * migrate or VM queues). Must be called after xe_bo_restore_late() to ensure
+ * page tables are valid before any job submission is attempted.
+ */
+void xe_guc_submit_start_user_queues(struct xe_guc *guc)
+{
+	struct xe_exec_queue *q;
+	unsigned long index;
+
+	if (!guc->submission_state.initialized)
+		return;
+
+	mutex_lock(&guc->submission_state.lock);
+	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q) {
+		/* Prevent redundant attempts to start parallel queues */
+		if (q->guc->id != index)
+			continue;
+
+		if (!exec_queue_needs_late_start(q))
+			continue;
+
+		/*
+		 * Skip queues whose scheduler is already running: they were
+		 * created after xe_guc_submit_start() decremented stopped to 0,
+		 * so they need no restart.
+		 */
+		if (!drm_sched_is_stopped(&q->guc->sched.base))
+			continue;
+
+		guc_exec_queue_start(q);
+	}
+	mutex_unlock(&guc->submission_state.lock);
+}
+
 static void guc_exec_queue_unpause_prepare(struct xe_guc *guc,
 					   struct xe_exec_queue *q)
 {
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.h b/drivers/gpu/drm/xe/xe_guc_submit.h
index b3839a90c142..b210b2f6cd2d 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.h
+++ b/drivers/gpu/drm/xe/xe_guc_submit.h
@@ -20,6 +20,7 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc);
 void xe_guc_submit_reset_wait(struct xe_guc *guc);
 void xe_guc_submit_stop(struct xe_guc *guc);
 int xe_guc_submit_start(struct xe_guc *guc);
+void xe_guc_submit_start_user_queues(struct xe_guc *guc);
 void xe_guc_submit_pause(struct xe_guc *guc);
 void xe_guc_submit_pause_abort(struct xe_guc *guc);
 void xe_guc_submit_pause_vf(struct xe_guc *guc);
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index d4672eb07476..c203a59d7000 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -282,6 +282,9 @@ int xe_pm_resume(struct xe_device *xe)
 	if (err)
 		goto err;
 
+	for_each_gt(gt, xe, id)
+		xe_gt_start_user_queues(gt);
+
 	xe_pxp_pm_resume(xe->pxp);
 
 	if (IS_VF_CCS_READY(xe))
@@ -696,6 +699,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 		err = xe_bo_restore_late(xe);
 		if (err)
 			goto out;
+
+		for_each_gt(gt, xe, id)
+			xe_gt_start_user_queues(gt);
 	}
 
 	xe_pxp_pm_resume(xe->pxp);
diff --git a/drivers/gpu/drm/xe/xe_uc.c b/drivers/gpu/drm/xe/xe_uc.c
index 75091bde0d50..12606133f5bc 100644
--- a/drivers/gpu/drm/xe/xe_uc.c
+++ b/drivers/gpu/drm/xe/xe_uc.c
@@ -263,6 +263,22 @@ int xe_uc_start(struct xe_uc *uc)
 	return xe_guc_start(&uc->guc);
 }
 
+/**
+ * xe_uc_start_user_queues() - Start user exec queues after late restore
+ * @uc: the UC object
+ *
+ * Starts the DRM schedulers for all user exec queues. Must be called after
+ * xe_bo_restore_late() to ensure page tables are valid before any job
+ * submission is attempted. Has no effect if GuC submission is not enabled.
+ */
+void xe_uc_start_user_queues(struct xe_uc *uc)
+{
+	if (!xe_device_uc_enabled(uc_to_xe(uc)))
+		return;
+
+	xe_guc_start_user_queues(&uc->guc);
+}
+
 static void uc_reset_wait(struct xe_uc *uc)
 {
 	int ret;
diff --git a/drivers/gpu/drm/xe/xe_uc.h b/drivers/gpu/drm/xe/xe_uc.h
index 255a54a8f876..2fd056cfa1d0 100644
--- a/drivers/gpu/drm/xe/xe_uc.h
+++ b/drivers/gpu/drm/xe/xe_uc.h
@@ -18,6 +18,7 @@ void xe_uc_runtime_suspend(struct xe_uc *uc);
 void xe_uc_stop_prepare(struct xe_uc *uc);
 void xe_uc_stop(struct xe_uc *uc);
 int xe_uc_start(struct xe_uc *uc);
+void xe_uc_start_user_queues(struct xe_uc *uc);
 void xe_uc_suspend_prepare(struct xe_uc *uc);
 int xe_uc_suspend(struct xe_uc *uc);
 int xe_uc_sanitize_reset(struct xe_uc *uc);
-- 
2.54.0


