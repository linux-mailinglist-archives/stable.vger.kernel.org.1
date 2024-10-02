Return-Path: <stable+bounces-78887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FB798D56F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1141F211F4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F01F1D0437;
	Wed,  2 Oct 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kNfafmeJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA718DF60;
	Wed,  2 Oct 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875818; cv=none; b=ubr1vOq/OqtBq+XD+NpCJf/YRyzZKRRQA2NmXYUBI6KnKqNOa67Qf9wZh0HKFUeBohCjzy1KVMHxCdQt/gO48ocKEnCzDPNdCufYPphdjBFCpISN6OYYrWN1/CTNg4DmACG5HNtfvHlKn8U7NV+Qg15GQ4DlnyFCLD8xWN7tE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875818; c=relaxed/simple;
	bh=TOuSSwrRkKps5iMVYxbqb1xICn/lEZMvGXdrft/S+3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeXz5F1P9LbwNvLCoUissfPpiovk+4EuXFKoaT094+amqKc2FpbA4C1YZglEgBfj8hSSK+z/9No5gTqZ6GiPgq1evfDXVTBaAoHzMohsoS6L6TTq6f8K8PKb+SyAAack42bgJ6FYGhwZq/5euOHiaI6fs1n+UEKNLRgVTzzC05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kNfafmeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9062C4CECD;
	Wed,  2 Oct 2024 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875818;
	bh=TOuSSwrRkKps5iMVYxbqb1xICn/lEZMvGXdrft/S+3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNfafmeJFLysb/APYWK1U6XmIe2terCMr3CwVDwctTHqcN36rZiusUl5rD0KtfdaJ
	 bfCXBx92iXOwNkW80jTlLMtyusZ+N7xD3rXNs9VeUDVktQWGJ2oWo2CQthJHbWwNfY
	 QQIXrUfGNoP0joRYhC5gehmO8tX1X13o28u0zggY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 232/695] drm/msm/a5xx: fix races in preemption evaluation stage
Date: Wed,  2 Oct 2024 14:53:50 +0200
Message-ID: <20241002125831.712202469@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Lypak <vladimir.lypak@gmail.com>

[ Upstream commit ce050f307ad93bcc5958d0dd35fc276fd394d274 ]

On A5XX GPUs when preemption is used it's invietable to enter a soft
lock-up state in which GPU is stuck at empty ring-buffer doing nothing.
This appears as full UI lockup and not detected as GPU hang (because
it's not). This happens due to not triggering preemption when it was
needed. Sometimes this state can be recovered by some new submit but
generally it won't happen because applications are waiting for old
submits to retire.

One of the reasons why this happens is a race between a5xx_submit and
a5xx_preempt_trigger called from IRQ during submit retire. Former thread
updates ring->cur of previously empty and not current ring right after
latter checks it for emptiness. Then both threads can just exit because
for first one preempt_state wasn't NONE yet and for second one all rings
appeared to be empty.

To prevent such situations from happening we need to establish guarantee
for preempt_trigger to make decision after each submit or retire. To
implement this we serialize preemption initiation using spinlock. If
switch is already in progress we need to re-trigger preemption when it
finishes.

Fixes: b1fc2839d2f9 ("drm/msm: Implement preemption for A5XX targets")
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/612045/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 24 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index c7187bcc5e908..b4d06ca3e499d 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -36,6 +36,7 @@ struct a5xx_gpu {
 	uint64_t preempt_iova[MSM_GPU_MAX_RINGS];
 
 	atomic_t preempt_state;
+	spinlock_t preempt_start_lock;
 	struct timer_list preempt_timer;
 
 	struct drm_gem_object *shadow_bo;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index 67a8ef4adf6b6..c65b34a4a8cc2 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -97,12 +97,19 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 	if (gpu->nr_rings == 1)
 		return;
 
+	/*
+	 * Serialize preemption start to ensure that we always make
+	 * decision on latest state. Otherwise we can get stuck in
+	 * lower priority or empty ring.
+	 */
+	spin_lock_irqsave(&a5xx_gpu->preempt_start_lock, flags);
+
 	/*
 	 * Try to start preemption by moving from NONE to START. If
 	 * unsuccessful, a preemption is already in flight
 	 */
 	if (!try_preempt_state(a5xx_gpu, PREEMPT_NONE, PREEMPT_START))
-		return;
+		goto out;
 
 	/* Get the next ring to preempt to */
 	ring = get_next_ring(gpu);
@@ -127,9 +134,11 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 		set_preempt_state(a5xx_gpu, PREEMPT_ABORT);
 		update_wptr(gpu, a5xx_gpu->cur_ring);
 		set_preempt_state(a5xx_gpu, PREEMPT_NONE);
-		return;
+		goto out;
 	}
 
+	spin_unlock_irqrestore(&a5xx_gpu->preempt_start_lock, flags);
+
 	/* Make sure the wptr doesn't update while we're in motion */
 	spin_lock_irqsave(&ring->preempt_lock, flags);
 	a5xx_gpu->preempt[ring->id]->wptr = get_wptr(ring);
@@ -152,6 +161,10 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 
 	/* And actually start the preemption */
 	gpu_write(gpu, REG_A5XX_CP_CONTEXT_SWITCH_CNTL, 1);
+	return;
+
+out:
+	spin_unlock_irqrestore(&a5xx_gpu->preempt_start_lock, flags);
 }
 
 void a5xx_preempt_irq(struct msm_gpu *gpu)
@@ -188,6 +201,12 @@ void a5xx_preempt_irq(struct msm_gpu *gpu)
 	update_wptr(gpu, a5xx_gpu->cur_ring);
 
 	set_preempt_state(a5xx_gpu, PREEMPT_NONE);
+
+	/*
+	 * Try to trigger preemption again in case there was a submit or
+	 * retire during ring switch
+	 */
+	a5xx_preempt_trigger(gpu);
 }
 
 void a5xx_preempt_hw_init(struct msm_gpu *gpu)
@@ -300,5 +319,6 @@ void a5xx_preempt_init(struct msm_gpu *gpu)
 		}
 	}
 
+	spin_lock_init(&a5xx_gpu->preempt_start_lock);
 	timer_setup(&a5xx_gpu->preempt_timer, a5xx_preempt_timer, 0);
 }
-- 
2.43.0




