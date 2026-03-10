Return-Path: <stable+bounces-224598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKG4BYugsGkwlQIAu9opvQ
	(envelope-from <stable+bounces-224598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:51:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C1A259174
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C3A6307B679
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389613BED45;
	Tue, 10 Mar 2026 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLSGAau+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4613BBA0C
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183045; cv=none; b=OFVxmA/v/F3Q/QxJ9RpGpdHzTfl5/x6xp28zsGvnglIrbBO/XBvYsLppLl5rsLq6Ib/ur0M2oOg1HBpNOfA08g79xjoO4FxquwFysdF8SnxyLfpXLEiB+NyB5FQrTAFhitaQeCvIWYU7XSItgF3zgftyw+GMXwE9tYoRx4VCjSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183045; c=relaxed/simple;
	bh=MIzx/n8/FqBhb07NqepSBkx9AzpoCTmrGbXpYe1ylcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JbkWNEsQyHAQZzY0d6GgpLWOaIsWDF+NioGYAP5ki6a5k6ggakNboPGrmp/p1MX7PhTSY0MLhIIYPETv4pWZ3Ob4F136V+2WkUUJUDxQkU0ylh8+1SF23MT21+ta+nD6or84NagDr00yyZC2gIRsPQ8vq2GHucq0Pefpk85HVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLSGAau+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773183044; x=1804719044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MIzx/n8/FqBhb07NqepSBkx9AzpoCTmrGbXpYe1ylcI=;
  b=ZLSGAau+QlJhizvdjZ9rqEbA+tCuwPJVMF56PPyFgzrrGN7u66/IfzBa
   UJxgCc3RC5KDQyP9REbo0UTi9kSPWNWezZ3PDiXrNEMMvK8bY9P8yM7Ni
   a1Z4/73w7p3lV49CQ8Z4LVVoso038cdlpK/6iE7cq0uGoFOF5nBTva9Zu
   9tohiG44c3VITIcZdgZ8becQGNOY6hqbGSPsMCWcdOuWk1TNCRMS3qEl5
   nMkgDy5Pb5UKi2f9iJ+rNu/VaW37EovYBQtUJcPxOp4veH0ma6clJP9T2
   Prm+wfnh/CSxs27CEaZ/2usKDHVYbwp0VO0RzgaaZLD5nCZuasWcfDIST
   A==;
X-CSE-ConnectionGUID: mb03QHjOQbqNdiQxnfUNZg==
X-CSE-MsgGUID: WIQKKjrtShyvTGlIgnQYlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61817882"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61817882"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:50:42 -0700
X-CSE-ConnectionGUID: yPIjyh42TFSVQVksiO9OIA==
X-CSE-MsgGUID: CUPfv7RuTpiIM7P/+4taig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220440995"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa007.jf.intel.com with ESMTP; 10 Mar 2026 15:50:41 -0700
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Zhanjun Dong <zhanjun.dong@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v9 3/7] drm/xe: Trigger queue cleanup if not in wedged mode 2
Date: Tue, 10 Mar 2026 18:50:35 -0400
Message-Id: <20260310225039.1320161-4-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310225039.1320161-1-zhanjun.dong@intel.com>
References: <20260310225039.1320161-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7C1A259174
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
	TAGGED_FROM(0.00)[bounces-224598-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

The intent of wedging a device is to allow queues to continue running
only in wedged mode 2. In other modes, queues should initiate cleanup
and signal all remaining fences. Fix xe_guc_submit_wedge to correctly
clean up queues when wedge mode != 2.

Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 35 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 8afd424b27fb..cb32053d57ec 100644
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


