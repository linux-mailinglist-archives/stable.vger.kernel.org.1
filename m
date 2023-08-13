Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4903677AC8D
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjHMVeZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjHMVeY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12AB10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4A662C4B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F4BC433C8;
        Sun, 13 Aug 2023 21:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962464;
        bh=meur11uQf4TzR5PJnSzN09Ocdf4bjerIQbrTZfDueB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmN3Lu6XrgjEZ+3i4g98iXsCEU/8J5e6R8209ruFXCc/fPD76TGe1hlZbxelS2C3l
         mrbnu7S2CjwJnYYtL5umT/y2FhpIMSup/Mzl9JgmYgvZtA2jIICnP+HAPILa4gJZfR
         7Em2yK46SSEcjqfdkvQynb4z0/a5ciGrXg3WYuyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 039/149] drm/amd/pm: fulfill powerplay peak profiling mode shader/memory clock settings
Date:   Sun, 13 Aug 2023 23:18:04 +0200
Message-ID: <20230813211719.976702716@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

commit b1a9557a7d00c758ed9e701fbb3445a13a49506f upstream

Enable peak profiling mode shader/memory clock reporting for powerplay
framework.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c      |   10 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |   16 +++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |   76 ++++++++++++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   16 +++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |   31 ++++++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |   22 +++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |   20 +---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h          |    2 
 8 files changed, 155 insertions(+), 38 deletions(-)

--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -769,10 +769,16 @@ static int pp_dpm_read_sensor(void *hand
 
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
-		*((uint32_t *)value) = hwmgr->pstate_sclk;
+		*((uint32_t *)value) = hwmgr->pstate_sclk * 100;
 		return 0;
 	case AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK:
-		*((uint32_t *)value) = hwmgr->pstate_mclk;
+		*((uint32_t *)value) = hwmgr->pstate_mclk * 100;
+		return 0;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK:
+		*((uint32_t *)value) = hwmgr->pstate_sclk_peak * 100;
+		return 0;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK:
+		*((uint32_t *)value) = hwmgr->pstate_mclk_peak * 100;
 		return 0;
 	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
 		*((uint32_t *)value) = hwmgr->thermal_controller.fanInfo.ulMinRPM;
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -375,6 +375,17 @@ static int smu10_enable_gfx_off(struct p
 	return 0;
 }
 
+static void smu10_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	hwmgr->pstate_sclk = SMU10_UMD_PSTATE_GFXCLK;
+	hwmgr->pstate_mclk = SMU10_UMD_PSTATE_FCLK;
+
+	smum_send_msg_to_smc(hwmgr,
+			     PPSMC_MSG_GetMaxGfxclkFrequency,
+			     &hwmgr->pstate_sclk_peak);
+	hwmgr->pstate_mclk_peak = SMU10_UMD_PSTATE_PEAK_FCLK;
+}
+
 static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -398,6 +409,8 @@ static int smu10_enable_dpm_tasks(struct
 			return ret;
 	}
 
+	smu10_populate_umdpstate_clocks(hwmgr);
+
 	return 0;
 }
 
@@ -574,9 +587,6 @@ static int smu10_hwmgr_backend_init(stru
 
 	hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
 
-	hwmgr->pstate_sclk = SMU10_UMD_PSTATE_GFXCLK * 100;
-	hwmgr->pstate_mclk = SMU10_UMD_PSTATE_FCLK * 100;
-
 	/* enable the pp_od_clk_voltage sysfs file */
 	hwmgr->od_enabled = 1;
 	/* disabled fine grain tuning function by default */
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1501,6 +1501,65 @@ static int smu7_populate_edc_leakage_reg
 	return ret;
 }
 
+static void smu7_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_dpm_table *golden_dpm_table = &data->golden_dpm_table;
+	struct phm_clock_voltage_dependency_table *vddc_dependency_on_sclk =
+			hwmgr->dyn_state.vddc_dependency_on_sclk;
+	struct phm_ppt_v1_information *table_info =
+			(struct phm_ppt_v1_information *)(hwmgr->pptable);
+	struct phm_ppt_v1_clock_voltage_dependency_table *vdd_dep_on_sclk =
+			table_info->vdd_dep_on_sclk;
+	int32_t tmp_sclk, count, percentage;
+
+	if (golden_dpm_table->mclk_table.count == 1) {
+		percentage = 70;
+		hwmgr->pstate_mclk = golden_dpm_table->mclk_table.dpm_levels[0].value;
+	} else {
+		percentage = 100 * golden_dpm_table->sclk_table.dpm_levels[golden_dpm_table->sclk_table.count - 1].value /
+				golden_dpm_table->mclk_table.dpm_levels[golden_dpm_table->mclk_table.count - 1].value;
+		hwmgr->pstate_mclk = golden_dpm_table->mclk_table.dpm_levels[golden_dpm_table->mclk_table.count - 2].value;
+	}
+
+	tmp_sclk = hwmgr->pstate_mclk * percentage / 100;
+
+	if (hwmgr->pp_table_version == PP_TABLE_V0) {
+		for (count = vddc_dependency_on_sclk->count - 1; count >= 0; count--) {
+			if (tmp_sclk >= vddc_dependency_on_sclk->entries[count].clk) {
+				hwmgr->pstate_sclk = vddc_dependency_on_sclk->entries[count].clk;
+				break;
+			}
+		}
+		if (count < 0)
+			hwmgr->pstate_sclk = vddc_dependency_on_sclk->entries[0].clk;
+
+		hwmgr->pstate_sclk_peak =
+			vddc_dependency_on_sclk->entries[vddc_dependency_on_sclk->count - 1].clk;
+	} else if (hwmgr->pp_table_version == PP_TABLE_V1) {
+		for (count = vdd_dep_on_sclk->count - 1; count >= 0; count--) {
+			if (tmp_sclk >= vdd_dep_on_sclk->entries[count].clk) {
+				hwmgr->pstate_sclk = vdd_dep_on_sclk->entries[count].clk;
+				break;
+			}
+		}
+		if (count < 0)
+			hwmgr->pstate_sclk = vdd_dep_on_sclk->entries[0].clk;
+
+		hwmgr->pstate_sclk_peak =
+			vdd_dep_on_sclk->entries[vdd_dep_on_sclk->count - 1].clk;
+	}
+
+	hwmgr->pstate_mclk_peak =
+		golden_dpm_table->mclk_table.dpm_levels[golden_dpm_table->mclk_table.count - 1].value;
+
+	/* make sure the output is in Mhz */
+	hwmgr->pstate_sclk /= 100;
+	hwmgr->pstate_mclk /= 100;
+	hwmgr->pstate_sclk_peak /= 100;
+	hwmgr->pstate_mclk_peak /= 100;
+}
+
 static int smu7_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	int tmp_result = 0;
@@ -1625,6 +1684,8 @@ static int smu7_enable_dpm_tasks(struct
 	PP_ASSERT_WITH_CODE((0 == tmp_result),
 			"pcie performance request failed!", result = tmp_result);
 
+	smu7_populate_umdpstate_clocks(hwmgr);
+
 	return 0;
 }
 
@@ -3143,15 +3204,12 @@ static int smu7_get_profiling_clk(struct
 		for (count = hwmgr->dyn_state.vddc_dependency_on_sclk->count-1;
 			count >= 0; count--) {
 			if (tmp_sclk >= hwmgr->dyn_state.vddc_dependency_on_sclk->entries[count].clk) {
-				tmp_sclk = hwmgr->dyn_state.vddc_dependency_on_sclk->entries[count].clk;
 				*sclk_mask = count;
 				break;
 			}
 		}
-		if (count < 0 || level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
+		if (count < 0 || level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
 			*sclk_mask = 0;
-			tmp_sclk = hwmgr->dyn_state.vddc_dependency_on_sclk->entries[0].clk;
-		}
 
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			*sclk_mask = hwmgr->dyn_state.vddc_dependency_on_sclk->count-1;
@@ -3161,15 +3219,12 @@ static int smu7_get_profiling_clk(struct
 
 		for (count = table_info->vdd_dep_on_sclk->count-1; count >= 0; count--) {
 			if (tmp_sclk >= table_info->vdd_dep_on_sclk->entries[count].clk) {
-				tmp_sclk = table_info->vdd_dep_on_sclk->entries[count].clk;
 				*sclk_mask = count;
 				break;
 			}
 		}
-		if (count < 0 || level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
+		if (count < 0 || level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
 			*sclk_mask = 0;
-			tmp_sclk =  table_info->vdd_dep_on_sclk->entries[0].clk;
-		}
 
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			*sclk_mask = table_info->vdd_dep_on_sclk->count - 1;
@@ -3181,8 +3236,6 @@ static int smu7_get_profiling_clk(struct
 		*mclk_mask = golden_dpm_table->mclk_table.count - 1;
 
 	*pcie_mask = data->dpm_table.pcie_speed_table.count - 1;
-	hwmgr->pstate_sclk = tmp_sclk;
-	hwmgr->pstate_mclk = tmp_mclk;
 
 	return 0;
 }
@@ -3195,9 +3248,6 @@ static int smu7_force_dpm_level(struct p
 	uint32_t mclk_mask = 0;
 	uint32_t pcie_mask = 0;
 
-	if (hwmgr->pstate_sclk == 0)
-		smu7_get_profiling_clk(hwmgr, level, &sclk_mask, &mclk_mask, &pcie_mask);
-
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 		ret = smu7_force_dpm_highest(hwmgr);
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1016,6 +1016,18 @@ static void smu8_reset_acp_boot_level(st
 	data->acp_boot_level = 0xff;
 }
 
+static void smu8_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	struct phm_clock_voltage_dependency_table *table =
+				hwmgr->dyn_state.vddc_dependency_on_sclk;
+
+	hwmgr->pstate_sclk = table->entries[0].clk / 100;
+	hwmgr->pstate_mclk = 0;
+
+	hwmgr->pstate_sclk_peak = table->entries[table->count - 1].clk / 100;
+	hwmgr->pstate_mclk_peak = 0;
+}
+
 static int smu8_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	smu8_program_voting_clients(hwmgr);
@@ -1024,6 +1036,8 @@ static int smu8_enable_dpm_tasks(struct
 	smu8_program_bootup_state(hwmgr);
 	smu8_reset_acp_boot_level(hwmgr);
 
+	smu8_populate_umdpstate_clocks(hwmgr);
+
 	return 0;
 }
 
@@ -1167,8 +1181,6 @@ static int smu8_phm_unforce_dpm_levels(s
 
 	data->sclk_dpm.soft_min_clk = table->entries[0].clk;
 	data->sclk_dpm.hard_min_clk = table->entries[0].clk;
-	hwmgr->pstate_sclk = table->entries[0].clk;
-	hwmgr->pstate_mclk = 0;
 
 	level = smu8_get_max_sclk_level(hwmgr) - 1;
 
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3008,6 +3008,30 @@ static int vega10_enable_disable_PCC_lim
 	return 0;
 }
 
+static void vega10_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	struct phm_ppt_v2_information *table_info =
+			(struct phm_ppt_v2_information *)(hwmgr->pptable);
+
+	if (table_info->vdd_dep_on_sclk->count > VEGA10_UMD_PSTATE_GFXCLK_LEVEL &&
+	    table_info->vdd_dep_on_mclk->count > VEGA10_UMD_PSTATE_MCLK_LEVEL) {
+		hwmgr->pstate_sclk = table_info->vdd_dep_on_sclk->entries[VEGA10_UMD_PSTATE_GFXCLK_LEVEL].clk;
+		hwmgr->pstate_mclk = table_info->vdd_dep_on_mclk->entries[VEGA10_UMD_PSTATE_MCLK_LEVEL].clk;
+	} else {
+		hwmgr->pstate_sclk = table_info->vdd_dep_on_sclk->entries[0].clk;
+		hwmgr->pstate_mclk = table_info->vdd_dep_on_mclk->entries[0].clk;
+	}
+
+	hwmgr->pstate_sclk_peak = table_info->vdd_dep_on_sclk->entries[table_info->vdd_dep_on_sclk->count - 1].clk;
+	hwmgr->pstate_mclk_peak = table_info->vdd_dep_on_mclk->entries[table_info->vdd_dep_on_mclk->count - 1].clk;
+
+	/* make sure the output is in Mhz */
+	hwmgr->pstate_sclk /= 100;
+	hwmgr->pstate_mclk /= 100;
+	hwmgr->pstate_sclk_peak /= 100;
+	hwmgr->pstate_mclk_peak /= 100;
+}
+
 static int vega10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
@@ -3082,6 +3106,8 @@ static int vega10_enable_dpm_tasks(struc
 				    result = tmp_result);
 	}
 
+	vega10_populate_umdpstate_clocks(hwmgr);
+
 	return result;
 }
 
@@ -4169,8 +4195,6 @@ static int vega10_get_profiling_clk_mask
 		*sclk_mask = VEGA10_UMD_PSTATE_GFXCLK_LEVEL;
 		*soc_mask = VEGA10_UMD_PSTATE_SOCCLK_LEVEL;
 		*mclk_mask = VEGA10_UMD_PSTATE_MCLK_LEVEL;
-		hwmgr->pstate_sclk = table_info->vdd_dep_on_sclk->entries[VEGA10_UMD_PSTATE_GFXCLK_LEVEL].clk;
-		hwmgr->pstate_mclk = table_info->vdd_dep_on_mclk->entries[VEGA10_UMD_PSTATE_MCLK_LEVEL].clk;
 	}
 
 	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
@@ -4281,9 +4305,6 @@ static int vega10_dpm_force_dpm_level(st
 	uint32_t mclk_mask = 0;
 	uint32_t soc_mask = 0;
 
-	if (hwmgr->pstate_sclk == 0)
-		vega10_get_profiling_clk_mask(hwmgr, level, &sclk_mask, &mclk_mask, &soc_mask);
-
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 		ret = vega10_force_dpm_highest(hwmgr);
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1026,6 +1026,25 @@ static int vega12_get_all_clock_ranges(s
 	return 0;
 }
 
+static void vega12_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	struct vega12_hwmgr *data = (struct vega12_hwmgr *)(hwmgr->backend);
+	struct vega12_single_dpm_table *gfx_dpm_table = &(data->dpm_table.gfx_table);
+	struct vega12_single_dpm_table *mem_dpm_table = &(data->dpm_table.mem_table);
+
+	if (gfx_dpm_table->count > VEGA12_UMD_PSTATE_GFXCLK_LEVEL &&
+	    mem_dpm_table->count > VEGA12_UMD_PSTATE_MCLK_LEVEL) {
+		hwmgr->pstate_sclk = gfx_dpm_table->dpm_levels[VEGA12_UMD_PSTATE_GFXCLK_LEVEL].value;
+		hwmgr->pstate_mclk = mem_dpm_table->dpm_levels[VEGA12_UMD_PSTATE_MCLK_LEVEL].value;
+	} else {
+		hwmgr->pstate_sclk = gfx_dpm_table->dpm_levels[0].value;
+		hwmgr->pstate_mclk = mem_dpm_table->dpm_levels[0].value;
+	}
+
+	hwmgr->pstate_sclk_peak = gfx_dpm_table->dpm_levels[gfx_dpm_table->count].value;
+	hwmgr->pstate_mclk_peak = mem_dpm_table->dpm_levels[mem_dpm_table->count].value;
+}
+
 static int vega12_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	int tmp_result, result = 0;
@@ -1077,6 +1096,9 @@ static int vega12_enable_dpm_tasks(struc
 	PP_ASSERT_WITH_CODE(!result,
 			"Failed to setup default DPM tables!",
 			return result);
+
+	vega12_populate_umdpstate_clocks(hwmgr);
+
 	return result;
 }
 
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -1555,26 +1555,23 @@ static int vega20_set_mclk_od(
 	return 0;
 }
 
-static int vega20_populate_umdpstate_clocks(
-		struct pp_hwmgr *hwmgr)
+static void vega20_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data = (struct vega20_hwmgr *)(hwmgr->backend);
 	struct vega20_single_dpm_table *gfx_table = &(data->dpm_table.gfx_table);
 	struct vega20_single_dpm_table *mem_table = &(data->dpm_table.mem_table);
 
-	hwmgr->pstate_sclk = gfx_table->dpm_levels[0].value;
-	hwmgr->pstate_mclk = mem_table->dpm_levels[0].value;
-
 	if (gfx_table->count > VEGA20_UMD_PSTATE_GFXCLK_LEVEL &&
 	    mem_table->count > VEGA20_UMD_PSTATE_MCLK_LEVEL) {
 		hwmgr->pstate_sclk = gfx_table->dpm_levels[VEGA20_UMD_PSTATE_GFXCLK_LEVEL].value;
 		hwmgr->pstate_mclk = mem_table->dpm_levels[VEGA20_UMD_PSTATE_MCLK_LEVEL].value;
+	} else {
+		hwmgr->pstate_sclk = gfx_table->dpm_levels[0].value;
+		hwmgr->pstate_mclk = mem_table->dpm_levels[0].value;
 	}
 
-	hwmgr->pstate_sclk = hwmgr->pstate_sclk * 100;
-	hwmgr->pstate_mclk = hwmgr->pstate_mclk * 100;
-
-	return 0;
+	hwmgr->pstate_sclk_peak = gfx_table->dpm_levels[gfx_table->count - 1].value;
+	hwmgr->pstate_mclk_peak = mem_table->dpm_levels[mem_table->count - 1].value;
 }
 
 static int vega20_get_max_sustainable_clock(struct pp_hwmgr *hwmgr,
@@ -1753,10 +1750,7 @@ static int vega20_enable_dpm_tasks(struc
 			"[EnableDPMTasks] Failed to initialize odn settings!",
 			return result);
 
-	result = vega20_populate_umdpstate_clocks(hwmgr);
-	PP_ASSERT_WITH_CODE(!result,
-			"[EnableDPMTasks] Failed to populate umdpstate clocks!",
-			return result);
+	vega20_populate_umdpstate_clocks(hwmgr);
 
 	result = smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetPptLimit,
 			POWER_SOURCE_AC << 16, &hwmgr->default_power_limit);
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -809,6 +809,8 @@ struct pp_hwmgr {
 	uint32_t workload_prority[Workload_Policy_Max];
 	uint32_t workload_setting[Workload_Policy_Max];
 	bool gfxoff_state_changed_by_workload;
+	uint32_t pstate_sclk_peak;
+	uint32_t pstate_mclk_peak;
 };
 
 int hwmgr_early_init(struct pp_hwmgr *hwmgr);


