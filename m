Return-Path: <stable+bounces-135014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82828A95DCC
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECC53B7EF5
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA001E7C28;
	Tue, 22 Apr 2025 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T83YwUvK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF391E5707
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302275; cv=none; b=hMDAbUpZvdeeUR+3lWW8WgEG/qWarYerpOGOMWm0xHOHbhMdZRZ4k3rrBcoTYbQy5DQDln+hLjgWL+6MyaFwa/T3hsixsut/a7N3KelQbCdC4mitamp5HFOpkw4kLS/mARePiF3P5PLm0cQTfhRoeABoWHeqll0PUyKNjsW9iSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302275; c=relaxed/simple;
	bh=aoU9F/faEzJMdptUa0hX6tnR2rm9mTgWiSTmqFDuJFU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E6rn3/AW89nizhKqezl9qliDeZsjdHeZuBmTdvvG/g6gtCnewmYbolJuvvb5MCv9gX4dXDwsWcfOFaxMvwBrGC34UtQoeVcujeYMPp3kx++Ci84Kuatjso1SigN+sfeMbEvzwzGZ8eXnI1kthbzl8WS6ml9n5y4nxEcThxuVGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T83YwUvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DE6C4CEEC;
	Tue, 22 Apr 2025 06:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745302274;
	bh=aoU9F/faEzJMdptUa0hX6tnR2rm9mTgWiSTmqFDuJFU=;
	h=Subject:To:Cc:From:Date:From;
	b=T83YwUvKInH7wR8Ajmhvgbv1ml3X3qzKozUzl2Ac4MsD5xhhVf7QTQtK4huI1/GDM
	 ZKAdyfzMpjP1NiSfErL7agZ+cGylx3D0Goifyi7adLu9pIRWiXF6nfjn+qpPH4CfAm
	 ERkfNvptlXMl35iGlLsjGHEMYLhENKZGoiyQl/mI=
Subject: FAILED: patch "[PATCH] drm/msm/a6xx: Fix stale rpmh votes from GPU" failed to apply to 5.10-stable tree
To: quic_akhilpo@quicinc.com,robdclark@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:11:03 +0200
Message-ID: <2025042203-tainted-gully-08b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f561db72a663f8a73c2250bf3244ce1ce221bed7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042203-tainted-gully-08b3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f561db72a663f8a73c2250bf3244ce1ce221bed7 Mon Sep 17 00:00:00 2001
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Wed, 26 Feb 2025 01:22:14 +0530
Subject: [PATCH] drm/msm/a6xx: Fix stale rpmh votes from GPU

It was observed on sc7180 (A618 gpu) that GPU votes for GX rail and CNOC
BCM nodes were not removed after GPU suspend. This was because we
skipped sending 'prepare-slumber' request to gmu during suspend sequence
in some cases. So, make sure we always call prepare-slumber hfi during
suspend. Also, calling prepare-slumber without a prior oob-gpu handshake
messes up gmu firmware's internal state. So, do that when required.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Cc: stable@vger.kernel.org
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/639569/
Signed-off-by: Rob Clark <robdclark@chromium.org>

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 699b0dd34b18..38c94915d4c9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1169,50 +1169,51 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	u32 val;
+	int ret;
 
 	/*
-	 * The GMU may still be in slumber unless the GPU started so check and
-	 * skip putting it back into slumber if so
+	 * GMU firmware's internal power state gets messed up if we send "prepare_slumber" hfi when
+	 * oob_gpu handshake wasn't done after the last wake up. So do a dummy handshake here when
+	 * required
 	 */
-	val = gmu_read(gmu, REG_A6XX_GPU_GMU_CX_GMU_RPMH_POWER_STATE);
+	if (adreno_gpu->base.needs_hw_init) {
+		if (a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET))
+			goto force_off;
 
-	if (val != 0xf) {
-		int ret = a6xx_gmu_wait_for_idle(gmu);
-
-		/* If the GMU isn't responding assume it is hung */
-		if (ret) {
-			a6xx_gmu_force_off(gmu);
-			return;
-		}
-
-		a6xx_bus_clear_pending_transactions(adreno_gpu, a6xx_gpu->hung);
-
-		/* tell the GMU we want to slumber */
-		ret = a6xx_gmu_notify_slumber(gmu);
-		if (ret) {
-			a6xx_gmu_force_off(gmu);
-			return;
-		}
-
-		ret = gmu_poll_timeout(gmu,
-			REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS, val,
-			!(val & A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS_GPUBUSYIGNAHB),
-			100, 10000);
-
-		/*
-		 * Let the user know we failed to slumber but don't worry too
-		 * much because we are powering down anyway
-		 */
-
-		if (ret)
-			DRM_DEV_ERROR(gmu->dev,
-				"Unable to slumber GMU: status = 0%x/0%x\n",
-				gmu_read(gmu,
-					REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS),
-				gmu_read(gmu,
-					REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS2));
+		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 	}
 
+	ret = a6xx_gmu_wait_for_idle(gmu);
+
+	/* If the GMU isn't responding assume it is hung */
+	if (ret)
+		goto force_off;
+
+	a6xx_bus_clear_pending_transactions(adreno_gpu, a6xx_gpu->hung);
+
+	/* tell the GMU we want to slumber */
+	ret = a6xx_gmu_notify_slumber(gmu);
+	if (ret)
+		goto force_off;
+
+	ret = gmu_poll_timeout(gmu,
+		REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS, val,
+		!(val & A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS_GPUBUSYIGNAHB),
+		100, 10000);
+
+	/*
+	 * Let the user know we failed to slumber but don't worry too
+	 * much because we are powering down anyway
+	 */
+
+	if (ret)
+		DRM_DEV_ERROR(gmu->dev,
+			"Unable to slumber GMU: status = 0%x/0%x\n",
+			gmu_read(gmu,
+				REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS),
+			gmu_read(gmu,
+				REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS2));
+
 	/* Turn off HFI */
 	a6xx_hfi_stop(gmu);
 
@@ -1221,6 +1222,11 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 
 	/* Tell RPMh to power off the GPU */
 	a6xx_rpmh_stop(gmu);
+
+	return;
+
+force_off:
+	a6xx_gmu_force_off(gmu);
 }
 
 


