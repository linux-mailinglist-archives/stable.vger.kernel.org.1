Return-Path: <stable+bounces-212710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHEPG9qYemm58QEAu9opvQ
	(envelope-from <stable+bounces-212710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 00:16:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D1BA9E2B
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 00:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E247730162A7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50452335554;
	Wed, 28 Jan 2026 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhZMfLoK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C42DECBD
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642200; cv=none; b=TXJREEEAUIsH7qmuUGQOyENg1RtUyLgZjfaHY4bY3e0qyceXy8Gl6FokMj3Q5eKXaA6HN3BRsLbjy6gboYeLusoxDVUUHqAPlMc0eA9UJJwaIE8ENBgcVlHlYIckUk8+xFA40MwVLCqx81zeU3BnH7G1G4p44JeoKrn8NvFChTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642200; c=relaxed/simple;
	bh=fb6pI9aTPHVF85IUn8Z0Bx0gwKHL+eX8zeovOXPfiD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcHDoWQWfscr6xk/yAaZ0P7UDMQZ/jwkwonqPRA73coyxdpzV8TVcHemryIviYBljufsB+qQh6tnxaf6iu7l8rqpuN2k/PTurUNPWzfH4xxfZ+E42ub9FVcLGhjNS4ghDGal+71Yc19NingrIpy7imcsf59KO3cYlX91/vX8nNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhZMfLoK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769642198; x=1801178198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fb6pI9aTPHVF85IUn8Z0Bx0gwKHL+eX8zeovOXPfiD8=;
  b=nhZMfLoKkqr3W0Q3Kb06MoyUOeXjuQ18VVIQS3akWkh84btRXH/Fs5X6
   JNC8xI2Zn3K+TOK8RgQXSv1ZK25tKg5AjmsbZ9SANL+NKZTtI7Ct4YPoN
   ENCtYjnDjRbyspH50rquVt6rGcju9ZiKiR/PM1gWoh9aFVaJH0ZT0Ooi7
   br9ZUVi856yae2yv4MwEI2PdIF9wy5cybbS8QqmS7TcQTy5lpxfpavUIM
   Cw/u2b/Jf4gE/qE4KWsI4LxHzd7rMF+4sjnfKcVARIx+zjxAOYaTOY0Nx
   opNBdlPNSmUSmCCbibEVn0HWaNMdxdmlZlVswtsWu21oci2wu/Y0o3QM7
   A==;
X-CSE-ConnectionGUID: 0a2vL1HPT9uQcqhNZE6e0g==
X-CSE-MsgGUID: iFRPCmnERzuW5runNVpBZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462217"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="73462217"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:16:36 -0800
X-CSE-ConnectionGUID: QnQGy+zORUyQZuZ1njapsA==
X-CSE-MsgGUID: zKJ0K0qGTwOJbOj6VpvyBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213266642"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jan 2026 15:16:35 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org,
	Zhanjun Dong <zhanjun.dong@intel.com>
Subject: [PATCH v5 2/6] drm/xe: Forcefully tear down exec queues in GuC submit fini
Date: Wed, 28 Jan 2026 18:16:30 -0500
Message-Id: <20260128231634.982494-3-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128231634.982494-1-zhanjun.dong@intel.com>
References: <20260128231634.982494-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212710-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1D1BA9E2B
X-Rspamd-Action: no action

From: Matthew Brost <matthew.brost@intel.com>

In GuC submit fini, forcefully tear down any exec queues by disabling
CTs, stopping the scheduler (which cleans up lost G2H), killing all
remaining queues, and resuming scheduling to allow any remaining cleanup
actions to complete and signal any remaining fences.

guc_submit_fini requires access to device hardware. Using a device-managed
action guarantees the correct ordering of cleanup.

v3:
 - Add page fault fix
v2:
 - Fix VF failure (CI)

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 31 +++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index d61bd0094e0b..92ea32423838 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -239,13 +239,21 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
 		 EXEC_QUEUE_STATE_BANNED));
 }
 
-static void guc_submit_fini(struct drm_device *drm, void *arg)
+static int __xe_guc_submit_reset_prepare(struct xe_guc *guc);
+
+static void guc_submit_fini(void *arg)
 {
 	struct xe_guc *guc = arg;
 	struct xe_device *xe = guc_to_xe(guc);
 	struct xe_gt *gt = guc_to_gt(guc);
 	int ret;
 
+	/* Forcefully kill any remaining exec queues */
+	xe_guc_ct_stop(&guc->ct);
+	__xe_guc_submit_reset_prepare(guc);
+	xe_guc_submit_stop(guc);
+	xe_guc_submit_pause_abort(guc);
+
 	ret = wait_event_timeout(guc->submission_state.fini_wq,
 				 xa_empty(&guc->submission_state.exec_queue_lookup),
 				 HZ * 5);
@@ -326,7 +334,7 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
 
 	guc->submission_state.initialized = true;
 
-	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
+	return devm_add_action_or_reset(xe->drm.dev, guc_submit_fini, guc);
 }
 
 /*
@@ -2354,16 +2362,10 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 	}
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
@@ -2378,6 +2380,17 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
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


