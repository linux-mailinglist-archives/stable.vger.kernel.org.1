Return-Path: <stable+bounces-250390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IPrBvfxDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-250390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:40:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9C5943B1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B41D33758364
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8FA3B6349;
	Wed, 20 May 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDo67t9J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25FB3A3E60;
	Wed, 20 May 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295289; cv=none; b=eVKpHMNZtM5bM2mBgSW2dNmPot0ATUCZri0mBPICWzF1UPGSD7DzT0qteo3eON+MbIGfV+NwWJTNtI6MpHxitYUtINm2TOrVlkpd7ed9q8cwEHABoLyfd/K+VjQ3De2OI4QPxzO+jhM2Mr059tRLHxqzW2tYja8tnQ6y7BQxD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295289; c=relaxed/simple;
	bh=Nz0dWmBTHgqQvwZZNloLaUvpJE1yeN34JdDKpWnv+U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBwJg9txJ40ksmfWoRa2+G9s4pdT/8TOi4tdLM9EO5uw9i+8pH3m0fwqE39nWzJ52NkVVFFtIPQKJuy7BZsuwTxEJ543QTx6KHvTtJdeAc2YdL08DtKOC650cJpf6NUcvMQ+ilMMD+MR7EzezdNxDUOtRHct2ihdmt8a8Aog6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDo67t9J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542951F000E9;
	Wed, 20 May 2026 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295287;
	bh=A881U0GJvmLom40owVgxyB4la3qQoWbw1dqo/urxLpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dDo67t9JAtLV4ITJSSdh1Bayj59dwfgyP3JDNMAhekYHL9INQyETLsqmZ0XeekG4N
	 0cNgRm7bbC7gQASiw8KM/1Y+9FhpCIBj16td8GAvgLTvWVydZJXUVZntex4Ewe8VR3
	 vMhw01I+z80xY7wAfYi//Nw3pcGcEf9JwGl3a6IY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0362/1146] drm/msm/adreno: Implement gx_is_on() for A8x
Date: Wed, 20 May 2026 18:10:12 +0200
Message-ID: <20260520162156.393934306@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250390-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 55E9C5943B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil P Oommen <akhilpo@oss.qualcomm.com>

[ Upstream commit ae25e6e9cdcac4cfef102b9d6de8bff13ca4d13b ]

A8x has a diverged enough for a separate implementation of gx_is_on()
check. Add that and move them to the adreno func table.

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/714661/
Message-ID: <20260327-a8xx-gpu-batch2-v2-5-2b53c38d2101@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c       | 42 +++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h       |  5 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  6 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  1 +
 5 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 690d3e53e2738..b41dbca1ebc63 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -91,10 +91,10 @@ bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu)
 }
 
 /* Check to see if the GX rail is still powered */
-bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
+bool a6xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu)
 {
-	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
-	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 val;
 
 	/* This can be called from gpu state code so make sure GMU is valid */
@@ -117,6 +117,40 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 		A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
 }
 
+bool a7xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu)
+{
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	u32 val;
+
+	/* This can be called from gpu state code so make sure GMU is valid */
+	if (!gmu->initialized)
+		return false;
+
+	val = gmu_read(gmu, REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS);
+
+	return !(val &
+		(A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
+		A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
+}
+
+bool a8xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu)
+{
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	u32 val;
+
+	/* This can be called from gpu state code so make sure GMU is valid */
+	if (!gmu->initialized)
+		return false;
+
+	val = gmu_read(gmu, REG_A8XX_GMU_PWR_CLK_STATUS);
+
+	return !(val &
+		(A8XX_GMU_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
+		 A8XX_GMU_PWR_CLK_STATUS_GX_HM_CLK_OFF));
+}
+
 void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 		       bool suspended)
 {
@@ -240,7 +274,7 @@ static bool a6xx_gmu_check_idle_level(struct a6xx_gmu *gmu)
 
 	if (val == local) {
 		if (gmu->idle_level != GMU_IDLE_STATE_IFPC ||
-			!a6xx_gmu_gx_is_on(gmu))
+			!adreno_gpu->funcs->gx_is_on(adreno_gpu))
 			return true;
 	}
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 2af074c8e8cfa..9f09daf45ab2b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -10,6 +10,7 @@
 #include <linux/notifier.h>
 #include <linux/soc/qcom/qcom_aoss.h>
 #include "msm_drv.h"
+#include "adreno_gpu.h"
 #include "a6xx_hfi.h"
 
 struct a6xx_gmu_bo {
@@ -231,7 +232,9 @@ void a6xx_hfi_stop(struct a6xx_gmu *gmu);
 int a6xx_hfi_send_prep_slumber(struct a6xx_gmu *gmu);
 int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, u32 perf_index, u32 bw_index);
 
-bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
+bool a6xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
+bool a7xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
+bool a8xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
 void a6xx_sptprac_disable(struct a6xx_gmu *gmu);
 int a6xx_sptprac_enable(struct a6xx_gmu *gmu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4e0d67e3acb7e..9327ecf94386e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1643,7 +1643,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
 	adreno_dump_info(gpu);
 
-	if (a6xx_gmu_gx_is_on(&a6xx_gpu->gmu)) {
+	if (adreno_gpu->funcs->gx_is_on(adreno_gpu)) {
 		/* Sometimes crashstate capture is skipped, so SQE should be halted here again */
 		gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
 
@@ -2763,6 +2763,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
+	.gx_is_on = a6xx_gmu_gx_is_on,
 };
 
 const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
@@ -2795,6 +2796,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 	.get_timestamp = a6xx_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
+	.gx_is_on = a6xx_gmu_gx_is_on,
 };
 
 const struct adreno_gpu_funcs a7xx_gpu_funcs = {
@@ -2829,6 +2831,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
+	.gx_is_on = a7xx_gmu_gx_is_on,
 };
 
 const struct adreno_gpu_funcs a8xx_gpu_funcs = {
@@ -2856,4 +2859,5 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 	.get_timestamp = a8xx_gmu_get_timestamp,
 	.bus_halt = a8xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a8xx_fault_handler,
+	.gx_is_on = a8xx_gmu_gx_is_on,
 };
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index e9a23d471f374..791623ddb67c9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1251,7 +1251,7 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
 		_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gpucc_reg,
 			&a6xx_state->gmu_registers[2], false);
 
-	if (!a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
+	if (!adreno_gpu->funcs->gx_is_on(adreno_gpu))
 		return;
 
 	/* Set the fence to ALLOW mode so we can access the registers */
@@ -1607,7 +1607,7 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 	}
 
 	/* If GX isn't on the rest of the data isn't going to be accessible */
-	if (!a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
+	if (!adreno_gpu->funcs->gx_is_on(adreno_gpu))
 		return &a6xx_state->base;
 
 	/* Halt SQE first */
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index c08725ed54c4f..29097e6b42535 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -82,6 +82,7 @@ struct adreno_gpu_funcs {
 	u64 (*get_timestamp)(struct msm_gpu *gpu);
 	void (*bus_halt)(struct adreno_gpu *adreno_gpu, bool gx_off);
 	int (*mmu_fault_handler)(void *arg, unsigned long iova, int flags, void *data);
+	bool (*gx_is_on)(struct adreno_gpu *adreno_gpu);
 };
 
 struct adreno_reglist {
-- 
2.53.0




