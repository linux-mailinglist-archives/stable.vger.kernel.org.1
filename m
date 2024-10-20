Return-Path: <stable+bounces-86960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58119A5355
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 11:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170731C20BF2
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46E514A08D;
	Sun, 20 Oct 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v4T+eolM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7CB2942A
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416862; cv=none; b=AIBwquuemEX54aRUsoKtrtbZs7iRFCbkXKa15KFhDHcq6pE2hxd1zmpmmpMT4l7K91ZFQl+P+OlNDc84l9/Fq0m0gPK6/6QwmrogA9kGdttOVI7nzdTYaDf8qRCLlelHDYYwJruIWUMzkmdmqZggcNf9VeJyAGuzHRSep22d6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416862; c=relaxed/simple;
	bh=qyBc0WwKn7Zsvpj6YgGY2aD5tBtPg9Cg1hPNvdy9DHc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eN0DZIPc2+UTwkZ+oCf1XU/IjsEUt1vSUYV/R8FcSPnkrnZl7dvqtBHl8rtWtpMUE8b1dPnS8agK3ryHJR3hYSkL2Vzn2KaFTg8f/hFe/RujaWuhMSe2oJDN5zkP3BPnHJMEzdvjELYV6tX3TEzP/poyCDr1/gv0d3tEnOPVz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v4T+eolM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B887DC4CEC6;
	Sun, 20 Oct 2024 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729416862;
	bh=qyBc0WwKn7Zsvpj6YgGY2aD5tBtPg9Cg1hPNvdy9DHc=;
	h=Subject:To:Cc:From:Date:From;
	b=v4T+eolMj109xGzgUgf4gCOosAt1absGX4zBf4Kt94cAUE5tw3InNkAN4JJFOKSta
	 NejQ+CerdumkOtO6voQ/d2HWdtmujBt2epq40RklYJL4FV+KWtWw4kvbU8XnAz+onl
	 WGBAvv5fzsc2bWKc/Kg5kBPYkcxmSZSuz1+XCmws=
Subject: FAILED: patch "[PATCH] drm/amdgpu/smu13: always apply the powersave optimization" failed to apply to 6.6-stable tree
To: alexander.deucher@amd.com,kenneth.feng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Oct 2024 11:34:18 +0200
Message-ID: <2024102018-distrust-unworthy-142c@gregkh>
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
git cherry-pick -x 7a1613e47e65ba6967085ad99dee95420346a0ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102018-distrust-unworthy-142c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a1613e47e65ba6967085ad99dee95420346a0ce Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Thu, 3 Oct 2024 10:09:50 -0400
Subject: [PATCH] drm/amdgpu/smu13: always apply the powersave optimization

It can avoid margin issues in some very demanding applications.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3618
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3131
Fixes: c50fe289ed72 ("drm/amdgpu/swsmu: always force a state reprogram on init")
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 62f38b4ccaa6aa063ca781d80b10aacd39dc5c76)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1d024b122b0c..cb923e33fd6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2555,18 +2555,16 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	workload_mask = 1 << workload_type;
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE) {
-		if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
-			((smu->adev->pm.fw_version == 0x004e6601) ||
-			(smu->adev->pm.fw_version >= 0x004e7300))) ||
-			(amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
-			 smu->adev->pm.fw_version >= 0x00504500)) {
-			workload_type = smu_cmn_to_asic_specific_index(smu,
-								CMN2ASIC_MAPPING_WORKLOAD,
-								PP_SMC_POWER_PROFILE_POWERSAVING);
-			if (workload_type >= 0)
-				workload_mask |= 1 << workload_type;
-		}
+	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
+	     ((smu->adev->pm.fw_version == 0x004e6601) ||
+	      (smu->adev->pm.fw_version >= 0x004e7300))) ||
+	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
+	     smu->adev->pm.fw_version >= 0x00504500)) {
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       PP_SMC_POWER_PROFILE_POWERSAVING);
+		if (workload_type >= 0)
+			workload_mask |= 1 << workload_type;
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,


