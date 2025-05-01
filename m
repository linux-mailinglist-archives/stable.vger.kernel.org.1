Return-Path: <stable+bounces-139384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A12DAAA6398
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6214E1B641EC
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB748224AE1;
	Thu,  1 May 2025 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMB9Vnit"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4951DF751
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126713; cv=none; b=R9u/AD0j0Is2jio/CZIjHBwQA1NCsePGt3RAJ2Hv9r4JlTRd7TS5z4d7jg6NNTVMcSbl1bvup3K5pmwFQkeLiYnKKw7/yK4EwJYsPMI4F05Se6w1d3msAjfQIqjWe+jVvT/FM9dIc/UodwV/C6h+ADnRt+0MpkWFCCRodHkmhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126713; c=relaxed/simple;
	bh=/Q5Ovrp9n+092gRlhOfLg5HTp21KzY+OmRloWn0alBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHEbbrV4A5Tru31bL1QrRQsNuwgtIv6sTxov4xoN2S2xMK8e39WE2ICPBre4/ASw6pENsYZx5AXKk3y34OWxKixbAlN0alWf+nRKjelEGtS/iRr2gq2v3POv07tY6W+2yo8KRRM1rg1EU8L+OHHI3iSxlk8a0tKxaiEkrfNAjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMB9Vnit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E127C4CEE3;
	Thu,  1 May 2025 19:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126711;
	bh=/Q5Ovrp9n+092gRlhOfLg5HTp21KzY+OmRloWn0alBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMB9Vnitoe+Vi8cRDNM2FNa5iMpQJ7mqaCpcPqoB3aTQ2GhcMSMK5BDDfhTbExFb+
	 U1dS1Gz6+a2V2AoR9yObprYNMWLof+BzYB9VEWk0oS72L5ePn8R9W+wiLf+mPdGA6T
	 w71bGXupKPlDuTZzI+gQ5Fsh3QKm3jYbe3/bjJ5juwIUWy0uyR5OwCUInkW7gi6CBk
	 ZIUF9Ye9Jl9be6pZ1e2v4+MX1biTUVGwHJtou0W1MixaYZFp8IoDHq3lBSnCD2hC00
	 nC4L1ug6QGWnxz2k7ACmPRpYxwsw8ge8lwbrwOd6DAJ8phuStzXeuf6Vl9gjeNpcRA
	 6R0Rx2ZfCVYOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/3] accel/ivpu: Abort all jobs after command queue unregister
Date: Thu,  1 May 2025 15:11:47 -0400
Message-Id: <20250501082330-a4e45016de508c6e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430123653.3748811-2-jacek.lawrynowicz@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 5bbccadaf33eea2b879d8326ad59ae0663be47d1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  5bbccadaf33ee ! 1:  ac0a38707ed72 accel/ivpu: Abort all jobs after command queue unregister
    @@ Metadata
      ## Commit message ##
         accel/ivpu: Abort all jobs after command queue unregister
     
    +    commit 5bbccadaf33eea2b879d8326ad59ae0663be47d1 upstream.
    +
         With hardware scheduler it is not expected to receive JOB_DONE
         notifications from NPU FW for the jobs aborted due to command queue destroy
         JSM command.
    @@ Commit message
         especially when destruction of the last job of a specific context results
         in context release.
     
    +    Cc: <stable@vger.kernel.org> # v6.14
         Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
         Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
         Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
    @@ drivers/accel/ivpu/ivpu_drv.h: struct ivpu_device {
      
     
      ## drivers/accel/ivpu/ivpu_job.c ##
    -@@ drivers/accel/ivpu/ivpu_job.c: static struct ivpu_cmdq *ivpu_cmdq_create(struct ivpu_file_priv *file_priv, u8 p
    - 
    - 	cmdq->priority = priority;
    - 	cmdq->is_legacy = is_legacy;
    -+	cmdq->is_valid = true;
    - 
    - 	ret = xa_alloc_cyclic(&file_priv->cmdq_xa, &cmdq->id, cmdq, file_priv->cmdq_limit,
    - 			      &file_priv->cmdq_id_next, GFP_KERNEL);
    -@@ drivers/accel/ivpu/ivpu_job.c: static struct ivpu_cmdq *ivpu_cmdq_create(struct ivpu_file_priv *file_priv, u8 p
    - 		goto err_free_cmdq;
    - 	}
    - 
    -+	ivpu_dbg(vdev, JOB, "Command queue %d created, ctx %d\n", cmdq->id, file_priv->ctx.id);
    - 	return cmdq;
    - 
    - err_free_cmdq:
    -@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_cmdq_unregister(struct ivpu_file_priv *file_priv, struct ivpu_cm
    +@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_cmdq_fini(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cm
      	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW) {
      		ret = ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->id);
      		if (!ret)
    @@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_cmdq_unregister(struct ivpu_file_
      	}
      
      	ret = ivpu_jsm_unregister_db(vdev, cmdq->db_id);
    -@@ drivers/accel/ivpu/ivpu_job.c: static struct ivpu_cmdq *ivpu_cmdq_acquire(struct ivpu_file_priv *file_priv, u32
    - 	lockdep_assert_held(&file_priv->lock);
    - 
    - 	cmdq = xa_load(&file_priv->cmdq_xa, cmdq_id);
    --	if (!cmdq) {
    --		ivpu_err(vdev, "Failed to find command queue with ID: %u\n", cmdq_id);
    -+	if (!cmdq || !cmdq->is_valid) {
    -+		ivpu_warn_ratelimited(vdev, "Failed to find command queue with ID: %u\n", cmdq_id);
    - 		return NULL;
    - 	}
    - 
    -@@ drivers/accel/ivpu/ivpu_job.c: void ivpu_cmdq_reset_all_contexts(struct ivpu_device *vdev)
    - 	mutex_unlock(&vdev->context_list_lock);
    - }
    - 
    --static void ivpu_cmdq_unregister_all(struct ivpu_file_priv *file_priv)
    --{
    --	struct ivpu_cmdq *cmdq;
    --	unsigned long cmdq_id;
    --
    --	xa_for_each(&file_priv->cmdq_xa, cmdq_id, cmdq)
    --		ivpu_cmdq_unregister(file_priv, cmdq);
    --}
    --
    - void ivpu_context_abort_locked(struct ivpu_file_priv *file_priv)
    - {
    - 	struct ivpu_device *vdev = file_priv->vdev;
    -+	struct ivpu_cmdq *cmdq;
    -+	unsigned long cmdq_id;
    - 
    - 	lockdep_assert_held(&file_priv->lock);
    - 
    --	ivpu_cmdq_unregister_all(file_priv);
    -+	xa_for_each(&file_priv->cmdq_xa, cmdq_id, cmdq)
    -+		ivpu_cmdq_unregister(file_priv, cmdq);
    +@@ drivers/accel/ivpu/ivpu_job.c: void ivpu_context_abort_locked(struct ivpu_file_priv *file_priv)
      
      	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS)
      		ivpu_jsm_context_release(vdev, file_priv->ctx.id);
    @@ drivers/accel/ivpu/ivpu_job.c: void ivpu_jobs_abort_all(struct ivpu_device *vdev
      	xa_for_each(&vdev->submitted_jobs_xa, id, job)
      		ivpu_job_signal_and_destroy(vdev, id, DRM_IVPU_JOB_STATUS_ABORTED);
     +
    -+	mutex_unlock(&vdev->submitted_jobs_lock);
    -+}
    -+
    -+void ivpu_cmdq_abort_all_jobs(struct ivpu_device *vdev, u32 ctx_id, u32 cmdq_id)
    -+{
    -+	struct ivpu_job *job;
    -+	unsigned long id;
    -+
    -+	mutex_lock(&vdev->submitted_jobs_lock);
    -+
    -+	xa_for_each(&vdev->submitted_jobs_xa, id, job)
    -+		if (job->file_priv->ctx.id == ctx_id && job->cmdq_id == cmdq_id)
    -+			ivpu_job_signal_and_destroy(vdev, id, DRM_IVPU_JOB_STATUS_ABORTED);
    -+
     +	mutex_unlock(&vdev->submitted_jobs_lock);
      }
      
    - static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
    -@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
    + static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
    +@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
      		goto err_unlock_file_priv;
      	}
      
     -	xa_lock(&vdev->submitted_jobs_xa);
    -+	job->cmdq_id = cmdq->id;
    -+
     +	mutex_lock(&vdev->submitted_jobs_lock);
     +
      	is_first_job = xa_empty(&vdev->submitted_jobs_xa);
    @@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job,
      	}
      
      	ret = ivpu_cmdq_push_job(cmdq, job);
    -@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
    - 		 job->job_id, file_priv->ctx.id, job->engine_idx, cmdq->priority,
    +@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
    + 		 job->job_id, file_priv->ctx.id, job->engine_idx, priority,
      		 job->cmd_buf_vpu_addr, cmdq->jobq->header.tail);
      
     -	xa_unlock(&vdev->submitted_jobs_xa);
    @@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job,
      err_unlock_file_priv:
      	mutex_unlock(&file_priv->lock);
      	ivpu_rpm_put(vdev);
    -@@ drivers/accel/ivpu/ivpu_job.c: int ivpu_cmdq_create_ioctl(struct drm_device *dev, void *data, struct drm_file *
    - int ivpu_cmdq_destroy_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
    - {
    - 	struct ivpu_file_priv *file_priv = file->driver_priv;
    -+	struct ivpu_device *vdev = file_priv->vdev;
    - 	struct drm_ivpu_cmdq_destroy *args = data;
    - 	struct ivpu_cmdq *cmdq;
    -+	u32 cmdq_id;
    - 	int ret = 0;
    - 
    - 	mutex_lock(&file_priv->lock);
    - 
    - 	cmdq = xa_load(&file_priv->cmdq_xa, args->cmdq_id);
    --	if (!cmdq || cmdq->is_legacy) {
    -+	if (!cmdq || !cmdq->is_valid || cmdq->is_legacy) {
    - 		ret = -ENOENT;
    - 		goto unlock;
    - 	}
    - 
    -+	/*
    -+	 * There is no way to stop executing jobs per command queue
    -+	 * in OS scheduling mode, mark command queue as invalid instead
    -+	 * and it will be freed together with context release.
    -+	 */
    -+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS) {
    -+		cmdq->is_valid = false;
    -+		goto unlock;
    -+	}
    -+
    -+	cmdq_id = cmdq->id;
    - 	ivpu_cmdq_destroy(file_priv, cmdq);
    -+	ivpu_cmdq_abort_all_jobs(vdev, file_priv->ctx.id, cmdq_id);
    - unlock:
    - 	mutex_unlock(&file_priv->lock);
    - 	return ret;
     @@ drivers/accel/ivpu/ivpu_job.c: ivpu_job_done_callback(struct ivpu_device *vdev, struct ivpu_ipc_hdr *ipc_hdr,
      		       struct vpu_jsm_msg *jsm_msg)
      {
    @@ drivers/accel/ivpu/ivpu_job.c: void ivpu_job_done_consumer_fini(struct ivpu_devi
     +}
     
      ## drivers/accel/ivpu/ivpu_job.h ##
    -@@ drivers/accel/ivpu/ivpu_job.h: struct ivpu_cmdq {
    - 	u32 id;
    - 	u32 db_id;
    - 	u8 priority;
    -+	bool is_valid;
    - 	bool is_legacy;
    - };
    - 
    -@@ drivers/accel/ivpu/ivpu_job.h: struct ivpu_job {
    - 	struct ivpu_file_priv *file_priv;
    - 	struct dma_fence *done_fence;
    - 	u64 cmd_buf_vpu_addr;
    -+	u32 cmdq_id;
    - 	u32 job_id;
    - 	u32 engine_idx;
    - 	size_t bo_count;
    -@@ drivers/accel/ivpu/ivpu_job.h: void ivpu_context_abort_locked(struct ivpu_file_priv *file_priv);
    - 
    - void ivpu_cmdq_release_all_locked(struct ivpu_file_priv *file_priv);
    - void ivpu_cmdq_reset_all_contexts(struct ivpu_device *vdev);
    -+void ivpu_cmdq_abort_all_jobs(struct ivpu_device *vdev, u32 ctx_id, u32 cmdq_id);
    +@@ drivers/accel/ivpu/ivpu_job.h: void ivpu_cmdq_reset_all_contexts(struct ivpu_device *vdev);
      
      void ivpu_job_done_consumer_init(struct ivpu_device *vdev);
      void ivpu_job_done_consumer_fini(struct ivpu_device *vdev);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

