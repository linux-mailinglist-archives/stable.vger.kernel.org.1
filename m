Return-Path: <stable+bounces-139159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AD3AA4BB1
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE443A74DC
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338B23815D;
	Wed, 30 Apr 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGpjDNPo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B725A2C9
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017313; cv=none; b=E6WHFXQedCIK98BuKCMozQxSCpALZ3IO0Gs3975uzlqBSkauG34v0JCTienmov2mWTuX5LRoEv68kpqhHlCPYemFMU9yi+UOHS5UNixmLCuKgdSyM8/9jtLHNLtFWTORIEDIbItDDe0ogxCdGdV6ljvdiexIb15+75NxTO3AizA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017313; c=relaxed/simple;
	bh=LkL2TDIPXmr7gMfoQk5R4veL5ALzDzYwOFeXJIRq23k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTGFsRh/10vNOodh22vJmyps4UKJ484GjOpBMODLq3DTrS4py53Uj9F7Zh1CUEOPWP9ryJ/s468PENK7tP9LOhisgHN1mPh5yu52VjwmjbwZgWzsAfhp9Qwqhch1f7ZtmnQ8J393Jvma1t54Ua9GLMdkslExCBkPK/BgMFEXBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGpjDNPo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017312; x=1777553312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LkL2TDIPXmr7gMfoQk5R4veL5ALzDzYwOFeXJIRq23k=;
  b=fGpjDNPoux4WTgTVsS7oE52zfaDSU3fI0vEdkggmQu9LcULbSNTW4ZD4
   MslB7wOqsr4IGoK33BqFqBgJhBLkpnh6UgFQApWc+eRQHdqzTrJ0PIq27
   dWoXOtUb4yqjpXrh3blBczcX4P7vvHNnax6miU//fchNH2uv0vSMFuF8X
   5it2HYeKrWFExj7u2MqGrOrU3Xrk3O0W/0uFEJHpebp4mdN4h4WWNLAWH
   PL2ws8uLJFuDZLw17it1KNRT+emmvP5nkuXLAAtG/l7DAB5fBUmCVLnGg
   Nx9w04BrSVRvWziyiQgj1DzELwxvX7zNXCXS39q0ra60Cw/gBOFj1sCpC
   A==;
X-CSE-ConnectionGUID: nSGqptlGT1WeB4ux1RihXw==
X-CSE-MsgGUID: KlENVNiGSKq2za5MWTujRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51488514"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51488514"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:31 -0700
X-CSE-ConnectionGUID: b0p0QSVOTwaJFE6NKCHxUQ==
X-CSE-MsgGUID: PoXOPnoYTxGR7Q/ZaUiztw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138925418"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:30 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 5/7] accel/ivpu: Abort all jobs after command queue unregister
Date: Wed, 30 Apr 2025 14:48:17 +0200
Message-ID: <20250430124819.3761263-6-jacek.lawrynowicz@linux.intel.com>
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

commit 5bbccadaf33eea2b879d8326ad59ae0663be47d1 upstream.

With hardware scheduler it is not expected to receive JOB_DONE
notifications from NPU FW for the jobs aborted due to command queue destroy
JSM command.

Remove jobs submitted to unregistered command queue from submitted_jobs_xa
to avoid triggering a TDR in such case.

Add explicit submitted_jobs_lock that protects access to list of submitted
jobs which is now used to find jobs to abort.

Move context abort procedure to separate work queue not to slow down
handling of IPCs or DCT requests in case where job abort takes longer,
especially when destruction of the last job of a specific context results
in context release.

Cc: <stable@vger.kernel.org> # v6.12
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-4-maciej.falkowski@linux.intel.com
---
 drivers/accel/ivpu/ivpu_drv.c   | 32 +++----------
 drivers/accel/ivpu/ivpu_drv.h   |  2 +
 drivers/accel/ivpu/ivpu_job.c   | 82 +++++++++++++++++++++++++--------
 drivers/accel/ivpu/ivpu_job.h   |  1 +
 drivers/accel/ivpu/ivpu_mmu.c   |  3 +-
 drivers/accel/ivpu/ivpu_sysfs.c |  5 +-
 6 files changed, 77 insertions(+), 48 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 17b3d38abd68d..817c3c0f58e2b 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -36,8 +36,6 @@
 			   __stringify(DRM_IVPU_DRIVER_MINOR) "."
 #endif
 
-static struct lock_class_key submitted_jobs_xa_lock_class_key;
-
 int ivpu_dbg_mask;
 module_param_named(dbg_mask, ivpu_dbg_mask, int, 0644);
 MODULE_PARM_DESC(dbg_mask, "Driver debug mask. See IVPU_DBG_* macros.");
@@ -455,26 +453,6 @@ static const struct drm_driver driver = {
 	.minor = DRM_IVPU_DRIVER_MINOR,
 };
 
-static void ivpu_context_abort_invalid(struct ivpu_device *vdev)
-{
-	struct ivpu_file_priv *file_priv;
-	unsigned long ctx_id;
-
-	mutex_lock(&vdev->context_list_lock);
-
-	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
-		if (!file_priv->has_mmu_faults || file_priv->aborted)
-			continue;
-
-		mutex_lock(&file_priv->lock);
-		ivpu_context_abort_locked(file_priv);
-		file_priv->aborted = true;
-		mutex_unlock(&file_priv->lock);
-	}
-
-	mutex_unlock(&vdev->context_list_lock);
-}
-
 static irqreturn_t ivpu_irq_thread_handler(int irq, void *arg)
 {
 	struct ivpu_device *vdev = arg;
@@ -488,9 +466,6 @@ static irqreturn_t ivpu_irq_thread_handler(int irq, void *arg)
 		case IVPU_HW_IRQ_SRC_IPC:
 			ivpu_ipc_irq_thread_handler(vdev);
 			break;
-		case IVPU_HW_IRQ_SRC_MMU_EVTQ:
-			ivpu_context_abort_invalid(vdev);
-			break;
 		case IVPU_HW_IRQ_SRC_DCT:
 			ivpu_pm_dct_irq_thread_handler(vdev);
 			break;
@@ -607,16 +582,21 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 	xa_init_flags(&vdev->context_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	xa_init_flags(&vdev->submitted_jobs_xa, XA_FLAGS_ALLOC1);
 	xa_init_flags(&vdev->db_xa, XA_FLAGS_ALLOC1);
-	lockdep_set_class(&vdev->submitted_jobs_xa.xa_lock, &submitted_jobs_xa_lock_class_key);
 	INIT_LIST_HEAD(&vdev->bo_list);
 
 	vdev->db_limit.min = IVPU_MIN_DB;
 	vdev->db_limit.max = IVPU_MAX_DB;
 
+	INIT_WORK(&vdev->context_abort_work, ivpu_context_abort_thread_handler);
+
 	ret = drmm_mutex_init(&vdev->drm, &vdev->context_list_lock);
 	if (ret)
 		goto err_xa_destroy;
 
+	ret = drmm_mutex_init(&vdev->drm, &vdev->submitted_jobs_lock);
+	if (ret)
+		goto err_xa_destroy;
+
 	ret = drmm_mutex_init(&vdev->drm, &vdev->bo_list_lock);
 	if (ret)
 		goto err_xa_destroy;
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 56509c5a3875b..a5707a85e7255 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -137,6 +137,7 @@ struct ivpu_device {
 	struct mutex context_list_lock; /* Protects user context addition/removal */
 	struct xarray context_xa;
 	struct xa_limit context_xa_limit;
+	struct work_struct context_abort_work;
 
 	struct xarray db_xa;
 	struct xa_limit db_limit;
@@ -145,6 +146,7 @@ struct ivpu_device {
 	struct mutex bo_list_lock; /* Protects bo_list */
 	struct list_head bo_list;
 
+	struct mutex submitted_jobs_lock; /* Protects submitted_jobs */
 	struct xarray submitted_jobs_xa;
 	struct ivpu_ipc_consumer job_done_consumer;
 
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index c2108346c4c9d..8207d1218e207 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -335,6 +335,8 @@ void ivpu_context_abort_locked(struct ivpu_file_priv *file_priv)
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS)
 		ivpu_jsm_context_release(vdev, file_priv->ctx.id);
+
+	file_priv->aborted = true;
 }
 
 static int ivpu_cmdq_push_job(struct ivpu_cmdq *cmdq, struct ivpu_job *job)
@@ -467,16 +469,14 @@ static struct ivpu_job *ivpu_job_remove_from_submitted_jobs(struct ivpu_device *
 {
 	struct ivpu_job *job;
 
-	xa_lock(&vdev->submitted_jobs_xa);
-	job = __xa_erase(&vdev->submitted_jobs_xa, job_id);
+	lockdep_assert_held(&vdev->submitted_jobs_lock);
 
+	job = xa_erase(&vdev->submitted_jobs_xa, job_id);
 	if (xa_empty(&vdev->submitted_jobs_xa) && job) {
 		vdev->busy_time = ktime_add(ktime_sub(ktime_get(), vdev->busy_start_ts),
 					    vdev->busy_time);
 	}
 
-	xa_unlock(&vdev->submitted_jobs_xa);
-
 	return job;
 }
 
@@ -484,6 +484,8 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 {
 	struct ivpu_job *job;
 
+	lockdep_assert_held(&vdev->submitted_jobs_lock);
+
 	job = ivpu_job_remove_from_submitted_jobs(vdev, job_id);
 	if (!job)
 		return -ENOENT;
@@ -501,6 +503,10 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 	ivpu_stop_job_timeout_detection(vdev);
 
 	ivpu_rpm_put(vdev);
+
+	if (!xa_empty(&vdev->submitted_jobs_xa))
+		ivpu_start_job_timeout_detection(vdev);
+
 	return 0;
 }
 
@@ -509,8 +515,12 @@ void ivpu_jobs_abort_all(struct ivpu_device *vdev)
 	struct ivpu_job *job;
 	unsigned long id;
 
+	mutex_lock(&vdev->submitted_jobs_lock);
+
 	xa_for_each(&vdev->submitted_jobs_xa, id, job)
 		ivpu_job_signal_and_destroy(vdev, id, DRM_IVPU_JOB_STATUS_ABORTED);
+
+	mutex_unlock(&vdev->submitted_jobs_lock);
 }
 
 static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
@@ -535,15 +545,16 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 		goto err_unlock_file_priv;
 	}
 
-	xa_lock(&vdev->submitted_jobs_xa);
+	mutex_lock(&vdev->submitted_jobs_lock);
+
 	is_first_job = xa_empty(&vdev->submitted_jobs_xa);
-	ret = __xa_alloc_cyclic(&vdev->submitted_jobs_xa, &job->job_id, job, file_priv->job_limit,
-				&file_priv->job_id_next, GFP_KERNEL);
+	ret = xa_alloc_cyclic(&vdev->submitted_jobs_xa, &job->job_id, job, file_priv->job_limit,
+			      &file_priv->job_id_next, GFP_KERNEL);
 	if (ret < 0) {
 		ivpu_dbg(vdev, JOB, "Too many active jobs in ctx %d\n",
 			 file_priv->ctx.id);
 		ret = -EBUSY;
-		goto err_unlock_submitted_jobs_xa;
+		goto err_unlock_submitted_jobs;
 	}
 
 	ret = ivpu_cmdq_push_job(cmdq, job);
@@ -565,19 +576,21 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 		 job->job_id, file_priv->ctx.id, job->engine_idx, priority,
 		 job->cmd_buf_vpu_addr, cmdq->jobq->header.tail);
 
-	xa_unlock(&vdev->submitted_jobs_xa);
-
+	mutex_unlock(&vdev->submitted_jobs_lock);
 	mutex_unlock(&file_priv->lock);
 
-	if (unlikely(ivpu_test_mode & IVPU_TEST_MODE_NULL_HW))
+	if (unlikely(ivpu_test_mode & IVPU_TEST_MODE_NULL_HW)) {
+		mutex_lock(&vdev->submitted_jobs_lock);
 		ivpu_job_signal_and_destroy(vdev, job->job_id, VPU_JSM_STATUS_SUCCESS);
+		mutex_unlock(&vdev->submitted_jobs_lock);
+	}
 
 	return 0;
 
 err_erase_xa:
-	__xa_erase(&vdev->submitted_jobs_xa, job->job_id);
-err_unlock_submitted_jobs_xa:
-	xa_unlock(&vdev->submitted_jobs_xa);
+	xa_erase(&vdev->submitted_jobs_xa, job->job_id);
+err_unlock_submitted_jobs:
+	mutex_unlock(&vdev->submitted_jobs_lock);
 err_unlock_file_priv:
 	mutex_unlock(&file_priv->lock);
 	ivpu_rpm_put(vdev);
@@ -748,7 +761,6 @@ ivpu_job_done_callback(struct ivpu_device *vdev, struct ivpu_ipc_hdr *ipc_hdr,
 		       struct vpu_jsm_msg *jsm_msg)
 {
 	struct vpu_ipc_msg_payload_job_done *payload;
-	int ret;
 
 	if (!jsm_msg) {
 		ivpu_err(vdev, "IPC message has no JSM payload\n");
@@ -761,9 +773,10 @@ ivpu_job_done_callback(struct ivpu_device *vdev, struct ivpu_ipc_hdr *ipc_hdr,
 	}
 
 	payload = (struct vpu_ipc_msg_payload_job_done *)&jsm_msg->payload;
-	ret = ivpu_job_signal_and_destroy(vdev, payload->job_id, payload->job_status);
-	if (!ret && !xa_empty(&vdev->submitted_jobs_xa))
-		ivpu_start_job_timeout_detection(vdev);
+
+	mutex_lock(&vdev->submitted_jobs_lock);
+	ivpu_job_signal_and_destroy(vdev, payload->job_id, payload->job_status);
+	mutex_unlock(&vdev->submitted_jobs_lock);
 }
 
 void ivpu_job_done_consumer_init(struct ivpu_device *vdev)
@@ -776,3 +789,36 @@ void ivpu_job_done_consumer_fini(struct ivpu_device *vdev)
 {
 	ivpu_ipc_consumer_del(vdev, &vdev->job_done_consumer);
 }
+
+void ivpu_context_abort_thread_handler(struct work_struct *work)
+{
+	struct ivpu_device *vdev = container_of(work, struct ivpu_device, context_abort_work);
+	struct ivpu_file_priv *file_priv;
+	unsigned long ctx_id;
+	struct ivpu_job *job;
+	unsigned long id;
+
+	mutex_lock(&vdev->context_list_lock);
+	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
+		if (!file_priv->has_mmu_faults || file_priv->aborted)
+			continue;
+
+		mutex_lock(&file_priv->lock);
+		ivpu_context_abort_locked(file_priv);
+		mutex_unlock(&file_priv->lock);
+	}
+	mutex_unlock(&vdev->context_list_lock);
+
+	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
+		return;
+	/*
+	 * In hardware scheduling mode NPU already has stopped processing jobs
+	 * and won't send us any further notifications, thus we have to free job related resources
+	 * and notify userspace
+	 */
+	mutex_lock(&vdev->submitted_jobs_lock);
+	xa_for_each(&vdev->submitted_jobs_xa, id, job)
+		if (job->file_priv->aborted)
+			ivpu_job_signal_and_destroy(vdev, job->job_id, DRM_IVPU_JOB_STATUS_ABORTED);
+	mutex_unlock(&vdev->submitted_jobs_lock);
+}
diff --git a/drivers/accel/ivpu/ivpu_job.h b/drivers/accel/ivpu/ivpu_job.h
index 6accb94028c7a..0ae77f0638fad 100644
--- a/drivers/accel/ivpu/ivpu_job.h
+++ b/drivers/accel/ivpu/ivpu_job.h
@@ -64,6 +64,7 @@ void ivpu_cmdq_reset_all_contexts(struct ivpu_device *vdev);
 
 void ivpu_job_done_consumer_init(struct ivpu_device *vdev);
 void ivpu_job_done_consumer_fini(struct ivpu_device *vdev);
+void ivpu_context_abort_thread_handler(struct work_struct *work);
 
 void ivpu_jobs_abort_all(struct ivpu_device *vdev);
 
diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index c078e214b2212..fb15eb75b5ba9 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -917,8 +917,7 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
 		REGV_WR32(IVPU_MMU_REG_EVTQ_CONS_SEC, vdev->mmu->evtq.cons);
 	}
 
-	if (!kfifo_put(&vdev->hw->irq.fifo, IVPU_HW_IRQ_SRC_MMU_EVTQ))
-		ivpu_err_ratelimited(vdev, "IRQ FIFO full\n");
+	queue_work(system_wq, &vdev->context_abort_work);
 }
 
 void ivpu_mmu_evtq_dump(struct ivpu_device *vdev)
diff --git a/drivers/accel/ivpu/ivpu_sysfs.c b/drivers/accel/ivpu/ivpu_sysfs.c
index 616477fc17fa0..8a616791c32f5 100644
--- a/drivers/accel/ivpu/ivpu_sysfs.c
+++ b/drivers/accel/ivpu/ivpu_sysfs.c
@@ -30,11 +30,12 @@ npu_busy_time_us_show(struct device *dev, struct device_attribute *attr, char *b
 	struct ivpu_device *vdev = to_ivpu_device(drm);
 	ktime_t total, now = 0;
 
-	xa_lock(&vdev->submitted_jobs_xa);
+	mutex_lock(&vdev->submitted_jobs_lock);
+
 	total = vdev->busy_time;
 	if (!xa_empty(&vdev->submitted_jobs_xa))
 		now = ktime_sub(ktime_get(), vdev->busy_start_ts);
-	xa_unlock(&vdev->submitted_jobs_xa);
+	mutex_unlock(&vdev->submitted_jobs_lock);
 
 	return sysfs_emit(buf, "%lld\n", ktime_to_us(ktime_add(total, now)));
 }
-- 
2.45.1


