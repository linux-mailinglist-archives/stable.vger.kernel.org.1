Return-Path: <stable+bounces-76838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C497D900
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42681F22C15
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14122AEF1;
	Fri, 20 Sep 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyzzhJPT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3281EF1D
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853193; cv=none; b=KA2DO2UhNc1+IFxjWntNVQ5MDCGBumNPVtE2kE7EDjFxGNkpCgs6XZsa2Y4eaelfKn8DZBiwAfH9gPo0CQY+y7w7nxf4vghQoblPWmv3sgOf5CKVUa7kVTZDB1ioVNy8KC+NeF62wObnZ7l0VK/yA1ckFKGAFE4xlWZSThYtBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853193; c=relaxed/simple;
	bh=99J/E8a3Dd5i7gMfkBZzBX9Boeg1oCZlNmlkkdALR1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7xNplnNGKnRKL45mHb62gXL6XnjSsWxz19jiCvrD+40j2iDpVJbF1s1Ytz3TFjVwI+ZwQ4Z65i6gMQacsjxUw/lB2xfV7FxJTN6rcv34MMsLO3Qn5+hEOWjAfoSTzIVjYyANeqNK6vPXao2TbjGbsbd3tVXvcDJQOoD1/yZiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyzzhJPT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726853192; x=1758389192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=99J/E8a3Dd5i7gMfkBZzBX9Boeg1oCZlNmlkkdALR1c=;
  b=TyzzhJPT/7FBaZSLsIs4XFuEX843oYJftTPElFiMZfX1+T8Sj4ZueY6E
   ijt7/CUs6qW0mrVcxyxlrAswUOLAVTgDRvlpZhULaVnEgZMnudt4rXdvs
   XZYYhdeXS6blDkkh/KHV7SuEFq3ZSfKdItkb/cxupGKmq08E6kKKb/5RP
   1R6TmeGjGMJPkOdn860u6C6nno3PY52SvDd8FobIezvCCFeXNm+U/lnTL
   F+joUPkqOfQ/DJL/NGFqvW2l7BksBoAyMWeyc0/TKCY5ZvWzw3V8AFjhu
   FJBoVRrG5+2rL3yFlht0WZSMUQGnDYKJmGmaz+USEaYsDTl8KkWn6oZ58
   g==;
X-CSE-ConnectionGUID: bZVa0n1bQnasVAxIPeR5Jg==
X-CSE-MsgGUID: BzuIhi97QUanHCMkaAK8pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="51289082"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="51289082"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 10:26:31 -0700
X-CSE-ConnectionGUID: VnXQZk9zRfG1xKemdVNpvA==
X-CSE-MsgGUID: Q4cVWDIbS9SE7WgdIqvXhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="74919705"
Received: from opintica-mobl1 (HELO mwauld-desk.intel.com) ([10.245.245.19])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 10:26:30 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: fix UAF around queue destruction
Date: Fri, 20 Sep 2024 18:26:00 +0100
Message-ID: <20240920172559.208358-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently do stuff like queuing the final destruction step on a
random system wq, which will outlive the driver instance. With bad
timing we can teardown the driver with one or more work workqueue still
being alive leading to various UAF splats. Add a fini step to ensure
user queues are properly torn down. At this point GuC should already be
nuked so queue itself should no longer be referenced from hw pov.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2317
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_device.c       |  6 +++++-
 drivers/gpu/drm/xe/xe_device_types.h |  3 +++
 drivers/gpu/drm/xe/xe_guc_submit.c   | 32 +++++++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index cb5a9fd820cf..90b3478ed7cd 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -297,6 +297,9 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
 	if (xe->unordered_wq)
 		destroy_workqueue(xe->unordered_wq);
 
+	if (xe->destroy_wq)
+		destroy_workqueue(xe->destroy_wq);
+
 	ttm_device_fini(&xe->ttm);
 }
 
@@ -360,8 +363,9 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq", 0);
 	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
 	xe->unordered_wq = alloc_workqueue("xe-unordered-wq", 0, 0);
+	xe->destroy_wq = alloc_workqueue("xe-destroy-wq", 0, 0);
 	if (!xe->ordered_wq || !xe->unordered_wq ||
-	    !xe->preempt_fence_wq) {
+	    !xe->preempt_fence_wq || !xe->destroy_wq) {
 		/*
 		 * Cleanup done in xe_device_destroy via
 		 * drmm_add_action_or_reset register above
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 5ad96d283a71..515385b916cc 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -422,6 +422,9 @@ struct xe_device {
 	/** @unordered_wq: used to serialize unordered work, mostly display */
 	struct workqueue_struct *unordered_wq;
 
+	/** @destroy_wq: used to serialize user destroy work, like queue */
+	struct workqueue_struct *destroy_wq;
+
 	/** @tiles: device tiles */
 	struct xe_tile tiles[XE_MAX_TILES_PER_DEVICE];
 
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index fbbe6a487bbb..66441efa0bcd 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -276,10 +276,37 @@ static struct workqueue_struct *get_submit_wq(struct xe_guc *guc)
 }
 #endif
 
+static void guc_exec_queue_fini_async(struct xe_exec_queue *q);
+
+static void xe_guc_submit_fini(struct xe_guc *guc)
+{
+	struct xe_device *xe = guc_to_xe(guc);
+	struct xe_exec_queue *q;
+	unsigned long index;
+
+	mutex_lock(&guc->submission_state.lock);
+	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q) {
+		struct xe_gpu_scheduler *sched = &q->guc->sched;
+
+		xe_assert(xe, !kref_read(&q->refcount));
+
+		xe_sched_submission_stop(sched);
+
+		if (exec_queue_registered(q) && !exec_queue_wedged(q))
+			guc_exec_queue_fini_async(q);
+	}
+	mutex_unlock(&guc->submission_state.lock);
+
+	drain_workqueue(xe->destroy_wq);
+
+	xe_assert(xe, xa_empty(&guc->submission_state.exec_queue_lookup));
+}
+
 static void guc_submit_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc *guc = arg;
 
+	xe_guc_submit_fini(guc);
 	xa_destroy(&guc->submission_state.exec_queue_lookup);
 	free_submit_wq(guc);
 }
@@ -1268,13 +1295,16 @@ static void __guc_exec_queue_fini_async(struct work_struct *w)
 
 static void guc_exec_queue_fini_async(struct xe_exec_queue *q)
 {
+	struct xe_guc *guc = exec_queue_to_guc(q);
+	struct xe_device *xe = guc_to_xe(guc);
+
 	INIT_WORK(&q->guc->fini_async, __guc_exec_queue_fini_async);
 
 	/* We must block on kernel engines so slabs are empty on driver unload */
 	if (q->flags & EXEC_QUEUE_FLAG_PERMANENT || exec_queue_wedged(q))
 		__guc_exec_queue_fini_async(&q->guc->fini_async);
 	else
-		queue_work(system_wq, &q->guc->fini_async);
+		queue_work(xe->destroy_wq, &q->guc->fini_async);
 }
 
 static void __guc_exec_queue_fini(struct xe_guc *guc, struct xe_exec_queue *q)
-- 
2.46.0


