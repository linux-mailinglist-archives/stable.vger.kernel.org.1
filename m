Return-Path: <stable+bounces-187808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4E8BEC66D
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 05:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A5D34E961E
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F4427702D;
	Sat, 18 Oct 2025 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Llrki9gB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085D3595C
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760757853; cv=none; b=dsl4lpOQ6756kyHjHJWoVedsbyNl9Em8S5Ixfe1V7S08s4AEKt3vZMS8lqp1Gc1HMoyPYUAnr0Fde2qQJzOu4bBF/OInbG49iSWOoNP+7+3UeRVkifR7FGZsjOAFDdASu/It5GiF8LeQUag0IQLzoxUxV8VdHvJ98i0zwTdRp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760757853; c=relaxed/simple;
	bh=px7jYbqwdqVR7BMsbxx2cR4lpp2b6B4DwFpTzMq87PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0suRLPRVK0CUoiI6Ivip4slX3CldPsfDWgQqpQFz630j4qv7aaq5iqfEqkP4O6bUIA4nGnYXWonXjnesjwt+diJhqUhO4Ar+SNy6cjF+bWl5Kbv3EpshqZh+1Njcp2+DpdMzSoyK+kjpBVbKRZWvEAmYAB7//OcmHr0/+ej3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Llrki9gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0744C4CEE7;
	Sat, 18 Oct 2025 03:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760757851;
	bh=px7jYbqwdqVR7BMsbxx2cR4lpp2b6B4DwFpTzMq87PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Llrki9gB2z4iMD4L7vP99VvFq/+4kt7EG1oW5xB9xdqcPOVBQXFdnm1lL7DNtaAUp
	 sTZ9hpNDMpE8ovAqIGzKOY1W/gpqKQ8f5ZGOGQg0WNm08tOHlBO462CrQ8HYQXwyCO
	 UeUWq+oMmxNxYBMoiijqLsi1Whv7sqEhkZKJzKC0i4mREnNBXdUuDdOH31jC1cOhkX
	 rqWUbwtwfmVzdhoMhVtSXSq7HdBKbqDEZayuK3HNggXXCgudGSLpOUqHRus6Mwz1Sj
	 6DTY06rNvwTE2w2h2src2fVgBemKbDqTRoG9oYGyaEGujKnFHOwZVTJ+204E09+fBG
	 04xiX7uJAjMIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm/msm/adreno: De-spaghettify the use of memory barriers
Date: Fri, 17 Oct 2025 23:24:07 -0400
Message-ID: <20251018032408.252050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101631-punctual-jaybird-dba5@gregkh>
References: <2025101631-punctual-jaybird-dba5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 43ec1a202cfa9f765412d325b93873284e7c3d82 ]

Memory barriers help ensure instruction ordering, NOT time and order
of actual write arrival at other observers (e.g. memory-mapped IP).
On architectures employing weak memory ordering, the latter can be a
giant pain point, and it has been as part of this driver.

Moreover, the gpu_/gmu_ accessors already use non-relaxed versions of
readl/writel, which include r/w (respectively) barriers.

Replace the barriers with a readback (or drop altogether where possible)
that ensures the previous writes have exited the write buffer (as the CPU
must flush the write to the register it's trying to read back).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/600869/
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Stable-dep-of: f248d5d5159a ("drm/msm/a6xx: Fix PDC sleep sequence")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  4 +---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index e7136b7759cb3..0a30ecc81a8cc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -460,9 +460,7 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
-	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1 << 1);
-	/* Wait for the register to finish posting */
-	wmb();
+	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
 
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
 		val & (1 << 1), 100, 10000);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 3664c1476a83a..00bfc6f38f459 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1209,14 +1209,16 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Clear GBIF halt in case GX domain was not collapsed */
 	if (adreno_is_a619_holi(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_read(gpu, REG_A6XX_GBIF_HALT);
+
 		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
-		/* Let's make extra sure that the GPU can access the memory.. */
-		mb();
+		gpu_read(gpu, REG_A6XX_RBBM_GPR0_CNTL);
 	} else if (a6xx_has_gbif(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_read(gpu, REG_A6XX_GBIF_HALT);
+
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
-		/* Let's make extra sure that the GPU can access the memory.. */
-		mb();
+		gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT);
 	}
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
-- 
2.51.0


