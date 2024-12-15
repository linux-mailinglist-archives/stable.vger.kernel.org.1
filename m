Return-Path: <stable+bounces-104238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019669F229E
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F9E18855D3
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDB42AB3;
	Sun, 15 Dec 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zgyhy/oS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEF7483
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734251658; cv=none; b=YZzvElgmJMVdkATv6Mxu4aTTCBTqPJhqEVnDy9sbs3aaD6QlJyBJaF/FaLshArhsmjqerAx4xy0xiKbpubO4N9bwtKb5tCTjHgvWyzgI0i3YguIr1J8BNhNJZ2PAJZGyK9sfjA6IlRBUQdzIuCOH9XMFDzeXzBOQUgJ0SNBzD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734251658; c=relaxed/simple;
	bh=ETF5knKiFQl9+hCWH0RTpzw9q4jZ532x5E5gBgh434U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HCJlpwTFECVkWw/g7L2MRAt1m/05Xo6r5jUl1E2jpjTxt2jMpSkKt1JC5i0WQqRzRn4J1gDbYCVJ3/PoXkdDSfAbU7hyfjWS+pWT3kBvBjVtTiSt0IK7w9R6Bf3nw3ywzI3ERKMKMfU3QpT83p3C83RQEHb9DyfcohTxyniubKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zgyhy/oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1E0C4CECE;
	Sun, 15 Dec 2024 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734251658;
	bh=ETF5knKiFQl9+hCWH0RTpzw9q4jZ532x5E5gBgh434U=;
	h=Subject:To:Cc:From:Date:From;
	b=Zgyhy/oSqTJjGXkn741tUuboygDcapAUe7fwJuemtiCG09rpXay8H+9Jl/zpJEnJJ
	 nETIG5/kPKzK6bWHHe2mnI8mBHTC7utj6HiwdqJ1Qjr9cjO9gXXhAsjqUsbEUXKin1
	 zEuzwLzcmPYRs2tTlF7p7lRDXiNeZ1FiPaW61Wgg=
Subject: FAILED: patch "[PATCH] drm/amd/pm: Initialize power profile mode" failed to apply to 6.12-stable tree
To: lijo.lazar@amd.com,alexander.deucher@amd.com,kevinyang.wang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:34:15 +0100
Message-ID: <2024121515-quickstep-reapprove-b82d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8eb966f2403abb844e972fb4eb1348640111f121
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121515-quickstep-reapprove-b82d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8eb966f2403abb844e972fb4eb1348640111f121 Mon Sep 17 00:00:00 2001
From: Lijo Lazar <lijo.lazar@amd.com>
Date: Wed, 4 Dec 2024 13:11:28 +0530
Subject: [PATCH] drm/amd/pm: Initialize power profile mode

Refactor such that individual SMU IP versions can choose the startup
power profile mode. If no preference, then use the generic default power
profile selection logic.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.11.x

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 67a5de573943..d7acdd42d80f 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -164,6 +164,7 @@ enum amd_pp_task {
 };
 
 enum PP_SMC_POWER_PROFILE {
+	PP_SMC_POWER_PROFILE_UNKNOWN = -1,
 	PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT = 0x0,
 	PP_SMC_POWER_PROFILE_FULLSCREEN3D = 0x1,
 	PP_SMC_POWER_PROFILE_POWERSAVING  = 0x2,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5eae14fe79f1..21bd635bcdfc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -764,6 +764,7 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	smu->smu_baco.platform_support = false;
 	smu->smu_baco.maco_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
+	smu->power_profile_mode = PP_SMC_POWER_PROFILE_UNKNOWN;
 
 	mutex_init(&smu->message_lock);
 
@@ -1248,6 +1249,21 @@ static bool smu_is_workload_profile_available(struct smu_context *smu,
 	return smu->workload_map && smu->workload_map[profile].valid_mapping;
 }
 
+static void smu_init_power_profile(struct smu_context *smu)
+{
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_UNKNOWN) {
+		if (smu->is_apu ||
+		    !smu_is_workload_profile_available(
+			    smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
+			smu->power_profile_mode =
+				PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		else
+			smu->power_profile_mode =
+				PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	}
+	smu_power_profile_mode_get(smu, smu->power_profile_mode);
+}
+
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1269,13 +1285,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	else
-		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	smu_power_profile_mode_get(smu, smu->power_profile_mode);
-
+	smu_init_power_profile(smu);
 	smu->display_config = &adev->pm.pm_display_cfg;
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;


