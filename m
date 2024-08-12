Return-Path: <stable+bounces-66558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB594F022
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524A3B2213D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06B4186E38;
	Mon, 12 Aug 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l97SYN3C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172F183094
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473963; cv=none; b=aES84k4L7NVbbcNVSGql7Z7Dqc3a/SvkAgLe6OUxoF5hw8AuE1w8a/MvNPnFu7a0kBS7KZmqEvCgH+TdHLSbss4kap7zfYAUsiyjYUZy2wAyYCZr2GAzBZqCgNYmXzPIVMXuCwm1oxG8aMbVHwqNCHqqkyK+GF4sKRH3QLKbmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473963; c=relaxed/simple;
	bh=vYr5jYE87WzgQzajw+8ZkJGFO2/HM1RD57dhHJLjksU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lM5qiFrqkb+yzgRv/deEJan8h1iXdQG3uGNhCFQIAkgIEUOEgVHZ/aNkm8tNtHtB3vHO4w+TOkH1SrT9IuMiImNIfGnGRL0DHoreqzK0HSoDUXWsh0vR08YOPUJX7BnWYJCbaY0ZFmrvctJkO3q1cFnoOzDJheWKlk0GX0jNrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l97SYN3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85422C32782;
	Mon, 12 Aug 2024 14:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473962;
	bh=vYr5jYE87WzgQzajw+8ZkJGFO2/HM1RD57dhHJLjksU=;
	h=Subject:To:Cc:From:Date:From;
	b=l97SYN3CUE6kGGmfna43MQddeOOBnKXuQyXGmVvqE6E4LVfSCuGWL0XAQBlKBClUD
	 vQXqKdXiIu1YoqHxF6gAH+A6+NLTkm+kG/W/f3Obet5UaaQ889xR9tbLAgYzz41CTh
	 m76vndlzAMAfdTkHQzi29Ut27qsldYVruBEmfTpo=
Subject: FAILED: patch "[PATCH] drm/amd: Fix shutdown (again) on some SMU v13.0.4/11" failed to apply to 6.1-stable tree
To: mario.limonciello@amd.com,Tim.Huang@amd.com,alexander.deucher@amd.com,electrodexsnet@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:45:49 +0200
Message-ID: <2024081249-derail-recovery-86ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ff4e49f446ed24772182c724e0ef1a5be23c622a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081249-derail-recovery-86ca@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

ff4e49f446ed ("drm/amd: Fix shutdown (again) on some SMU v13.0.4/11 platforms")
b911505e6ba4 ("dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users")
fedb6ae49758 ("drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ff4e49f446ed24772182c724e0ef1a5be23c622a Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Sun, 26 May 2024 07:59:08 -0500
Subject: [PATCH] drm/amd: Fix shutdown (again) on some SMU v13.0.4/11
 platforms

commit cd94d1b182d2 ("dm/amd/pm: Fix problems with reboot/shutdown for
some SMU 13.0.4/13.0.11 users") attempted to fix shutdown issues
that were reported since commit 31729e8c21ec ("drm/amd/pm: fixes a
random hang in S4 for SMU v13.0.4/11") but caused issues for some
people.

Adjust the workaround flow to properly only apply in the S4 case:
-> For shutdown go through SMU_MSG_PrepareMp1ForUnload
-> For S4 go through SMU_MSG_GfxDeviceDriverReset and
   SMU_MSG_PrepareMp1ForUnload

Reported-and-tested-by: lectrode <electrodexsnet@gmail.com>
Closes: https://github.com/void-linux/void-packages/issues/50417
Cc: stable@vger.kernel.org
Fixes: cd94d1b182d2 ("dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users")
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index dfc76f6b468f..b081ae3e8f43 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -226,15 +226,17 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && adev->in_s4) {
-		/* Adds a GFX reset as workaround just before sending the
-		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
-		 * an invalid state.
-		 */
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-						      SMU_RESET_MODE_2, NULL);
-		if (ret)
-			return ret;
+	if (!en && !adev->in_s0ix) {
+		if (adev->in_s4) {
+			/* Adds a GFX reset as workaround just before sending the
+			 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
+			 * an invalid state.
+			 */
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
+							      SMU_RESET_MODE_2, NULL);
+			if (ret)
+				return ret;
+		}
 
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
 	}


