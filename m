Return-Path: <stable+bounces-101094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE2B9EEA9E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2175918818B6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967DB216E3B;
	Thu, 12 Dec 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q/2/F2yp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C4721639F;
	Thu, 12 Dec 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016338; cv=none; b=Fs0e/otTYuxgVZyzvKk0Lj8acsJCOuApAe1UQuph9C4P3CCysfLlbRSR04t5tJMQWkPB4K757e9rxQQ0xJlZzm20rcA9rPxfsoWoWfXLMfogEK4ooVBikBEm/FGZUtSnomT+cmdU4E8AhuMrQU9A+0miXlQB+WIXKtnqjM2yLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016338; c=relaxed/simple;
	bh=yIHf5OuNhoQOn0t8wnuaD+G2x25U6uziwFAOr/CxPzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vu45Z2/I/RXWBsFLQs9ROB4v+/cms/l/cvDQ+5sgyVzgOLrxd+e0BToZpEUL4zMv7LMuu5BaTycXdgC6nJ+igHUl5bpRityzI0HEu2d/eVEZ9Jiky0d6dda7o2OvUc41OpMXKcfBXeTNj5LDfZKTk6ESMsUol+gXgD6xMeFEnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q/2/F2yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B901C4CECE;
	Thu, 12 Dec 2024 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016338;
	bh=yIHf5OuNhoQOn0t8wnuaD+G2x25U6uziwFAOr/CxPzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/2/F2ypr6piW5nCMHvAboGFFU6jqwaVOm6t6hR5TvYdUlIlNz9xqy6I7VgKZg6pc
	 si7YDk5IWn353u1fKYlZvGqgn7ofhT3upKJEyDnj7l7yw1mSPh5bwB56BO+oTR8ubS
	 0tY/OUAabwER1OQUwd+p2QvmXUAQvZPiCdBu2E0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 6.12 171/466] drm/amd/pm: fix and simplify workload handling
Date: Thu, 12 Dec 2024 15:55:40 +0100
Message-ID: <20241212144313.556403153@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 1443dd3c67f6d1a8bd1f810e598e2f0c6f19205c upstream.

smu->workload_mask is IP specific and should not be messed with in
the common code. The mask bits vary across SMU versions.

Move all handling of smu->workload_mask in to the backends and
simplify the code.  Store the user's preference in smu->power_profile_mode
which will be reflected in sysfs.  For internal driver profile
switches for KFD or VCN, just update the workload mask so that the
user's preference is retained.  Remove all of the extra now unused
workload related elements in the smu structure.

v2: use refcounts for workload profiles
v3: rework based on feedback from Lijo
v4: fix the refcount on failure, drop backend mask
v5: rework custom handling
v6: handle failure cleanup with custom profile
v7: Update documentation

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: stable@vger.kernel.org # 6.11.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                      |    6 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               |  148 ++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           |   15 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       |  166 ++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         |  167 +++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |  168 +++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        |   41 +--
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c         |   43 +--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    |  167 ++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    |  138 +++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    |  176 +++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  |   25 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h                  |    4 
 13 files changed, 744 insertions(+), 520 deletions(-)

--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1409,7 +1409,11 @@ static ssize_t amdgpu_set_pp_mclk_od(str
  * create a custom set of heuristics, write a string of numbers to the file
  * starting with the number of the custom profile along with a setting
  * for each heuristic parameter.  Due to differences across asic families
- * the heuristic parameters vary from family to family.
+ * the heuristic parameters vary from family to family. Additionally,
+ * you can apply the custom heuristics to different clock domains.  Each
+ * clock domain is considered a distinct operation so if you modify the
+ * gfxclk heuristics and then the memclk heuristics, the all of the
+ * custom heuristics will be retained until you switch to another profile.
  *
  */
 
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -72,6 +72,10 @@ static int smu_set_power_limit(void *han
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
+static void smu_power_profile_mode_get(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode);
+static void smu_power_profile_mode_put(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode);
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -1257,35 +1261,19 @@ static int smu_sw_init(void *handle)
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
-	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
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
-
 	if (smu->is_apu ||
 	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	else
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	smu_power_profile_mode_get(smu, smu->power_profile_mode);
 
-	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
-	smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
-	smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
-	smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
-	smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
 	smu->display_config = &adev->pm.pm_display_cfg;
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
@@ -1338,6 +1326,11 @@ static int smu_sw_fini(void *handle)
 		return ret;
 	}
 
+	if (smu->custom_profile_params) {
+		kfree(smu->custom_profile_params);
+		smu->custom_profile_params = NULL;
+	}
+
 	smu_fini_microcode(smu);
 
 	return 0;
@@ -2117,6 +2110,9 @@ static int smu_suspend(void *handle)
 	if (!ret)
 		adev->gfx.gfx_off_entrycount = count;
 
+	/* clear this on suspend so it will get reprogrammed on resume */
+	smu->workload_mask = 0;
+
 	return 0;
 }
 
@@ -2229,25 +2225,49 @@ static int smu_enable_umd_pstate(void *h
 }
 
 static int smu_bump_power_profile_mode(struct smu_context *smu,
-					   long *param,
-					   uint32_t param_size)
+				       long *custom_params,
+				       u32 custom_params_max_idx)
 {
-	int ret = 0;
+	u32 workload_mask = 0;
+	int i, ret = 0;
+
+	for (i = 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
+		if (smu->workload_refcount[i])
+			workload_mask |= 1 << i;
+	}
+
+	if (smu->workload_mask == workload_mask)
+		return 0;
 
 	if (smu->ppt_funcs->set_power_profile_mode)
-		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
+		ret = smu->ppt_funcs->set_power_profile_mode(smu, workload_mask,
+							     custom_params,
+							     custom_params_max_idx);
+
+	if (!ret)
+		smu->workload_mask = workload_mask;
 
 	return ret;
 }
 
+static void smu_power_profile_mode_get(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode)
+{
+	smu->workload_refcount[profile_mode]++;
+}
+
+static void smu_power_profile_mode_put(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode)
+{
+	if (smu->workload_refcount[profile_mode])
+		smu->workload_refcount[profile_mode]--;
+}
+
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
-					  bool skip_display_settings,
-					  bool init)
+					  bool skip_display_settings)
 {
 	int ret = 0;
-	int index = 0;
-	long workload[1];
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (!skip_display_settings) {
@@ -2284,14 +2304,8 @@ static int smu_adjust_power_state_dynami
 	}
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
-		index = fls(smu->workload_mask);
-		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-
-		if (init || smu->power_profile_mode != workload[0])
-			smu_bump_power_profile_mode(smu, workload, 0);
-	}
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+		smu_bump_power_profile_mode(smu, NULL, 0);
 
 	return ret;
 }
@@ -2310,13 +2324,13 @@ static int smu_handle_task(struct smu_co
 		ret = smu_pre_display_config_changed(smu);
 		if (ret)
 			return ret;
-		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
-		ret = smu_adjust_power_state_dynamic(smu, level, true, true);
+		ret = smu_adjust_power_state_dynamic(smu, level, true);
 		break;
 	case AMD_PP_TASK_READJUST_POWER_STATE:
-		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, true);
 		break;
 	default:
 		break;
@@ -2338,12 +2352,11 @@ static int smu_handle_dpm_task(void *han
 
 static int smu_switch_power_profile(void *handle,
 				    enum PP_SMC_POWER_PROFILE type,
-				    bool en)
+				    bool enable)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	long workload[1];
-	uint32_t index;
+	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -2351,21 +2364,21 @@ static int smu_switch_power_profile(void
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
 
-	if (!en) {
-		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
-		index = fls(smu->workload_mask);
-		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	} else {
-		smu->workload_mask |= (1 << smu->workload_prority[type]);
-		index = fls(smu->workload_mask);
-		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	}
-
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-		smu_bump_power_profile_mode(smu, workload, 0);
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+		if (enable)
+			smu_power_profile_mode_get(smu, type);
+		else
+			smu_power_profile_mode_put(smu, type);
+		ret = smu_bump_power_profile_mode(smu, NULL, 0);
+		if (ret) {
+			if (enable)
+				smu_power_profile_mode_put(smu, type);
+			else
+				smu_power_profile_mode_get(smu, type);
+			return ret;
+		}
+	}
 
 	return 0;
 }
@@ -3053,12 +3066,35 @@ static int smu_set_power_profile_mode(vo
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
+	bool custom = false;
+	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	return smu_bump_power_profile_mode(smu, param, param_size);
+	if (param[param_size] == PP_SMC_POWER_PROFILE_CUSTOM) {
+		custom = true;
+		/* clear frontend mask so custom changes propogate */
+		smu->workload_mask = 0;
+	}
+
+	if ((param[param_size] != smu->power_profile_mode) || custom) {
+		/* clear the old user preference */
+		smu_power_profile_mode_put(smu, smu->power_profile_mode);
+		/* set the new user preference */
+		smu_power_profile_mode_get(smu, param[param_size]);
+		ret = smu_bump_power_profile_mode(smu,
+						  custom ? param : NULL,
+						  custom ? param_size : 0);
+		if (ret)
+			smu_power_profile_mode_put(smu, param[param_size]);
+		else
+			/* store the user's preference */
+			smu->power_profile_mode = param[param_size];
+	}
+
+	return ret;
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -556,11 +556,13 @@ struct smu_context {
 	uint32_t hard_min_uclk_req_from_dal;
 	bool disable_uclk_switch;
 
+	/* asic agnostic workload mask */
 	uint32_t workload_mask;
-	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
-	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
+	/* default/user workload preference */
 	uint32_t power_profile_mode;
-	uint32_t default_power_profile_mode;
+	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
+	/* backend specific custom workload settings */
+	long *custom_profile_params;
 	bool pm_enabled;
 	bool is_apu;
 
@@ -731,9 +733,12 @@ struct pptable_funcs {
 	 * @set_power_profile_mode: Set a power profile mode. Also used to
 	 *                          create/set custom power profile modes.
 	 * &input: Power profile mode parameters.
-	 * &size: Size of &input.
+	 * &workload_mask: mask of workloads to enable
+	 * &custom_params: custom profile parameters
+	 * &custom_params_max_idx: max valid idx into custom_params
 	 */
-	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
+	int (*set_power_profile_mode)(struct smu_context *smu, u32 workload_mask,
+				      long *custom_params, u32 custom_params_max_idx);
 
 	/**
 	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1445,98 +1445,120 @@ static int arcturus_get_power_profile_mo
 	return size;
 }
 
-static int arcturus_set_power_profile_mode(struct smu_context *smu,
-					   long *input,
-					   uint32_t size)
+#define ARCTURUS_CUSTOM_PARAMS_COUNT 10
+#define ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT 2
+#define ARCTURUS_CUSTOM_PARAMS_SIZE (ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT * ARCTURUS_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int arcturus_set_power_profile_mode_coeff(struct smu_context *smu,
+						 long *input)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
-	int workload_type = 0;
-	uint32_t profile_mode = input[size];
-	int ret = 0;
+	int ret, idx;
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
-		return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
 	}
 
+	idx = 0 * ARCTURUS_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor.Gfx_FPS = input[idx + 1];
+		activity_monitor.Gfx_UseRlcBusy = input[idx + 2];
+		activity_monitor.Gfx_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Gfx_MinActiveFreq = input[idx + 4];
+		activity_monitor.Gfx_BoosterFreqType = input[idx + 5];
+		activity_monitor.Gfx_BoosterFreq = input[idx + 6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 1 * ARCTURUS_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Uclk */
+		activity_monitor.Mem_FPS = input[idx + 1];
+		activity_monitor.Mem_UseRlcBusy = input[idx + 2];
+		activity_monitor.Mem_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Mem_MinActiveFreq = input[idx + 4];
+		activity_monitor.Mem_BoosterFreqType = input[idx + 5];
+		activity_monitor.Mem_BoosterFreq = input[idx + 6];
+		activity_monitor.Mem_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[idx + 9];
+	}
 
-	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
-	     (smu->smc_fw_version >= 0x360d00)) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-				       WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor),
-				       false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
+
+static int arcturus_set_power_profile_mode(struct smu_context *smu,
+					   u32 workload_mask,
+					   long *custom_params,
+					   u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
+
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor.Gfx_FPS = input[1];
-			activity_monitor.Gfx_UseRlcBusy = input[2];
-			activity_monitor.Gfx_MinActiveFreqType = input[3];
-			activity_monitor.Gfx_MinActiveFreq = input[4];
-			activity_monitor.Gfx_BoosterFreqType = input[5];
-			activity_monitor.Gfx_BoosterFreq = input[6];
-			activity_monitor.Gfx_PD_Data_limit_c = input[7];
-			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Uclk */
-			activity_monitor.Mem_FPS = input[1];
-			activity_monitor.Mem_UseRlcBusy = input[2];
-			activity_monitor.Mem_MinActiveFreqType = input[3];
-			activity_monitor.Mem_MinActiveFreq = input[4];
-			activity_monitor.Mem_BoosterFreqType = input[5];
-			activity_monitor.Mem_BoosterFreq = input[6];
-			activity_monitor.Mem_PD_Data_limit_c = input[7];
-			activity_monitor.Mem_PD_Data_error_coeff = input[8];
-			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (smu->smc_fw_version < 0x360d00)
 			return -EINVAL;
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(ARCTURUS_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
 		}
-
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-				       WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor),
-				       true);
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != ARCTURUS_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * ARCTURUS_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = arcturus_set_power_profile_mode_coeff(smu,
+							    smu->custom_profile_params);
 		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
 			return ret;
 		}
-	}
-
-	/*
-	 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
-	 * Not all profile modes are supported on arcturus.
-	 */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
-		return -EINVAL;
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, ARCTURUS_CUSTOM_PARAMS_SIZE);
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetWorkloadMask,
-					  1 << workload_type,
-					  NULL);
+					      SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
+	return ret;
 }
 
 static int arcturus_set_performance_level(struct smu_context *smu,
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2004,87 +2004,122 @@ static int navi10_get_power_profile_mode
 	return size;
 }
 
-static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+#define NAVI10_CUSTOM_PARAMS_COUNT 10
+#define NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT 3
+#define NAVI10_CUSTOM_PARAMS_SIZE (NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT * NAVI10_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int navi10_set_power_profile_mode_coeff(struct smu_context *smu,
+					       long *input)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
-	int workload_type, ret = 0;
+	int ret, idx;
 
-	smu->power_profile_mode = input[size];
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
+	idx = 0 * NAVI10_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor.Gfx_FPS = input[idx + 1];
+		activity_monitor.Gfx_MinFreqStep = input[idx + 2];
+		activity_monitor.Gfx_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Gfx_MinActiveFreq = input[idx + 4];
+		activity_monitor.Gfx_BoosterFreqType = input[idx + 5];
+		activity_monitor.Gfx_BoosterFreq = input[idx + 6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 1 * NAVI10_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Socclk */
+		activity_monitor.Soc_FPS = input[idx + 1];
+		activity_monitor.Soc_MinFreqStep = input[idx + 2];
+		activity_monitor.Soc_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Soc_MinActiveFreq = input[idx + 4];
+		activity_monitor.Soc_BoosterFreqType = input[idx + 5];
+		activity_monitor.Soc_BoosterFreq = input[idx + 6];
+		activity_monitor.Soc_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Soc_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Soc_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 2 * NAVI10_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Memclk */
+		activity_monitor.Mem_FPS = input[idx + 1];
+		activity_monitor.Mem_MinFreqStep = input[idx + 2];
+		activity_monitor.Mem_MinActiveFreqType = input[idx + 3];
+		activity_monitor.Mem_MinActiveFreq = input[idx + 4];
+		activity_monitor.Mem_BoosterFreqType = input[idx + 5];
+		activity_monitor.Mem_BoosterFreq = input[idx + 6];
+		activity_monitor.Mem_PD_Data_limit_c = input[idx + 7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[idx + 9];
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor.Gfx_FPS = input[1];
-			activity_monitor.Gfx_MinFreqStep = input[2];
-			activity_monitor.Gfx_MinActiveFreqType = input[3];
-			activity_monitor.Gfx_MinActiveFreq = input[4];
-			activity_monitor.Gfx_BoosterFreqType = input[5];
-			activity_monitor.Gfx_BoosterFreq = input[6];
-			activity_monitor.Gfx_PD_Data_limit_c = input[7];
-			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Socclk */
-			activity_monitor.Soc_FPS = input[1];
-			activity_monitor.Soc_MinFreqStep = input[2];
-			activity_monitor.Soc_MinActiveFreqType = input[3];
-			activity_monitor.Soc_MinActiveFreq = input[4];
-			activity_monitor.Soc_BoosterFreqType = input[5];
-			activity_monitor.Soc_BoosterFreq = input[6];
-			activity_monitor.Soc_PD_Data_limit_c = input[7];
-			activity_monitor.Soc_PD_Data_error_coeff = input[8];
-			activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 2: /* Memclk */
-			activity_monitor.Mem_FPS = input[1];
-			activity_monitor.Mem_MinFreqStep = input[2];
-			activity_monitor.Mem_MinActiveFreqType = input[3];
-			activity_monitor.Mem_MinActiveFreq = input[4];
-			activity_monitor.Mem_BoosterFreqType = input[5];
-			activity_monitor.Mem_BoosterFreq = input[6];
-			activity_monitor.Mem_PD_Data_limit_c = input[7];
-			activity_monitor.Mem_PD_Data_error_coeff = input[8];
-			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int navi10_set_power_profile_mode(struct smu_context *smu,
+					 u32 workload_mask,
+					 long *custom_params,
+					 u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), true);
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
+
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params = kzalloc(NAVI10_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
+		}
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != NAVI10_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * NAVI10_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = navi10_set_power_profile_mode_coeff(smu,
+							  smu->custom_profile_params);
 		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
 			return ret;
 		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, NAVI10_CUSTOM_PARAMS_SIZE);
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1706,90 +1706,126 @@ static int sienna_cichlid_get_power_prof
 	return size;
 }
 
-static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+#define SIENNA_CICHLID_CUSTOM_PARAMS_COUNT 10
+#define SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT 3
+#define SIENNA_CICHLID_CUSTOM_PARAMS_SIZE (SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_context *smu,
+						       long *input)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
+	int ret, idx;
 
-	smu->power_profile_mode = input[size];
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
+	idx = 0 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor->Gfx_FPS = input[idx + 1];
+		activity_monitor->Gfx_MinFreqStep = input[idx + 2];
+		activity_monitor->Gfx_MinActiveFreqType = input[idx + 3];
+		activity_monitor->Gfx_MinActiveFreq = input[idx + 4];
+		activity_monitor->Gfx_BoosterFreqType = input[idx + 5];
+		activity_monitor->Gfx_BoosterFreq = input[idx + 6];
+		activity_monitor->Gfx_PD_Data_limit_c = input[idx + 7];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 1 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Socclk */
+		activity_monitor->Fclk_FPS = input[idx + 1];
+		activity_monitor->Fclk_MinFreqStep = input[idx + 2];
+		activity_monitor->Fclk_MinActiveFreqType = input[idx + 3];
+		activity_monitor->Fclk_MinActiveFreq = input[idx + 4];
+		activity_monitor->Fclk_BoosterFreqType = input[idx + 5];
+		activity_monitor->Fclk_BoosterFreq = input[idx + 6];
+		activity_monitor->Fclk_PD_Data_limit_c = input[idx + 7];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 9];
+	}
+	idx = 2 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Memclk */
+		activity_monitor->Mem_FPS = input[idx + 1];
+		activity_monitor->Mem_MinFreqStep = input[idx + 2];
+		activity_monitor->Mem_MinActiveFreqType = input[idx + 3];
+		activity_monitor->Mem_MinActiveFreq = input[idx + 4];
+		activity_monitor->Mem_BoosterFreqType = input[idx + 5];
+		activity_monitor->Mem_BoosterFreq = input[idx + 6];
+		activity_monitor->Mem_PD_Data_limit_c = input[idx + 7];
+		activity_monitor->Mem_PD_Data_error_coeff = input[idx + 8];
+		activity_monitor->Mem_PD_Data_error_rate_coeff = input[idx + 9];
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinFreqStep = input[2];
-			activity_monitor->Gfx_MinActiveFreqType = input[3];
-			activity_monitor->Gfx_MinActiveFreq = input[4];
-			activity_monitor->Gfx_BoosterFreqType = input[5];
-			activity_monitor->Gfx_BoosterFreq = input[6];
-			activity_monitor->Gfx_PD_Data_limit_c = input[7];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Socclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinFreqStep = input[2];
-			activity_monitor->Fclk_MinActiveFreqType = input[3];
-			activity_monitor->Fclk_MinActiveFreq = input[4];
-			activity_monitor->Fclk_BoosterFreqType = input[5];
-			activity_monitor->Fclk_BoosterFreq = input[6];
-			activity_monitor->Fclk_PD_Data_limit_c = input[7];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[8];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 2: /* Memclk */
-			activity_monitor->Mem_FPS = input[1];
-			activity_monitor->Mem_MinFreqStep = input[2];
-			activity_monitor->Mem_MinActiveFreqType = input[3];
-			activity_monitor->Mem_MinActiveFreq = input[4];
-			activity_monitor->Mem_BoosterFreqType = input[5];
-			activity_monitor->Mem_BoosterFreq = input[6];
-			activity_monitor->Mem_PD_Data_limit_c = input[7];
-			activity_monitor->Mem_PD_Data_error_coeff = input[8];
-			activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
+						 u32 workload_mask,
+						 long *custom_params,
+						 u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
+
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(SIENNA_CICHLID_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
+		}
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != SIENNA_CICHLID_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = sienna_cichlid_set_power_profile_mode_coeff(smu,
+								  smu->custom_profile_params);
 		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
 			return ret;
 		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, SIENNA_CICHLID_CUSTOM_PARAMS_SIZE);
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1054,42 +1054,27 @@ static int vangogh_get_power_profile_mod
 	return size;
 }
 
-static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int vangogh_set_power_profile_mode(struct smu_context *smu,
+					  u32 workload_mask,
+					  long *custom_params,
+					  u32 custom_params_max_idx)
 {
-	int workload_type, ret;
-	uint32_t profile_mode = input[size];
+	u32 backend_workload_mask = 0;
+	int ret;
 
-	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
-		return -EINVAL;
-	}
-
-	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
-		return 0;
-
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
-					profile_mode);
-		return -EINVAL;
-	}
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
-				    NULL);
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
-					workload_type);
+		dev_err_once(smu->adev->dev, "Fail to set workload mask 0x%08x\n",
+			     workload_mask);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
+	return ret;
 }
 
 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -862,44 +862,27 @@ static int renoir_force_clk_levels(struc
 	return ret;
 }
 
-static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int renoir_set_power_profile_mode(struct smu_context *smu,
+					 u32 workload_mask,
+					 long *custom_params,
+					 u32 custom_params_max_idx)
 {
-	int workload_type, ret;
-	uint32_t profile_mode = input[size];
+	int ret;
+	u32 backend_workload_mask = 0;
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
-		return -EINVAL;
-	}
-
-	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
-		return 0;
-
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		/*
-		 * TODO: If some case need switch to powersave/default power mode
-		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
-		 */
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
-		return -EINVAL;
-	}
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
-				    NULL);
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
+		dev_err_once(smu->adev->dev, "Failed to set workload mask 0x08%x\n",
+			     workload_mask);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
+	return ret;
 }
 
 static int renoir_set_peak_clock_by_device(struct smu_context *smu)
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2477,82 +2477,76 @@ static int smu_v13_0_0_get_power_profile
 	return size;
 }
 
-static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
-					      long *input,
-					      uint32_t size)
+#define SMU_13_0_0_CUSTOM_PARAMS_COUNT 9
+#define SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT 2
+#define SMU_13_0_0_CUSTOM_PARAMS_SIZE (SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT * SMU_13_0_0_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
-	u32 workload_mask, selected_workload_mask;
+	int ret, idx;
 
-	smu->power_profile_mode = input[size];
-
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 9)
-			return -EINVAL;
-
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
-
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinActiveFreqType = input[2];
-			activity_monitor->Gfx_MinActiveFreq = input[3];
-			activity_monitor->Gfx_BoosterFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreq = input[5];
-			activity_monitor->Gfx_PD_Data_limit_c = input[6];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinActiveFreqType = input[2];
-			activity_monitor->Fclk_MinActiveFreq = input[3];
-			activity_monitor->Fclk_BoosterFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreq = input[5];
-			activity_monitor->Fclk_PD_Data_limit_c = input[6];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
-			break;
-		default:
-			return -EINVAL;
-		}
+	idx = 0 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor->Gfx_FPS = input[idx + 1];
+		activity_monitor->Gfx_MinActiveFreqType = input[idx + 2];
+		activity_monitor->Gfx_MinActiveFreq = input[idx + 3];
+		activity_monitor->Gfx_BoosterFreqType = input[idx + 4];
+		activity_monitor->Gfx_BoosterFreq = input[idx + 5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[idx + 6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 8];
+	}
+	idx = 1 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Fclk */
+		activity_monitor->Fclk_FPS = input[idx + 1];
+		activity_monitor->Fclk_MinActiveFreqType = input[idx + 2];
+		activity_monitor->Fclk_MinActiveFreq = input[idx + 3];
+		activity_monitor->Fclk_BoosterFreqType = input[idx + 4];
+		activity_monitor->Fclk_BoosterFreq = input[idx + 5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[idx + 6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 8];
+	}
 
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
+	return ret;
+}
 
-	if (workload_type < 0)
-		return -EINVAL;
+static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask,
+					      long *custom_params,
+					      u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int workload_type, ret, idx = -1, i;
 
-	selected_workload_mask = workload_mask = 1 << workload_type;
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2564,15 +2558,48 @@ static int smu_v13_0_0_set_power_profile
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       PP_SMC_POWER_PROFILE_POWERSAVING);
 		if (workload_type >= 0)
-			workload_mask |= 1 << workload_type;
+			backend_workload_mask |= 1 << workload_type;
+	}
+
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(SMU_13_0_0_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
+		}
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != SMU_13_0_0_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = smu_v13_0_0_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_params);
+		if (ret) {
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
+			return ret;
+		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, SMU_13_0_0_CUSTOM_PARAMS_SIZE);
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       workload_mask,
-					       NULL);
-	if (!ret)
-		smu->workload_mask = selected_workload_mask;
+					      SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask,
+					      NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2436,78 +2436,110 @@ out:
 	return result;
 }
 
-static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+#define SMU_13_0_7_CUSTOM_PARAMS_COUNT 8
+#define SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT 2
+#define SMU_13_0_7_CUSTOM_PARAMS_SIZE (SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT * SMU_13_0_7_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
+	int ret, idx;
 
-	smu->power_profile_mode = input[size];
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
+	idx = 0 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor->Gfx_ActiveHystLimit = input[idx + 1];
+		activity_monitor->Gfx_IdleHystLimit = input[idx + 2];
+		activity_monitor->Gfx_FPS = input[idx + 3];
+		activity_monitor->Gfx_MinActiveFreqType = input[idx + 4];
+		activity_monitor->Gfx_BoosterFreqType = input[idx + 5];
+		activity_monitor->Gfx_MinActiveFreq = input[idx + 6];
+		activity_monitor->Gfx_BoosterFreq = input[idx + 7];
+	}
+	idx = 1 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Fclk */
+		activity_monitor->Fclk_ActiveHystLimit = input[idx + 1];
+		activity_monitor->Fclk_IdleHystLimit = input[idx + 2];
+		activity_monitor->Fclk_FPS = input[idx + 3];
+		activity_monitor->Fclk_MinActiveFreqType = input[idx + 4];
+		activity_monitor->Fclk_BoosterFreqType = input[idx + 5];
+		activity_monitor->Fclk_MinActiveFreq = input[idx + 6];
+		activity_monitor->Fclk_BoosterFreq = input[idx + 7];
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 8)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_ActiveHystLimit = input[1];
-			activity_monitor->Gfx_IdleHystLimit = input[2];
-			activity_monitor->Gfx_FPS = input[3];
-			activity_monitor->Gfx_MinActiveFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreqType = input[5];
-			activity_monitor->Gfx_MinActiveFreq = input[6];
-			activity_monitor->Gfx_BoosterFreq = input[7];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_ActiveHystLimit = input[1];
-			activity_monitor->Fclk_IdleHystLimit = input[2];
-			activity_monitor->Fclk_FPS = input[3];
-			activity_monitor->Fclk_MinActiveFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreqType = input[5];
-			activity_monitor->Fclk_MinActiveFreq = input[6];
-			activity_monitor->Fclk_BoosterFreq = input[7];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask,
+					      long *custom_params,
+					      u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
+
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(SMU_13_0_7_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
+		}
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != SMU_13_0_7_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = smu_v13_0_7_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_params);
 		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
 			return ret;
 		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, SMU_13_0_7_CUSTOM_PARAMS_SIZE);
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+					      backend_workload_mask, NULL);
 
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu->workload_mask = (1 << workload_type);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1751,90 +1751,120 @@ static int smu_v14_0_2_get_power_profile
 	return size;
 }
 
-static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
-					      long *input,
-					      uint32_t size)
+#define SMU_14_0_2_CUSTOM_PARAMS_COUNT 9
+#define SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT 2
+#define SMU_14_0_2_CUSTOM_PARAMS_SIZE (SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT * SMU_14_0_2_CUSTOM_PARAMS_COUNT * sizeof(long))
+
+static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
-	uint32_t current_profile_mode = smu->power_profile_mode;
-	smu->power_profile_mode = input[size];
-
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
-		return -EINVAL;
-	}
-
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 9)
-			return -EINVAL;
-
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	int ret, idx;
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinActiveFreqType = input[2];
-			activity_monitor->Gfx_MinActiveFreq = input[3];
-			activity_monitor->Gfx_BoosterFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreq = input[5];
-			activity_monitor->Gfx_PD_Data_limit_c = input[6];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinActiveFreqType = input[2];
-			activity_monitor->Fclk_MinActiveFreq = input[3];
-			activity_monitor->Fclk_BoosterFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreq = input[5];
-			activity_monitor->Fclk_PD_Data_limit_c = input[6];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
-			break;
-		default:
-			return -EINVAL;
-		}
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
+	idx = 0 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Gfxclk */
+		activity_monitor->Gfx_FPS = input[idx + 1];
+		activity_monitor->Gfx_MinActiveFreqType = input[idx + 2];
+		activity_monitor->Gfx_MinActiveFreq = input[idx + 3];
+		activity_monitor->Gfx_BoosterFreqType = input[idx + 4];
+		activity_monitor->Gfx_BoosterFreq = input[idx + 5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[idx + 6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 8];
+	}
+	idx = 1 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
+	if (input[idx]) {
+		/* Fclk */
+		activity_monitor->Fclk_FPS = input[idx + 1];
+		activity_monitor->Fclk_MinActiveFreqType = input[idx + 2];
+		activity_monitor->Fclk_MinActiveFreq = input[idx + 3];
+		activity_monitor->Fclk_BoosterFreqType = input[idx + 4];
+		activity_monitor->Fclk_BoosterFreq = input[idx + 5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[idx + 6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 8];
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask,
+					      long *custom_params,
+					      u32 custom_params_max_idx)
+{
+	u32 backend_workload_mask = 0;
+	int ret, idx = -1, i;
+
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask);
+
+	/* disable deep sleep if compute is enabled */
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
 		smu_v14_0_deep_sleep_control(smu, false);
-	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+	else
 		smu_v14_0_deep_sleep_control(smu, true);
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
-					       NULL);
-	if (!ret)
-		smu->workload_mask = 1 << workload_type;
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
+		if (!smu->custom_profile_params) {
+			smu->custom_profile_params =
+				kzalloc(SMU_14_0_2_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
+			if (!smu->custom_profile_params)
+				return -ENOMEM;
+		}
+		if (custom_params && custom_params_max_idx) {
+			if (custom_params_max_idx != SMU_14_0_2_CUSTOM_PARAMS_COUNT)
+				return -EINVAL;
+			if (custom_params[0] >= SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT)
+				return -EINVAL;
+			idx = custom_params[0] * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
+			smu->custom_profile_params[idx] = 1;
+			for (i = 1; i < custom_params_max_idx; i++)
+				smu->custom_profile_params[idx + i] = custom_params[i];
+		}
+		ret = smu_v14_0_2_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_params);
+		if (ret) {
+			if (idx != -1)
+				smu->custom_profile_params[idx] = 0;
+			return ret;
+		}
+	} else if (smu->custom_profile_params) {
+		memset(smu->custom_profile_params, 0, SMU_14_0_2_CUSTOM_PARAMS_SIZE);
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		if (idx != -1)
+			smu->custom_profile_params[idx] = 0;
+		return ret;
+	}
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1215,3 +1215,28 @@ void smu_cmn_generic_plpd_policy_desc(st
 {
 	policy->desc = &xgmi_plpd_policy_desc;
 }
+
+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+				       u32 workload_mask,
+				       u32 *backend_workload_mask)
+{
+	int workload_type;
+	u32 profile_mode;
+
+	*backend_workload_mask = 0;
+
+	for (profile_mode = 0; profile_mode < PP_SMC_POWER_PROFILE_COUNT; profile_mode++) {
+		if (!(workload_mask & (1 << profile_mode)))
+			continue;
+
+		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       profile_mode);
+
+		if (workload_type < 0)
+			continue;
+
+		*backend_workload_mask |= 1 << workload_type;
+	}
+}
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -147,5 +147,9 @@ bool smu_cmn_is_audio_func_enabled(struc
 void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
 
+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+				       u32 workload_mask,
+				       u32 *backend_workload_mask);
+
 #endif
 #endif



