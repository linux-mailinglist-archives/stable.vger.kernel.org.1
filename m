Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F727794E2
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjHKQkb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbjHKQka (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:40:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968F018F
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhlRPzWNBif6XlCNEB1l/I9xI1xYxSmZ2JEFc6cXdrV7wXbnewAagPioj1weLuqXHMKh68xIDNsc4b7xPaAnNSn+z2UY3WoZAXZfrh+SQIwMnKxvrCRQ4fFCJbqzluJQ2vT3Fr463FXVCpHFaB+A4QLikgQcV7+S4QyB9CK3qwIMhmOmzJjTVJ1WkJqZQJjQLUncixUV+qEqHBJEcIsuF12J1PGjWqX7prFjfIBiggJgL7JNjoyJGQVV+wsyl0PN7Y2BJic7VyOr1Qpz5eyRX11616/LLmGPSwtTduJp0OZLhC2zuhGYJVlAMNF4ZOU5sXhVtIBegj6I9oDqs0uRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyNH9AV5Znng9lJcaIzrSU9TDdAGiIxvINiwXyzkz+g=;
 b=lotsIzSnuLSvxx4tM0eE7Y83B3F0BEFe6iBXXims2TvCx4X9lb1X3hVn5cwt8tZ6BBBNWJMQRb5qO+EMjrgEuIXkzJ2TxhBIOZl+SCj5/oJ9cNjm+r2SmlcXLpPYPrxWMuDEOSFHd/jFM/2U0Rvw6iJu1GqlKgIJc7biyOChQ0qbIGb6NNgML1J/g2YbEOFS9k9O0L4XWtjVdSXjuyWhZS89UwVKb27Zz3FpvUCzRFG0jfdfIh/XjFdyssYCbtBGqS3E2na5ZNTSU8pHkODctBWG8d30hS++hqTRAqkNndqhO1UHm1yn3yADZs01ooaYCBQzBpAwF1AIIKPr9xMXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyNH9AV5Znng9lJcaIzrSU9TDdAGiIxvINiwXyzkz+g=;
 b=4KgZ1jwiiFKYYtdUlm3USgRGaQw8zvLNF5C3ez5w++8i9uFRIrOtOnQIOPD7/oyyV9ne8NMu1NtE1RmrnJpK2OtNIIyXSuUIfOCHJOzqBTewuSf4NY0Xq4YI1orJMJnHpgZtMXazhtNjYdni4k76iuFSX5GngBBgxi36LC2DzRE=
Received: from BN8PR16CA0032.namprd16.prod.outlook.com (2603:10b6:408:4c::45)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 16:40:27 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::66) by BN8PR16CA0032.outlook.office365.com
 (2603:10b6:408:4c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 16:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 16:40:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:40:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.4.y 1/2] drm/amd/pm: expose swctf threshold setting for legacy powerplay
Date:   Fri, 11 Aug 2023 11:39:50 -0500
Message-ID: <20230811163951.24631-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811163951.24631-1-mario.limonciello@amd.com>
References: <20230811163951.24631-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bba6cd-ded0-4171-45b6-08db9a89aadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljtWdYag1PWTfmRVrXEKHXVz39hf9Sa1n/AQiQoxSY8vae668ay3oh+TaZmzorZf1wYOfV1CUldtHMtW7UqAUvGI9xoghsyhgnfc+snLlyks4Q5f5VQE0QE4vqdyohkrCgdI+VU+nG9ZapFa6nXedpfhXk7/b+ORFxH3whYAs5DByb/sXu1k2A4YaLKg68eKRMjgy5BB3sDNUW0SjEU90EdynwyWL/+huMT08y06hOnTtzV6JFH2CLO+l7SeEprkYr7UIXowEnQp3XV+J1V3KKz2anoOrWUKQBhha+Uqxkv9vWNHGrgqsHX8P1quRDPXj+qPNuTXCc0kehPI3k/yRsqTfK9sgFqaWfVQ48MbxvazHYxbhQis/FG/N8loF7O/fCyWc3CvYFJj46rHxDCVFVbfs+w2ZKS6bVy79cjt2KMmPgMlvehimkRVWWhK/WGwPz2BENf2khNQ/xVBmtIWwusy7BDtPlrW82xbOd/B06w1oEQz0fRbBR9P07fVZJaHnELZLhA2SXshANrVayclnhezHueCMzHCZ5jYEUziGxY1jf6wXaChRNi+Eyg52ys4j9JuBrz2axnybmGOl60UtA5nJNG90L8kCcitzzwfFna2on1G0PCIIYW0zceE7w+mURpdJETh2OUvGhdwz1hMJs/NCTXe37uBRaVKWTL3CZElQg2ye5Hl+BWEPDCBtoil706/91rT4Y6j5lVRgOpweVAtbpflZH3kvurYDTr4NQLwUmah3J/8cqCPCnqesBoYcs69jN5grQ3ylVZcDeIsvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(82310400008)(186006)(1800799006)(451199021)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(40460700003)(41300700001)(6916009)(4326008)(8936002)(8676002)(70206006)(70586007)(316002)(478600001)(426003)(83380400001)(336012)(47076005)(26005)(16526019)(1076003)(2616005)(356005)(7696005)(6666004)(82740400003)(86362001)(36860700001)(81166007)(5660300002)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:40:27.0257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bba6cd-ded0-4171-45b6-08db9a89aadd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431
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

Preparation for coming optimization which eliminates the influence of
GPU temperature momentary fluctuation.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 064329c595da56eff6d7a7e7760660c726433139)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                |  2 ++
 .../gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   |  4 +++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  2 ++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 10 ++++++++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |  4 ++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  4 ++++
 drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h     |  1 +
 7 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index d178f3f44081..42172b00be66 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -89,6 +89,8 @@ struct amdgpu_dpm_thermal {
 	int                max_mem_crit_temp;
 	/* memory max emergency(shutdown) temp */
 	int                max_mem_emergency_temp;
+	/* SWCTF threshold */
+	int                sw_ctf_threshold;
 	/* was last interrupt low to high or high to low */
 	bool               high_to_low;
 	/* interrupt source */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 981dc8c7112d..90452b66e107 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -241,7 +241,8 @@ int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 		TEMP_RANGE_MAX,
 		TEMP_RANGE_MIN,
 		TEMP_RANGE_MAX,
-		TEMP_RANGE_MAX};
+		TEMP_RANGE_MAX,
+		0};
 	struct amdgpu_device *adev = hwmgr->adev;
 
 	if (!hwmgr->not_vf)
@@ -265,6 +266,7 @@ int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 	adev->pm.dpm.thermal.min_mem_temp = range.mem_min;
 	adev->pm.dpm.thermal.max_mem_crit_temp = range.mem_crit_max;
 	adev->pm.dpm.thermal.max_mem_emergency_temp = range.mem_emergency_max;
+	adev->pm.dpm.thermal.sw_ctf_threshold = range.sw_ctf_threshold;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index e10cc5e7928e..6841a4bce186 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5432,6 +5432,8 @@ static int smu7_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		thermal_data->max = data->thermal_temp_setting.temperature_shutdown *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
+	thermal_data->sw_ctf_threshold = thermal_data->max;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 99cd2e63afdd..c51dd4c74fe9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5241,6 +5241,9 @@ static int vega10_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
+	struct phm_ppt_v2_information *pp_table_info =
+		(struct phm_ppt_v2_information *)(hwmgr->pptable);
+	struct phm_tdp_table *tdp_table = pp_table_info->tdp_table;
 
 	memcpy(thermal_data, &SMU7ThermalWithDelayPolicy[0], sizeof(struct PP_TemperatureRange));
 
@@ -5257,6 +5260,13 @@ static int vega10_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 	thermal_data->mem_emergency_max = (pp_table->ThbmLimit + CTF_OFFSET_HBM)*
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
+	if (tdp_table->usSoftwareShutdownTemp > pp_table->ThotspotLimit &&
+	    tdp_table->usSoftwareShutdownTemp < VEGA10_THERMAL_MAXIMUM_ALERT_TEMP)
+		thermal_data->sw_ctf_threshold = tdp_table->usSoftwareShutdownTemp;
+	else
+		thermal_data->sw_ctf_threshold = VEGA10_THERMAL_MAXIMUM_ALERT_TEMP;
+	thermal_data->sw_ctf_threshold *= PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index e9db137cd1c6..1937be1cf5b4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2763,6 +2763,8 @@ static int vega12_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
 static int vega12_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *thermal_data)
 {
+	struct phm_ppt_v3_information *pptable_information =
+		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct vega12_hwmgr *data =
 			(struct vega12_hwmgr *)(hwmgr->backend);
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
@@ -2781,6 +2783,8 @@ static int vega12_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	thermal_data->mem_emergency_max = (pp_table->ThbmLimit + CTF_OFFSET_HBM)*
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	thermal_data->sw_ctf_threshold = pptable_information->us_software_shutdown_temp *
+		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 0d4d4811527c..4e19ccbdb807 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4206,6 +4206,8 @@ static int vega20_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
 static int vega20_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *thermal_data)
 {
+	struct phm_ppt_v3_information *pptable_information =
+		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
@@ -4224,6 +4226,8 @@ static int vega20_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	thermal_data->mem_emergency_max = (pp_table->ThbmLimit + CTF_OFFSET_HBM)*
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	thermal_data->sw_ctf_threshold = pptable_information->us_software_shutdown_temp *
+		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
index a5f2227a3971..0ffc2347829d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
@@ -131,6 +131,7 @@ struct PP_TemperatureRange {
 	int mem_min;
 	int mem_crit_max;
 	int mem_emergency_max;
+	int sw_ctf_threshold;
 };
 
 struct PP_StateValidationBlock {
-- 
2.34.1

