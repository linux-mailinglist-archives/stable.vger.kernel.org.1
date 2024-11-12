Return-Path: <stable+bounces-92713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC46A9C55C5
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1781F23267
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693A219E2B;
	Tue, 12 Nov 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTRetUj2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79DC21314E;
	Tue, 12 Nov 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408347; cv=none; b=svJWtYZtXmiPTU6TRvaNSM2JXZzWzgjojpDO2K9NGqgsbNtd9ev1fufF+XtVKvDNfN4FXgMSeVF9tQBqGCvghfkRhtXQSPqoAcJBRZCvLNDEmzIB5Mjaoe1Qh/NGRit3PCxl/DGHNtH9dGtuST+qdqRMIAzNrJnrK+VxmmmpE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408347; c=relaxed/simple;
	bh=hLzR3sYufr6aR+eSzTrI/wbZNqhQKAfRXut+cWU/sAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eglaPFLwk79pB5fR7lHL4EvGyOWPuhuO/47gOT6BkfJ5ho7q12ji08F+CyeeVeUWsMDwm5pPWdv0pcL70GkCoPWnrICvoNS0+WpTZzH8XByLuHloCzTASIiDvTptD+7U9ar05YPTF0SZal8P+IxrHVuKUB+QM8vVPd3BSWd2acs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTRetUj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC5CC4CECD;
	Tue, 12 Nov 2024 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408347;
	bh=hLzR3sYufr6aR+eSzTrI/wbZNqhQKAfRXut+cWU/sAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTRetUj2OQ8yHCQ/H5PXSkFmJ+AqgV1PV2GROtt3/E01sp2ZfF9Sk7w/smpCzOsUN
	 9il8zveagJfsaYIBQSQg2UoXVvNYmsGyfoP4l/hqWgGoQARFk4J5jMeoKcLIL6CpRx
	 ubHyiB540gsDZWRapLemCOpySCsKOIiqF5eOB6kE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.11 103/184] drm/amd/pm: correct the workload setting
Date: Tue, 12 Nov 2024 11:21:01 +0100
Message-ID: <20241112101904.817198953@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kenneth Feng <kenneth.feng@amd.com>

commit 74e1006430a5377228e49310f6d915628609929e upstream.

Correct the workload setting in order not to mix the setting
with the end user. Update the workload mask accordingly.

v2: changes as below:
1. the end user can not erase the workload from driver except default workload.
2. always shows the real highest priority workoad to the end user.
3. the real workload mask is combined with driver workload mask and end user workload mask.

v3: apply this to the other ASICs as well.
v4: simplify the code
v5: refine the code based on the review comments.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8cc438be5d49b8326b2fcade0bdb7e6a97df9e0b)
Cc: stable@vger.kernel.org # 6.11.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               |   49 +++++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           |    4 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       |    5 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         |    5 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |    5 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        |    4 -
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c         |    4 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    |   20 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    |    5 -
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    |    9 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  |    8 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h                  |    2 
 12 files changed, 84 insertions(+), 36 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1259,26 +1259,33 @@ static int smu_sw_init(void *handle)
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	smu->user_dpm_profile.user_workload_mask = 0;
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
 	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
-	else
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
+		smu->driver_workload_mask =
+			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+	} else {
+		smu->driver_workload_mask =
+			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	}
 
+	smu->workload_mask = smu->driver_workload_mask |
+							smu->user_dpm_profile.user_workload_mask;
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
@@ -2348,17 +2355,20 @@ static int smu_switch_power_profile(void
 		return -EINVAL;
 
 	if (!en) {
-		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
+		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	} else {
-		smu->workload_mask |= (1 << smu->workload_prority[type]);
+		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	}
 
+	smu->workload_mask = smu->driver_workload_mask |
+						 smu->user_dpm_profile.user_workload_mask;
+
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
 		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, workload, 0);
@@ -3049,12 +3059,23 @@ static int smu_set_power_profile_mode(vo
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
+	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	return smu_bump_power_profile_mode(smu, param, param_size);
+	if (smu->user_dpm_profile.user_workload_mask &
+	   (1 << smu->workload_priority[param[param_size]]))
+	   return 0;
+
+	smu->user_dpm_profile.user_workload_mask =
+		(1 << smu->workload_priority[param[param_size]]);
+	smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
+		smu->driver_workload_mask;
+	ret = smu_bump_power_profile_mode(smu, param, param_size);
+
+	return ret;
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,6 +240,7 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
+	uint32_t user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -557,7 +558,8 @@ struct smu_context {
 	bool disable_uclk_switch;
 
 	uint32_t workload_mask;
-	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
+	uint32_t driver_workload_mask;
+	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
 	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
 	uint32_t power_profile_mode;
 	uint32_t default_power_profile_mode;
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1455,7 +1455,6 @@ static int arcturus_set_power_profile_mo
 		return -EINVAL;
 	}
 
-
 	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
 	     (smu->smc_fw_version >= 0x360d00)) {
 		if (size != 10)
@@ -1523,14 +1522,14 @@ static int arcturus_set_power_profile_mo
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetWorkloadMask,
-					  1 << workload_type,
+					  smu->workload_mask,
 					  NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	smu_cmn_assign_power_profile(smu);
 
 	return 0;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2081,10 +2081,13 @@ static int navi10_set_power_profile_mode
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+	else
+		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1786,10 +1786,13 @@ static int sienna_cichlid_set_power_prof
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+	else
+		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1079,7 +1079,7 @@ static int vangogh_set_power_profile_mod
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
+				    smu->workload_mask,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
@@ -1087,7 +1087,7 @@ static int vangogh_set_power_profile_mod
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	smu_cmn_assign_power_profile(smu);
 
 	return 0;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -890,14 +890,14 @@ static int renoir_set_power_profile_mode
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
+				    smu->workload_mask,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	smu_cmn_assign_power_profile(smu);
 
 	return 0;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2485,7 +2485,7 @@ static int smu_v13_0_0_set_power_profile
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-	u32 workload_mask, selected_workload_mask;
+	u32 workload_mask;
 
 	smu->power_profile_mode = input[size];
 
@@ -2552,7 +2552,7 @@ static int smu_v13_0_0_set_power_profile
 	if (workload_type < 0)
 		return -EINVAL;
 
-	selected_workload_mask = workload_mask = 1 << workload_type;
+	workload_mask = 1 << workload_type;
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2567,12 +2567,22 @@ static int smu_v13_0_0_set_power_profile
 			workload_mask |= 1 << workload_type;
 	}
 
+	smu->workload_mask |= workload_mask;
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       workload_mask,
+					       smu->workload_mask,
 					       NULL);
-	if (!ret)
-		smu->workload_mask = selected_workload_mask;
+	if (!ret) {
+		smu_cmn_assign_power_profile(smu);
+		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
+			workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
+			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
+										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
+										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		}
+	}
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2499,13 +2499,14 @@ static int smu_v13_0_7_set_power_profile
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 	else
-		smu->workload_mask = (1 << workload_type);
+		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1508,12 +1508,11 @@ static int smu_v14_0_2_set_power_profile
 	if (workload_type < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
-					       NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+										  smu->workload_mask, NULL);
+
 	if (!ret)
-		smu->workload_mask = 1 << workload_type;
+		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1138,6 +1138,14 @@ int smu_cmn_set_mp1_state(struct smu_con
 	return ret;
 }
 
+void smu_cmn_assign_power_profile(struct smu_context *smu)
+{
+	uint32_t index;
+	index = fls(smu->workload_mask);
+	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+	smu->power_profile_mode = smu->workload_setting[index];
+}
+
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 {
 	struct pci_dev *p = NULL;
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -130,6 +130,8 @@ void smu_cmn_init_soft_gpu_metrics(void
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
+void smu_cmn_assign_power_profile(struct smu_context *smu);
+
 /*
  * Helper function to make sysfs_emit_at() happy. Align buf to
  * the current page boundary and record the offset.



