Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7707570389E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbjEORdk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbjEORdY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4546914368
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF1E62D3E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF31CC433EF;
        Mon, 15 May 2023 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171872;
        bh=8cjKOFMEbaDWbMfgMDlWxFLC7xlLYuO2i/1BOXp476Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Viq+ljBPPR9eCVIOpsNKNjsXKLzssAq5pS8p8uoxZMFeHbRwANclKR+IHO6Q7zD5u
         nL9tHFret0wVQpHrlkOK1wPoffiUt6cZ72tAMYvEv7rNtKIPn4ES3bksN3yX3GqLgT
         CqJrWHJm52UiqKHRfmjF37sXqYtPKKYWSrNhFwiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 105/134] drm/msm: Remove struct_mutex usage
Date:   Mon, 15 May 2023 18:29:42 +0200
Message-Id: <20230515161706.620494441@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit c28e2f2b417ed747bfbc5f900c87f3ec9cc6b25e ]

The remaining struct_mutex usage is just to serialize various gpu
related things (submit/retire/recover/fault/etc), so replace
struct_mutex with gpu->lock.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Link: https://lore.kernel.org/r/20211109181117.591148-4-robdclark@gmail.com
Signed-off-by: Rob Clark <robdclark@chromium.org>
Stable-dep-of: 0d997f95b70f ("drm/msm/adreno: fix runtime PM imbalance at gpu load")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c  |  4 ++--
 drivers/gpu/drm/msm/adreno/adreno_device.c |  4 ++--
 drivers/gpu/drm/msm/msm_debugfs.c          | 12 ++++++------
 drivers/gpu/drm/msm/msm_gpu.c              | 14 +++++++-------
 drivers/gpu/drm/msm/msm_gpu.h              | 20 +++++++++++++++-----
 drivers/gpu/drm/msm/msm_perf.c             |  9 ++++++---
 drivers/gpu/drm/msm/msm_rd.c               | 16 +++++++++-------
 drivers/gpu/drm/msm/msm_ringbuffer.c       |  4 ++--
 8 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
index c9d11d57aed66..1aa39aa73e745 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
@@ -107,7 +107,7 @@ reset_set(void *data, u64 val)
 	 * try to reset an active GPU.
 	 */
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	release_firmware(adreno_gpu->fw[ADRENO_FW_PM4]);
 	adreno_gpu->fw[ADRENO_FW_PM4] = NULL;
@@ -133,7 +133,7 @@ reset_set(void *data, u64 val)
 	gpu->funcs->recover(gpu);
 
 	pm_runtime_put_sync(&gpu->pdev->dev);
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 3eb9146653444..afdfa9edbea3d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -411,9 +411,9 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 		return NULL;
 	}
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 	ret = msm_gpu_hw_init(gpu);
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 	pm_runtime_put_autosuspend(&pdev->dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", ret);
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index dee13fedee3b5..f970a14b66336 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -29,14 +29,14 @@ static int msm_gpu_show(struct seq_file *m, void *arg)
 	struct msm_gpu *gpu = priv->gpu;
 	int ret;
 
-	ret = mutex_lock_interruptible(&show_priv->dev->struct_mutex);
+	ret = mutex_lock_interruptible(&gpu->lock);
 	if (ret)
 		return ret;
 
 	drm_printf(&p, "%s Status:\n", gpu->name);
 	gpu->funcs->show(gpu, show_priv->state, &p);
 
-	mutex_unlock(&show_priv->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	return 0;
 }
@@ -48,9 +48,9 @@ static int msm_gpu_release(struct inode *inode, struct file *file)
 	struct msm_drm_private *priv = show_priv->dev->dev_private;
 	struct msm_gpu *gpu = priv->gpu;
 
-	mutex_lock(&show_priv->dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 	gpu->funcs->gpu_state_put(show_priv->state);
-	mutex_unlock(&show_priv->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	kfree(show_priv);
 
@@ -72,7 +72,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 	if (!show_priv)
 		return -ENOMEM;
 
-	ret = mutex_lock_interruptible(&dev->struct_mutex);
+	ret = mutex_lock_interruptible(&gpu->lock);
 	if (ret)
 		goto free_priv;
 
@@ -81,7 +81,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 	show_priv->state = gpu->funcs->gpu_state_get(gpu);
 	pm_runtime_put_sync(&gpu->pdev->dev);
 
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	if (IS_ERR(show_priv->state)) {
 		ret = PTR_ERR(show_priv->state);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index b01d0a521c908..a2f21b89d077c 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -150,7 +150,7 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
 {
 	int ret;
 
-	WARN_ON(!mutex_is_locked(&gpu->dev->struct_mutex));
+	WARN_ON(!mutex_is_locked(&gpu->lock));
 
 	if (!gpu->needs_hw_init)
 		return 0;
@@ -361,7 +361,7 @@ static void recover_worker(struct kthread_work *work)
 	char *comm = NULL, *cmd = NULL;
 	int i;
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	DRM_DEV_ERROR(dev->dev, "%s: hangcheck recover!\n", gpu->name);
 
@@ -442,7 +442,7 @@ static void recover_worker(struct kthread_work *work)
 		}
 	}
 
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	msm_gpu_retire(gpu);
 }
@@ -450,12 +450,11 @@ static void recover_worker(struct kthread_work *work)
 static void fault_worker(struct kthread_work *work)
 {
 	struct msm_gpu *gpu = container_of(work, struct msm_gpu, fault_work);
-	struct drm_device *dev = gpu->dev;
 	struct msm_gem_submit *submit;
 	struct msm_ringbuffer *cur_ring = gpu->funcs->active_ring(gpu);
 	char *comm = NULL, *cmd = NULL;
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	submit = find_submit(cur_ring, cur_ring->memptrs->fence + 1);
 	if (submit && submit->fault_dumped)
@@ -490,7 +489,7 @@ static void fault_worker(struct kthread_work *work)
 	memset(&gpu->fault_info, 0, sizeof(gpu->fault_info));
 	gpu->aspace->mmu->funcs->resume_translation(gpu->aspace->mmu);
 
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 }
 
 static void hangcheck_timer_reset(struct msm_gpu *gpu)
@@ -734,7 +733,7 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned long flags;
 
-	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
+	WARN_ON(!mutex_is_locked(&gpu->lock));
 
 	pm_runtime_get_sync(&gpu->pdev->dev);
 
@@ -849,6 +848,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	INIT_LIST_HEAD(&gpu->active_list);
 	mutex_init(&gpu->active_lock);
+	mutex_init(&gpu->lock);
 	kthread_init_work(&gpu->retire_work, retire_worker);
 	kthread_init_work(&gpu->recover_work, recover_worker);
 	kthread_init_work(&gpu->fault_work, fault_worker);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 2e2424066e701..461ff5a5aa5bb 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -143,13 +143,23 @@ struct msm_gpu {
 	 */
 	struct list_head active_list;
 
+	/**
+	 * lock:
+	 *
+	 * General lock for serializing all the gpu things.
+	 *
+	 * TODO move to per-ring locking where feasible (ie. submit/retire
+	 * path, etc)
+	 */
+	struct mutex lock;
+
 	/**
 	 * active_submits:
 	 *
 	 * The number of submitted but not yet retired submits, used to
 	 * determine transitions between active and idle.
 	 *
-	 * Protected by lock
+	 * Protected by active_lock
 	 */
 	int active_submits;
 
@@ -530,28 +540,28 @@ static inline struct msm_gpu_state *msm_gpu_crashstate_get(struct msm_gpu *gpu)
 {
 	struct msm_gpu_state *state = NULL;
 
-	mutex_lock(&gpu->dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	if (gpu->crashstate) {
 		kref_get(&gpu->crashstate->ref);
 		state = gpu->crashstate;
 	}
 
-	mutex_unlock(&gpu->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	return state;
 }
 
 static inline void msm_gpu_crashstate_put(struct msm_gpu *gpu)
 {
-	mutex_lock(&gpu->dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	if (gpu->crashstate) {
 		if (gpu->funcs->gpu_state_put(gpu->crashstate))
 			gpu->crashstate = NULL;
 	}
 
-	mutex_unlock(&gpu->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_perf.c b/drivers/gpu/drm/msm/msm_perf.c
index 3a27153eef084..3d3da79fec2aa 100644
--- a/drivers/gpu/drm/msm/msm_perf.c
+++ b/drivers/gpu/drm/msm/msm_perf.c
@@ -155,9 +155,12 @@ static int perf_open(struct inode *inode, struct file *file)
 	struct msm_gpu *gpu = priv->gpu;
 	int ret = 0;
 
-	mutex_lock(&dev->struct_mutex);
+	if (!gpu)
+		return -ENODEV;
 
-	if (perf->open || !gpu) {
+	mutex_lock(&gpu->lock);
+
+	if (perf->open) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -171,7 +174,7 @@ static int perf_open(struct inode *inode, struct file *file)
 	perf->next_jiffies = jiffies + SAMPLE_TIME;
 
 out:
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index e3f0dd4a36792..15a44491a42c3 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -86,7 +86,7 @@ struct msm_rd_state {
 	struct msm_gem_submit *submit;
 
 	/* fifo access is synchronized on the producer side by
-	 * struct_mutex held by submit code (otherwise we could
+	 * gpu->lock held by submit code (otherwise we could
 	 * end up w/ cmds logged in different order than they
 	 * were executed).  And read_lock synchronizes the reads
 	 */
@@ -181,9 +181,12 @@ static int rd_open(struct inode *inode, struct file *file)
 	uint32_t gpu_id;
 	int ret = 0;
 
-	mutex_lock(&dev->struct_mutex);
+	if (!gpu)
+		return -ENODEV;
 
-	if (rd->open || !gpu) {
+	mutex_lock(&gpu->lock);
+
+	if (rd->open) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -203,7 +206,7 @@ static int rd_open(struct inode *inode, struct file *file)
 	rd_write_section(rd, RD_GPU_ID, &gpu_id, sizeof(gpu_id));
 
 out:
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 	return ret;
 }
 
@@ -343,11 +346,10 @@ static void snapshot_buf(struct msm_rd_state *rd,
 	msm_gem_unlock(&obj->base);
 }
 
-/* called under struct_mutex */
+/* called under gpu->lock */
 void msm_rd_dump_submit(struct msm_rd_state *rd, struct msm_gem_submit *submit,
 		const char *fmt, ...)
 {
-	struct drm_device *dev = submit->dev;
 	struct task_struct *task;
 	char msg[256];
 	int i, n;
@@ -358,7 +360,7 @@ void msm_rd_dump_submit(struct msm_rd_state *rd, struct msm_gem_submit *submit,
 	/* writing into fifo is serialized by caller, and
 	 * rd->read_lock is used to serialize the reads
 	 */
-	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
+	WARN_ON(!mutex_is_locked(&submit->gpu->lock));
 
 	if (fmt) {
 		va_list args;
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index bd54c14126497..a2314b75962fd 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -32,11 +32,11 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 	pm_runtime_get_sync(&gpu->pdev->dev);
 
 	/* TODO move submit path over to using a per-ring lock.. */
-	mutex_lock(&gpu->dev->struct_mutex);
+	mutex_lock(&gpu->lock);
 
 	msm_gpu_submit(gpu, submit);
 
-	mutex_unlock(&gpu->dev->struct_mutex);
+	mutex_unlock(&gpu->lock);
 
 	pm_runtime_put(&gpu->pdev->dev);
 
-- 
2.39.2



