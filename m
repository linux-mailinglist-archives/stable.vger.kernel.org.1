Return-Path: <stable+bounces-66557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46B294F01F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B761C21F9D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCF7186E32;
	Mon, 12 Aug 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k/DPUUzo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24694B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473959; cv=none; b=BQMSHx+0Lo8YCW5g3AuKEWWy+mFu1E49Lx906JrL3tVsoqS07RnbhiMkAt0z/3s+GyYqSjlQ7mwHmLWrFSnP8PQs4UEzNZ/hCnEN7grgXGajTJhpXTph84TJWxgMEc4N9lZVLdQQ0SQ+YzhaKTiwZ7MmHNUu+7HECfynMDmiyfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473959; c=relaxed/simple;
	bh=YqkSl0nLeNab0x6YY4DwHXf18XMyNgJ/WbwJJlVaqgw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yw7Nml5/eUo4U2E6GrFvpHeqrZlKOGyLeAkvMl7jyp4OcNWprIuGUnvgWS64tORXTraG43Yd7zES6q0caX4hJZuU8f/j1AR2R8jIpD6G2UbRe7U5Ay8Pmi2S2pBvdnlistYLpIVYVT/8FYUTa6ApxP8FoNx6AVE4FyKO9tJvUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k/DPUUzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF67C32782;
	Mon, 12 Aug 2024 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473959;
	bh=YqkSl0nLeNab0x6YY4DwHXf18XMyNgJ/WbwJJlVaqgw=;
	h=Subject:To:Cc:From:Date:From;
	b=k/DPUUzo6/d6jhpup9BMz9RW3smh6aOyNVC+FZlCoHtuzEbkv2+5HS+VwlJDGttNX
	 VxQp4np4KFMCz6qNuxgsp8SEb9jYIWJ3MpyBuBtpTEgkjD5qV7My9bXcVEqgkYVbvY
	 FH56QjTqWlv7Tma0cCqRi3sY35IveHIb1hmNEdBc=
Subject: FAILED: patch "[PATCH] drm/amd: Fix shutdown (again) on some SMU v13.0.4/11" failed to apply to 6.6-stable tree
To: mario.limonciello@amd.com,Tim.Huang@amd.com,alexander.deucher@amd.com,electrodexsnet@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:45:48 +0200
Message-ID: <2024081248-evident-fever-c73b@gregkh>
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
git cherry-pick -x ff4e49f446ed24772182c724e0ef1a5be23c622a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081248-evident-fever-c73b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


