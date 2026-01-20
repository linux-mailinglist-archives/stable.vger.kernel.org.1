Return-Path: <stable+bounces-210605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAYmLg/1b2m+UQAAu9opvQ
	(envelope-from <stable+bounces-210605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:35:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8011C4C58B
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8455154D1E7
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548493AA18E;
	Tue, 20 Jan 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9eR7XL7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062893A4F5B
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940188; cv=none; b=oQxw32QUq2CySPWg6kqdIvNKmauCkZFmTCvP1t7RfXCqoD8zPfNh0mn7IYGSNklLewXQUCjp1qN65V2grFt0rObGVF1mCpjjvmRflXzQ8ZHFESG0THfdXSFY5k+TCoH7Ihcm31QPhONiN52QGmXAfpSNpPXSALGrcNBUeBS97Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940188; c=relaxed/simple;
	bh=is2mTxcPa0ny+SCcI11ksXMU3M2/KulOqM7jyjKoWbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIoPVbXsisXhrhbFXOYAD0Q0cL9eH9p2uT4rQOVLySEH0ycCYt4xupbCoSj8JxyutZl+3nLB3rxdPZ0PRLALA8NIH0Nh3mkYeHi2eXGWtYmiy07sJOnn8fNWi/gJ7sZnF2KoEnVwTenAadG3wrfmIyU4jMy6e8hj1e87mExAee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9eR7XL7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768940186; x=1800476186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=is2mTxcPa0ny+SCcI11ksXMU3M2/KulOqM7jyjKoWbo=;
  b=K9eR7XL7Bg+BWUUifZG6IUun7oT4d+rzIGFoolXkJzTPcRUPbsPGV47o
   FqyMzIz8Ov7Ib4l0EmHdPhKe4DTlEjrfR2m3xkLo4pAr/IQrjJD4Czjty
   ttKzIXgmT/h/bfPNPZieHSdVFsIGkKMbDz2DhjnbuAM0BJoYr+zrGrnPh
   QHzmKrr1BRVcNF6CHbe4TOyv+a9q2Yew1gKVwg2hiLiOj6G77S8H0OuQt
   MpQP/5bq+ENRKXO6uejm9Y/8uJ+CkjNszqyHMyjHZoKsWQ+Pkt31KjE7U
   VRYxQDoSiya10r4erANjAQo1jMtl4VqBwjK9pN+ow7YxD9ZFGOoQilqrK
   A==;
X-CSE-ConnectionGUID: qeZLsgQ3QXKWnz6vpWa/DQ==
X-CSE-MsgGUID: QGtZbTOlTOKBreUayFuqiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87574656"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="87574656"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 12:16:24 -0800
X-CSE-ConnectionGUID: 3Q+9uZunRKuiZK6belF3TA==
X-CSE-MsgGUID: 9StJyxI2TGe4N1n2wDTNeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="210373498"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa003.jf.intel.com with ESMTP; 20 Jan 2026 12:16:24 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org,
	Zhanjun Dong <zhanjun.dong@intel.com>
Subject: [PATCH v3 3/6] drm/xe: Trigger queue cleanup if not in wedged mode 2
Date: Tue, 20 Jan 2026 15:16:18 -0500
Message-Id: <20260120201621.2442803-4-zhanjun.dong@intel.com>
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
	TAGGED_FROM(0.00)[bounces-210605-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 8011C4C58B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Matthew Brost <matthew.brost@intel.com>

The intent of wedging a device is to allow queues to continue running
only in wedged mode 2. In other modes, queues should initiate cleanup
and signal all remaining fences. Fix xe_guc_submit_wedge to correctly
clean up queues when wedge mode != 2.

Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 34 ++++++++++++++++++------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 088d05e502ae..c848615d6057 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1326,6 +1326,7 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
  */
 void xe_guc_submit_wedge(struct xe_guc *guc)
 {
+	struct xe_device *xe = guc_to_xe(guc);
 	struct xe_gt *gt = guc_to_gt(guc);
 	struct xe_exec_queue *q;
 	unsigned long index;
@@ -1340,20 +1341,27 @@ void xe_guc_submit_wedge(struct xe_guc *guc)
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
+		xe_guc_ct_stop(&guc->ct);
+		__xe_guc_submit_reset_prepare(guc);
+		xe_guc_submit_stop(guc);
+		xe_guc_submit_pause_abort(guc);
+	}
 }
 
 static bool guc_submit_hint_wedged(struct xe_guc *guc)
-- 
2.34.1


