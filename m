Return-Path: <stable+bounces-53745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F790E5FB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8841F24904
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1A7FBDA;
	Wed, 19 Jun 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d9PPk3iK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279FC7B3EB
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786328; cv=none; b=UAHhTMWkI2ztBBixQhReEm0JGz/0YxicqjYGYRz38rR6c/qkx8J6Gu0nILg51Ev6aX5+bPSuzimd0L+nq3U1nv5AKFhKFrw6OXjaSfsiUHY3hcDAvJC6ME9PqB7pZivs09QvavB8exmcy6FuY43w5C924RtgL88/mwZW2ER1Wrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786328; c=relaxed/simple;
	bh=iwyeILm+y9Ef1YHWoXtOx9Wq5SIvdgcXeHB24kwdal4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L2jGmKHzYBKe7A3osHS2Z5pyoE3F/98zM4lvxoEpFPJXy3KFcmY3iJF3oqw2AY66yMHC2yXwT0kwTHc06VZXCPa5A2n05ASXdzDbD9VobUYnYoDEcgVC8qxETT9B87jTMK0klrjFkdqcLxO4RjQhrWa4pIroQrLl2wFp4i203Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d9PPk3iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71166C2BBFC;
	Wed, 19 Jun 2024 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786327;
	bh=iwyeILm+y9Ef1YHWoXtOx9Wq5SIvdgcXeHB24kwdal4=;
	h=Subject:To:Cc:From:Date:From;
	b=d9PPk3iKA0uksvj7LIJ91lnipfRqZEziBWtb/IjRzM7qjgHqHwyOH5l/GH9Pa03dL
	 IGmKPVQuTwzcsSgc6cDB1D+3dnCuFDKcu/T2+odUwBM8YVM+iXZNtL1/5/+gZVEFJG
	 6xeA0rSIwFYL9DfHpmdzJVSYOQfhI27GOxPQHUXs=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Reset dGPU if suspend got aborted" failed to apply to 6.6-stable tree
To: lijo.lazar@amd.com,Hawking.Zhang@amd.com,alexander.deucher@amd.com,kevinyang.wang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:38:32 +0200
Message-ID: <2024061932-pox-humid-9244@gregkh>
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
git cherry-pick -x df3c7dc5c58b1f85033d2cd9a121b27844700ca2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061932-pox-humid-9244@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


