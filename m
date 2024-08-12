Return-Path: <stable+bounces-66556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ABC94F020
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5971BB251D3
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C7E186E36;
	Mon, 12 Aug 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0POMXnir"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451CB186E33
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473951; cv=none; b=YAWSE2g89WUf1DBOy4hEbZE1JcASlR/+e66VotbuaQBt++7WnD6lMLKfSuwSyy+vJCJ3uKmaqiuFtjInGbPlyluYysMHGiKo4CIWlXafsa4sD7bouNO/S1DrTQspSgMd+4ey8g/hfQefNtNTo5+vFmJ/Nqpn6c/LovLDzpgjxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473951; c=relaxed/simple;
	bh=kgXD+Pq8OdRJ93FwH2yCgjte9trxUnd7zaoJhHX2cEM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=av7TCT4KP4KjMZuAx00i8If03GlRbK4tzr22ea7jc0gJmxVoRBX1XMPlRCAxXlGcCEZ+mtxtkKXStFH28bG7vDVyz9b+OxvQXe9s+1Ec9dED0ElUfrGXsms7O547lBRUxM/MUJo05gekQDTJHc/tabCgAPph5HMsPvNcdKVqZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0POMXnir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BFBC32782;
	Mon, 12 Aug 2024 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473950;
	bh=kgXD+Pq8OdRJ93FwH2yCgjte9trxUnd7zaoJhHX2cEM=;
	h=Subject:To:Cc:From:Date:From;
	b=0POMXnirjL2LxXClndTPSIXDiuPnyMo9Yn3NGBvvk2xjL8WlRqsrOVawMLZIKebeD
	 V1TRzJuiObSQtD5Fa0EZR8Q77Qm4X/L2Jp5zncsszblV2uUYL9vCG5Z/LHHMGvX4Kc
	 +E3ISOB7bd4sHvhTU8dxNoJxDp5LY4chctFuw+Es=
Subject: FAILED: patch "[PATCH] drm/amd: Fix shutdown (again) on some SMU v13.0.4/11" failed to apply to 6.10-stable tree
To: mario.limonciello@amd.com,Tim.Huang@amd.com,alexander.deucher@amd.com,electrodexsnet@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:45:47 +0200
Message-ID: <2024081247-smolder-deputize-5350@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x ff4e49f446ed24772182c724e0ef1a5be23c622a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081247-smolder-deputize-5350@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

ff4e49f446ed ("drm/amd: Fix shutdown (again) on some SMU v13.0.4/11 platforms")
b911505e6ba4 ("dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users")

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


