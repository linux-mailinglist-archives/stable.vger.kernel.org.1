Return-Path: <stable+bounces-139160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93D2AA4BDF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14703500471
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFADA25B1F9;
	Wed, 30 Apr 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mhl+aJrH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72825B663
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017314; cv=none; b=VyUmXtD00kWxtIYIZDrzsNzFIy/bVFjqUmDopq6H++ndzaHWO02aiXrg86z5aYG2Y8caRSCJwDjLJlyD91siKHlCkFQ/23GkiMUrXOT7s/9HxRvNf7+2BIMxmtooU8gg4VPGYW+QA93s052x532VLl79qwN/C99hOdyW9tzYG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017314; c=relaxed/simple;
	bh=cQ9ptcMfS7BSQvVPJr4RFdlS8dDIWYDDQBnTL7RNFMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOerLB7TNsMR7qk8HG8UO8UUzvNTUZyRY6Uc74TK062zBIhhzJLPIlMT6BioRAAb5K55k4INTHwuMnUNmFUKIlk5zKxydq3pwY2xHAGDs5wBTwAaM1u8IexWTXBCRsgOoxhMjtgD8afqHncWdqwCG/Ff1UfKYiTs6F/H9u4nscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mhl+aJrH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017313; x=1777553313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQ9ptcMfS7BSQvVPJr4RFdlS8dDIWYDDQBnTL7RNFMQ=;
  b=Mhl+aJrHTXgajRFF4TsteurrhEbNPcm/GudZxfq1WWGkFoxJjYQJ5H9/
   sdCIhwjXpOCj+IRisDVUBv2cBXGizAeofQSvvxiZiWL59JWpQZ7/jnwSu
   d400EgF2EFQdhuat1qMVCDgYo74L/1hVOnemnpS0yvevOMsMfnALHrfuB
   RdJ8JDKCeNRIO8W2f/Gzm31HwGcVIgkAGCx+v7RC+qKEfK8GnlCZy+0e6
   tctxuSYU7H9fuAmF2dpGTejaxuMySh3oLPhEkR2V8T8LQhwINPiD6qMpQ
   4shFlcy+mLuPhYOwiBinkRGSpxEDGToFOwO58s7BkZy551txaIYKYRI8r
   w==;
X-CSE-ConnectionGUID: 8/y9MmnGTzCgI1mbL2QZNg==
X-CSE-MsgGUID: 4LtKo5d5S2uJ22Wo1D5ihQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51488517"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51488517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:33 -0700
X-CSE-ConnectionGUID: zgydjdspQU6mZfCWpAuENg==
X-CSE-MsgGUID: 5wSeOpWUTfS9eMEE4//zlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138925428"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:32 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 6/7] accel/ivpu: Fix locking order in ivpu_job_submit
Date: Wed, 30 Apr 2025 14:48:18 +0200
Message-ID: <20250430124819.3761263-7-jacek.lawrynowicz@linux.intel.com>
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

Cc: <stable@vger.kernel.org> # v6.12
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-12-maciej.falkowski@linux.intel.com
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


