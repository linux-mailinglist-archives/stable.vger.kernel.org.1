Return-Path: <stable+bounces-16138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7683F0F1
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6777AB26FC0
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E61DDD6;
	Sat, 27 Jan 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iRV2h4ZN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2C18E07
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395127; cv=none; b=OPFEfWkv5oBtnuJRmgtVGhIwCPEJ5ng9vpBC6tG1vyUerkeoGGHJig+rRDWAB2SPglmpsVxXIG+dz8D/YIMc9EKWGv6aOJAK1PjnxkQaBzZfJ/n49ASenIwunBBleOahdYaIIgJjJbMRME8pxWsedX64LjMJrEx7o95esVddLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395127; c=relaxed/simple;
	bh=cIS7MvNp+TKllpTj6pqOXNRIAaVL3m/nY0yhOLYXtaQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=okvS9+AeBjvo5jwYyyuH56SH67GQqs3/FvRyTxNe3k6UhoD2Er2Od9hLmY3+W7Wlr5XvgAafxETsJVTtRTbT4bE4eUEv42GSkqMz50zuWDZyTE/Ukbn9izrLPx5OR1GzsHGY+ER4YkPj6y3XQzuf9At7hHmhHzXI9V9ayTY8XfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iRV2h4ZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07FFC433F1;
	Sat, 27 Jan 2024 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395127;
	bh=cIS7MvNp+TKllpTj6pqOXNRIAaVL3m/nY0yhOLYXtaQ=;
	h=Subject:To:Cc:From:Date:From;
	b=iRV2h4ZN4jiIS81GWK5/3rPx3GFSqCMEtZV1wFDfM98/t+CaJbKSda+Em94ZtI1ZU
	 t969KWhLZ6IbeQKVTE2USFnh7o6NR1TYE5lJobcPDeIrlUdJbHSsj2XqaQbdpCyU3o
	 WeOcsVNnsrpa8MAdCOhhvCz0/Yo3vfjLT10ASgv8=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Restrict extended wait to PSP v13.0.6" failed to apply to 6.6-stable tree
To: lijo.lazar@amd.com,alexander.deucher@amd.com,asad.kamal@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:38:46 -0800
Message-ID: <2024012745-stingy-busboy-80dc@gregkh>
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
git cherry-pick -x 4657b3e45683223b5d982ec13a6e2cd367004bb6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012745-stingy-busboy-80dc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

4657b3e45683 ("drm/amdgpu: Restrict extended wait to PSP v13.0.6")
d8c1925ba8cd ("drm/amdgpu: update retry times for psp BL wait")
fc5988907156 ("drm/amdgpu: update retry times for psp vmbx wait")

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


