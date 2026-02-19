Return-Path: <stable+bounces-217490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMKELFRRl2nswwIAu9opvQ
	(envelope-from <stable+bounces-217490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:07:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C20B1161788
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F4C301DE1A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB717352C28;
	Thu, 19 Feb 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVzcDHTa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00234D93E
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524427; cv=none; b=ITriX7V/x7HAdPVQe7hatBHSdzRIAWoadKWPfue4xA9wSrhoRErFQ/fTm7yX+nLLZIC2dY6cljBFyTfRLDa9bZEPdqN2U/cdJN2U6n7kdRPEItf7ZVsjHShLDDT347tAmsltlmuV5Hcr7nGTuIJhyD1PWhIIIaVY3EoOsbpoo2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524427; c=relaxed/simple;
	bh=7OdAg7o9l8SL5M+eZ0J2cHBwp+I6mykn2ZvzlPe4/sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kzzMJ3eWTfie+po5EOBIYTdXhNiQYRIOFT0PrlW0w/O6aROtABYnCE93cfCkE55o7wn6oSMU8OYWFYlL63AnIBKTVBluJeCqLiEfYqGRJlPuGZ53NS4kkJS0FGrpjOTFe0gJs2Dqkdz92tNopiR5Gok4KHxw/w9GGwZFwDy7dME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVzcDHTa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771524426; x=1803060426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7OdAg7o9l8SL5M+eZ0J2cHBwp+I6mykn2ZvzlPe4/sQ=;
  b=SVzcDHTayvRXlxMib2et/+CwX6FIgmK3feb8d6kGAGNnSGXZb02P+y2e
   0vhCfHESFXpV6L68gf8LnXJjhvhPC4rpGIPAVFDsWpUNY7013Z66GhTOC
   bFzvJ6WNAH5bMhsh6h0tJyd23FnaFTa2bgps9KbHDpunPmWje/3F3O4fW
   HTOAHyW/FwX0sfvKnvmenIBM2NfVNW2JGXY/jUH8q5CH2LksludX4v7Ma
   3FasKFeDCZJQhg2Sf3v6IRLAIs6/V8HURabDWczstaQW40z3ZoWiX45Y3
   iWmur0MhT+zA3T45zqhlk3n4B4DDPLMaQzRPFK2e5w3S+57VDFcfIFghu
   w==;
X-CSE-ConnectionGUID: LEqWHYYiS/a6HH02I8bDWA==
X-CSE-MsgGUID: eUJg0cZnQmyEQzefl0uq0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76482813"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76482813"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:07:03 -0800
X-CSE-ConnectionGUID: 7sFLPOtsSBe3nYp8MSA4CA==
X-CSE-MsgGUID: T9oMHlFvQEy6bS+fjMGIMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="245189020"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa002.jf.intel.com with ESMTP; 19 Feb 2026 10:07:03 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Wajdeczko@web.codeaurora.org,
	Michal <Michal.Wajdeczko@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>, stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v7 2/7] drm/xe: Forcefully tear down exec queues in GuC submit fini
Date: Thu, 19 Feb 2026 13:06:56 -0500
Message-Id: <20260219180701.2418453-3-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219180701.2418453-1-zhanjun.dong@intel.com>
References: <20260219180701.2418453-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[intel.com:s=Intel];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217490-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:email]
X-Rspamd-Queue-Id: C20B1161788
X-Rspamd-Action: no action

In GuC submit fini, forcefully tear down any exec queues by disabling
CTs, stopping the scheduler (which cleans up lost G2H), killing all
remaining queues, and resuming scheduling to allow any remaining cleanup
actions to complete and signal any remaining fences.

Split guc_submit_fini into device related and software only part. Using
device-managed and drm-managed action guarantees the correct ordering of
cleanup.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---
history:
v4:
 - Split guc_submit_fini into 2 parts, device related by devm and software
   only part by drmm
v3:
 - Add page fault fix
v2:
 - Fix VF failure (CI)
---
 drivers/gpu/drm/xe/xe_guc.c        | 18 +++++++++--
 drivers/gpu/drm/xe/xe_guc.h        |  1 +
 drivers/gpu/drm/xe/xe_guc_submit.c | 48 +++++++++++++++++++++++-------
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index cbbb4d665b8f..f59ae602b8ed 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -1402,15 +1402,29 @@ int xe_guc_enable_communication(struct xe_guc *guc)
 	return 0;
 }
 
-int xe_guc_suspend(struct xe_guc *guc)
+int xe_guc_softreset(struct xe_guc *guc)
 {
-	struct xe_gt *gt = guc_to_gt(guc);
 	u32 action[] = {
 		XE_GUC_ACTION_CLIENT_SOFT_RESET,
 	};
 	int ret;
 
+	if (!xe_uc_fw_is_running(&guc->fw))
+		return 0;
+
 	ret = xe_guc_mmio_send(guc, action, ARRAY_SIZE(action));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int xe_guc_suspend(struct xe_guc *guc)
+{
+	struct xe_gt *gt = guc_to_gt(guc);
+	int ret;
+
+	ret = xe_guc_softreset(guc);
 	if (ret) {
 		xe_gt_err(gt, "GuC suspend failed: %pe\n", ERR_PTR(ret));
 		return ret;
diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
index 66e7edc70ed9..02514914f404 100644
--- a/drivers/gpu/drm/xe/xe_guc.h
+++ b/drivers/gpu/drm/xe/xe_guc.h
@@ -44,6 +44,7 @@ int xe_guc_opt_in_features_enable(struct xe_guc *guc);
 void xe_guc_runtime_suspend(struct xe_guc *guc);
 void xe_guc_runtime_resume(struct xe_guc *guc);
 int xe_guc_suspend(struct xe_guc *guc);
+int xe_guc_softreset(struct xe_guc *guc);
 void xe_guc_notify(struct xe_guc *guc);
 int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
 int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 42712acf2ec2..bfb176c201c7 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -47,6 +47,8 @@
 
 #define XE_GUC_EXEC_QUEUE_CGP_CONTEXT_ERROR_LEN		6
 
+static int __xe_guc_submit_reset_prepare(struct xe_guc *guc);
+
 static struct xe_guc *
 exec_queue_to_guc(struct xe_exec_queue *q)
 {
@@ -238,7 +240,7 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
 		 EXEC_QUEUE_STATE_BANNED));
 }
 
-static void guc_submit_fini(struct drm_device *drm, void *arg)
+static void guc_submit_sw_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc *guc = arg;
 	struct xe_device *xe = guc_to_xe(guc);
@@ -256,6 +258,19 @@ static void guc_submit_fini(struct drm_device *drm, void *arg)
 	xa_destroy(&guc->submission_state.exec_queue_lookup);
 }
 
+static void guc_submit_fini(void *arg)
+{
+	struct xe_guc *guc = arg;
+
+	/* Forcefully kill any remaining exec queues */
+	xe_guc_ct_stop(&guc->ct);
+	__xe_guc_submit_reset_prepare(guc);
+	xe_guc_softreset(guc);
+	xe_guc_submit_stop(guc);
+	xe_uc_fw_sanitize(&guc->fw);
+	xe_guc_submit_pause_abort(guc);
+}
+
 static void guc_submit_wedged_fini(void *arg)
 {
 	struct xe_guc *guc = arg;
@@ -325,7 +340,11 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
 
 	guc->submission_state.initialized = true;
 
-	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
+	err = drmm_add_action_or_reset(&xe->drm, guc_submit_sw_fini, guc);
+	if (err)
+		return err;
+
+	return devm_add_action_or_reset(xe->drm.dev, guc_submit_fini, guc);
 }
 
 /*
@@ -2298,6 +2317,7 @@ static const struct xe_exec_queue_ops guc_exec_queue_ops = {
 static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 {
 	struct xe_gpu_scheduler *sched = &q->guc->sched;
+	bool do_destroy = false;
 
 	/* Stop scheduling + flush any DRM scheduler operations */
 	xe_sched_submission_stop(sched);
@@ -2305,7 +2325,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 	/* Clean up lost G2H + reset engine state */
 	if (exec_queue_registered(q)) {
 		if (exec_queue_destroyed(q))
-			__guc_exec_queue_destroy(guc, q);
+			do_destroy = true;
 	}
 	if (q->guc->suspend_pending) {
 		set_exec_queue_suspended(q);
@@ -2341,18 +2361,15 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 			xe_guc_exec_queue_trigger_cleanup(q);
 		}
 	}
+
+	if (do_destroy)
+		__guc_exec_queue_destroy(guc, q);
 }
 
-int xe_guc_submit_reset_prepare(struct xe_guc *guc)
+static int __xe_guc_submit_reset_prepare(struct xe_guc *guc)
 {
 	int ret;
 
-	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
-		return 0;
-
-	if (!guc->submission_state.initialized)
-		return 0;
-
 	/*
 	 * Using an atomic here rather than submission_state.lock as this
 	 * function can be called while holding the CT lock (engine reset
@@ -2367,6 +2384,17 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
 	return ret;
 }
 
+int xe_guc_submit_reset_prepare(struct xe_guc *guc)
+{
+	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
+		return 0;
+
+	if (!guc->submission_state.initialized)
+		return 0;
+
+	return __xe_guc_submit_reset_prepare(guc);
+}
+
 void xe_guc_submit_reset_wait(struct xe_guc *guc)
 {
 	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||
-- 
2.34.1


