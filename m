Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17F7794E6
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjHKQk6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjHKQk5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:40:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D3E65
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJg1aLBXoj/v2kMhLEsPqO4AqBpBEA72MCs4ji9/mXX6RnM16aVDhpJjgotZq7oY49URHAwoJ9JzWsHf9VGoySiifHDaCbKECxzIOcVIPqzw8AdhP+tfrKTZBjwzWhtV2UhCe2k/Dgpez/rr2/ClIBIq1ACnZlgx6oRKf2RMnHYRihrrIwqSGsiBVFZQEJpIX4nCIeXNM7joN38834JKD87i86aqT21A+gzsGDgBwi6DTv/qh8JZvF8ye3OHnFJd7jxaMp0lwZQgch1X2rsuVXdtEQHBf2Kk0afQjFFXEDgQNBr7/9m0mKIhcXZR9TSjNOM8y4fpeSZj3glDA6ZomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxi70BROMjiA915vvnb4mUSw/J3YJnEZl1/tK+kVFxA=;
 b=KDulT5WRJCpgV1NpN2f+M6J3xR6vArDzvhWNRF4axy725c6vkVKJTJ0YvbFg2X65kfdJeniBPcCL7Hlc8SthIVUhI9qlE8R+1AnqoS07ODCazSFeB9+J6A9hQ1nkTmGVWMEUfDbptFVg9LCAQxArdA6Bgf3AE/niCIfX7PYuKIK8TbXhBPwgbpGIkDJ2NRokJAE70lSIhwIplmd2/dcev1TGhIfPag0mnP5iNK2J/E7i+/jn4U6xBBj84/bOy928fwDloRv7GcrM2rQKo6Cbf1gg7BUDAQ2lJOYnYq/Gj6KyxOrtfujAdKRPoLt19j+1713WX8sgCLn71r8UUljNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxi70BROMjiA915vvnb4mUSw/J3YJnEZl1/tK+kVFxA=;
 b=SzippFz5lu+SoBRjoULvYRK8oHn7+OSEJYwOKCr5meDsF9raEOm0RQKeiB5jmOk6sJFwujayAOHpP6DFYYxUa16VLMwazB0Cvnof4ekE0ZUQCQTx+Y4CGbiRaHaENKaowkvWTwU+69n2pVeGR+Bjyn3OMTuVNGBM81sIpLvvBT0=
Received: from SN7PR04CA0086.namprd04.prod.outlook.com (2603:10b6:806:121::31)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 16:40:54 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::68) by SN7PR04CA0086.outlook.office365.com
 (2603:10b6:806:121::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 16:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 16:40:53 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:40:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 2/4] drm/amd/pm: expose swctf threshold setting for legacy powerplay
Date:   Fri, 11 Aug 2023 11:40:29 -0500
Message-ID: <20230811164031.24687-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CO6PR12MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ff2470-6d78-473f-fcb0-08db9a89bae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxDm5zHS76yaE7GPU+PjkS5qG1rPVYk9LlDorCN8pDomEW4NfoAMYR3YTameZ8nyWPfssTrv31gUoBudZV98JxH41gIYt9AWdQ7hWuH45g4/INNCvpkT1JMIbg/QXXvrUPlIQ55Z5V3Rti99GX3UIuFMV8pUGeoGv5ASHSXKc62ff33zIzZBDqO3P/5lGmpXdpcwl3en7JLo757l3OM6sBszv33TK3Q5Q/gEha8RbwntZkvmd3nVZBJ1L1h/VJh8RoCYNIDke1a08LBgvCnGm6wphGATZxSoI6UTYESCD/WKA9iq0pQ36tiGG6mBVUowR+KRz2tDk5n19PiLJsEjpZ5OxdJ94zQyL5WJwRchhg7tNpYCxvUd/Xd0V1/hN873j6t3Bv/fXXblseE0en+tq8wZ9SJQlV5aezcBlC50ZSFeVx781md49yI4rrRGhHdcF46LeJOEFJH6SsKZGSIdWIo1e1vcroNF3b8mVzvuHmfdt24DTxAr9m9KHdkSCbi6BZA+5Y5Nb63fk2fZgsD6A42vuoyG6a5H4novVv0obUOgEnwz2MMqP0ZQwtgZAJ5P9viabq0fVLKUpagZoQE+ZPGZDuM0EWd2Dv4BE1DfNtOQFajhzyI4UPhru5e7v94BnCOXrkHQgFYBo/bhfsdCYUZgDXcvvvr0KdjBO33IsOxSY//TXBbbenKC1zk8aZqhjJDFwFAF5giJPnAcbpYtB57ooe+IWg7RxSQI5OXK7rrtSEWNxPAYB0CUbCKD1gpG1xKcySjBmG3KmlD3ocms0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(1800799006)(186006)(46966006)(36840700001)(40470700004)(4326008)(70206006)(70586007)(6916009)(41300700001)(86362001)(316002)(36756003)(82740400003)(336012)(26005)(1076003)(81166007)(356005)(6666004)(7696005)(16526019)(36860700001)(40480700001)(2616005)(47076005)(83380400001)(426003)(478600001)(40460700003)(2906002)(5660300002)(8676002)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:40:53.9369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ff2470-6d78-473f-fcb0-08db9a89bae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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
index cb5b9df78b4d..338fce249f5a 100644
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
index 7ef7e81525a3..b9e6e49ba4f0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5381,6 +5381,8 @@ static int smu7_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		thermal_data->max = data->thermal_temp_setting.temperature_shutdown *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
+	thermal_data->sw_ctf_threshold = thermal_data->max;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index c8c9fb827bda..c78f8b2b056d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5221,6 +5221,9 @@ static int vega10_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
+	struct phm_ppt_v2_information *pp_table_info =
+		(struct phm_ppt_v2_information *)(hwmgr->pptable);
+	struct phm_tdp_table *tdp_table = pp_table_info->tdp_table;
 
 	memcpy(thermal_data, &SMU7ThermalWithDelayPolicy[0], sizeof(struct PP_TemperatureRange));
 
@@ -5237,6 +5240,13 @@ static int vega10_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
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
index a2f4d6773d45..0fe821dff0a4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2742,6 +2742,8 @@ static int vega12_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
 static int vega12_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *thermal_data)
 {
+	struct phm_ppt_v3_information *pptable_information =
+		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct vega12_hwmgr *data =
 			(struct vega12_hwmgr *)(hwmgr->backend);
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
@@ -2760,6 +2762,8 @@ static int vega12_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	thermal_data->mem_emergency_max = (pp_table->ThbmLimit + CTF_OFFSET_HBM)*
 		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	thermal_data->sw_ctf_threshold = pptable_information->us_software_shutdown_temp *
+		PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index b30684c84e20..8e4743cb7443 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4213,6 +4213,8 @@ static int vega20_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
 static int vega20_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *thermal_data)
 {
+	struct phm_ppt_v3_information *pptable_information =
+		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
@@ -4231,6 +4233,8 @@ static int vega20_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
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

