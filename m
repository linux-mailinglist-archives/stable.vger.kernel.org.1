Return-Path: <stable+bounces-172159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053FDB2FD7F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A141CC2295
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71302E62C6;
	Thu, 21 Aug 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0ANv535"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CFF2E2F0E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787696; cv=none; b=MEyUrcMIKFvMw1vIca0N1Y/9rXrnXwMmHtHLPl9dgQDmQ8EqFyTmN3c40uIrpb6+4pcvT4VyYf2rwSdPL+Fp8h3d2bJKYxFBcTSgmfmq6NEkoF9SlOtAYuVK/5TqixbPzsfI21WlfH/bVL0C1+PtpcHRZA2v6rMAlrtMU40FORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787696; c=relaxed/simple;
	bh=w6XKZWbgAiduxUL99ZPJpZMkKKqBdFr7jBFV2dLq7d4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rik+4LHy2vWNwEUDRrefuwTOLE5kvVXyl+QaFCpP7m8WcfQScewr6Rgj7Yb95kmHfHHBzVz+hQLf90bCUmiezPkvoukFsiO6bkfD9dN66gvOa5cfeAIyjVHQTAXGh8XHIv8rGeaoLac7cS71CWXhGtrlDwUUpm98n7yRFiYojeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0ANv535; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BB4C4CEEB;
	Thu, 21 Aug 2025 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755787696;
	bh=w6XKZWbgAiduxUL99ZPJpZMkKKqBdFr7jBFV2dLq7d4=;
	h=Subject:To:Cc:From:Date:From;
	b=Q0ANv535kYXPE4zejqlN2XOkw0Q8iufydyydMl01r95Od1B61Oqs7k9hK0fo7AobV
	 E7jk4h/iW08Xp1txPiaO/1mfQpSeGMGWd6csaVe1Lk4bddJ6pCAgakAWTIAmMs5TE4
	 XZsZjvyDKvyYpL1o0HI0TCRQwLMraNeWUUQ9ol/E=
Subject: FAILED: patch "[PATCH] drm/amd: Restore cached manual clock settings during resume" failed to apply to 6.16-stable tree
To: mario.limonciello@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:46:08 +0200
Message-ID: <2025082108-oil-trailing-aa0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 796ff8a7e01bd18738d3bb4111f9d6f963145d29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082108-oil-trailing-aa0d@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 796ff8a7e01bd18738d3bb4111f9d6f963145d29 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 24 Jul 2025 22:12:22 -0500
Subject: [PATCH] drm/amd: Restore cached manual clock settings during resume

If the SCLK limits have been set before S3 they will not
be restored. The limits are however cached in the driver and so
they can be restored by running a commit sequence during resume.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://lore.kernel.org/r/20250725031222.3015095-3-superm1@kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4e9526924d09057a9ba854305e17eded900ced82)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 310f51ff05b9..b47cb4a5f488 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -77,6 +77,9 @@ static void smu_power_profile_mode_get(struct smu_context *smu,
 static void smu_power_profile_mode_put(struct smu_context *smu,
 				       enum PP_SMC_POWER_PROFILE profile_mode);
 static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type);
+static int smu_od_edit_dpm_table(void *handle,
+				 enum PP_OD_DPM_TABLE_COMMAND type,
+				 long *input, uint32_t size);
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -2195,6 +2198,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
@@ -2232,6 +2236,12 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 			return ret;
 	}
 
+	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
+		ret = smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE, NULL, 0);
+		if (ret)
+			return ret;
+	}
+
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;


