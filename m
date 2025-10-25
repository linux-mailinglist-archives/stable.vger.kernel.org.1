Return-Path: <stable+bounces-189456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A7C09716
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 18:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021801C605B9
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7587A30B52A;
	Sat, 25 Oct 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umJTa37a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6D307494;
	Sat, 25 Oct 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409034; cv=none; b=e3lhuCpAI1d891HcA3YY/Su5V42GllyCL0wAWunIGK1IJdX3kdp3G8/f2HXDaS0MN2zb6s3jmmBsEou/1zRe8FseSEtVGZagtfEMPoirhHqjxF47CsV7XQ1kvg4/Wz93m+qiwnkdt0mvjB7PpRSvqV9XWanXgonWUhtA3PR4eRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409034; c=relaxed/simple;
	bh=TFH3h/wjgSi7eeODKqH12cQ96m/R0SGF5dcNKHzNo38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4KobgMHrG28l4Dhq5uY5YX4enTT1CX3HdEuB7zz/PUc37nKwgryWc6baqd75f3+w5i8MGKJiUKejgi5IjLj7Vb7dlUwNh5cGXhatWtdTRf3r3KeVsyrVnNeDO518pidpRltmqUx0zF+haI4Jj92knKViy7W4V4RjK9ZSw/UdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umJTa37a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A384FC113D0;
	Sat, 25 Oct 2025 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409032;
	bh=TFH3h/wjgSi7eeODKqH12cQ96m/R0SGF5dcNKHzNo38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umJTa37aDTlbuXV9flIm3i+gOkN8MLtDiDsQ7vqAv67vy/yto15WBiBGkyX6JiV3R
	 0SWbtz3xjg+cXM3xTd/vuDdMkGMEYtMm+9H0+1wabKzLy1el4In5DxcMWXNuJUH0o3
	 J+zzk/u5PWcgP31EahmOUqDBT3B8Bweogq1SKCQmFbokJCky6w2wWuOOT67ujIoMxW
	 xvh29zcAkesE8A1xz56myR2Q6ttf7juRwoeY4j035XHlg5d3Np6+o70fp9htizgm5w
	 ZC7t/YWPSh/2D9Hka1/Xg0sjIjTdjOIRhf2gVbh8LVPuj/Qa825wQRTPwAtM1bycpo
	 N+cPJD/N57SNQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.17] drm/msm/adreno: Add fenced regwrite support
Date: Sat, 25 Oct 2025 11:56:49 -0400
Message-ID: <20251025160905.3857885-178-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Akhil P Oommen <akhilpo@oss.qualcomm.com>

[ Upstream commit a27d774045566b587bfc1ae9fb122642b06677b8 ]

There are some special registers which are accessible even when GX power
domain is collapsed during an IFPC sleep. Accessing these registers
wakes up GPU from power collapse and allow programming these registers
without additional handshake with GMU. This patch adds support for this
special register write sequence.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/673368/
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes
  - Prevents register writes from being “dropped” while the GPU’s GX
    power domain is collapsed during IFPC. The new fenced write path
    forces a retry and waits for the GMU AHB fence to move to allow-mode
    so the write actually sticks. Without this, key writes (preemption
    trigger, ring wptr restore) can be lost, leading to missed
    preemption, scheduling stalls, or timeouts under IFPC.

- Scope and changes
  - Introduces a contained helper that performs a write, issues a heavy
    barrier, and polls GMU AHB fence status, retrying briefly if the
    write was dropped:
    - `drivers/gpu/drm/msm/adreno/a6xx_gpu.c:32` adds
      `fence_status_check()` which retries after writedropped and
      enforces `mb()` barriers.
    - `drivers/gpu/drm/msm/adreno/a6xx_gpu.c:50` adds `fenced_write()`
      that polls `REG_A6XX_GMU_AHB_FENCE_STATUS` via
      `gmu_poll_timeout()` for up to 2ms and logs rate-limited errors on
      delay/fail.
    - `drivers/gpu/drm/msm/adreno/a6xx_gpu.c:94` adds
      `a6xx_fenced_write()` handling 32b/64b register pairs.
  - Converts critical writes to this fenced path:
    - Ring flush path: `drivers/gpu/drm/msm/adreno/a6xx_gpu.c:180`
      switches `REG_A6XX_CP_RB_WPTR` to fenced write (mask `BIT(0)`).
    - Preemption wptr restore:
      `drivers/gpu/drm/msm/adreno/a6xx_preempt.c:51` uses fenced write
      for `REG_A6XX_CP_RB_WPTR`.
    - Preemption trigger and context setup:
      - `drivers/gpu/drm/msm/adreno/a6xx_preempt.c:319` uses fenced 64b
        write for `REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO` (mask
        `BIT(1)`).
      - `drivers/gpu/drm/msm/adreno/a6xx_preempt.c:319` uses fenced 64b
        write for
        `REG_A6XX_CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR` (mask
        `BIT(1)`).
      - `drivers/gpu/drm/msm/adreno/a6xx_preempt.c:350` uses fenced
        write for `REG_A6XX_CP_CONTEXT_SWITCH_CNTL` (mask `BIT(1)`).

- Why this is safe and appropriate for stable
  - Small and surgical: Changes are isolated to the msm/adreno a6xx
    driver and only replace a few direct writes with a robust, bounded
    poll-and-retry sequence.
  - Minimal risk path selection:
    - On platforms without a “real” GMU (GMU wrapper), the new helper
      fast-paths out and behaves like the previous code
      (`drivers/gpu/drm/msm/adreno/adreno_gpu.h:274` and
      `drivers/gpu/drm/msm/adreno/a6xx_gpu.c:60`).
    - When not in IFPC (or when fence is already in allow mode), the
      condition evaluates immediately and returns without delay
      (`drivers/gpu/drm/msm/adreno/a6xx_gmu.h:169` for
      `gmu_poll_timeout`).
    - Time-bounded: two 1ms polls with short udelays; errors are rate-
      limited and the call sites do not introduce new failure paths
      relative to pre-existing behavior.
  - Aligned with existing GMU AHB fence machinery already in-tree:
    - Fence ranges configured during GMU bring-up
      (`drivers/gpu/drm/msm/adreno/a6xx_gmu.c:897` writes
      `REG_A6XX_GMU_AHB_FENCE_RANGE_0` to cover the CP context switch
      region; register locations:
      `drivers/gpu/drm/msm/registers/adreno/a6xx.xml:167`
      `CP_CONTEXT_SWITCH_CNTL`,
      `drivers/gpu/drm/msm/registers/adreno/a6xx.xml:173`
      `CP_CONTEXT_SWITCH_SMMU_INFO`,
      `drivers/gpu/drm/msm/registers/adreno/a6xx.xml:174`
      `CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR`,
      `drivers/gpu/drm/msm/registers/adreno/adreno_common.xml:129`
      `CP_RB_WPTR`).
    - WRITEDROPPED status fields are cleared elsewhere as part of
      power/control management
      (`drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1044`), and the helper
      polls the same `REG_A6XX_GMU_AHB_FENCE_STATUS`.
  - Fixes real-world IFPC races and intermittent failures:
    - IFPC has the GMU put the AHB fence into drop mode during
      collapses; writes to certain CP registers are “special” and
      intended to wake/allow programming without extra handshakes, but
      need the fence status polling to be reliable. This patch makes
      those writes robust against brief GMU/IFPC races.

- Stable policy considerations
  - Bugfix vs. feature: This is a correctness/reliability fix under
    IFPC, not a new feature. It eliminates spurious failures where
    preemption and ring write-pointer updates are dropped due to IFPC-
    related fencing. No ABI/API changes.
  - Limited blast radius: Touches only a6xx GPU driver paths; does not
    alter core DRM or other subsystems.
  - No architectural overhaul: It adds a helper and swaps a few reg
    writes; the GMU fence infra it depends on is already present in the
    driver.

- Potential backport prerequisites
  - Ensure the target stable tree includes the GMU AHB fence
    control/range support used by the helper (e.g.,
    `REG_A6XX_GMU_AHB_FENCE_STATUS`, `REG_A6XX_GMU_AHB_FENCE_RANGE_0`,
    `REG_A6XX_GMU_AO_AHB_FENCE_CTRL`) and `gmu_poll_timeout()`
    (`drivers/gpu/drm/msm/adreno/a6xx_gmu.h:169`).
  - If IFPC is not enabled for specific GPUs in a given stable, this
    change is effectively a no-op on those platforms and remains safe.

Conclusion: This is a contained, low-risk reliability fix for IFPC-
capable Adreno a6xx/a7xx paths, preventing dropped writes to critical CP
registers during power-collapsed states. It meets stable backport
criteria and should be backported.

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 80 ++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 +++---
 3 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f8992a68df7fb..536da1acf615e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -16,6 +16,84 @@
 
 #define GPU_PAS_ID 13
 
+static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
+{
+	/* Success if !writedropped0/1 */
+	if (!(status & mask))
+		return true;
+
+	udelay(10);
+
+	/* Try to update fenced register again */
+	gpu_write(gpu, offset, value);
+
+	/* We can't do a posted write here because the power domain could be
+	 * in collapse state. So use the heaviest barrier instead
+	 */
+	mb();
+	return false;
+}
+
+static int fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u32 value, u32 mask)
+{
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	u32 status;
+
+	gpu_write(gpu, offset, value);
+
+	/* Nothing else to be done in the case of no-GMU */
+	if (adreno_has_gmu_wrapper(adreno_gpu))
+		return 0;
+
+	/* We can't do a posted write here because the power domain could be
+	 * in collapse state. So use the heaviest barrier instead
+	 */
+	mb();
+
+	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
+			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
+		return 0;
+
+	/* Try again for another 1ms before failing */
+	gpu_write(gpu, offset, value);
+	mb();
+
+	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
+			fence_status_check(gpu, offset, value, status, mask), 0, 1000)) {
+		/*
+		 * The 'delay' warning is here because the pause to print this
+		 * warning will allow gpu to move to power collapse which
+		 * defeats the purpose of continuous polling for 2 ms
+		 */
+		dev_err_ratelimited(gmu->dev, "delay in fenced register write (0x%x)\n",
+				offset);
+		return 0;
+	}
+
+	dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\n",
+			offset);
+
+	return -ETIMEDOUT;
+}
+
+int a6xx_fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u64 value, u32 mask, bool is_64b)
+{
+	int ret;
+
+	ret = fenced_write(a6xx_gpu, offset, lower_32_bits(value), mask);
+	if (ret)
+		return ret;
+
+	if (!is_64b)
+		return 0;
+
+	ret = fenced_write(a6xx_gpu, offset + 1, upper_32_bits(value), mask);
+
+	return ret;
+}
+
 static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -86,7 +164,7 @@ static void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	/* Update HW if this is the current ring and we are not in preempt*/
 	if (!a6xx_in_preempt(a6xx_gpu)) {
 		if (a6xx_gpu->cur_ring == ring)
-			gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
+			a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
 		else
 			ring->restore_wptr = true;
 	} else {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 6e71f617fc3d0..e736c59d566b3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -295,5 +295,6 @@ int a6xx_gpu_state_put(struct msm_gpu_state *state);
 
 void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
 void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
+int a6xx_fenced_write(struct a6xx_gpu *gpu, u32 offset, u64 value, u32 mask, bool is_64b);
 
 #endif /* __A6XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index 6a12a35dabff1..10625ffbc4cfc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -41,7 +41,7 @@ static inline void set_preempt_state(struct a6xx_gpu *gpu,
 }
 
 /* Write the most recent wptr for the given ring into the hardware */
-static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+static inline void update_wptr(struct a6xx_gpu *a6xx_gpu, struct msm_ringbuffer *ring)
 {
 	unsigned long flags;
 	uint32_t wptr;
@@ -51,7 +51,7 @@ static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	if (ring->restore_wptr) {
 		wptr = get_wptr(ring);
 
-		gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
+		a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
 
 		ring->restore_wptr = false;
 	}
@@ -172,7 +172,7 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
 
 	set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
 
-	update_wptr(gpu, a6xx_gpu->cur_ring);
+	update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
 
 	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
 
@@ -268,7 +268,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 	 */
 	if (!ring || (a6xx_gpu->cur_ring == ring)) {
 		set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
-		update_wptr(gpu, a6xx_gpu->cur_ring);
+		update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
 		set_preempt_state(a6xx_gpu, PREEMPT_NONE);
 		spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
 		return;
@@ -302,13 +302,13 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 
 	spin_unlock_irqrestore(&ring->preempt_lock, flags);
 
-	gpu_write64(gpu,
-		REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO,
-		a6xx_gpu->preempt_smmu_iova[ring->id]);
+	a6xx_fenced_write(a6xx_gpu,
+		REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO, a6xx_gpu->preempt_smmu_iova[ring->id],
+		BIT(1), true);
 
-	gpu_write64(gpu,
+	a6xx_fenced_write(a6xx_gpu,
 		REG_A6XX_CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR,
-		a6xx_gpu->preempt_iova[ring->id]);
+		a6xx_gpu->preempt_iova[ring->id], BIT(1), true);
 
 	a6xx_gpu->next_ring = ring;
 
@@ -328,7 +328,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 	set_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED);
 
 	/* Trigger the preemption */
-	gpu_write(gpu, REG_A6XX_CP_CONTEXT_SWITCH_CNTL, cntl);
+	a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_CONTEXT_SWITCH_CNTL, cntl, BIT(1), false);
 }
 
 static int preempt_init_ring(struct a6xx_gpu *a6xx_gpu,
-- 
2.51.0


