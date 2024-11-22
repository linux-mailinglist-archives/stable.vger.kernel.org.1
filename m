Return-Path: <stable+bounces-94629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC289D620A
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 17:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3436228345B
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923D1DF27E;
	Fri, 22 Nov 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mf78kgq2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB81DF720
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292384; cv=none; b=bubEWkVkBPWI9rhrZViGzqgHh8wWXvppSzwWCx5APNxHk1Efzu2dJHGMHOYgqQnsbWOlMthaYaE0Dtew5v1Brs3Cz2fQjOaQ5RGqXB/b/PYBnFiHcBrVCTkCAW1XFTK3NGmccIPWLRwJ1yWCa/OVlq5bWrEXmNWQbEptBIAoQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292384; c=relaxed/simple;
	bh=OXdwZCdbCB9Cb04rG4i8IFxP38HzeQYQ7+7d1J62P5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i02jkpIfY3C/z6Xqk+Krpn4HI3OzclijAYk8tOxJjAEt6XRzPw7gIycibSQ+N+1qd5yQyEPow8mZPWaYcg5PICfX+Sw0lqur30gXHRqgIroExL8JRVxY7xSRincfAe4bhCyBEwgZCcLqXuFHWj9PHa8xPyi1L7gGn3hjQFa++3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mf78kgq2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732292382; x=1763828382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXdwZCdbCB9Cb04rG4i8IFxP38HzeQYQ7+7d1J62P5A=;
  b=Mf78kgq2LY9z7ZxX8Facfs6nSLU1KNafuQmKaLsboBfiTfnXFQ4u0Lal
   kHqMqEBw62pnESlXVJxy3cK+45NDYRs++jZqNXB/Q9KIv7kvXiPiOxfit
   0Zms5OxIaKFBjXqAArQQpe4wF8x43FJLwwL0MPIImNYAm8JS/U2Ot/Q1m
   ExmSVetxcP2oVEqXxkUGRKYzSsxHJa4nFSxWIw+l+R9IiOac3Ha4REGuT
   8XnsusQqRNL9l2DeNqylhFS74qegIgD5bdn39HByFTVUEuE5JVc+LICFo
   OWxOsEqTjKHSSqfFFiZ3yz8LI+Qg3XczsUz7ZpXIH/KiS/NkEbBYhxTQl
   g==;
X-CSE-ConnectionGUID: G3en5DDKTAGgLpbms08idg==
X-CSE-MsgGUID: OEqQ7IoWRHmsGa8yRjj54w==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32379419"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32379419"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 08:19:40 -0800
X-CSE-ConnectionGUID: UWLH1lyFRdKfwTGgt3UAVg==
X-CSE-MsgGUID: j97H/QpoR1CVejHRaiFMUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="90782850"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.10])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 08:19:39 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] drm/xe/guc_submit: fix race around suspend_pending
Date: Fri, 22 Nov 2024 16:19:17 +0000
Message-ID: <20241122161914.321263-6-matthew.auld@intel.com>
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

xe 0000:03:00.0: [drm] Assertion `exec_queue_destroyed(q)` failed!
....
WARNING: CPU: 18 PID: 2640 at drivers/gpu/drm/xe/xe_guc_submit.c:1826 xe_guc_sched_done_handler+0xa54/0xef0 [xe]
xe 0000:03:00.0: [drm] *ERROR* GT1: DEREGISTER_DONE: Unexpected engine state 0x00a1, guc_id=57

Looking at a snippet of corresponding ftrace for this GuC id we can see:

162.673311: xe_sched_msg_add:     dev=0000:03:00.0, gt=1 guc_id=57, opcode=3
162.673317: xe_sched_msg_recv:    dev=0000:03:00.0, gt=1 guc_id=57, opcode=3
162.673319: xe_exec_queue_scheduling_disable: dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0x29, flags=0x0
162.674089: xe_exec_queue_kill:   dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0x29, flags=0x0
162.674108: xe_exec_queue_close:  dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0xa9, flags=0x0
162.674488: xe_exec_queue_scheduling_done: dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0xa9, flags=0x0
162.678452: xe_exec_queue_deregister: dev=0000:03:00.0, 1:0x2, gt=1, width=1, guc_id=57, guc_state=0xa1, flags=0x0

It looks like we try to suspend the queue (opcode=3), setting
suspend_pending and triggering a disable_scheduling. The user then
closes the queue. However closing the queue seems to forcefully signal
the fence after killing the queue, however when the G2H response for
disable_scheduling comes back we have now cleared suspend_pending when
signalling the suspend fence, so the disable_scheduling now incorrectly
tries to also deregister the queue, leading to warnings since the queue
has yet to even be marked for destruction. We also seem to trigger
errors later with trying to double unregister the same queue.

To fix this tweak the ordering when handling the response to ensure we
don't race with a disable_scheduling that doesn't actually intend to
actually unregister.  The destruction path should now also correctly
wait for any pending_disable before marking as destroyed.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3371
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index f3c22b101916..f82f286fd431 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1867,16 +1867,30 @@ static void handle_sched_done(struct xe_guc *guc, struct xe_exec_queue *q,
 		xe_gt_assert(guc_to_gt(guc), runnable_state == 0);
 		xe_gt_assert(guc_to_gt(guc), exec_queue_pending_disable(q));
 
-		clear_exec_queue_pending_disable(q);
 		if (q->guc->suspend_pending) {
 			suspend_fence_signal(q);
+			clear_exec_queue_pending_disable(q);
 		} else {
 			if (exec_queue_banned(q) || check_timeout) {
 				smp_wmb();
 				wake_up_all(&guc->ct.wq);
 			}
-			if (!check_timeout)
+			if (!check_timeout && exec_queue_destroyed(q)) {
+				/*
+				 * Make sure we clear the pending_disable only
+				 * after the sampling the destroyed state. We
+				 * want to ensure we don't trigger the
+				 * unregister too early with something only
+				 * intending to only disable scheduling. The
+				 * caller doing the destroy must wait for an
+				 * ongoing pending_destroy before marking as
+				 * destroyed.
+				 */
+				clear_exec_queue_pending_disable(q);
 				deregister_exec_queue(guc, q);
+			} else {
+				clear_exec_queue_pending_disable(q);
+			}
 		}
 	}
 }
-- 
2.47.0


