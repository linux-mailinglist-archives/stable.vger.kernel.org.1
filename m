Return-Path: <stable+bounces-139150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 933ADAA4B5F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AEA18902AD
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7B259CB4;
	Wed, 30 Apr 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAxxZnES"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1152475CF
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016630; cv=none; b=o5ey0bab/e4JqgfnbhAd8a4M3KJxNTLh0tUFM6Q6nYNNsGiMndDTO2U8GF2wdKEFu1J/l+O/6F7uHuCw9kh/a2eHPCmXJYuqs0UcIlwb24BkAC6mtjpMMsyWVv7iD77dwOYcoKUPCSLiH442P9dN04DySd8A/S0J+TUwmWLzX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016630; c=relaxed/simple;
	bh=ATC9PoSyb2dqZW2O8k8f4IZYVA+oTQAGStdJI5pM7eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSPUiwgSg8qB3M5k2PCDv9q40+92pWEdy6XGVcPCkAmp6E46vONXpBRp1YHYdg6UBud9iGanMNmhyEWoL4BrLXCElO6MwoQ3Cn9DPv4GFQCaU/ExSPLdHHMTbaT11BbjVvXn+cx0cBUwUmkJO07NX2kpSEp+e3vw7Fru2ykwNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAxxZnES; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746016628; x=1777552628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ATC9PoSyb2dqZW2O8k8f4IZYVA+oTQAGStdJI5pM7eU=;
  b=oAxxZnES7IXEiaAcRPuG+BN64WXYe+0d80wrRBWe/keK/oILnG1MR++a
   WUGbnVeL6rI+kwvwaBKnwYqcqgT4WCoPnCBYH+BfrqGdul82SjhvRg+Xs
   yCeasvTfyaGBXPIMWQVLTunEzgDJelGMVRhNci/C8KH/1KYkeSE0s0zjs
   l9CE/Fnq4pJwnjtxnaTvS+yU2VCAUwY8Xs/HuLWvs4F7IWaNsIQQUYtXQ
   KVJTtHXOYk8UJpfSQRdJ5FoLpzCAoC6/B63cUZLQ7nnHV9t6tLG1wFzLd
   q0IqvuU+/af6ic2oVWt14bNsc+HzGik+OP/MBAz78dy73OnJqxZd7C/g4
   w==;
X-CSE-ConnectionGUID: H2PZJnhoTEm5I8JTbv5MSQ==
X-CSE-MsgGUID: SeVpV0syTimpdtRzbJ7jAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51336930"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51336930"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:37:01 -0700
X-CSE-ConnectionGUID: E/l7U/QfQCWDQpxFna0i5Q==
X-CSE-MsgGUID: KKNnSkKVTxmGOpzFruzjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="165201926"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:36:59 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 3/3] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Wed, 30 Apr 2025 14:36:53 +0200
Message-ID: <20250430123653.3748811-4-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250430123653.3748811-1-jacek.lawrynowicz@linux.intel.com>
References: <20250430123653.3748811-1-jacek.lawrynowicz@linux.intel.com>
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

Cc: <stable@vger.kernel.org> # v6.14
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-13-maciej.falkowski@linux.intel.com
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


