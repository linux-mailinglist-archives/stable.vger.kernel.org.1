Return-Path: <stable+bounces-76814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C097D56E
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 14:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A296E283D80
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B381E53A;
	Fri, 20 Sep 2024 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOemehYx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230AD1E498
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836000; cv=none; b=dgR+gbwiMWnPgzDI4fthqc2mcqIZ4l2uycVfpffO6cBOkxz4owKFt/ozwBVNDwRHNz+V7egna4V4pmi1T5amdhEBhESrToBUjczHUzACwthWegElIYMA4ZVxQ4xgqmBKuNH0GoBgshnLvQU+SJTdnW2xDBnoJ6DDOlLMov1ZtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836000; c=relaxed/simple;
	bh=umP9Eh3HHtH+2RE7AoiWYIkD8ktJgdL3V3Hkgr4Mwgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFnnweePaI8593OFfcYxUEYi264YWVB1objgnUv7nEdRmgjzoVk4bhYINvC9u2wWrHOsEHxrAaimO+7nf8+XHyZnplVq9XdReZdOT/p3Ot5DQSlKYEq5VgVKisEaFUwkFAa94qONLFQKiT4E5dgQyngaG8FlDHfSr8xzX377ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOemehYx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726835998; x=1758371998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=umP9Eh3HHtH+2RE7AoiWYIkD8ktJgdL3V3Hkgr4Mwgs=;
  b=EOemehYxSlK8IleP5E4dAq2A9hoIg7icH/Ia3eGCSRwbgvJVk7RBFPam
   2MwxLIr4CWauZTsh88wtKTlGZrJ6D0+9haFORBJAtVEUWnkLEZ2Is6Zb+
   U/kHhgFuchIsxMIZMsixUJ+6xM2i7Kvk98hLP4U5eL5FQfLUm3sNE8+Xs
   JYQ7yV8wUWF+7kHYK9kDA61zFlpX8CniI1guLf2lr79J/jZv3fz7lfHb3
   TlmSjaNzxP3rLpIhd0da0F4NE3aRQb6unxwxq80/HDFrtPFSfAIDxily9
   dmJ58/FQfFHv237GagHV9loaFYY2svSq1HIAvB36eqWvjdlTF0ZzeB7GV
   g==;
X-CSE-ConnectionGUID: koW3qm54TGiwLoJW+gX0uw==
X-CSE-MsgGUID: EqW1eVm5Tdq9rQHFmxx57A==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="26023948"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="26023948"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 05:39:57 -0700
X-CSE-ConnectionGUID: YrW+I/n3SfmdJl1aGMzDmg==
X-CSE-MsgGUID: 12CzCK0cSwe6JVIHthg97Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70416793"
Received: from opintica-mobl1 (HELO mwauld-desk.intel.com) ([10.245.245.19])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 05:39:56 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/guc_submit: fix UAF in run_job()
Date: Fri, 20 Sep 2024 13:38:07 +0100
Message-ID: <20240920123806.176709-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial kref from dma_fence_init() should match up with whatever
signals the fence, however here we are submitting the job first to the
hw and only then grabbing the extra ref and even then we touch some
fence state before this. This might be too late if the fence is
signalled before we can grab the extra ref. Rather always grab the
refcount early before we do the submission part.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2811
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index fbbe6a487bbb..b33f3d23a068 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -766,12 +766,15 @@ guc_exec_queue_run_job(struct drm_sched_job *drm_job)
 	struct xe_guc *guc = exec_queue_to_guc(q);
 	struct xe_device *xe = guc_to_xe(guc);
 	bool lr = xe_exec_queue_is_lr(q);
+	struct dma_fence *fence;
 
 	xe_assert(xe, !(exec_queue_destroyed(q) || exec_queue_pending_disable(q)) ||
 		  exec_queue_banned(q) || exec_queue_suspended(q));
 
 	trace_xe_sched_job_run(job);
 
+	dma_fence_get(job->fence);
+
 	if (!exec_queue_killed_or_banned_or_wedged(q) && !xe_sched_job_is_error(job)) {
 		if (!exec_queue_registered(q))
 			register_exec_queue(q);
@@ -782,12 +785,16 @@ guc_exec_queue_run_job(struct drm_sched_job *drm_job)
 
 	if (lr) {
 		xe_sched_job_set_error(job, -EOPNOTSUPP);
-		return NULL;
+		fence = NULL;
 	} else if (test_and_set_bit(JOB_FLAG_SUBMIT, &job->fence->flags)) {
-		return job->fence;
+		fence = job->fence;
 	} else {
-		return dma_fence_get(job->fence);
+		fence = dma_fence_get(job->fence);
 	}
+
+	dma_fence_put(job->fence);
+
+	return fence;
 }
 
 static void guc_exec_queue_free_job(struct drm_sched_job *drm_job)
-- 
2.46.0


