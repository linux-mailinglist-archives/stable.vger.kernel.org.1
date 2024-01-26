Return-Path: <stable+bounces-15993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A663383E642
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2211A1F24931
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A956473;
	Fri, 26 Jan 2024 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v4l6DvFA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A655E6E
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310584; cv=none; b=FpR+UcrivDPtvHDVDoyTLTbVmftoljPDbA+RkrUVBWEd7vNCFHEDyNdImvTmpPd8f/d+m/j80z0mZhH9+zJxm3LYL+wow8x9weoEt3kOPTpPXlxUHFenLr4FKQ0B7S+P9Y378Bo1Qs2ukDKoPmTrAYLo3zxHie1FfKuVJI+qN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310584; c=relaxed/simple;
	bh=S45/Sf5OzNH0bmI8hUZMHYZEVmN9m7wor1kkoxemKmQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qJLULUzrmbl02dX+TOaHdnDGIcSRTAIkpiffA18JqBtXAjrDxY0eNIWiLeRXSXBD9fHzLRde94wSSWEJWOSZOYJJW9z7qFlBWipf08ZfMOVe3f/9Lo61cBkHIV2o9sc0cnvY+L1OlPo5Kximcwk7j2hz0wekFcy7KP501pdb9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v4l6DvFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43137C433F1;
	Fri, 26 Jan 2024 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310584;
	bh=S45/Sf5OzNH0bmI8hUZMHYZEVmN9m7wor1kkoxemKmQ=;
	h=Subject:To:Cc:From:Date:From;
	b=v4l6DvFAXCn/V1vFN0HmIc/C6wsMLQx7OTrrkzJj/Q2vX4EtNwW3svTOP5i+ZYntu
	 P1eR/MHSX/NerE/bwL/5JFRxJUfQ6rmbrKCogvftM1YahKEqx/Bc9a1YKTTGgw3btU
	 BVQ512cENYhdx4cvz7Uy3FFtfSSWaKCSbUBucz3E=
Subject: FAILED: patch "[PATCH] dma-buf: add dma_fence_timestamp helper" failed to apply to 6.6-stable tree
To: christian.koenig@amd.com,Yunxiang.Li@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:09:43 -0800
Message-ID: <2024012643-undecided-bride-578b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0da611a8702101814257a7c03f6caf0574c83b98
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012643-undecided-bride-578b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0da611a87021 ("dma-buf: add dma_fence_timestamp helper")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0da611a8702101814257a7c03f6caf0574c83b98 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Fri, 8 Sep 2023 10:27:23 +0200
Subject: [PATCH] dma-buf: add dma_fence_timestamp helper
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a fence signals there is a very small race window where the timestamp
isn't updated yet. sync_file solves this by busy waiting for the
timestamp to appear, but on other ocassions didn't handled this
correctly.

Provide a dma_fence_timestamp() helper function for this and use it in
all appropriate cases.

Another alternative would be to grab the spinlock when that happens.

v2 by teddy: add a wait parameter to wait for the timestamp to show up, in case
   the accurate timestamp is needed and/or the timestamp is not based on
   ktime (e.g. hw timestamp)
v3 chk: drop the parameter again for unified handling

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 1774baa64f93 ("drm/scheduler: Change scheduled fence track v2")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20230929104725.2358-1-christian.koenig@amd.com

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index c625bb2b5d56..628af51c81af 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -76,16 +76,11 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i]) {
 			if (!dma_fence_is_signaled(tmp)) {
 				++count;
-			} else if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
-					    &tmp->flags)) {
-				if (ktime_after(tmp->timestamp, timestamp))
-					timestamp = tmp->timestamp;
 			} else {
-				/*
-				 * Use the current time if the fence is
-				 * currently signaling.
-				 */
-				timestamp = ktime_get();
+				ktime_t t = dma_fence_timestamp(tmp);
+
+				if (ktime_after(t, timestamp))
+					timestamp = t;
 			}
 		}
 	}
diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index af57799c86ce..2e9a316c596a 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -268,13 +268,10 @@ static int sync_fill_fence_info(struct dma_fence *fence,
 		sizeof(info->driver_name));
 
 	info->status = dma_fence_get_status(fence);
-	while (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) &&
-	       !test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
-		cpu_relax();
 	info->timestamp_ns =
-		test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags) ?
-		ktime_to_ns(fence->timestamp) :
-		ktime_set(0, 0);
+		dma_fence_is_signaled(fence) ?
+			ktime_to_ns(dma_fence_timestamp(fence)) :
+			ktime_set(0, 0);
 
 	return info->status;
 }
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index fd755e953487..99797a8c836a 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -935,7 +935,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 
 		if (next) {
 			next->s_fence->scheduled.timestamp =
-				job->s_fence->finished.timestamp;
+				dma_fence_timestamp(&job->s_fence->finished);
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
 		}
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 0d678e9a7b24..ebe78bd3d121 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -568,6 +568,25 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
 	fence->error = error;
 }
 
+/**
+ * dma_fence_timestamp - helper to get the completion timestamp of a fence
+ * @fence: fence to get the timestamp from.
+ *
+ * After a fence is signaled the timestamp is updated with the signaling time,
+ * but setting the timestamp can race with tasks waiting for the signaling. This
+ * helper busy waits for the correct timestamp to appear.
+ */
+static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
+{
+	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
+		return ktime_get();
+
+	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
+		cpu_relax();
+
+	return fence->timestamp;
+}
+
 signed long dma_fence_wait_timeout(struct dma_fence *,
 				   bool intr, signed long timeout);
 signed long dma_fence_wait_any_timeout(struct dma_fence **fences,


