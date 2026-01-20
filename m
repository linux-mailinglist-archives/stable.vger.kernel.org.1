Return-Path: <stable+bounces-210604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKVfFrr9b2mUUgAAu9opvQ
	(envelope-from <stable+bounces-210604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:12:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C87084CCCD
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAA428AE22D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352AB3A7849;
	Tue, 20 Jan 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U31mjgxX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8D3A9005
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940187; cv=none; b=pWg1oNmx5TpXng0VABP8Uyp36hrMIQfqtBWk6cU9NlVTSVa8LM7j0betfGEuulbnPGHZ/rrwOTFlCE3wer5LBI5lkKAunzK5om9xpZ7oSnX8Le4PbCUyMx2d9KmK4coaq1TMiXa/vQfU1OaDsy0b5dRP9VNRk/HghA4QvfMIbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940187; c=relaxed/simple;
	bh=bU6cbHeFzYawkmeHPgJhHamiX9vCw3SBKZhg7vy5IRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d07rNw/TNKCQwJ/AzMR+OJnad2P1j2AwfzYSuGfF+xYxkKjb4DoUKeJ/Vdxjy/3oRQ6JeQQOGnfzuXORlE1/0MHpld9L0LLZQmtaa5bGQxncb7rn2vuJ5OwJ3i3qBSBGJ+sc5Wssw18VK5tbVuxOyLkVY9ui3UT6nzMsVDjn3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U31mjgxX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768940186; x=1800476186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bU6cbHeFzYawkmeHPgJhHamiX9vCw3SBKZhg7vy5IRo=;
  b=U31mjgxXdBoPL2m7Am2X8ljF6vdt/OpR2YZz8GgwEzTHQUfMka2EOaN7
   8bLHfMeKHWCYgToPLnqNbeopg6ICatGmGQeBmcMyDyXyiNyB2fl3JDukx
   lPIvCTQ8fQW85DhVjQUI6iw2G1UnnovFNbit8wpAH7RDBCfGXnzOBQ+Pm
   zRgGGNyJ0IFnw7AbYXiCFJLhgTUAko59NeqiXtIQHjxsKJA5jKEpez7Qp
   LCWjfAoBMrsym4bKJST00jzNKr/XiXZFSH1nEnDjgJcmUqENqbql/x+a9
   XWpZQCu0g8aQe1RhDQxvEdNG7JY9u9yhgurMpgGhEtc6lpsoQw3aycTk3
   g==;
X-CSE-ConnectionGUID: D8v80UiWQvSLSFtwt2kp4g==
X-CSE-MsgGUID: hphvuZZaQMemvwYOLOSy4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87574654"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="87574654"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 12:16:24 -0800
X-CSE-ConnectionGUID: w2AxorJzRLmrqan7sSyvTw==
X-CSE-MsgGUID: WIhRtfuTSL2ioMwgUBDQrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="210373495"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa003.jf.intel.com with ESMTP; 20 Jan 2026 12:16:24 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org,
	Zhanjun Dong <zhanjun.dong@intel.com>
Subject: [PATCH v3 2/6] drm/xe: Forcefully tear down exec queues in GuC submit fini
Date: Tue, 20 Jan 2026 15:16:17 -0500
Message-Id: <20260120201621.2442803-3-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120201621.2442803-1-zhanjun.dong@intel.com>
References: <20260120201621.2442803-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210604-lists,stable=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: C87084CCCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Matthew Brost <matthew.brost@intel.com>

In GuC submit fini, forcefully tear down any exec queues by disabling
CTs, stopping the scheduler (which cleans up lost G2H), killing all
remaining queues, and resuming scheduling to allow any remaining cleanup
actions to complete and signal any remaining fences.

v2:
 - Fix VF failure (CI)

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index d61bd0094e0b..088d05e502ae 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -239,6 +239,8 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
 		 EXEC_QUEUE_STATE_BANNED));
 }
 
+static int __xe_guc_submit_reset_prepare(struct xe_guc *guc);
+
 static void guc_submit_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc *guc = arg;
@@ -246,6 +248,12 @@ static void guc_submit_fini(struct drm_device *drm, void *arg)
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


