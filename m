Return-Path: <stable+bounces-139161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91291AA4BD3
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EBD1C05B16
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A28258CEB;
	Wed, 30 Apr 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvEhMlC2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2A25B669
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017316; cv=none; b=R+1Evuj7A1S/MjxdkCTPCLH0okSqFPn5/6eMj7JzjDecIpshkTEmK6TsRF27JqXzdX7z69YMFfK3Q9ljIXc+XEyz/PefJNJ8tIto8MnmmjEqz9QoW/NtMNhNDqYSfEaT/89FUUmf/MEXbr4Wn9KsjW6w3RfPU24IpbGPkEHf6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017316; c=relaxed/simple;
	bh=R2wuMulYi/1dqJuzJDFNMAd7QwsPifDFI0DwvPNTW08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYtAnYBWegieYfvOOS/dxAymkj4k0mXMWVPVwbB8a/A/fL3w/kF6/mnRSXsYNimBAcAkpvy1L0KY2eoxb7o8ByOoxaTcaG2kKTUVJebLzlBrbQmsBvehGmHOChYu9SWCTijzKFfiroX0KKOUF8L5g3cG89ai9/9Z1SHRWsb/tNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvEhMlC2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017315; x=1777553315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2wuMulYi/1dqJuzJDFNMAd7QwsPifDFI0DwvPNTW08=;
  b=VvEhMlC26kEq9jltJObmanvneN9rsZU4F3S1ax5wS2gHfMQkyIPFPC+c
   AGltcF3glMa6pUcIkQVeKuv3zro2Mm7nNUFtJcBImexIaSA06Q33uF098
   ePvhQn3+T+1i34E0IhX/rifSq9uk4iTwDI/pYjcIW8XX0IOdeBW7XPMV7
   zM9sGLqRWaiUWVl7+T26RbwLImwcdDxVGflhwhqfLhVtQaB1N0NZZZZIG
   3un21TJofiUm8vG3iiDk5Fov4CUYOus+9R/VImhuBALYaF6PlqZokXlyO
   S4ZBWORtNwczIUfXVjFLYkmVdiBWNPt1d3g554odMTDRmxFYb/WVxc4t7
   A==;
X-CSE-ConnectionGUID: WS0P9Sk4RyOxyCDlE0AUdg==
X-CSE-MsgGUID: 7M7u4zr6QjuLnBjx8J7MYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51488519"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51488519"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:34 -0700
X-CSE-ConnectionGUID: HWfkFNu4Rryezd6lHSFA9g==
X-CSE-MsgGUID: My/kjfzUTlez1PplNwq7dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138925431"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:33 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 7/7] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Wed, 30 Apr 2025 14:48:19 +0200
Message-ID: <20250430124819.3761263-8-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
References: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
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

Cc: <stable@vger.kernel.org> # v6.12
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-13-maciej.falkowski@linux.intel.com
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


