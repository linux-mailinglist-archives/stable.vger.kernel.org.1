Return-Path: <stable+bounces-211871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMHdDmjweGkCuAEAu9opvQ
	(envelope-from <stable+bounces-211871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 18:05:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A469798293
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1B1D302BA01
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92A3624B9;
	Tue, 27 Jan 2026 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HF1xwx9M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F953362128
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533504; cv=none; b=RCXNoNQ+cdNNdlgOxLXO2FlUb5hqwKRtP4i7EIEy9PvXazc0o5rE1dlNhGlgnWyhp6pQ6pa8rmADf67Sc7S3H8H+LkI9Y0XIsmiV1MMj2CqSnmRE7sANx9Dqpvp60pJNrLh34l3E+g93yvKn6tLegZIrwyOFfSUozXMnGKNdQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533504; c=relaxed/simple;
	bh=fb6pI9aTPHVF85IUn8Z0Bx0gwKHL+eX8zeovOXPfiD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pPVcGVL/bg5bSxHQLHfP+OOcXa8Hb6dhhvQcMKbwMrH+1JtEWenKL+XndJ3e6P9d3t1N3uzVcKlO8/D8ladN7a8qmuXf0pK28br8Fw+gsb+Kis3Po1uRP8mtkirZbianyXsiD0HvPOANBYj0fcqC+CwOz7p6x7zCA0I/hr8exPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HF1xwx9M; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769533503; x=1801069503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fb6pI9aTPHVF85IUn8Z0Bx0gwKHL+eX8zeovOXPfiD8=;
  b=HF1xwx9M/xsc+qEaY+tNGL0cwWOsfO6wj/tNTTF/XkZQowbJpdkh/pGd
   seIFe4bZ8dAusTtI9hCapwkO90WkBiG+8U5Z4zf5dMhFQ67wXoA0VBujf
   6iQQdg7NcYepKy0CYmEm3+MeL1ttQ9yXA1pdKFZRZKrFmgEMz/Mo1AnVP
   eStrkyfM2W8uuRo9wetvuFh4qq3ws+/tB/PggUJQs+RtrfjOZO/xxr2gl
   LYtO6FsQLE/vts7jVC1U/ZMcYGJ984yzAr4/prplIfuGk/LYhYJrQEkF3
   KWnB9GsZYh7xhGhKa2B26rNqNBwsa/dkdoYoG1gTaJNNw/0smtoANWBVQ
   A==;
X-CSE-ConnectionGUID: sfmQcJ63ST2Uc0gBAXaEAQ==
X-CSE-MsgGUID: Nt+WaLIuSgi6G1UEhJPNMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93393524"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="93393524"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 09:04:57 -0800
X-CSE-ConnectionGUID: 1E0zqbAnQyiVtZhmZ4Q/QA==
X-CSE-MsgGUID: n11JefjYQVOhLLs46R9vJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208039392"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa008.jf.intel.com with ESMTP; 27 Jan 2026 09:04:57 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org,
	Zhanjun Dong <zhanjun.dong@intel.com>
Subject: [PATCH v4 2/5] drm/xe: Forcefully tear down exec queues in GuC submit fini
Date: Tue, 27 Jan 2026 12:04:52 -0500
Message-Id: <20260127170455.618616-3-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127170455.618616-1-zhanjun.dong@intel.com>
References: <20260127170455.618616-1-zhanjun.dong@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211871-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: A469798293
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


