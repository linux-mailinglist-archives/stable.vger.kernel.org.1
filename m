Return-Path: <stable+bounces-253818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A5OMPSHEGriYwYAu9opvQ
	(envelope-from <stable+bounces-253818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:44:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 070935B7AFB
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E6A23005AA8
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3F47884B;
	Fri, 22 May 2026 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BS2hT/CO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5344CADF
	for <stable@vger.kernel.org>; Fri, 22 May 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468268; cv=none; b=oaewDw/gobA7RDpJco6E6FgsK7vIybcheU+00NgzGYlmYLpHjbkJqWN++ya3/iMrcCh6+0j7EUIU9FQgsD1823SnC66SJneKHLgzc/8rJ7EhAkKaVGVBCz7iw/PEC2IDM/++PUHOrTd+L+7sKIVKC8nWAnqEDwz0tXvHlhQ13vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468268; c=relaxed/simple;
	bh=tXgWROCUuZGNdu5o7XsYPMykxIJCauydPhoeyxfHchs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZzhe7GOC7Fnj65y0me7VshbOPC3Pt1/no/vWqrcCu6Cdcfp3c4hh5JvbaI6WjMknU9hgSDk1xwjCXeonM8lX6yqSW0KzyRPhfRGpnRR5R9oJT6SzgHCTR7k+JgfoJxRvMUXJitpN4PJIY8uXrOFvrtOg8WFF0kyecdMP32cUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BS2hT/CO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779468265; x=1811004265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tXgWROCUuZGNdu5o7XsYPMykxIJCauydPhoeyxfHchs=;
  b=BS2hT/CO5Ea1SHPUFmCdbViVUlUbBxW9GZGmQSctpjIn4cloXsyQ7KNy
   s7/77lla6uNEio1cgCpyFFFRvco+lOkGAbaL0PjyYJqUFm5He86CkYZok
   L3HQnbSE5DNIRd4NvNRhrRZHAEptJ87O6JOVrhDvpt4gj+TfnMi3L3ihJ
   UKb2IxO/ddbc8HSF4LVGBD/Ro121ZqYwE92C+3eK8sjpmV7v08PL7C4UL
   11caWPRnwezWP9Dny4hL0uQdreIiREHkexyh4/l+y/2ZDNkk0SxBhXLUd
   hcA+q+nvYDrrpUXDDjWnhIP+hiUWN845g3B0DPwKO5p0TbzAJPkuCCNXI
   Q==;
X-CSE-ConnectionGUID: X9HFLL0nSKSynKoW/bJ8FA==
X-CSE-MsgGUID: 6S3Z2LMGQ/Cs3L6JvQYcDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80453394"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="80453394"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 09:44:25 -0700
X-CSE-ConnectionGUID: t79GP8jtS4etkNvWdfcuxA==
X-CSE-MsgGUID: FH8YZhifTnmMa94W83NrRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="238370116"
Received: from vpanait-mobl.ger.corp.intel.com (HELO fedora) ([10.245.244.219])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 09:44:22 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Tomasz Lis <tomasz.lis@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] drm/xe/guc: Don't ban LR VM exec queues on PM suspend
Date: Fri, 22 May 2026 18:43:52 +0200
Message-ID: <20260522164355.2773-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522164355.2773-1-thomas.hellstrom@linux.intel.com>
References: <20260522164355.2773-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253818-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 070935B7AFB
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
index 084ecc8e7efa..42bc7425de0d 100644
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


