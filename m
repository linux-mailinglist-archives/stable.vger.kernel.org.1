Return-Path: <stable+bounces-139374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701BAAA6389
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A591BA8564
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85DC224AE1;
	Thu,  1 May 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiriW1ml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE9215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126619; cv=none; b=fYofiFRaXqNUR6Uo+dpTud1YFIHyT3a1iRLmPKkpJoyrfcUAvhEAAKsTYPyA0Urc9kuzoiKfL/zsY7BaSa2NR/+g8YqNCfo7elZHt+95buYwc4R9yZE16bWd1V1yqywc531GiphD21eVic5idUIswNH7RMO9GCyu94f32tqnytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126619; c=relaxed/simple;
	bh=8N3TetesAwBDCbibPxbF/CEDe8DyHIC6ezIAtjz1R+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+Hu96qUmr6ZqH23/5ibk+9R1laQaToB4IQn1hlqk6ZZPylFx8hRK8I6LH7uURy6Ek5151lwB5jixzito3MsfafVg+6DKhGPbuMC8nr9VLRwS2JYZYRJwZoi+hZ7mg79IUT7rSfonezJZvDcw5Af9Zffzh4aOA8SGSKt48EVDY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiriW1ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE5EC4CEE3;
	Thu,  1 May 2025 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126619;
	bh=8N3TetesAwBDCbibPxbF/CEDe8DyHIC6ezIAtjz1R+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiriW1ml9vHc3aYFHvxNzYElo//AuByFoBWWTvBER/Z/zb/WmBAto4mQdjypVdyA0
	 wdoSWcib8QT9yOR1UGRlmDwsYzNqV7S95P97NQk9Dc380qLcXkOtIGGDrc4OlJOp3f
	 1mqaGOb6qeftsuu5YfV1OASyUmFKX+ZKRvKtKP9Wq514HM55TEkEMWBP4DtBpVKUKE
	 uJiTVsgmLVavqT/vAY+r3on6PuZDN87pXMZYMgiQn0pADIo30+STvRdLCB9xVBhZkL
	 yiiUjTdP8A37qogDLeWNc1OdfQO87fHCtJ4PhwYB5phX6B/7swQhUgTJM6c9SFsqi7
	 EUpJtXSB5KJ6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/3] accel/ivpu: Fix locking order in ivpu_job_submit
Date: Thu,  1 May 2025 15:10:15 -0400
Message-Id: <20250501082633-4d497a4301fd2d17@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430123653.3748811-3-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: ab680dc6c78aa035e944ecc8c48a1caab9f39924

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  ab680dc6c78aa ! 1:  b7d18d7cd5b08 accel/ivpu: Fix locking order in ivpu_job_submit
    @@ Metadata
      ## Commit message ##
         accel/ivpu: Fix locking order in ivpu_job_submit
     
    +    commit ab680dc6c78aa035e944ecc8c48a1caab9f39924 upstream.
    +
         Fix deadlock in job submission and abort handling.
         When a thread aborts currently executing jobs due to a fault,
         it first locks the global lock protecting submitted_jobs (#1).
    @@ Commit message
         This order of locking causes a deadlock. To resolve this issue,
         change the order of locking in ivpu_job_submit().
     
    +    Cc: <stable@vger.kernel.org> # v6.14
         Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
         Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
         Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
    @@ Commit message
         Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-12-maciej.falkowski@linux.intel.com
     
      ## drivers/accel/ivpu/ivpu_job.c ##
    -@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
    +@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
      	if (ret < 0)
      		return ret;
      
     +	mutex_lock(&vdev->submitted_jobs_lock);
      	mutex_lock(&file_priv->lock);
      
    - 	if (cmdq_id == 0)
    -@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
    - 	if (!cmdq) {
    - 		ivpu_warn_ratelimited(vdev, "Failed to get job queue, ctx %d\n", file_priv->ctx.id);
    + 	cmdq = ivpu_cmdq_acquire(file_priv, priority);
    +@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
    + 		ivpu_warn_ratelimited(vdev, "Failed to get job queue, ctx %d engine %d prio %d\n",
    + 				      file_priv->ctx.id, job->engine_idx, priority);
      		ret = -EINVAL;
     -		goto err_unlock_file_priv;
     +		goto err_unlock;
      	}
      
    - 	ret = ivpu_cmdq_register(file_priv, cmdq);
    - 	if (ret) {
    - 		ivpu_err(vdev, "Failed to register command queue: %d\n", ret);
    --		goto err_unlock_file_priv;
    -+		goto err_unlock;
    - 	}
    - 
    - 	job->cmdq_id = cmdq->id;
    - 
     -	mutex_lock(&vdev->submitted_jobs_lock);
     -
      	is_first_job = xa_empty(&vdev->submitted_jobs_xa);
      	ret = xa_alloc_cyclic(&vdev->submitted_jobs_xa, &job->job_id, job, file_priv->job_limit,
      			      &file_priv->job_id_next, GFP_KERNEL);
    -@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
    +@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
      		ivpu_dbg(vdev, JOB, "Too many active jobs in ctx %d\n",
      			 file_priv->ctx.id);
      		ret = -EBUSY;
    @@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job,
      	}
      
      	ret = ivpu_cmdq_push_job(cmdq, job);
    -@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
    - 		 job->job_id, file_priv->ctx.id, job->engine_idx, cmdq->priority,
    +@@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
    + 		 job->job_id, file_priv->ctx.id, job->engine_idx, priority,
      		 job->cmd_buf_vpu_addr, cmdq->jobq->header.tail);
      
     -	mutex_unlock(&vdev->submitted_jobs_lock);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

