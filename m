Return-Path: <stable+bounces-139669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37530AA913F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E547A4B84
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846CF1FF61D;
	Mon,  5 May 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfBJoHO/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21E201000
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746441231; cv=none; b=HTEPdTxm/GArBHIy2NIFitCAXggegldW+kfonkTX4nnHTpVb6ykwVdMrN6imBOpDpuQDhTf+xlN2JvYPJPfR1RcSntwEMxjZSQLmX/XmuE/Q9IHezDkfmGFjEITUwlRE9Rz2K/z7P2ZNZVtCpue1q+qG/zHE2Uw7L6oAKYkaPYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746441231; c=relaxed/simple;
	bh=VpWIOgBnBCKWfXRwPZZMxF8bpKW2vzNnXiFjz7P1DHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6O4rXo5ahAreUn5DXorAl3ZM1HRp0QIrlW0MWRWPpd59vR301Qk42KGYDPyb+tec8BGP5HO9J6aq92hEcXJXaEY9fyhlZu/ot/NH3oFhrq+n9m7CbChEQ2cdRZPVOBB3sP2GIC+2CdLl6iCf3pZGfOlZg8Xi2l3DzEZVFFuE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfBJoHO/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746441229; x=1777977229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VpWIOgBnBCKWfXRwPZZMxF8bpKW2vzNnXiFjz7P1DHM=;
  b=JfBJoHO/+0tAV9nD6HTMWIg56fBxeeEqcFz6Q0MFDm5COMkNci1iiF+K
   6EGdz03GWSzw35K3z+AF0ts+v3M9UXyE98gXdNBHcL7sycfNZGfHkW/47
   8fiL+hxUhG4r7QZk87BZLRVWiU/25NRUj8ZHjGNU7k6rSXpHqoYScr6pn
   ByXIMRIlW6y7IJwM9RejxgNLmE//ahsOr6KaoyYMt+E1C0MjUTWa8cAKp
   0aQJIVNroMqQ++kLOqb0JjjAiRuF4BlQRyIp/KHzFiNRN4itWU0GBuOLM
   ZCU4QB8XGgZdwpBcejEMYJXgicPx8iAEg2/nwrJ+NTCqztNpemGyUR7ZW
   w==;
X-CSE-ConnectionGUID: irP0TNDCRLS+8hM2yg0oZQ==
X-CSE-MsgGUID: 7Quo0sSQRSCBrn804OkAtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="47301826"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="47301826"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:49 -0700
X-CSE-ConnectionGUID: gKsiuj0jSJ66uXIjuVUDxA==
X-CSE-MsgGUID: swlD9HA7SQmho8jqBQh9QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135186873"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:47 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH v2 7/7] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Mon,  5 May 2025 12:33:34 +0200
Message-ID: <20250505103334.79027-8-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250505103334.79027-1-jacek.lawrynowicz@linux.intel.com>
References: <20250505103334.79027-1-jacek.lawrynowicz@linux.intel.com>
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

Cc: stable@vger.kernel.org # v6.12
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-13-maciej.falkowski@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_job.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index a8e3eca14989c..27121c66e48f8 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -486,6 +486,26 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 
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
@@ -795,6 +815,9 @@ void ivpu_context_abort_thread_handler(struct work_struct *work)
 	struct ivpu_job *job;
 	unsigned long id;
 
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
+		ivpu_jsm_reset_engine(vdev, 0);
+
 	mutex_lock(&vdev->context_list_lock);
 	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
 		if (!file_priv->has_mmu_faults || file_priv->aborted)
@@ -808,6 +831,8 @@ void ivpu_context_abort_thread_handler(struct work_struct *work)
 
 	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
 		return;
+
+	ivpu_jsm_hws_resume_engine(vdev, 0);
 	/*
 	 * In hardware scheduling mode NPU already has stopped processing jobs
 	 * and won't send us any further notifications, thus we have to free job related resources
-- 
2.45.1


