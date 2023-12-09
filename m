Return-Path: <stable+bounces-5147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD5A80B44E
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4627E1C20B12
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865B14293;
	Sat,  9 Dec 2023 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yb5PwMR/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253E748C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8679C433C8;
	Sat,  9 Dec 2023 12:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702126029;
	bh=lRpZzRdn1aWvPpk8lihzSv3U3tCncNrI3KRdQfLyeW8=;
	h=Subject:To:Cc:From:Date:From;
	b=yb5PwMR/bZhysqpxmHSiS/UJwpG4Yj2Xw1ggEx40lk/hHwDvI9GTE5Xt6IIL/g23i
	 tR+Ib6yAahca/KOA9YPgeKCxgitU7JrPvHoq7oCUcK+NBarnwBOpOoOSUWAOGiEgX1
	 oN77b5Fcrew4ROeGBOAKUf044mwOtUlmJTovEw7I=
Subject: FAILED: patch "[PATCH] drm/amdgpu: disable MCBP by default" failed to apply to 6.6-stable tree
To: Jiadong.Zhu@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:46:53 +0100
Message-ID: <2023120953-unaligned-chowtime-dd0c@gregkh>
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
git cherry-pick -x d6a57588666301acd9d42d3b00d74240964f07f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120953-unaligned-chowtime-dd0c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d6a575886663 ("drm/amdgpu: disable MCBP by default")
4e8303cf2c4d ("drm/amdgpu: Use function for IP version check")
6b7d211740da ("drm/amdgpu: Fix refclk reporting for SMU v13.0.6")
1b8e56b99459 ("drm/amdgpu: Restrict bootloader wait to SMUv13.0.6")
983ac45a06ae ("drm/amdgpu: update SET_HW_RESOURCES definition for UMSCH")
822f7808291f ("drm/amdgpu/discovery: enable UMSCH 4.0 in IP discovery")
3488c79beafa ("drm/amdgpu: add initial support for UMSCH")
2da1b04a2096 ("drm/amdgpu: add UMSCH 4.0 api definition")
3ee8fb7005ef ("drm/amdgpu: enable VPE for VPE 6.1.0")
9d4346bdbc64 ("drm/amdgpu: add VPE 6.1.0 support")
e370f8f38976 ("drm/amdgpu: Add bootloader wait for PSP v13")
aba2be41470a ("drm/amdgpu: add mmhub 3.3.0 support")
15e7cbd91de6 ("drm/amdgpu/gfx11: initialize gfx11.5.0")
f56c1941ebb7 ("drm/amdgpu: use 6.1.0 register offset for HDP CLK_CNTL")
15c5c5f57514 ("drm/amdgpu: Add bootloader status check")
3cce0bfcd0f9 ("drm/amd/display: Enable Replay for static screen use cases")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d6a57588666301acd9d42d3b00d74240964f07f6 Mon Sep 17 00:00:00 2001
From: Jiadong Zhu <Jiadong.Zhu@amd.com>
Date: Fri, 1 Dec 2023 08:38:15 +0800
Subject: [PATCH] drm/amdgpu: disable MCBP by default

Disable MCBP(mid command buffer preemption) by default as old Mesa
hangs with it. We shall not enable the feature that breaks old usermode
driver.

Fixes: 50a7c8765ca6 ("drm/amdgpu: enable mcbp by default on gfx9")
Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c0817cbc7c2..1cc1ae2743c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3791,10 +3791,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 		adev->gfx.mcbp = true;
 	else if (amdgpu_mcbp == 0)
 		adev->gfx.mcbp = false;
-	else if ((amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 0, 0)) &&
-		 (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0)) &&
-		 adev->gfx.num_gfx_rings)
-		adev->gfx.mcbp = true;
 
 	if (amdgpu_sriov_vf(adev))
 		adev->gfx.mcbp = true;


