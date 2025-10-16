Return-Path: <stable+bounces-185984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65138BE2620
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826A8188C554
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D0E2D3A7B;
	Thu, 16 Oct 2025 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sCN5q58y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B8192D97
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606914; cv=none; b=RcNhQj69S71QKCtvIso2iZpP3FHSOcJDiB/kwZ0hWQ7MbY5lc2Pat5EFkkXR5vbj0c2fbrhAhArC2r2mhPK7b0Q3eXl1L4UkoDgoFvokSA4TlEv5HQmxdWGjhIdJgAQtcTZNxgDalR284nL3cuqXqFj5pPSb45F4G0kzM1UMk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606914; c=relaxed/simple;
	bh=sSFfUVcjy88lzQXNIWFleQ7yvjkJVen9yTVBg3m7B6k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O2ieG611ZIXmN4AIvhsmIW/Dgh/F23D08PWpn+e1A7a3GQgyYhjnd1Q2gxiSklLr7GTxFbFCk3Y1qlWfb8avuJUFQO6NWdKeUwiItxTk1SIRzQMuIPG5ObwauRdnfJbGGiKj2fKHlrVaeEeu308f/ZkinstRxc+xl4uelTaMeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sCN5q58y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8D5C4CEF1;
	Thu, 16 Oct 2025 09:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760606913;
	bh=sSFfUVcjy88lzQXNIWFleQ7yvjkJVen9yTVBg3m7B6k=;
	h=Subject:To:Cc:From:Date:From;
	b=sCN5q58ywC/llbGVMjbIM0Ve0EKB/yqCr6lLyC58LYnRinlbfonRjahgSWYesVHPJ
	 5ee9DqY9Nx3XGLN74Odh+UIkRVrkzAh+sMrLzckApHfXxx5KWuQfCUE97g8g9wedaZ
	 x3sXS7+okw6euuONAzlopZdHGeuo/W4hJ8gDg4O0=
Subject: FAILED: patch "[PATCH] drm/msm/a6xx: Fix PDC sleep sequence" failed to apply to 6.12-stable tree
To: akhilpo@oss.qualcomm.com,robin.clark@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:28:31 +0200
Message-ID: <2025101631-neurosis-worshiper-3728@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f248d5d5159a88ded55329f0b1b463d0f4094228
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101631-neurosis-worshiper-3728@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f248d5d5159a88ded55329f0b1b463d0f4094228 Mon Sep 17 00:00:00 2001
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 13:56:57 +0530
Subject: [PATCH] drm/msm/a6xx: Fix PDC sleep sequence

Since the PDC resides out of the GPU subsystem and cannot be reset in
case it enters bad state, utmost care must be taken to trigger the PDC
wake/sleep routines in the correct order.

The PDC wake sequence can be exercised only after a PDC sleep sequence.
Additionally, GMU firmware should initialize a few registers before the
KMD can trigger a PDC sleep sequence. So PDC sleep can't be done if the
GMU firmware has not initialized. Track these dependencies using a new
status variable and trigger PDC sleep/wake sequences appropriately.

Cc: stable@vger.kernel.org
Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/673362/
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index e74651d5bd7a..5594499ad2d1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -279,6 +279,8 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
 	if (ret)
 		DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");
 
+	set_bit(GMU_STATUS_FW_START, &gmu->status);
+
 	return ret;
 }
 
@@ -525,6 +527,9 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
+	if (!test_and_clear_bit(GMU_STATUS_PDC_SLEEP, &gmu->status))
+		return 0;
+
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
 
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
@@ -552,6 +557,9 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
+	if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
+		return;
+
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1);
 
 	ret = gmu_poll_timeout_rscc(gmu, REG_A6XX_GPU_RSCC_RSC_STATUS0_DRV0,
@@ -560,6 +568,8 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 		DRM_DEV_ERROR(gmu->dev, "Unable to power off the GPU RSC\n");
 
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 0);
+
+	set_bit(GMU_STATUS_PDC_SLEEP, &gmu->status);
 }
 
 static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
@@ -688,8 +698,6 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	/* ensure no writes happen before the uCode is fully written */
 	wmb();
 
-	a6xx_rpmh_stop(gmu);
-
 err:
 	if (!IS_ERR_OR_NULL(pdcptr))
 		iounmap(pdcptr);
@@ -849,19 +857,15 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	else
 		gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
 
-	if (state == GMU_WARM_BOOT) {
-		ret = a6xx_rpmh_start(gmu);
-		if (ret)
-			return ret;
-	} else {
+	ret = a6xx_rpmh_start(gmu);
+	if (ret)
+		return ret;
+
+	if (state == GMU_COLD_BOOT) {
 		if (WARN(!adreno_gpu->fw[ADRENO_FW_GMU],
 			"GMU firmware is not loaded\n"))
 			return -ENOENT;
 
-		ret = a6xx_rpmh_start(gmu);
-		if (ret)
-			return ret;
-
 		ret = a6xx_gmu_fw_load(gmu);
 		if (ret)
 			return ret;
@@ -1046,6 +1050,8 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 
 	/* Reset GPU core blocks */
 	a6xx_gpu_sw_reset(gpu, true);
+
+	a6xx_rpmh_stop(gmu);
 }
 
 static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index d1ce11131ba6..069a8c9474e8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -117,6 +117,12 @@ struct a6xx_gmu {
 
 	struct qmp *qmp;
 	struct a6xx_hfi_msg_bw_table *bw_table;
+
+/* To check if we can trigger sleep seq at PDC. Cleared in a6xx_rpmh_stop() */
+#define GMU_STATUS_FW_START	0
+/* To track if PDC sleep seq was done */
+#define GMU_STATUS_PDC_SLEEP	1
+	unsigned long status;
 };
 
 static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)


