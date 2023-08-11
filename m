Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BE7794E8
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjHKQlB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjHKQlA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:41:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66895E65
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOVLJuBXJ63k8zk/z6wYOQEyNMpE4mue0QgUv6tafFYWOzZW9wmC1z2qJBuoYQc+ANZq70dKEEUwrXGzYlAVsEwakVxVztoR3o3qQjZoh5AWDNVuERenoJBIzK3LL1xxodCcxmFYycjxP/cX/RhxFYb7pnv7VQ78bqKJuoKu43W5OwLxl38wzMTVFrpqk1g+1DkSus1ZWVknll33DC/y1RbStsqqAQFVFb6VA+14BsXDDAoZ81OJQfeFoy0JV7rIYcm1GfK5b6y4wnEMrW9n9UFoDYtlwDSWyoWsgcMMhtuCxpxKOTNXILFBWnClfNjGJFcwk9kGWM3a2/w9jEnThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJZDl0F7q7DeJUpfNLki8MqnMPiQiMTLbZcSEbrZbVo=;
 b=Etc9KnWqxFRxQBeiQU93WJpRzdbSKg3l/XXtePTCfLE8fzQri+qTFuweC5LSFu+Ns7EUmEIUqqjcVLLuNEmzjwJ07s0U4ZPELSFmEAoCjjc2MvXluzTlPvDKJNspIsxUSDzuCf6bEwqH8T7O/N8/8lMFDFUG47GFpEdikm8dsD3wd125RAYhAnPEGgWuW7QTRVGnvkAMPKP/mFcE9GzEcaaE5z90rCp8kFciVqCQNWw9hDi5ke6TUksPhks+v9Uf3nVDk9s9wPBN1fxJbuHqQiWjV2qcIab5YmPmv51jpnlFmTZpW1vKg2F8yoa2lBn+GOMGe4zwPX3bHvjXmesoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJZDl0F7q7DeJUpfNLki8MqnMPiQiMTLbZcSEbrZbVo=;
 b=CVc0fLZ8jjAJBhuA7EJlxLHq9xqVURwwtipw8tPFoq/t1X/GqOFUM17eg06mWKXm1HoT3Oy8npefCGyTPqtzv6QPQ+nVdxnA1sHpnkLDJh3aFT1sEzztZzpE5arioSgYuM/ffg7G/lnoa5+dNorw+duX94Te1MKU1uKNhb5Ax1Q=
Received: from CH0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::33)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 16:40:54 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::40) by CH0P223CA0015.outlook.office365.com
 (2603:10b6:610:116::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 16:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 16:40:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:40:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 3/4] drm/amd/pm: fulfill powerplay peak profiling mode shader/memory clock settings
Date:   Fri, 11 Aug 2023 11:40:30 -0500
Message-ID: <20230811164031.24687-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811164031.24687-1-mario.limonciello@amd.com>
References: <20230811164031.24687-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bc9cd7-e6aa-40fc-f612-08db9a89bb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQYy+i+91n+VFgLWZruiPxOETY1IU5V0weGwqIQoCSzftCey5UospaPSDVlW0nWtKs/+foigw76okis32GLZFdyyfHAV18tjNoXVPTSZ2Azb951AF7Y4YuCScJqDjaC8nKkCjedOkYiwa1I4kKM2yeBqoF5cp0SFyCiVsxNBL2FDrzVgjcMX1MuIDl0AhzHuWDHUgVwnUbdRN57j0K1QxI2cbIlV7ZUQsGwwqMyXXD+CG+BmcJqxNLoXqtHmv/G9N2xMLJH7+pjin2ucx2A8vFGvxdW4pnWf1TZOqz4v/F9hhskG99O4ZfcRh0zDjIesRFc9iWlVRR/5/DxSQjvUGFVvYN2MZ6cH9QVs2bO/CB9Yu16QQmf52YKJhVS3oE6XCDzCqE8LUaimm36oWy/8XSmHAqvw6v2jmkaSk6jvFByy+vmX38bi8TnM0ySIwA0JBL3sjbb6cAdLkr7QjpxVTARjUkxXejTTPwKk6ssvrzeez1uvlKaZobhp9dVr5yJDuktSaPxqmszy2qdFKLE1rIdfbT+8z6cq1g9/WHcXxBYrZna0l8zR3dm7UvYfI3lB4AC+Bk1qqTugJEudBG3oEAwDULU8qnTvqHjVIiBYwbOO4HmCU+BbxxYRoMr0yrvzoZ2x202bRaDb3mKFrVVDhat1Mq9wHw2jPVk3JL3atYemSbR6L/uR4QeBawlchC8OVAJozB9xFyhU9qiMNspkAziUq7y79+8/hbtRlKw3CzPNHJr1kqqt03gUyLm3pENb063+0v9bOsnfFBijoGt+bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(1800799006)(82310400008)(186006)(451199021)(40470700004)(46966006)(36840700001)(44832011)(5660300002)(4326008)(70586007)(2906002)(70206006)(6916009)(82740400003)(316002)(30864003)(8676002)(41300700001)(478600001)(8936002)(86362001)(40460700003)(6666004)(7696005)(356005)(36860700001)(336012)(16526019)(83380400001)(81166007)(26005)(2616005)(426003)(47076005)(1076003)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:40:54.5094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bc9cd7-e6aa-40fc-f612-08db9a89bb3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

Enable peak profiling mode shader/memory clock reporting for powerplay
framework.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b1a9557a7d00c758ed9e701fbb3445a13a49506f)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 ++-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 16 +++-
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 76 +++++++++++++++----
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 16 +++-
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 31 ++++++--
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 22 ++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 20 ++---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 +
 8 files changed, 155 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 1159ae114dd0..3f4a476d7802 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -769,10 +769,16 @@ static int pp_dpm_read_sensor(void *handle, int idx,
 
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
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index ede71de2343d..86d6e88c7386 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -375,6 +375,17 @@ static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)
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
@@ -398,6 +409,8 @@ static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 			return ret;
 	}
 
+	smu10_populate_umdpstate_clocks(hwmgr);
+
 	return 0;
 }
 
@@ -574,9 +587,6 @@ static int smu10_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
 
-	hwmgr->pstate_sclk = SMU10_UMD_PSTATE_GFXCLK * 100;
-	hwmgr->pstate_mclk = SMU10_UMD_PSTATE_FCLK * 100;
-
 	/* enable the pp_od_clk_voltage sysfs file */
 	hwmgr->od_enabled = 1;
 	/* disabled fine grain tuning function by default */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index b9e6e49ba4f0..44ec238cfeff 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1501,6 +1501,65 @@ static int smu7_populate_edc_leakage_registers(struct pp_hwmgr *hwmgr)
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
@@ -1625,6 +1684,8 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE((0 == tmp_result),
 			"pcie performance request failed!", result = tmp_result);
 
+	smu7_populate_umdpstate_clocks(hwmgr);
+
 	return 0;
 }
 
@@ -3143,15 +3204,12 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *hwmgr, enum amd_dpm_forced_le
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
@@ -3161,15 +3219,12 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *hwmgr, enum amd_dpm_forced_le
 
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
@@ -3181,8 +3236,6 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *hwmgr, enum amd_dpm_forced_le
 		*mclk_mask = golden_dpm_table->mclk_table.count - 1;
 
 	*pcie_mask = data->dpm_table.pcie_speed_table.count - 1;
-	hwmgr->pstate_sclk = tmp_sclk;
-	hwmgr->pstate_mclk = tmp_mclk;
 
 	return 0;
 }
@@ -3195,9 +3248,6 @@ static int smu7_force_dpm_level(struct pp_hwmgr *hwmgr,
 	uint32_t mclk_mask = 0;
 	uint32_t pcie_mask = 0;
 
-	if (hwmgr->pstate_sclk == 0)
-		smu7_get_profiling_clk(hwmgr, level, &sclk_mask, &mclk_mask, &pcie_mask);
-
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 		ret = smu7_force_dpm_highest(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b50fd4a4a3d1..b015a601b385 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1016,6 +1016,18 @@ static void smu8_reset_acp_boot_level(struct pp_hwmgr *hwmgr)
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
@@ -1024,6 +1036,8 @@ static int smu8_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	smu8_program_bootup_state(hwmgr);
 	smu8_reset_acp_boot_level(hwmgr);
 
+	smu8_populate_umdpstate_clocks(hwmgr);
+
 	return 0;
 }
 
@@ -1167,8 +1181,6 @@ static int smu8_phm_unforce_dpm_levels(struct pp_hwmgr *hwmgr)
 
 	data->sclk_dpm.soft_min_clk = table->entries[0].clk;
 	data->sclk_dpm.hard_min_clk = table->entries[0].clk;
-	hwmgr->pstate_sclk = table->entries[0].clk;
-	hwmgr->pstate_mclk = 0;
 
 	level = smu8_get_max_sclk_level(hwmgr) - 1;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index c78f8b2b056d..d8cd23438b76 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3008,6 +3008,30 @@ static int vega10_enable_disable_PCC_limit_feature(struct pp_hwmgr *hwmgr, bool
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
@@ -3082,6 +3106,8 @@ static int vega10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 				    result = tmp_result);
 	}
 
+	vega10_populate_umdpstate_clocks(hwmgr);
+
 	return result;
 }
 
@@ -4169,8 +4195,6 @@ static int vega10_get_profiling_clk_mask(struct pp_hwmgr *hwmgr, enum amd_dpm_fo
 		*sclk_mask = VEGA10_UMD_PSTATE_GFXCLK_LEVEL;
 		*soc_mask = VEGA10_UMD_PSTATE_SOCCLK_LEVEL;
 		*mclk_mask = VEGA10_UMD_PSTATE_MCLK_LEVEL;
-		hwmgr->pstate_sclk = table_info->vdd_dep_on_sclk->entries[VEGA10_UMD_PSTATE_GFXCLK_LEVEL].clk;
-		hwmgr->pstate_mclk = table_info->vdd_dep_on_mclk->entries[VEGA10_UMD_PSTATE_MCLK_LEVEL].clk;
 	}
 
 	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
@@ -4281,9 +4305,6 @@ static int vega10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
 	uint32_t mclk_mask = 0;
 	uint32_t soc_mask = 0;
 
-	if (hwmgr->pstate_sclk == 0)
-		vega10_get_profiling_clk_mask(hwmgr, level, &sclk_mask, &mclk_mask, &soc_mask);
-
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 		ret = vega10_force_dpm_highest(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 0fe821dff0a4..1069eaaae2f8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1026,6 +1026,25 @@ static int vega12_get_all_clock_ranges(struct pp_hwmgr *hwmgr)
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
@@ -1077,6 +1096,9 @@ static int vega12_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE(!result,
 			"Failed to setup default DPM tables!",
 			return result);
+
+	vega12_populate_umdpstate_clocks(hwmgr);
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 8e4743cb7443..ff77a3683efd 100644
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
@@ -1753,10 +1750,7 @@ static int vega20_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 			"[EnableDPMTasks] Failed to initialize odn settings!",
 			return result);
 
-	result = vega20_populate_umdpstate_clocks(hwmgr);
-	PP_ASSERT_WITH_CODE(!result,
-			"[EnableDPMTasks] Failed to populate umdpstate clocks!",
-			return result);
+	vega20_populate_umdpstate_clocks(hwmgr);
 
 	result = smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetPptLimit,
 			POWER_SOURCE_AC << 16, &hwmgr->default_power_limit);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 27f8d0e0e6a8..5ce433e2c16a 100644
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
-- 
2.34.1

