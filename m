Return-Path: <stable+bounces-139152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C2BAA4B60
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03FF1891942
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E5B21C9E7;
	Wed, 30 Apr 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZZW5IaS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5F258CC3
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016631; cv=none; b=B/5UOMSU5RTOEnWRrWJRvSJdlvyVbXhcHW4vODWpjPhhtuMwwm/XZtn9chuDyIOb9mwhOyGlfmXMRFaF6UnJNc/vMk1DkEYrrw9MagoAQTFfQehzXWtyp358qvTC5ydMggLPcXWQJf+QxqlFu4KjZuqnczE+0FOtmwN5iCm/fyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016631; c=relaxed/simple;
	bh=scTjtvZknnuGeOEd4izQWC3fZAMY4JHoMadKEWNAjfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSmU2+lEtCdut8hUSfBJo4wu4nSxDjnFsHpHBZp2FU0AgHADxr6zCVk7aAKQwbEIeVYG748E5JU1WQcGLYJlEYFcnU0O14GnKfacDCyt07ZiTrsojS+5xvp+t8gxts3GED+2ZEwTe7H5rc29BNNR9TgB9QoJ/Xvua5VknNoP9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZZW5IaS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746016630; x=1777552630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=scTjtvZknnuGeOEd4izQWC3fZAMY4JHoMadKEWNAjfE=;
  b=DZZW5IaS+kAZOmBWy2C4SGfjPvIp7itASDaWmn1EVR1nQwpf1c8ahCYh
   CQcQW4+N9th5ETWXSGcFERZqETWm21iGb8yFegkLJMUWWAoYxTDlYcMcd
   r627w6HoF0PmDw/HS7luzGqD0MSaFpQBVRXfaMdw6ESJcWIY5c40y6ahJ
   2dbyn3zinaab2JXGBLZuFI6Bln/mUzEfBv/YbWNF8hqbxUWPWPzJspQJv
   BsfUm0vxkfJE/Uj9fyIgH5JuWbGyE5Eu3s6Q+9Tb3qimoZ3dhRdjh9OzV
   5VkbdiTwvzeh71z12wIf2FKAZtKTPH35wgiA+lcobfmH6Rg2lFDwlRLIJ
   w==;
X-CSE-ConnectionGUID: d7rXRnyPQXuMBE23McXS4Q==
X-CSE-MsgGUID: ZMUSP5f3RuuS1vxlwyg0tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51336928"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51336928"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:37:00 -0700
X-CSE-ConnectionGUID: VX7/Bld/ToS1du23xpP0cw==
X-CSE-MsgGUID: 0fJWIf3QSliNbJnSGg6YPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="165201921"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:36:58 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 2/3] accel/ivpu: Fix locking order in ivpu_job_submit
Date: Wed, 30 Apr 2025 14:36:52 +0200
Message-ID: <20250430123653.3748811-3-jacek.lawrynowicz@linux.intel.com>
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

Cc: <stable@vger.kernel.org> # v6.14
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-12-maciej.falkowski@linux.intel.com
---
 drivers/accel/ivpu/ivpu_job.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index fc91681469e33..5b6d93c20b2da 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -532,6 +532,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 	if (ret < 0)
 		return ret;
 
+	mutex_lock(&vdev->submitted_jobs_lock);
 	mutex_lock(&file_priv->lock);
 
 	cmdq = ivpu_cmdq_acquire(file_priv, priority);
@@ -539,11 +540,9 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
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
@@ -551,7 +550,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 		ivpu_dbg(vdev, JOB, "Too many active jobs in ctx %d\n",
 			 file_priv->ctx.id);
 		ret = -EBUSY;
-		goto err_unlock_submitted_jobs;
+		goto err_unlock;
 	}
 
 	ret = ivpu_cmdq_push_job(cmdq, job);
@@ -574,22 +573,20 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
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


