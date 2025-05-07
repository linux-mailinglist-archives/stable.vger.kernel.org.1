Return-Path: <stable+bounces-142599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1577AAEB5C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699DA1C08C5E
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16A728E584;
	Wed,  7 May 2025 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gf1yz7Jm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4F214813;
	Wed,  7 May 2025 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644750; cv=none; b=IDiBCdGuZfbfzNvz3HStG64wftn2Uo7TlZE5jC/lqXXvs3kg7FtLLTHHURmcsu2UfJTcgU9EMzmE3HWN1x175UXTQFn17EetZdJEiKosBv5MbB1lF6JtXVusaCmhXvkhRHOPaytCV+b0vTKUbXRENXzxTEPMQb7CDW5wcWJ0j1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644750; c=relaxed/simple;
	bh=+7nkfop8RBNyUbLusxMQZqCHfu4x/THC+811XTIvq8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMF+ld8NL1Eoogbq98fcxBjfEMsFTnJE9dllrRp3zHJK4O2zwSrRgNtbk0iKqfSFOWrlPuBG/UfDIz77w3fhUn7RXseqynj5S/EM+5bXvQmmuqQoUn9ysoOaHrAgVXAxAuPvK5IjH1lY6watIRBJ8YOC2Krw7fNI4Iw9b728gwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gf1yz7Jm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ACCC4CEE2;
	Wed,  7 May 2025 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644750;
	bh=+7nkfop8RBNyUbLusxMQZqCHfu4x/THC+811XTIvq8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gf1yz7JmW/FD4zwDs+Qo2lxcmnnxtb6IxIevgXj8ixpmQHgwNdsVg5b/9Fdp3XEqI
	 PBGYJnO7vnEWiIQkEH03Rth+XSlM9dWPBsF8rRNbFPEJuUb/iESLcRmHAekgSveUws
	 idO3D/NQJxllPN4/DBoKNCEFkksV0EpLpwYzPlV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karol Wachowski <karol.wachowski@intel.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 6.12 144/164] accel/ivpu: Abort all jobs after command queue unregister
Date: Wed,  7 May 2025 20:40:29 +0200
Message-ID: <20250507183826.798985764@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
References: <20250507183820.781599563@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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

Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-4-maciej.falkowski@linux.intel.com
[ This backport removes all the lines from upstream commit related to
  the command queue UAPI, as it is not present in the 6.12 kernel and
  should not be backported. ]
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_drv.c   |   32 ++-------------
 drivers/accel/ivpu/ivpu_drv.h   |    2 
 drivers/accel/ivpu/ivpu_job.c   |   82 +++++++++++++++++++++++++++++++---------
 drivers/accel/ivpu/ivpu_job.h   |    1 
 drivers/accel/ivpu/ivpu_mmu.c   |    3 -
 drivers/accel/ivpu/ivpu_sysfs.c |    5 +-
 6 files changed, 77 insertions(+), 48 deletions(-)

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
@@ -455,26 +453,6 @@ static const struct drm_driver driver =
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
@@ -488,9 +466,6 @@ static irqreturn_t ivpu_irq_thread_handl
 		case IVPU_HW_IRQ_SRC_IPC:
 			ivpu_ipc_irq_thread_handler(vdev);
 			break;
-		case IVPU_HW_IRQ_SRC_MMU_EVTQ:
-			ivpu_context_abort_invalid(vdev);
-			break;
 		case IVPU_HW_IRQ_SRC_DCT:
 			ivpu_pm_dct_irq_thread_handler(vdev);
 			break;
@@ -607,16 +582,21 @@ static int ivpu_dev_init(struct ivpu_dev
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
 
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -335,6 +335,8 @@ void ivpu_context_abort_locked(struct iv
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS)
 		ivpu_jsm_context_release(vdev, file_priv->ctx.id);
+
+	file_priv->aborted = true;
 }
 
 static int ivpu_cmdq_push_job(struct ivpu_cmdq *cmdq, struct ivpu_job *job)
@@ -467,16 +469,14 @@ static struct ivpu_job *ivpu_job_remove_
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
 
@@ -484,6 +484,8 @@ static int ivpu_job_signal_and_destroy(s
 {
 	struct ivpu_job *job;
 
+	lockdep_assert_held(&vdev->submitted_jobs_lock);
+
 	job = ivpu_job_remove_from_submitted_jobs(vdev, job_id);
 	if (!job)
 		return -ENOENT;
@@ -501,6 +503,10 @@ static int ivpu_job_signal_and_destroy(s
 	ivpu_stop_job_timeout_detection(vdev);
 
 	ivpu_rpm_put(vdev);
+
+	if (!xa_empty(&vdev->submitted_jobs_xa))
+		ivpu_start_job_timeout_detection(vdev);
+
 	return 0;
 }
 
@@ -509,8 +515,12 @@ void ivpu_jobs_abort_all(struct ivpu_dev
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
@@ -535,15 +545,16 @@ static int ivpu_job_submit(struct ivpu_j
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
@@ -565,19 +576,21 @@ static int ivpu_job_submit(struct ivpu_j
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
@@ -748,7 +761,6 @@ ivpu_job_done_callback(struct ivpu_devic
 		       struct vpu_jsm_msg *jsm_msg)
 {
 	struct vpu_ipc_msg_payload_job_done *payload;
-	int ret;
 
 	if (!jsm_msg) {
 		ivpu_err(vdev, "IPC message has no JSM payload\n");
@@ -761,9 +773,10 @@ ivpu_job_done_callback(struct ivpu_devic
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
@@ -776,3 +789,36 @@ void ivpu_job_done_consumer_fini(struct
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
--- a/drivers/accel/ivpu/ivpu_job.h
+++ b/drivers/accel/ivpu/ivpu_job.h
@@ -64,6 +64,7 @@ void ivpu_cmdq_reset_all_contexts(struct
 
 void ivpu_job_done_consumer_init(struct ivpu_device *vdev);
 void ivpu_job_done_consumer_fini(struct ivpu_device *vdev);
+void ivpu_context_abort_thread_handler(struct work_struct *work);
 
 void ivpu_jobs_abort_all(struct ivpu_device *vdev);
 
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -917,8 +917,7 @@ void ivpu_mmu_irq_evtq_handler(struct iv
 		REGV_WR32(IVPU_MMU_REG_EVTQ_CONS_SEC, vdev->mmu->evtq.cons);
 	}
 
-	if (!kfifo_put(&vdev->hw->irq.fifo, IVPU_HW_IRQ_SRC_MMU_EVTQ))
-		ivpu_err_ratelimited(vdev, "IRQ FIFO full\n");
+	queue_work(system_wq, &vdev->context_abort_work);
 }
 
 void ivpu_mmu_evtq_dump(struct ivpu_device *vdev)
--- a/drivers/accel/ivpu/ivpu_sysfs.c
+++ b/drivers/accel/ivpu/ivpu_sysfs.c
@@ -30,11 +30,12 @@ npu_busy_time_us_show(struct device *dev
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



