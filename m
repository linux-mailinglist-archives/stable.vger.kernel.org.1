Return-Path: <stable+bounces-139659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2805AA90EC
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9BD7A4BFF
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628C1FF7CD;
	Mon,  5 May 2025 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFuRsMav"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C71FECD3
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440600; cv=none; b=aXObWFyS6om4NfJhN5TbQBDf9as8WVVqhqJMDR8GKwdyT14bD+yvA2YjSUGUU1jEzYVYtg2tLcrhC9OZHXg7vBAamsKD5wuJpdr6FyhpAyY805JEQcqmMR49mCaV/5+BLOMZqgZNTK4LrWdDf2iAgDj9zRmpLzx93qu0qc00wyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440600; c=relaxed/simple;
	bh=meblTXhTmIm3HPOWk7CFovO3N1RQjoZ6UqrSyjyDyxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2zpStRQYoLbTWyKM6kPj5C4B0nviE2QPNWe+cAaF97wFGPtgw3gz+cnIGvGuEMH1sgeb1Jz+U1u94h7/hgqRVy/89TZTpFGXiW03U3ovF2/UQjzjrrvgs7105tNphPzZi2HpMNYziWUs98SJs/eo2zpB6fvwrnpRtsPDvl2STc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFuRsMav; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746440599; x=1777976599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=meblTXhTmIm3HPOWk7CFovO3N1RQjoZ6UqrSyjyDyxA=;
  b=WFuRsMava9hC6IW06TfcdVFve3xIwdLRQkh18RQkf0O4S75gFuLYBZ0a
   21iJsIo9FKNJPAoyXi2+VuzPOacGZqzFx/EJaSl0XXMMpo02DEu5Vocfe
   SmJYRdXdr3iDJ9Xq16MJKVwHBzv0gQ1W23cTj9pPxzmx9fd0oOeiAEErP
   g83dTiyZrGYx26XO2aN02iS9Eg0p6w1N3LRWRZc7EB1sXNuCPssyejKap
   DM0Sk/IbQY0SQyodGe5yOdd5/IRLtwJqlsoRLB8B2m99jL43A9dz38lqA
   JVZkptxNvG2Edpjz+0WITgcLUmWDHhbSspXrR0QljDXqA2KjcD90hO5Yv
   g==;
X-CSE-ConnectionGUID: jNRlkJs6TdSxORGqYK/gDw==
X-CSE-MsgGUID: ZNge/srGTDy4BfYnFJ9l2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="65447860"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="65447860"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:23:19 -0700
X-CSE-ConnectionGUID: VXacCy/vRfizHfg+n3eobQ==
X-CSE-MsgGUID: /gevblv8SlSo6i8QdUFfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135170587"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:23:17 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH v2 3/3] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Mon,  5 May 2025 12:23:11 +0200
Message-ID: <20250505102311.23425-4-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250505102311.23425-1-jacek.lawrynowicz@linux.intel.com>
References: <20250505102311.23425-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Wachowski <karol.wachowski@intel.com>

commit dad945c27a42dfadddff1049cf5ae417209a8996 upstream.

Mark as invalid context of a job that returned HW context violation
error and queue work that aborts jobs from faulty context.
Add engine reset to the context abort thread handler to not only abort
currently executing jobs but also to ensure NPU invalid state recovery.

Cc: stable@vger.kernel.org # v6.14
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-13-maciej.falkowski@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_job.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 5b6d93c20b2da..673801889c7b2 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -482,6 +482,26 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 
 	lockdep_assert_held(&vdev->submitted_jobs_lock);
 
+	job = xa_load(&vdev->submitted_jobs_xa, job_id);
+	if (!job)
+		return -ENOENT;
+
+	if (job_status == VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW) {
+		guard(mutex)(&job->file_priv->lock);
+
+		if (job->file_priv->has_mmu_faults)
+			return 0;
+
+		/*
+		 * Mark context as faulty and defer destruction of the job to jobs abort thread
+		 * handler to synchronize between both faults and jobs returning context violation
+		 * status and ensure both are handled in the same way
+		 */
+		job->file_priv->has_mmu_faults = true;
+		queue_work(system_wq, &vdev->context_abort_work);
+		return 0;
+	}
+
 	job = ivpu_job_remove_from_submitted_jobs(vdev, job_id);
 	if (!job)
 		return -ENOENT;
@@ -793,6 +813,9 @@ void ivpu_context_abort_thread_handler(struct work_struct *work)
 	struct ivpu_job *job;
 	unsigned long id;
 
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
+		ivpu_jsm_reset_engine(vdev, 0);
+
 	mutex_lock(&vdev->context_list_lock);
 	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
 		if (!file_priv->has_mmu_faults || file_priv->aborted)
@@ -806,6 +829,8 @@ void ivpu_context_abort_thread_handler(struct work_struct *work)
 
 	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
 		return;
+
+	ivpu_jsm_hws_resume_engine(vdev, 0);
 	/*
 	 * In hardware scheduling mode NPU already has stopped processing jobs
 	 * and won't send us any further notifications, thus we have to free job related resources
-- 
2.45.1


