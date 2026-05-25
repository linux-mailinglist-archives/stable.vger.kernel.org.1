Return-Path: <stable+bounces-254149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ2kBFBQFGrmMQcAu9opvQ
	(envelope-from <stable+bounces-254149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:36:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBF5CB390
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD7630459CA
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE0384CCD;
	Mon, 25 May 2026 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBoRIndr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FC3859E0
	for <stable@vger.kernel.org>; Mon, 25 May 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715885; cv=none; b=YHICHaQYJ/dumkeFNQctZzwywCgOpH9FglKaF2RZ6/AeqXNceobmSEaZGtdTEyfqfQas67Q86VsfGZkNVlHJF7VNQFEnO12pH5Ei4VoASfOgTxQkR0qWEX1trOMrXGcmiCchvlvP1ll91wv+rCkbPK0O5b+C34/taF3SJg/FKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715885; c=relaxed/simple;
	bh=c2Sl7c2Dhq9x+f3o9jE0GotgWKWWi4Rql4T0yM6k8rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=an7l+wecAXLFzODc+Ra30FMwvxAcT8DIbcuv0KiMey2R3Mxv+g+WEduj3Z8bAj+LdRMZ0tLyV2/eqfMNRf3kBWfRu9KVYtoDaNVWkdBx11FMfMbtgm/N1ZS9P6Wu/AuXmkB67QpZdcL6h4BqW7WHC8P8nI/FFdtgVuaZ/JKVk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBoRIndr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779715883; x=1811251883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c2Sl7c2Dhq9x+f3o9jE0GotgWKWWi4Rql4T0yM6k8rw=;
  b=oBoRIndrzvm5hPk1J2iU92H+OONVFJxs9BQEjw8QFonfBFuBFjgU+iIU
   M5gvHQZAasFcbt4ij/5rP968O0qxcijz4eltj5Rr16xzhUXMvgo04YxUJ
   9+fyv/logb8hDGGgRgd2rY2m/xlOwLMeKoy1Z8Hi7+nsg6Cq/Kd1j+aMr
   lQfgPoFn+O8Hepggsl5lW0ddZ9f579ws/jv+zckDvo+obvFnNVDRZSr/f
   TUl1xBxl4fuVkNhbIcX6uv4bMh6qWjV8MWR+sWOBAYIRwLso0ZOCVDZ8y
   lEl6/HWDFguPtn9lEbyedS9vMJYTMgrxqAVMI/M6ZzYTOdkjVl/PsltXe
   Q==;
X-CSE-ConnectionGUID: JOCjk3R9TreJcZqD82bKlA==
X-CSE-MsgGUID: osy80rQtSA2rNCCl3jBF7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91225458"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="91225458"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:31:23 -0700
X-CSE-ConnectionGUID: IJb0OIBLTVmDcCVjx2+b9A==
X-CSE-MsgGUID: TUGkhnv2R8W6n0CCEaC5CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="235241838"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.238])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:31:20 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Tomasz Lis <tomasz.lis@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Francois Dugast <francois.dugast@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v3 2/5] drm/xe/guc: Don't ban LR VM exec queues on PM suspend
Date: Mon, 25 May 2026 15:30:48 +0200
Message-ID: <20260525133051.91636-3-thomas.hellstrom@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254149-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 89EBF5CB390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When xe_guc_submit_stop() is called during an S3/S4 suspend or GT
reset, guc_exec_queue_stop() bans any user exec queue that has a job
which has started but not yet completed.  For normal (non-LR) exec
queues this is the correct behaviour: a started-but-incomplete job at
reset time may indicate a hung workload.

For exec queues attached to Long Running (LR) VMs the same condition
is always true during normal operation: LR jobs are designed to run
indefinitely and are never "completed" in the DRM scheduler sense —
they are preempted and resumed via the preempt-fence mechanism.
Banning such an exec queue on PM suspend permanently prevents the job
from restarting after resume, causing the userspace compute workload to
fail silently.

Fix this by not banning LR VM exec queues when a system suspend or
hibernation is in progress, while preserving the ban for GT reset where
a started-but-incomplete job is a legitimate indicator of a hang.

Fixes: f6375fb3aa94 ("drm/xe: Track LR jobs in DRM scheduler pending list")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Tomasz Lis <tomasz.lis@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.19+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
---
 drivers/gpu/drm/xe/xe_device_types.h |  8 ++++++++
 drivers/gpu/drm/xe/xe_guc_submit.c   | 10 +++++++++-
 drivers/gpu/drm/xe/xe_pm.c           |  5 ++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 32dd2ffbc796..9dbf7b3a0c49 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -433,6 +433,14 @@ struct xe_device {
 	struct notifier_block pm_notifier;
 	/** @pm_block: Completion to block validating tasks on suspend / hibernate prepare */
 	struct completion pm_block;
+	/**
+	 * @pm_suspend_in_progress: True while the device is going through
+	 * system suspend or hibernation (set at xe_pm_suspend() entry, cleared
+	 * at xe_pm_resume() entry or on suspend error). Used to suppress exec
+	 * queue bans that should only apply during GT reset, not PM suspend.
+	 * Serialised by the PM suspend sequence; no lock required.
+	 */
+	bool pm_suspend_in_progress;
 	/** @rebind_resume_list: List of wq items to kick on resume. */
 	struct list_head rebind_resume_list;
 	/** @rebind_resume_lock: Lock to protect the rebind_resume_list */
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 2b8b316c0ca3..f1a6f13011b5 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2268,8 +2268,16 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 	 * Ban any engine (aside from kernel and engines used for VM ops) with a
 	 * started but not complete job or if a job has gone through a GT reset
 	 * more than twice.
+	 *
+	 * LR VM exec queues are excluded from this ban during PM suspend: their
+	 * jobs are intentionally long-running and are preempted and resumed via
+	 * the preempt-fence mechanism. Banning them on PM suspend would
+	 * permanently prevent the job from restarting after resume.
+	 * On GT reset however we do want to ban them, as that may indicate a
+	 * genuinely hung workload.
 	 */
-	if (!(q->flags & (EXEC_QUEUE_FLAG_KERNEL | EXEC_QUEUE_FLAG_VM))) {
+	if (!(q->flags & (EXEC_QUEUE_FLAG_KERNEL | EXEC_QUEUE_FLAG_VM)) &&
+	    !(q->vm && xe_vm_in_lr_mode(q->vm) && guc_to_xe(guc)->pm_suspend_in_progress)) {
 		struct xe_sched_job *job = xe_sched_first_pending_job(sched);
 		bool ban = false;
 
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index c203a59d7000..76d211986822 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -176,6 +176,7 @@ int xe_pm_suspend(struct xe_device *xe)
 	int err;
 
 	drm_dbg(&xe->drm, "Suspending device\n");
+	xe->pm_suspend_in_progress = true;
 	xe_pm_block_begin_signalling();
 	trace_xe_pm_suspend(xe, __builtin_return_address(0));
 
@@ -217,6 +218,7 @@ int xe_pm_suspend(struct xe_device *xe)
 	xe_pxp_pm_resume(xe->pxp);
 err:
 	drm_dbg(&xe->drm, "Device suspend failed %d\n", err);
+	xe->pm_suspend_in_progress = false;
 	xe_pm_block_end_signalling();
 	return err;
 }
@@ -234,8 +236,9 @@ int xe_pm_resume(struct xe_device *xe)
 	u8 id;
 	int err;
 
-	xe_pm_block_begin_signalling();
+	xe->pm_suspend_in_progress = false;
 	drm_dbg(&xe->drm, "Resuming device\n");
+	xe_pm_block_begin_signalling();
 	trace_xe_pm_resume(xe, __builtin_return_address(0));
 
 	for_each_gt(gt, xe, id)
-- 
2.54.0


