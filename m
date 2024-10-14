Return-Path: <stable+bounces-84399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B034799CFFE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13241C2346B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131A1ADFE9;
	Mon, 14 Oct 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DAwFvqNL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33631ABEA6;
	Mon, 14 Oct 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917875; cv=none; b=H/TwkCrWjxI4szXJAw9sYV2lfdAfquFqqGeX2VDyqD9KkwMMDnKSXjPTZqhDMnmiNbQF4kjosgTrdCkqXmsuSr7UOCIXBB+OwQOP6iDQJfg6YtmLNSqBMUu7o+yVW8zAGkuV9PjO0dqBOOr1o93pnYZIC2QRhynFug0JktLxtUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917875; c=relaxed/simple;
	bh=D7OLTjuPCopmpyVqWyAbQ68A1ZXrQvsJ3/fRnefqn/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/a4gXI3AR9mBhnWfb0SEr0EkM8gvHs2LMB40WFQX64mGVzHK03GKB3dzyO5jvKDFuoHQkt3DSDSPk3YSCJSNPe7zEzi5JOxg4PXykjWkteWWmS+O3Y9xUZRH9+ASkOgP1O8phrqbEBiPf0zME46ecKY3Y+z/zUGzalWEuWAh9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DAwFvqNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332AFC4CEC3;
	Mon, 14 Oct 2024 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917875;
	bh=D7OLTjuPCopmpyVqWyAbQ68A1ZXrQvsJ3/fRnefqn/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAwFvqNLYwFs7YYsy/qMHdVF6vPfh2IfcpIiS+AR1B6/5AfpeOl/AKWhcjw7oG5gY
	 24vQbUZKkLctbua/5inqpLHDTlE6y5d3ww+tfGVH7dGBxWT0pjrJhkiKIG0EGSKlMK
	 68lq5xyUz4gU3yzPrDUNGnpNVw/auVo1T0oSBC20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 128/798] drm/msm/a5xx: workaround early ring-buffer emptiness check
Date: Mon, 14 Oct 2024 16:11:22 +0200
Message-ID: <20241014141222.951013890@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Lypak <vladimir.lypak@gmail.com>

[ Upstream commit a30f9f65b5ac82d4390548c32ed9c7f05de7ddf5 ]

There is another cause for soft lock-up of GPU in empty ring-buffer:
race between GPU executing last commands and CPU checking ring for
emptiness. On GPU side IRQ for retire is triggered by CACHE_FLUSH_TS
event and RPTR shadow (which is used to check ring emptiness) is updated
a bit later from CP_CONTEXT_SWITCH_YIELD. Thus if GPU is executing its
last commands slow enough or we check that ring too fast we will miss a
chance to trigger switch to lower priority ring because current ring isn't
empty just yet. This can escalate to lock-up situation described in
previous patch.
To work-around this issue we keep track of last submit sequence number
for each ring and compare it with one written to memptrs from GPU during
execution of CACHE_FLUSH_TS event.

Fixes: b1fc2839d2f9 ("drm/msm: Implement preemption for A5XX targets")
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/612047/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     | 4 ++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     | 1 +
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 6e3f7d39d7e38..5a10628934bc6 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -65,6 +65,8 @@ void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 
 static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = submit->ring;
 	struct msm_gem_object *obj;
 	uint32_t *ptr, dwords;
@@ -109,6 +111,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 		}
 	}
 
+	a5xx_gpu->last_seqno[ring->id] = submit->seqno;
 	a5xx_flush(gpu, ring, true);
 	a5xx_preempt_trigger(gpu);
 
@@ -210,6 +213,7 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	/* Write the fence to the scratch register */
 	OUT_PKT4(ring, REG_A5XX_CP_SCRATCH_REG(2), 1);
 	OUT_RING(ring, submit->seqno);
+	a5xx_gpu->last_seqno[ring->id] = submit->seqno;
 
 	/*
 	 * Execute a CACHE_FLUSH_TS event. This will ensure that the
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index b4d06ca3e499d..9c0d701fe4b85 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -34,6 +34,7 @@ struct a5xx_gpu {
 	struct drm_gem_object *preempt_counters_bo[MSM_GPU_MAX_RINGS];
 	struct a5xx_preempt_record *preempt[MSM_GPU_MAX_RINGS];
 	uint64_t preempt_iova[MSM_GPU_MAX_RINGS];
+	uint32_t last_seqno[MSM_GPU_MAX_RINGS];
 
 	atomic_t preempt_state;
 	spinlock_t preempt_start_lock;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index c65b34a4a8cc2..0469fea550108 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -55,6 +55,8 @@ static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 /* Return the highest priority ringbuffer with something in it */
 static struct msm_ringbuffer *get_next_ring(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
 	unsigned long flags;
 	int i;
 
@@ -64,6 +66,8 @@ static struct msm_ringbuffer *get_next_ring(struct msm_gpu *gpu)
 
 		spin_lock_irqsave(&ring->preempt_lock, flags);
 		empty = (get_wptr(ring) == gpu->funcs->get_rptr(gpu, ring));
+		if (!empty && ring == a5xx_gpu->cur_ring)
+			empty = ring->memptrs->fence == a5xx_gpu->last_seqno[i];
 		spin_unlock_irqrestore(&ring->preempt_lock, flags);
 
 		if (!empty)
-- 
2.43.0




