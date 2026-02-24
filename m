Return-Path: <stable+bounces-217927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFHLK5rUnWk0SQQAu9opvQ
	(envelope-from <stable+bounces-217927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 17:40:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13754189E94
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 17:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3DF231E616B
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E513A9608;
	Tue, 24 Feb 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpoLjqi8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8763A9017
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950962; cv=none; b=sL00SHP3Y6n786vCBxxC/CYoxKOfgK7ZX8vcol4kFYte/HeZPsEGM1aDO+x/1fyfRLFYsrlNnKjJDS6t/5aQbMGVGUkNHxvKxhFCSpr8twRO14hsM8y5asCTpL2Vbaj7/B+J5qt8a3enXLlrGW2Bw2WbPZMO+kQM2beQGD95tjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950962; c=relaxed/simple;
	bh=7NsKUzYRGP4BbWXIF3AUxIKKqcoz50r28mvkV2vjuQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCCflpqwyr7+iIvkYow/rU4HSV/yN/KOQUhdVHJZkAsdtJd78/za5onRy7tPPR0fE4BMHHnDGBFCRjm5FExZMoTTGdj74tmU5LJffvRiW3huNzgmK1mkVxHyJAOMEKNdl67HWo7sH6nh4TnMwf2JnSdoexjPKZbQYckwfWS6G9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpoLjqi8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771950961; x=1803486961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NsKUzYRGP4BbWXIF3AUxIKKqcoz50r28mvkV2vjuQc=;
  b=UpoLjqi875JjhVYOo/40Iwa7i//9FK9UhFC6x1235SGPnQJNoIAc51TQ
   vLDC1jPZY5GPCXiJyMwAuxqvgQJEMvTkfDPi6Hvet84hulrJp6wcdBK9Z
   wN2+BkOWhTiZGPZ3+EBCo2oF7SDI3w0J6poUfiL4fCCMH7QQCJ33K72WG
   Aymin9IF9hRLOimo8uzCPor29gO8nd465moZk4hns094lXPEeaXgPM0OH
   CJ7WNm/wiAfmrWXG6KlWQ7idCuvcxsJyzkbsCieI/FI6SmgzkkQD3doCx
   E6Hs4sFdcVL3iTL/fGIRFYthicwyBB2AiRFrZZCXH2TmIUdlkje9ZmCOk
   w==;
X-CSE-ConnectionGUID: q4uBH7zTTKKxG9SjUwU05w==
X-CSE-MsgGUID: ex91a8lNS9aEQeuY6g4IvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73040143"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73040143"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 08:35:58 -0800
X-CSE-ConnectionGUID: WqRlrXRnSFSLnXZw+N7ogg==
X-CSE-MsgGUID: Qv2OjhzvRX6LMJBxz/3f6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220555626"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 08:35:58 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Zhanjun Dong <zhanjun.dong@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v8 3/7] drm/xe: Trigger queue cleanup if not in wedged mode 2
Date: Tue, 24 Feb 2026 11:35:51 -0500
Message-Id: <20260224163555.218750-4-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224163555.218750-1-zhanjun.dong@intel.com>
References: <20260224163555.218750-1-zhanjun.dong@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217927-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 13754189E94
X-Rspamd-Action: no action

The intent of wedging a device is to allow queues to continue running
only in wedged mode 2. In other modes, queues should initiate cleanup
and signal all remaining fences. Fix xe_guc_submit_wedge to correctly
clean up queues when wedge mode != 2.

Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 35 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index c8b59e662c9e..04a575221528 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1319,6 +1319,7 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
  */
 void xe_guc_submit_wedge(struct xe_guc *guc)
 {
+	struct xe_device *xe = guc_to_xe(guc);
 	struct xe_gt *gt = guc_to_gt(guc);
 	struct xe_exec_queue *q;
 	unsigned long index;
@@ -1333,20 +1334,28 @@ void xe_guc_submit_wedge(struct xe_guc *guc)
 	if (!guc->submission_state.initialized)
 		return;
 
-	err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
-				       guc_submit_wedged_fini, guc);
-	if (err) {
-		xe_gt_err(gt, "Failed to register clean-up in wedged.mode=%s; "
-			  "Although device is wedged.\n",
-			  xe_wedged_mode_to_string(XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET));
-		return;
-	}
+	if (xe->wedged.mode == 2) {
+		err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
+					       guc_submit_wedged_fini, guc);
+		if (err) {
+			xe_gt_err(gt, "Failed to register clean-up on wedged.mode=2; "
+				  "Although device is wedged.\n");
+			return;
+		}
 
-	mutex_lock(&guc->submission_state.lock);
-	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
-		if (xe_exec_queue_get_unless_zero(q))
-			set_exec_queue_wedged(q);
-	mutex_unlock(&guc->submission_state.lock);
+		mutex_lock(&guc->submission_state.lock);
+		xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
+			if (xe_exec_queue_get_unless_zero(q))
+				set_exec_queue_wedged(q);
+		mutex_unlock(&guc->submission_state.lock);
+	} else {
+		/* Forcefully kill any remaining exec queues, signal fences */
+		guc_submit_reset_prepare(guc);
+		xe_guc_submit_stop(guc);
+		xe_guc_softreset(guc);
+		xe_uc_fw_sanitize(&guc->fw);
+		xe_guc_submit_pause_abort(guc);
+	}
 }
 
 static bool guc_submit_hint_wedged(struct xe_guc *guc)
-- 
2.34.1


