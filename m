Return-Path: <stable+bounces-16137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D64DC83F0F0
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70263B26F90
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D71D6AA;
	Sat, 27 Jan 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OywysNkS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047B18E07
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395126; cv=none; b=hxVCTlXSQPBX5Ds5wux0OL+WlSlneCbRuZlS+qCMTJZyt1kAu3QmHDMIymq50Xa3DRIQKMbv2hp3mD99vN1bNBDWlAfd6NQo2Z1HzgZELX8Xsqpj+nc6WthPsXzhdWeMS5kjUQabzsRrD+0VwgQC6p77ZY3EoqddfCMhD907CCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395126; c=relaxed/simple;
	bh=IbcgrU0d9gWVzFhWuSouOMC9+jEAoJBoICQxiEP6cbo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hqzp9PhBbTRDV1lg7V114EjR9zZQz4eU1OsQtls+M7iSHh3H15y/i26mwEUrkhaVrQ6Cvi7zF9fQKkwQgDwwbA9SUtscgpUbnQrX+RPeK3uK2r2Hi1q2uscV8m1clPChIlfxwTTKy9BF3ohJ4NS0eFm3fEpb0R1u3lFgjHpLb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OywysNkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20B3C433F1;
	Sat, 27 Jan 2024 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395125;
	bh=IbcgrU0d9gWVzFhWuSouOMC9+jEAoJBoICQxiEP6cbo=;
	h=Subject:To:Cc:From:Date:From;
	b=OywysNkSf7VqNtAc/4yQJ2cB2qFSTTG6s1X6+LvmD29hIY9ad/y//jTfyd1H2W8jz
	 lJr70IzRpRp4naSPPfXyVhKHuF0Xzr6iUkz8g7N4n5zvnRF1YpoyPX2fdpVoqBBQ8s
	 tCUckZzY+3NR3QIsi1ObgKDrGkXwjJVJmGRjTmUM=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Restrict extended wait to PSP v13.0.6" failed to apply to 6.7-stable tree
To: lijo.lazar@amd.com,alexander.deucher@amd.com,asad.kamal@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:38:44 -0800
Message-ID: <2024012744-graceless-creamer-0fa6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 4657b3e45683223b5d982ec13a6e2cd367004bb6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012744-graceless-creamer-0fa6@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

4657b3e45683 ("drm/amdgpu: Restrict extended wait to PSP v13.0.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4657b3e45683223b5d982ec13a6e2cd367004bb6 Mon Sep 17 00:00:00 2001
From: Lijo Lazar <lijo.lazar@amd.com>
Date: Wed, 29 Nov 2023 18:06:55 +0530
Subject: [PATCH] drm/amdgpu: Restrict extended wait to PSP v13.0.6

Only PSPv13.0.6 SOCs take a longer time to reach steady state. Other
PSPv13 based SOCs don't need extended wait. Also, reduce PSPv13.0.6 wait
time.

Cc: stable@vger.kernel.org
Fixes: fc5988907156 ("drm/amdgpu: update retry times for psp vmbx wait")
Fixes: d8c1925ba8cd ("drm/amdgpu: update retry times for psp BL wait")
Link: https://lore.kernel.org/amd-gfx/34dd4c66-f7bf-44aa-af8f-c82889dd652c@amd.com/
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 5f46877f78cf..df1844d0800f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -60,7 +60,7 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 #define GFX_CMD_USB_PD_USE_LFB 0x480
 
 /* Retry times for vmbx ready wait */
-#define PSP_VMBX_POLLING_LIMIT 20000
+#define PSP_VMBX_POLLING_LIMIT 3000
 
 /* VBIOS gfl defines */
 #define MBOX_READY_MASK 0x80000000
@@ -161,14 +161,18 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)
 static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
-	int retry_loop, ret;
+	int retry_loop, retry_cnt, ret;
 
+	retry_cnt =
+		(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) ?
+			PSP_VMBX_POLLING_LIMIT :
+			10;
 	/* Wait for bootloader to signify that it is ready having bit 31 of
 	 * C2PMSG_35 set to 1. All other bits are expected to be cleared.
 	 * If there is an error in processing command, bits[7:0] will be set.
 	 * This is applicable for PSP v13.0.6 and newer.
 	 */
-	for (retry_loop = 0; retry_loop < PSP_VMBX_POLLING_LIMIT; retry_loop++) {
+	for (retry_loop = 0; retry_loop < retry_cnt; retry_loop++) {
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
 			0x80000000, 0xffffffff, false);


