Return-Path: <stable+bounces-91178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17C9BECD1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618D0285EB5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F21F669C;
	Wed,  6 Nov 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W9jPHFqT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB31E04BA;
	Wed,  6 Nov 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897971; cv=none; b=iyx+uBV/gKXYAX3EK/Dc9ujyFn2RLgNGImzwswRYqtHnhUaJQwjU1InZodGm7DwklYypqm6QIlwVVNq/EUgtQzLvV3pCCkGhox4cYKqhKNO5h2Av8bAMcUYWkURNABAnjif4bjpNuRpPzfBqd8f7zLr00eYVDDiU7sd6G8HOGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897971; c=relaxed/simple;
	bh=2KGtN4/HfJXRcqcxE/soZQkuYKgdjkyv5Mte6bxQoyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l519lIj0/1QACLnqFddYIR0jxOwb2VJaGWvvzGk2EM5x4PqeO0eQKlvaGe4GTJIHTF7fCOWvlTJXztOnF7d7UJLwi4Wi7CpNCDkOwuMj2DLPN5PTYIoIpbusSwqGecnvSa/34jRvQKJ+LEpg+QMC5k3blBTZWLoHk6PTdx8m3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W9jPHFqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37936C4CECD;
	Wed,  6 Nov 2024 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897970;
	bh=2KGtN4/HfJXRcqcxE/soZQkuYKgdjkyv5Mte6bxQoyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9jPHFqTPKkqsjEkBKkzpTazcDDCKy7gBsa0kxcDgm4HfKfeidoQ6M8v5N57PJ0pp
	 QkkcdCMAa1yFqtA+X4v6QOYaDJLn/UfuJ5Lntd237i5TuXj8E7rgg7MoMBq4IEfYBr
	 mru3H2F5WnUjdBPt6Z5hW3379+RTJTcdn1u88cRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 081/462] drm/msm/a5xx: fix races in preemption evaluation stage
Date: Wed,  6 Nov 2024 12:59:34 +0100
Message-ID: <20241106120333.507949363@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 833468ce6b6d7..cf29cc6238c7e 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -35,6 +35,7 @@ struct a5xx_gpu {
 	uint64_t preempt_iova[MSM_GPU_MAX_RINGS];
 
 	atomic_t preempt_state;
+	spinlock_t preempt_start_lock;
 	struct timer_list preempt_timer;
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index 0a892f4f59d1d..e55a6a068c39a 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -98,12 +98,19 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
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
@@ -128,9 +135,11 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 		set_preempt_state(a5xx_gpu, PREEMPT_ABORT);
 		update_wptr(gpu, a5xx_gpu->cur_ring);
 		set_preempt_state(a5xx_gpu, PREEMPT_NONE);
-		return;
+		goto out;
 	}
 
+	spin_unlock_irqrestore(&a5xx_gpu->preempt_start_lock, flags);
+
 	/* Make sure the wptr doesn't update while we're in motion */
 	spin_lock_irqsave(&ring->lock, flags);
 	a5xx_gpu->preempt[ring->id]->wptr = get_wptr(ring);
@@ -154,6 +163,10 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 
 	/* And actually start the preemption */
 	gpu_write(gpu, REG_A5XX_CP_CONTEXT_SWITCH_CNTL, 1);
+	return;
+
+out:
+	spin_unlock_irqrestore(&a5xx_gpu->preempt_start_lock, flags);
 }
 
 void a5xx_preempt_irq(struct msm_gpu *gpu)
@@ -191,6 +204,12 @@ void a5xx_preempt_irq(struct msm_gpu *gpu)
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
@@ -289,5 +308,6 @@ void a5xx_preempt_init(struct msm_gpu *gpu)
 		}
 	}
 
+	spin_lock_init(&a5xx_gpu->preempt_start_lock);
 	timer_setup(&a5xx_gpu->preempt_timer, a5xx_preempt_timer, 0);
 }
-- 
2.43.0




