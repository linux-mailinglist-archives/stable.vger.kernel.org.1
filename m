Return-Path: <stable+bounces-53746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306AD90E5FC
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8E91C21799
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CEB7BB12;
	Wed, 19 Jun 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OhApd2lj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF427BAF4
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786331; cv=none; b=BVBeQEid/cDPuCOUsodzcufQiQZt9z9V+TLArNw7P1z2nn+z1Ef7vNcc8BViFjC7r3y44jEEWmyWy16oCqzxfsn4SLPpwZMz+4x71enwzTEn6SsvN0REB19nE3h2HVpT7R88pEIflR+YE+GhC1f/ynaxcKSV20Whz5amp1BGMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786331; c=relaxed/simple;
	bh=ncSucYV/w/JLpAM7hn7inq91zzc/LGEhdePSY/TJJ78=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KL1ySO1wxCAl3Vh1bYOM+W8Vd2FW0gJcJaAQJaQYgHl6QyELAuC1ZaXpm+gInjBfriuE9Py5WnRv0FuajsJDjBsZs4tAjavI20XqVp7wUD3kAyXLUIqq4TYH7Gku8m6/Ul/LPBpAKQOKDZFIziT/YDtjijHe5VAiP2gl6f1vi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OhApd2lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6960EC2BBFC;
	Wed, 19 Jun 2024 08:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786330;
	bh=ncSucYV/w/JLpAM7hn7inq91zzc/LGEhdePSY/TJJ78=;
	h=Subject:To:Cc:From:Date:From;
	b=OhApd2ljf4pkgWpX0n6dyjVfD6ZM40PLL/TgrvPGj/IOLIjsAqNBkef4G312v+1uy
	 raywA2QmyzcagKgfVR8SQeBHc0FmfVFAf+KzNhd78fvhHPDZMPeEupffeDNNh6fVpj
	 ekn1FpgQJFbq7Vbh+aAoR78o6hfEWQ/7GDXgLPxA=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Reset dGPU if suspend got aborted" failed to apply to 6.9-stable tree
To: lijo.lazar@amd.com,Hawking.Zhang@amd.com,alexander.deucher@amd.com,kevinyang.wang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:38:32 +0200
Message-ID: <2024061931-animator-sandbag-4be3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x df3c7dc5c58b1f85033d2cd9a121b27844700ca2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061931-animator-sandbag-4be3@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

df3c7dc5c58b ("drm/amdgpu: Reset dGPU if suspend got aborted")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df3c7dc5c58b1f85033d2cd9a121b27844700ca2 Mon Sep 17 00:00:00 2001
From: Lijo Lazar <lijo.lazar@amd.com>
Date: Wed, 14 Feb 2024 17:55:54 +0530
Subject: [PATCH] drm/amdgpu: Reset dGPU if suspend got aborted

For SOC21 ASICs, there is an issue in re-enabling PM features if a
suspend got aborted. In such cases, reset the device during resume
phase. This is a workaround till a proper solution is finalized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 8526282f4da1..abe319b0f063 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -867,10 +867,35 @@ static int soc21_common_suspend(void *handle)
 	return soc21_common_hw_fini(adev);
 }
 
+static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg1, sol_reg2;
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset dGPU side.
+	 * 2) S3 suspend got aborted and TOS is active.
+	 */
+	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
+	    !adev->suspend_complete) {
+		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+		msleep(100);
+		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+		return (sol_reg1 != sol_reg2);
+	}
+
+	return false;
+}
+
 static int soc21_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (soc21_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend aborted, resetting...");
+		soc21_asic_reset(adev);
+	}
+
 	return soc21_common_hw_init(adev);
 }
 


