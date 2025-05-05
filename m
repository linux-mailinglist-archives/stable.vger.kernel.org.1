Return-Path: <stable+bounces-139668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689E8AA913E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECA73AE7C5
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF90201002;
	Mon,  5 May 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOpVVVBh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546514D283
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746441229; cv=none; b=ssuLM6pDIWvJuiTnmBDBBdZwybKKdB6gRaftl1VsgBkpL7ERBiIR4jrBBAtXqKvyuDfUj1X22H4YfwZOnNsihWe4uPQRIfJUbTVWhwEm2AaCkEOcBkNc3uS7YhU8ZLYNP7kSO/xwRZyRBzhg2YBByxKItydAzHEPLI9lcI5EBhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746441229; c=relaxed/simple;
	bh=TSIbVxkr90edTKVBOtyKjpi4hPSCK+4Nc3zrIsRJKJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBeuFmsIiuM65joiffjNFUablf397m8WDbPsFxTFiWr/RLgZ0WbPFBf/lOLnz3F3DTWkpworehNZOofIVOLrRQKnA5Bnk0s0iKsIk4ClL+xFXem0ZGnBIAoRnVALSD6x/yvxSyGHmmTwmasXmr+3YCenrRvpcmyY/SqzNXGv29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOpVVVBh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746441227; x=1777977227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSIbVxkr90edTKVBOtyKjpi4hPSCK+4Nc3zrIsRJKJQ=;
  b=AOpVVVBhJW5P06D35ElcWKEeTvoBHAgRMZYbtSucXMJEQ5sEvosBMDOa
   iakIf36WtiCQyktFMYn+dP5IKAo5foFYBkl0ICdrwig6A8MMhfEbx2vFE
   DKoqoguB1t4l5Ez6Swkloowi5T0EmqWOaLlrdp5/kJKDhm/65E8SXocXv
   TT+b53A8Xvwv4tUvYCy97NCKbrvPT8y7blCPHn8OiuItH+DFsWRZviyNK
   fqNTzjtRFirLc+6tS/mhgzAHfJeeP4eSnREhZr3FPvB972jAYqDkbq/mW
   Lwuc0iZBAdFHZeYxKyE0lmqgeUqEbefvms40thGpTpoL+ylAW16zlRiVh
   w==;
X-CSE-ConnectionGUID: tHTakoO4QyCWlO7ccUxqTA==
X-CSE-MsgGUID: aqOb/yg9TraQohOmAP7yXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="47301824"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="47301824"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:47 -0700
X-CSE-ConnectionGUID: 1np5XnZETMmYAxTfdVAEJA==
X-CSE-MsgGUID: NzMdyxbXQYGozD6JIt5g6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135186866"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:46 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH v2 6/7] accel/ivpu: Fix locking order in ivpu_job_submit
Date: Mon,  5 May 2025 12:33:33 +0200
Message-ID: <20250505103334.79027-7-jacek.lawrynowicz@linux.intel.com>
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

commit ab680dc6c78aa035e944ecc8c48a1caab9f39924 upstream.

Fix deadlock in job submission and abort handling.
When a thread aborts currently executing jobs due to a fault,
it first locks the global lock protecting submitted_jobs (#1).

After the last job is destroyed, it proceeds to release the related context
and locks file_priv (#2). Meanwhile, in the job submission thread,
the file_priv lock (#2) is taken first, and then the submitted_jobs
lock (#1) is obtained when a job is added to the submitted jobs list.

       CPU0                            CPU1
       ----                    	       ----
  (for example due to a fault)         (jobs submissions keep coming)

  lock(&vdev->submitted_jobs_lock) #1
  ivpu_jobs_abort_all()
  job_destroy()
                                      lock(&file_priv->lock)           #2
                                      lock(&vdev->submitted_jobs_lock) #1
  file_priv_release()
  lock(&vdev->context_list_lock)
  lock(&file_priv->lock)           #2

This order of locking causes a deadlock. To resolve this issue,
change the order of locking in ivpu_job_submit().

This backport required small adjustments to ivpu_job_submit(),
which lacks support for explicit command queue creation added in 6.15.

Cc: stable@vger.kernel.org # v6.12
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-12-maciej.falkowski@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_job.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 8207d1218e207..a8e3eca14989c 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -535,6 +535,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 	if (ret < 0)
 		return ret;
 
+	mutex_lock(&vdev->submitted_jobs_lock);
 	mutex_lock(&file_priv->lock);
 
 	cmdq = ivpu_cmdq_acquire(file_priv, job->engine_idx, priority);
@@ -542,11 +543,9 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 		ivpu_warn_ratelimited(vdev, "Failed to get job queue, ctx %d engine %d prio %d\n",
 				      file_priv->ctx.id, job->engine_idx, priority);
 		ret = -EINVAL;
-		goto err_unlock_file_priv;
+		goto err_unlock;
 	}
 
-	mutex_lock(&vdev->submitted_jobs_lock);
-
 	is_first_job = xa_empty(&vdev->submitted_jobs_xa);
 	ret = xa_alloc_cyclic(&vdev->submitted_jobs_xa, &job->job_id, job, file_priv->job_limit,
 			      &file_priv->job_id_next, GFP_KERNEL);
@@ -554,7 +553,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 		ivpu_dbg(vdev, JOB, "Too many active jobs in ctx %d\n",
 			 file_priv->ctx.id);
 		ret = -EBUSY;
-		goto err_unlock_submitted_jobs;
+		goto err_unlock;
 	}
 
 	ret = ivpu_cmdq_push_job(cmdq, job);
@@ -576,22 +575,20 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 		 job->job_id, file_priv->ctx.id, job->engine_idx, priority,
 		 job->cmd_buf_vpu_addr, cmdq->jobq->header.tail);
 
-	mutex_unlock(&vdev->submitted_jobs_lock);
 	mutex_unlock(&file_priv->lock);
 
 	if (unlikely(ivpu_test_mode & IVPU_TEST_MODE_NULL_HW)) {
-		mutex_lock(&vdev->submitted_jobs_lock);
 		ivpu_job_signal_and_destroy(vdev, job->job_id, VPU_JSM_STATUS_SUCCESS);
-		mutex_unlock(&vdev->submitted_jobs_lock);
 	}
 
+	mutex_unlock(&vdev->submitted_jobs_lock);
+
 	return 0;
 
 err_erase_xa:
 	xa_erase(&vdev->submitted_jobs_xa, job->job_id);
-err_unlock_submitted_jobs:
+err_unlock:
 	mutex_unlock(&vdev->submitted_jobs_lock);
-err_unlock_file_priv:
 	mutex_unlock(&file_priv->lock);
 	ivpu_rpm_put(vdev);
 	return ret;
-- 
2.45.1


