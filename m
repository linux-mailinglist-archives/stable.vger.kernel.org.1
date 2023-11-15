Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D57ECED9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjKOToy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjKOTox (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:53 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED519F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrOvMx0wbY7fU2FGYYLSIQulGawCSr4gSPcykcOpNsn6VrgXbhcBeNYIg6L4C3hlUXPP/nb/4q8AgibnoA/68la13DkswC59gwdxY3LL5q5y429x4JvYPQr8CrYCp17f8y5NWcxoLDh6DshkmRdMHCWWgho1MQVttwzAVFUU2QZo+IK/H21jlXbXwzqu7qgLx0IlMELuEiwlHlcQ3MWwqB9JluPvD9T/rSn7/zKd3iAyBviQSw3n1zgRQJWMLSTjU82vkNAEX5XijaPx5FCfw45uhZYaAPBdfzYzYG1P1JC2xTnW48OYN5wNlfptHfDqLJ7Ne7niN3+/xFYo6QomtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNR8hZY8hlIIL3z7rW+Tq1aQ8lEWh23a+zqLqeJXlWg=;
 b=bfeqZqWDNXjoHdiVho6Xt6EgnoGCzzHPd/n+0C3YCp4KsXW6yJhxkYGPGLMXBG/MUtmZmN56/O5BASlG4yJyEmQSCXiQYpiWHMlMjWTwi5v48tJBBAWX2oqwjFY5cQrThBtsqCXf4gPgNOEw+NRNGj6zZvX6VzJh8ZQzOKiC0y4hI97hFahcTes94akRlp58cOCDXTurrKfF7rubs2quJekGfV3/ncEHuj5CVjs5E1A1ubybK6clrjxwQt9WLiqH9gKhvld5BbFgPnXbYTuWsfx/FTDfZzOd9C9qPhziNzHCy28xglrE5KL9GT/qbW7iiRZ4XAj47gt81zVdomfEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNR8hZY8hlIIL3z7rW+Tq1aQ8lEWh23a+zqLqeJXlWg=;
 b=J71gwuO4+gVjYJyuBrL13CmnlIxVdd4nqy9iWYmCxECdoZ9ZrXpd0a0p5hqLnGq02spUzn0lNGcfW4kZHn3rFnu/GKDwymzEFK3vOEL1WnlmC4Kh4nNvoCDOXQioSpOsFi/gK5RsRAcexOvDJoxFIsGr+4sfeHrEeo4GK4WOimM=
Received: from MN2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:208:23e::19)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:45 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::c6) by MN2PR14CA0014.outlook.office365.com
 (2603:10b6:208:23e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:45 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:43 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Taimur Hassan" <syed.hassan@amd.com>, <stable@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 31/35] drm/amd/display: Fix conversions between bytes and KB
Date:   Wed, 15 Nov 2023 14:40:44 -0500
Message-ID: <20231115194332.39469-32-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d545c7b-b68f-47a5-5faf-08dbe61351d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07xB6z9bkCaw0txnb0PMbUaSCCTGRrlPXYHRp2FNmpmRsKt8LnKU3xlNgphjEsxCu0TdHwnBUuv7HdcuTy30oen0KxxDNLGZFlN2BnHdzXDcFeShn+yRSK0V6lLKGir2649PLzcv9w3tQhdl0aC8XAtBIsjJPb0LQjbKDzhKGClgCKshvIeTB5FjWnQ5IexA4PApzHc8kCW5APtsnoKyKWnqpopeYbVVJHAvCBYGLny3xAmyqMe8Vl27AdFkdgNTdrvqEODZtdHk/OhJn1BI6sy4MtCIhp46+Xg6yKuh7eeY+fQUslANyQdRiYNlqJ2fEqPTKBKMHlLN+PCupGrUCm8kYXEmcwZzW5LJAX5dSSyJJ2BwFjhKRNLOjSYeVCvr/xk8cWH1NyfO8UINZrGN+2CJ+nokG0p49KQYs0HWBYp9m7JSngPcueF0IwhLfIdU7rS00MasIr1QeNWQXQ/Lh+2BijiPwBIV2LRP7pNUjw+CKk7o/h65dycGuWLgbXFj2a8Np5jHfSEM71UiC4AdpCfd9KMsu+Q6tDAz3UbAUUlFVR+4eQkGh2F8aDbCSVN3gLHuuUn2iCc8BhgHr0fhmWLPBINtMYTl58gmkk/Gf+8mCQiS2TyL9QguNPjVtpKzODV496KOLEKsXlWH4/16ZmG8KUMR10BYkCnGuOwMLTdszwjc6q5qaX0hGEWN+o/nDIy+GYLHqqu/X50Mja+b/jbhUpNDoPzLIBboGv3AIEjfihwXWTnetyYmhMcvCf+W9nM1W8+B27M0ojvlP6HKDCrBTKxmSJLdqg4n2y8iZlLvFqwmYu7OuzMqCJVxA1zxLyJdFe0/eZiXnlupEfa0rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(82740400003)(36756003)(2616005)(26005)(1076003)(5660300002)(8676002)(4326008)(8936002)(16526019)(54906003)(2906002)(426003)(83380400001)(336012)(316002)(70586007)(70206006)(6916009)(478600001)(44832011)(356005)(81166007)(40480700001)(36860700001)(41300700001)(47076005)(36900700001)(16060500005)(44824005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:45.4253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d545c7b-b68f-47a5-5faf-08dbe61351d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
There are a number of instances where we convert HostVMMinPageSize or
GPUVMMinPageSize from bytes to KB by dividing (rather than multiplying) and
vice versa.
Additionally, in some cases, a parameter is passed through DML in KB but
later checked as if it were in bytes.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 .../amd/display/dc/dml2/display_mode_core.c    | 18 +++++++++---------
 .../display/dc/dml2/dml2_translation_helper.c  |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index fe1f97e03aa5..2e7fe46fc689 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6277,7 +6277,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 				mode_lib->ms.NoOfDPPThisState,
 				mode_lib->ms.dpte_group_bytes,
 				s->HostVMInefficiencyFactor,
-				mode_lib->ms.soc.hostvm_min_page_size_kbytes,
+				mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
 				mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels);
 
 		s->NextMaxVStartup = s->MaxVStartupAllPlanes[j];
@@ -6355,7 +6355,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 				CalculatePrefetchSchedule_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
 				CalculatePrefetchSchedule_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
 				CalculatePrefetchSchedule_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
-				CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
+				CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
 				CalculatePrefetchSchedule_params->DynamicMetadataEnable = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataEnable[k];
 				CalculatePrefetchSchedule_params->DynamicMetadataVMEnabled = mode_lib->ms.ip.dynamic_metadata_vm_enabled;
 				CalculatePrefetchSchedule_params->DynamicMetadataLinesBeforeActiveRequired = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataLinesBeforeActiveRequired[k];
@@ -6533,7 +6533,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 						mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
 						mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels,
 						mode_lib->ms.cache_display_cfg.plane.GPUVMEnable,
-						mode_lib->ms.soc.hostvm_min_page_size_kbytes,
+						mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
 						mode_lib->ms.PDEAndMetaPTEBytesPerFrame[j][k],
 						mode_lib->ms.MetaRowBytes[j][k],
 						mode_lib->ms.DPTEBytesPerRow[j][k],
@@ -7678,7 +7678,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 		CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
 		CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
 		CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
-		CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
+		CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
 		CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
 		CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
 		CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = mode_lib->ms.PTEBufferSizeNotExceededPerState;
@@ -7948,7 +7948,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 		UseMinimumDCFCLK_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
 		UseMinimumDCFCLK_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
 		UseMinimumDCFCLK_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
-		UseMinimumDCFCLK_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
+		UseMinimumDCFCLK_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
 		UseMinimumDCFCLK_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
 		UseMinimumDCFCLK_params->DynamicMetadataVMEnabled = mode_lib->ms.ip.dynamic_metadata_vm_enabled;
 		UseMinimumDCFCLK_params->ImmediateFlipRequirement = s->ImmediateFlipRequiredFinal;
@@ -8690,7 +8690,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 	CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
 	CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
 	CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
-	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
+	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
 	CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
 	CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
 	CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = s->dummy_boolean_array[0];
@@ -8796,7 +8796,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			mode_lib->ms.cache_display_cfg.hw.DPPPerSurface,
 			locals->dpte_group_bytes,
 			s->HostVMInefficiencyFactor,
-			mode_lib->ms.soc.hostvm_min_page_size_kbytes,
+			mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
 			mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels);
 
 	locals->TCalc = 24.0 / locals->DCFCLKDeepSleep;
@@ -8986,7 +8986,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			CalculatePrefetchSchedule_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
 			CalculatePrefetchSchedule_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
 			CalculatePrefetchSchedule_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
-			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
+			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
 			CalculatePrefetchSchedule_params->DynamicMetadataEnable = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataEnable[k];
 			CalculatePrefetchSchedule_params->DynamicMetadataVMEnabled = mode_lib->ms.ip.dynamic_metadata_vm_enabled;
 			CalculatePrefetchSchedule_params->DynamicMetadataLinesBeforeActiveRequired = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataLinesBeforeActiveRequired[k];
@@ -9231,7 +9231,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 						mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
 						mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels,
 						mode_lib->ms.cache_display_cfg.plane.GPUVMEnable,
-						mode_lib->ms.soc.hostvm_min_page_size_kbytes,
+						mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
 						locals->PDEAndMetaPTEBytesFrame[k],
 						locals->MetaRowByte[k],
 						locals->PixelPTEBytesPerRow[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 2b9638c6d9b0..48caa34a5ce7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -515,8 +515,8 @@ void dml2_translate_socbb_params(const struct dc *in, struct soc_bounding_box_st
 	out->do_urgent_latency_adjustment = in_soc_params->do_urgent_latency_adjustment;
 	out->dram_channel_width_bytes = (dml_uint_t)in_soc_params->dram_channel_width_bytes;
 	out->fabric_datapath_to_dcn_data_return_bytes = (dml_uint_t)in_soc_params->fabric_datapath_to_dcn_data_return_bytes;
-	out->gpuvm_min_page_size_kbytes = in_soc_params->gpuvm_min_page_size_bytes * 1024;
-	out->hostvm_min_page_size_kbytes = in_soc_params->hostvm_min_page_size_bytes * 1024;
+	out->gpuvm_min_page_size_kbytes = in_soc_params->gpuvm_min_page_size_bytes / 1024;
+	out->hostvm_min_page_size_kbytes = in_soc_params->hostvm_min_page_size_bytes / 1024;
 	out->mall_allocated_for_dcn_mbytes = (dml_uint_t)in_soc_params->mall_allocated_for_dcn_mbytes;
 	out->max_avg_dram_bw_use_normal_percent = in_soc_params->max_avg_dram_bw_use_normal_percent;
 	out->max_avg_fabric_bw_use_normal_percent = in_soc_params->max_avg_fabric_bw_use_normal_percent;
-- 
2.42.0

