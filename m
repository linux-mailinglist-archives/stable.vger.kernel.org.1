Return-Path: <stable+bounces-108150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392DA08123
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 21:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381B3188C12C
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 20:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EE91B0421;
	Thu,  9 Jan 2025 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z22rcstb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10747B677
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736453106; cv=none; b=S/M6FBFQ5sTUqIuZClzJUvNe8sYQRkvnsnUuC5eDnFSD+lAdBO1kegU7qXKwxki38B0jRGD8Pq02KL4FoAgVgMxjdUZWW8aCd0j6/z/uDSJZ+7USiPZp81sK4uUB8zgOrDTzlCahKROTrTCbo2MIKaPAlYN1SIUKQckt00pCJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736453106; c=relaxed/simple;
	bh=/XK2cYg/zXNjqR1Mg96Drxtrtb1+I3J73K44HI+kjto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGqp9Nu9iiZvPPMChC5W5WYnkmlc3CUuY9NBC6ggEFYqbdrpKjptrqMCHRW22xwtOu0zM8wL73/nJhdVu/5seswR75Xgdoo7h9iCCjrq7/wocYkLmw1HeKxqRdxdwffu4OjdFqrt5kREVKZdAFrhNjj0nBi7m4vQP9W4CzqV9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z22rcstb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736453104; x=1767989104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/XK2cYg/zXNjqR1Mg96Drxtrtb1+I3J73K44HI+kjto=;
  b=Z22rcstbUjOAKhayRq2wvQNyXSqzo4Dktxp4QRoJw0ykOIbsKL7BtGQa
   nZf/x798ZcocXIyvBd7/uyxUiGe6COZl8+iLflrgPmr2IMp1VP3bGNKNR
   6OvIo89HgbPCpwts3AWst4pw4vpsaNWovJnrFih4mI3Q1Ss8McmH+Ud1V
   ffoejnd68LLbkcJ06K8tR7E6rilx0Dog7aFBKeyFs8hzfJzBFalbX1ba6
   CuDhXIUZEL8aHx6x+73hTso5IIkxgiLMk0g1Ym5HUhNSQcmqvC53CuEP2
   nhhr3gED3mJO5+Cn8NX0OeYWFB2/fYaQF39eAoz7CcPpSuFSaMSgtjJ/h
   w==;
X-CSE-ConnectionGUID: f3hzfMIDStSuxenJLZiDdw==
X-CSE-MsgGUID: +wixbQt6T6KYBIUqbVB7Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47229142"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="47229142"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 12:05:03 -0800
X-CSE-ConnectionGUID: UgQgMKrnQ/mRTDA1mL5lhA==
X-CSE-MsgGUID: naL6GBDeTSGwFh2FFwIwFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="104060477"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 12:05:03 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v2] drm/xe/client: Better correlate exec_queue and GT timestamps
Date: Thu,  9 Jan 2025 12:03:40 -0800
Message-ID: <20250109200340.1774314-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
queue file lock usage."). While it's desired to have the mutex to
protect only the reference to the exec queue, getting and dropping each
mutex and then later getting the GPU timestamp, doesn't produce a
correct result: it introduces multiple opportunities for the task to be
scheduled out and thus wrecking havoc the deltas reported to userspace.

Also, to better correlate the timestamp from the exec queues with the
GPU, disable preemption so they can be updated without allowing the task
to be scheduled out. We leave interrupts enabled as that shouldn't be
enough disturbance for the deltas to matter to userspace.

Test scenario:

	* IGT'S `xe_drm_fdinfo --r utilization-single-full-load`
	* Platform: LNL, where CI occasionally reports failures
	* `stress -c $(nproc)` running in parallel to disturb the
	  system

This brings a first failure from "after ~150 executions" to "never
occurs after 1000 attempts".

v2: Also keep xe_hw_engine_read_timestamp() call inside the
    preemption-disabled section (Umesh)

Cc: stable@vger.kernel.org # v6.11+
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index 7d55ad846bac5..2220a09bf9751 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -337,20 +337,18 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
 		return;
 	}
 
+	/* Let both the GPU timestamp and exec queue be updated together */
+	preempt_disable();
+	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
+
 	/* Accumulate all the exec queues from this client */
 	mutex_lock(&xef->exec_queue.lock);
-	xa_for_each(&xef->exec_queue.xa, i, q) {
-		xe_exec_queue_get(q);
-		mutex_unlock(&xef->exec_queue.lock);
 
+	xa_for_each(&xef->exec_queue.xa, i, q)
 		xe_exec_queue_update_run_ticks(q);
 
-		mutex_lock(&xef->exec_queue.lock);
-		xe_exec_queue_put(q);
-	}
 	mutex_unlock(&xef->exec_queue.lock);
-
-	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
+	preempt_enable();
 
 	xe_force_wake_put(gt_to_fw(hwe->gt), fw_ref);
 	xe_pm_runtime_put(xe);
-- 
2.47.0


