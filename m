Return-Path: <stable+bounces-76909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590C97ED81
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 16:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3991C210F4
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDED2195B1A;
	Mon, 23 Sep 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IK1BWC8Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D577F13
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103446; cv=none; b=a2yUvIgtO5UZ7zZuG0giYfDILf6T9OsvJ/ejMVXiNVMXaNcAzSMVyiktfYmOL+6xW+lV3OJj5MlrLZXdKW83+3zpaAn4UkE5YTewApcrAY2Ul31pMpIArwgd2BpPLmpvq6AzVIYgqyrK9JupNqxL/1BdRfTl2KY/HZ7PEN56bRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103446; c=relaxed/simple;
	bh=0BZrRJYAMrVVX5mI2NSflnJkeZs+VZc6/lYnjas1Sfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8qmOWSAZi8Gv9JbOpUgd2FLd+gF6o56YKnE3eFzbaqD3QSqVdedgc1fq2TJNkqkSs8Q+Nz7+U1FZxi7rNcTkxPDEdaFGkUCeTugEC5GaFfG6Mvl+ZvhonnXv8IYPV/+v0wNOcmuDAqWTV59Kx/aH/0B71w8x8C47xHmokmwPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IK1BWC8Z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727103445; x=1758639445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0BZrRJYAMrVVX5mI2NSflnJkeZs+VZc6/lYnjas1Sfo=;
  b=IK1BWC8ZmZ7QoIkWkE/DgjyfyHqS15+HlU27fn1lODE+W1D97EEImkRD
   M0CKakLRBjW8GtUGJeDlwemiRLrxdpgVi/LEErAiH4vS9pChAf+Z7JkMg
   GjPAa4DchR7sdRBUQXEb9OcfN6s1rlrRIeHOuStE0Wt4uI4aeFJnhWj6u
   zcEBqfExcupKP2fmPzHfvOCleTaNrao/T2HFjikEz5StQFrp+cXVdlj7z
   p7pq+BVbPP9ydjbytPDCsJr/CooHW6A1CIcEflc9TDyHFBxBo/WGNf8uZ
   VSOnARXjFqFtbWsVqrYni5ALAYho8AjGhB7u/AdHPTCT9hN/+9E2JsJfI
   A==;
X-CSE-ConnectionGUID: 5YVnNDDWTGuqkWZbT0i50g==
X-CSE-MsgGUID: wYlcOuGDTWCHjDCjb6LwLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29942989"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="29942989"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 07:57:24 -0700
X-CSE-ConnectionGUID: LR1xpozEQxydPDj9c2sbCg==
X-CSE-MsgGUID: Rck8CCr5Tpeprh3XM8kxjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="70680889"
Received: from johunt-mobl9.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.234])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 07:57:23 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/xe: fix UAF around queue destruction
Date: Mon, 23 Sep 2024 15:56:48 +0100
Message-ID: <20240923145647.77707-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.1
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

v2 (Matt B)
 - Looks much safer to use a waitqueue and then just wait for the
   xa_array to become empty before triggering the drain.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2317
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_device.c       |  6 +++++-
 drivers/gpu/drm/xe/xe_device_types.h |  3 +++
 drivers/gpu/drm/xe/xe_guc_submit.c   | 26 +++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_guc_types.h    |  2 ++
 4 files changed, 35 insertions(+), 2 deletions(-)

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
index fbbe6a487bbb..ae2f85cc2d08 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -276,10 +276,26 @@ static struct workqueue_struct *get_submit_wq(struct xe_guc *guc)
 }
 #endif
 
+static void xe_guc_submit_fini(struct xe_guc *guc)
+{
+	struct xe_device *xe = guc_to_xe(guc);
+	struct xe_gt *gt = guc_to_gt(guc);
+	int ret;
+
+	ret = wait_event_timeout(
+		guc->submission_state.fini_wq,
+		xa_empty(&guc->submission_state.exec_queue_lookup), HZ * 5);
+
+	drain_workqueue(xe->destroy_wq);
+
+	xe_gt_assert(gt, ret);
+}
+
 static void guc_submit_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc *guc = arg;
 
+	xe_guc_submit_fini(guc);
 	xa_destroy(&guc->submission_state.exec_queue_lookup);
 	free_submit_wq(guc);
 }
@@ -345,6 +361,8 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
 
 	xa_init(&guc->submission_state.exec_queue_lookup);
 
+	init_waitqueue_head(&guc->submission_state.fini_wq);
+
 	primelockdep(guc);
 
 	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
@@ -361,6 +379,9 @@ static void __release_guc_id(struct xe_guc *guc, struct xe_exec_queue *q, u32 xa
 
 	xe_guc_id_mgr_release_locked(&guc->submission_state.idm,
 				     q->guc->id, q->width);
+
+	if (xa_empty(&guc->submission_state.exec_queue_lookup))
+		wake_up(&guc->submission_state.fini_wq);
 }
 
 static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
@@ -1268,13 +1289,16 @@ static void __guc_exec_queue_fini_async(struct work_struct *w)
 
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
diff --git a/drivers/gpu/drm/xe/xe_guc_types.h b/drivers/gpu/drm/xe/xe_guc_types.h
index 546ac6350a31..69046f698271 100644
--- a/drivers/gpu/drm/xe/xe_guc_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_types.h
@@ -81,6 +81,8 @@ struct xe_guc {
 #endif
 		/** @submission_state.enabled: submission is enabled */
 		bool enabled;
+		/** @submission_state.fini_wq: submit fini wait queue */
+		wait_queue_head_t fini_wq;
 	} submission_state;
 	/** @hwconfig: Hardware config state */
 	struct {
-- 
2.46.1


