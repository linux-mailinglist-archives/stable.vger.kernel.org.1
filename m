Return-Path: <stable+bounces-94628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA29D6209
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 17:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2653F28354B
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF411DF263;
	Fri, 22 Nov 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ii5YzrYX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBF1DF25B
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292382; cv=none; b=ChruPgo4UvEnhwojDaGomHV7srLYNDvdsGMX8/rjZ1vNo3JB1YNuwPTKP5LRFTRb/D9PLRLDP7G4U7fo6+6FcnpFJCMbJhXlJGvRxee5DUEDeoxHqlpFA7QsDfjUy28n7xTZXS1bN23GDHRrSz31DqcPIqLPZPzPXiISPZCsEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292382; c=relaxed/simple;
	bh=hjpAAdUdKDykX0lFpMblzlzSo7UGuy4oryx9ueMiLBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REGhGRrfvr0P5wQ2Xlfil9mZ2u9x9164LXfTwrcWi2s8cjndhdvTda2axJU47WCdviE+WZ1qBiTHikQai3OMivGCMdtsWlkh4Z1eHmZxvIyHNvbmBm3zgP0+7Swt6o2jsaC5zR5D532/DwuJFN+RTAAyuo+i35QHKGEsmW9aT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ii5YzrYX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732292380; x=1763828380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hjpAAdUdKDykX0lFpMblzlzSo7UGuy4oryx9ueMiLBY=;
  b=Ii5YzrYX9odqrN4g6V3vdK+axKD/2ouSbDpiEACHRDhl8cduOFZB/+4w
   C3eUjEmx6PCWuzii9r+4enWMcG7SInUGPpPHsNidLjZdq+x095qWk5D6Y
   ifZSyYS1Vl1gBcw4fPkskroEV0D3UlZz97rYmO+zL5TyxIVUBePYtJbo7
   uwStLO26SsTrB8mVoX4BajbuJfiY+jLpOoJydtfRVnyeZEcUtS2+64PDL
   HmT9qbV2FJ4MO+VR6IcxK9///8NwcdHvgQUIKHNRdcLIUm8Hfb7JidOBZ
   TS5KnnkVt6h022/mRw3NUEaIBaGRwJuiBlqIa8Q543O8W/2afC/pE2Rz+
   g==;
X-CSE-ConnectionGUID: Y3aEiOFxSMa3d89UtFT/Gw==
X-CSE-MsgGUID: kt3SYjvcRJe5o+uHY+6iJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32379410"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32379410"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 08:19:39 -0800
X-CSE-ConnectionGUID: 9iPrET2gRBmM0ER89gY/6A==
X-CSE-MsgGUID: mSdg8VmcQSCum1ht8eaGKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="90782840"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.10])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 08:19:38 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] drm/xe/guc_submit: fix race around pending_disable
Date: Fri, 22 Nov 2024 16:19:16 +0000
Message-ID: <20241122161914.321263-5-matthew.auld@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122161914.321263-4-matthew.auld@intel.com>
References: <20241122161914.321263-4-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently in some testcases we can trigger:

[drm] *ERROR* GT0: SCHED_DONE: Unexpected engine state 0x02b1, guc_id=8, runnable_state=0
[drm] *ERROR* GT0: G2H action 0x1002 failed (-EPROTO) len 3 msg 02 10 00 90 08 00 00 00 00 00 00 00

Looking at a snippet of corresponding ftrace for this GuC id we can see:

498.852891: xe_sched_msg_add:     dev=0000:03:00.0, gt=0 guc_id=8, opcode=3
498.854083: xe_sched_msg_recv:    dev=0000:03:00.0, gt=0 guc_id=8, opcode=3
498.855389: xe_exec_queue_kill:   dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x3, flags=0x0
498.855436: xe_exec_queue_lr_cleanup: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x83, flags=0x0
498.856767: xe_exec_queue_close:  dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x83, flags=0x0
498.862889: xe_exec_queue_scheduling_disable: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0xa9, flags=0x0
498.863032: xe_exec_queue_scheduling_disable: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b9, flags=0x0
498.875596: xe_exec_queue_scheduling_done: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b9, flags=0x0
498.875604: xe_exec_queue_deregister: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b1, flags=0x0
499.074483: xe_exec_queue_deregister_done: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b1, flags=0x0

This looks to be the two scheduling_disable racing with each other, one
from the suspend (opcode=3) and then again during lr cleanup. While
those two operations are serialized, the G2H portion is not, therefore
when marking the queue as pending_disabled and then firing off the first
request, we proceed do the same again, however the first disable
response only fires after this which then clears the pending_disabled.
At this point the second comes back and is processed, however the
pending_disabled is no longer set, hence triggering the warning.

To fix this wait for pending_disabled when doing the lr cleanup and
calling disable_scheduling_deregister. Also do the same for all other
disable_scheduling callers.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3515
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index f9ecee5364d8..f3c22b101916 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -767,12 +767,15 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
 
 	set_min_preemption_timeout(guc, q);
 	smp_rmb();
-	ret = wait_event_timeout(guc->ct.wq, !exec_queue_pending_enable(q) ||
-				 xe_guc_read_stopped(guc), HZ * 5);
+	ret = wait_event_timeout(guc->ct.wq,
+				 (!exec_queue_pending_enable(q) &&
+				  !exec_queue_pending_disable(q)) ||
+					 xe_guc_read_stopped(guc),
+				 HZ * 5);
 	if (!ret) {
 		struct xe_gpu_scheduler *sched = &q->guc->sched;
 
-		xe_gt_warn(q->gt, "Pending enable failed to respond\n");
+		xe_gt_warn(q->gt, "Pending enable/disable failed to respond\n");
 		xe_sched_submission_start(sched);
 		xe_gt_reset_async(q->gt);
 		xe_sched_tdr_queue_imm(sched);
@@ -1099,7 +1102,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 			 * modifying state
 			 */
 			ret = wait_event_timeout(guc->ct.wq,
-						 !exec_queue_pending_enable(q) ||
+						 (!exec_queue_pending_enable(q) &&
+						  !exec_queue_pending_disable(q)) ||
 						 xe_guc_read_stopped(guc), HZ * 5);
 			if (!ret || xe_guc_read_stopped(guc))
 				goto trigger_reset;
@@ -1329,8 +1333,8 @@ static void __guc_exec_queue_process_msg_suspend(struct xe_sched_msg *msg)
 
 	if (guc_exec_queue_allowed_to_change_state(q) && !exec_queue_suspended(q) &&
 	    exec_queue_enabled(q)) {
-		wait_event(guc->ct.wq, q->guc->resume_time != RESUME_PENDING ||
-			   xe_guc_read_stopped(guc));
+		wait_event(guc->ct.wq, (q->guc->resume_time != RESUME_PENDING ||
+			   xe_guc_read_stopped(guc)) && !exec_queue_pending_disable(q));
 
 		if (!xe_guc_read_stopped(guc)) {
 			s64 since_resume_ms =
-- 
2.47.0


