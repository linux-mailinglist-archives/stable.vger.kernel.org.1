Return-Path: <stable+bounces-5143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5E80B440
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C931F2127B
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187711703;
	Sat,  9 Dec 2023 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GHbIjlAk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075914293
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A45FC433C7;
	Sat,  9 Dec 2023 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702125395;
	bh=CkHpF94Vxyzip5MM39dx3zTxFl8Uk0gnPgcLJ1vBQHc=;
	h=Subject:To:Cc:From:Date:From;
	b=GHbIjlAkItL5NpuhkBtUt5KKJuOGVYH0I8cLsjPBnDaZxObZhAZhzuecKgCo6nnxU
	 CaWQfTMptHCqp+M/fZ/btJP8EEqZgNBg+Q1cOJNySsqcdqPsfmW0Iv6VIoxOIJBRE2
	 hVRp4SAbwBV20SXq19i2ef+L1bf8DyfyFbLhNk8g=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Restrict extended wait to PSP v13.0.6" failed to apply to 6.6-stable tree
To: lijo.lazar@amd.com,alexander.deucher@amd.com,asad.kamal@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:36:32 +0100
Message-ID: <2023120932-suffocate-neuter-c5d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6fce23a4d8c5f93bf80b7f122449fbb97f1e40dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120932-suffocate-neuter-c5d7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

6fce23a4d8c5 ("drm/amdgpu: Restrict extended wait to PSP v13.0.6")
d8c1925ba8cd ("drm/amdgpu: update retry times for psp BL wait")
fc5988907156 ("drm/amdgpu: update retry times for psp vmbx wait")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6fce23a4d8c5f93bf80b7f122449fbb97f1e40dd Mon Sep 17 00:00:00 2001
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


