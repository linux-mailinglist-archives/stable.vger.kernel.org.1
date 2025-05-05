Return-Path: <stable+bounces-140185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D89AAA603
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090627B3550
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0206291899;
	Mon,  5 May 2025 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enyEOaBG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BF1D86DC;
	Mon,  5 May 2025 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484292; cv=none; b=inp6vqzCL1XdK24hjKenUbZlPUgXH4qZq4YqCm7Kj7SuhUZOouD+nPBdvZf7Q+SKT7lM1aC7hG07zPfys3GGMtUvZK6i2jkszakOg5+DM2dFKWaS/WlUC+DhbQFwhhfKOoIsi8MAv3kfE/Z3i5KgnYax+lGEmRQqd48NbHt9IOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484292; c=relaxed/simple;
	bh=Qk1eyKnX5OztIuXD3gcVb1g5PJcA+op3VmGa+6UqilU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cf01wBfs0hO7QbAN46O0wYLUPZRWqhVMclu1XdphVLcW1jBn8l8jceZHV7PZxtpCkahqDIM4IY5J6GoD2qNTppPfhN14XTWsBbvVfTcKlurawn+q/WMqNdzDQuQujjqZI4P3NG+wekfYndvCjKmX04eDN2NfFUBBmv3wB5B1R9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enyEOaBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E77EC4CEEE;
	Mon,  5 May 2025 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484292;
	bh=Qk1eyKnX5OztIuXD3gcVb1g5PJcA+op3VmGa+6UqilU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enyEOaBGzJZFWxnO/t/H8oKwnYMtc6Q+/RFT5LZHc3H5hjx4xtPfgkwIHf8vxrJdM
	 2xpywsbw7lVfPCJIARqZjvqvAae5xXDJ+1sH6e6na8cE7UbsaVvzxu/WK+1dvMEVWW
	 Y3t5rP476yI9H5IuJwwVON927JWgcqNNQfu5D0gKMU30oNrRTpIEQpR5sXqKVVquET
	 +ZpJlBzBEpWBeyPoYq3HDHSDVNJkhrXH4flwF900YGzeCn4Sw3jDWI0gkPq1rYjma+
	 puJRJeq6yfdQPtTq1LNj3+00TH7ekWg+sFBC9YSRrmR8nd3s2y43lEaad2gIiqHtqm
	 ObVUp6kjJyJ2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	min.ma@amd.com,
	ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 439/642] accel/amdxdna: Refactor hardware context destroy routine
Date: Mon,  5 May 2025 18:10:55 -0400
Message-Id: <20250505221419.2672473-439-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 4fd6ca90fc7f509977585d39885f21b2911123f3 ]

It is required by firmware to wait up to 2 seconds for pending commands
before sending the destroy hardware context command. After 2 seconds
wait, if there are still pending commands, driver needs to cancel them.

So the context destroy steps need to be:
  1. Stop drm scheduler. (drm_sched_entity_destroy)
  2. Wait up to 2 seconds for pending commands.
  3. Destroy hardware context and cancel the rest pending requests.
  4. Wait all jobs associated with the hwctx are freed.
  5. Free job resources.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250124173536.148676-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/aie2_ctx.c    | 29 ++++++++++++++++-------------
 drivers/accel/amdxdna/amdxdna_ctx.c |  2 ++
 drivers/accel/amdxdna/amdxdna_ctx.h |  3 +++
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 5f43db02b2404..92c768b0c9a03 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -34,6 +34,8 @@ static void aie2_job_release(struct kref *ref)
 
 	job = container_of(ref, struct amdxdna_sched_job, refcnt);
 	amdxdna_sched_job_cleanup(job);
+	atomic64_inc(&job->hwctx->job_free_cnt);
+	wake_up(&job->hwctx->priv->job_free_wq);
 	if (job->out_fence)
 		dma_fence_put(job->out_fence);
 	kfree(job);
@@ -134,7 +136,8 @@ static void aie2_hwctx_wait_for_idle(struct amdxdna_hwctx *hwctx)
 	if (!fence)
 		return;
 
-	dma_fence_wait(fence, false);
+	/* Wait up to 2 seconds for fw to finish all pending requests */
+	dma_fence_wait_timeout(fence, false, msecs_to_jiffies(2000));
 	dma_fence_put(fence);
 }
 
@@ -616,6 +619,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 	hwctx->status = HWCTX_STAT_INIT;
 	ndev = xdna->dev_handle;
 	ndev->hwctx_num++;
+	init_waitqueue_head(&priv->job_free_wq);
 
 	XDNA_DBG(xdna, "hwctx %s init completed", hwctx->name);
 
@@ -652,25 +656,23 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
 	xdna = hwctx->client->xdna;
 	ndev = xdna->dev_handle;
 	ndev->hwctx_num--;
-	drm_sched_wqueue_stop(&hwctx->priv->sched);
 
-	/* Now, scheduler will not send command to device. */
+	XDNA_DBG(xdna, "%s sequence number %lld", hwctx->name, hwctx->priv->seq);
+	drm_sched_entity_destroy(&hwctx->priv->entity);
+
+	aie2_hwctx_wait_for_idle(hwctx);
+
+	/* Request fw to destroy hwctx and cancel the rest pending requests */
 	aie2_release_resource(hwctx);
 
-	/*
-	 * All submitted commands are aborted.
-	 * Restart scheduler queues to cleanup jobs. The amdxdna_sched_job_run()
-	 * will return NODEV if it is called.
-	 */
-	drm_sched_wqueue_start(&hwctx->priv->sched);
+	/* Wait for all submitted jobs to be completed or canceled */
+	wait_event(hwctx->priv->job_free_wq,
+		   atomic64_read(&hwctx->job_submit_cnt) ==
+		   atomic64_read(&hwctx->job_free_cnt));
 
-	aie2_hwctx_wait_for_idle(hwctx);
-	drm_sched_entity_destroy(&hwctx->priv->entity);
 	drm_sched_fini(&hwctx->priv->sched);
 	aie2_ctx_syncobj_destroy(hwctx);
 
-	XDNA_DBG(xdna, "%s sequence number %lld", hwctx->name, hwctx->priv->seq);
-
 	for (idx = 0; idx < ARRAY_SIZE(hwctx->priv->cmd_buf); idx++)
 		drm_gem_object_put(to_gobj(hwctx->priv->cmd_buf[idx]));
 	amdxdna_gem_unpin(hwctx->priv->heap);
@@ -879,6 +881,7 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	drm_gem_unlock_reservations(job->bos, job->bo_cnt, &acquire_ctx);
 
 	aie2_job_put(job);
+	atomic64_inc(&hwctx->job_submit_cnt);
 
 	return 0;
 
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index d11b1c83d9c3b..43442b9e273b3 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -220,6 +220,8 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 	args->syncobj_handle = hwctx->syncobj_hdl;
 	mutex_unlock(&xdna->dev_lock);
 
+	atomic64_set(&hwctx->job_submit_cnt, 0);
+	atomic64_set(&hwctx->job_free_cnt, 0);
 	XDNA_DBG(xdna, "PID %d create HW context %d, ret %d", client->pid, args->handle, ret);
 	drm_dev_exit(idx);
 	return 0;
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index 80b0304193ec3..f0a4a8586d858 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -87,6 +87,9 @@ struct amdxdna_hwctx {
 	struct amdxdna_qos_info		     qos;
 	struct amdxdna_hwctx_param_config_cu *cus;
 	u32				syncobj_hdl;
+
+	atomic64_t			job_submit_cnt;
+	atomic64_t			job_free_cnt ____cacheline_aligned_in_smp;
 };
 
 #define drm_job_to_xdna_job(j) \
-- 
2.39.5


