Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8E76F4EA9
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 03:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjECBmB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 21:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECBmB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 21:42:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805A1FD2
        for <stable@vger.kernel.org>; Tue,  2 May 2023 18:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsutnSRvdFcOcFxW1Oo2aZ615naZVP4ZpetVJW/rrskoRs8Iys6Q1jonbGQATTz/pn5PXb7DvCa4YqiSVaZ+Z+b0EvMIxoKVRbnsOCM1L0XcHyeqpS0CLrwUhvuy8p2Ny7ZWX05bDa7mH2Z3rGD0jSIl4uGG6LvUs744E/86goYD0P66Et8NDV8TwKNE31z4lzwu4Qi+s1y/AXlkDUZB3yuMeWwzxhQ+6xaxWM/YKm7VPvhKm8RFMpHLDUAMf/cllfOlXvoQPV3UiXLGrt1dljzQiloto8MUk2U8JcYYJfDgn5UMLk0usv5AbkkUpUU7XAlNkoULTvWxvDpUWwtkaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3O8AhQNG8eOoYyNmZUtji9OLLl8WrLEAi7Y+kGPXdU=;
 b=G5pcaUQRK9msh+OZ9MXDOpWFR/njBfoJ+oifBvFLUole5GsmKhE6igtpuPXHqnTL+67RjoGApASSWPcxRWSmt90709/2GTYmP2GTFqbsUP9Vq04odnYobRGECelQRkMP0y7yeGDsgnu7L7FjGQtdsbdq0UK2REnwZEZGTWzrPa9AranY0+1bXJsevLE/9/qfzoea5gKM8P5ebO7m4vYGFLGibm968hA0ZlLs6CqIWjTfslwaHq6ojgFEOpMNv4ZjAn+jkKApdzp6XXtUBKtSXz1H+UJByUHlnWEEPWBORUFRKYy2s9qksUPbU26xLDoTgWyFnFujv+uH4aXMU3kr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3O8AhQNG8eOoYyNmZUtji9OLLl8WrLEAi7Y+kGPXdU=;
 b=ACK3yWbG4baA0eaCbaIUHewFXlpam4SsjAdhXFf6MOZkwM2FamJTHU6M3whBrbT08gLSmeQwEd2YPMb+0d6Rhc3vzzYG+t+t3yLnvUUL0dILo41jhUCWngvdCPoYgQ0GZKcMUGUI5GbTgZ0NnQ0QeRwgbpz5djK0Kyo7jbV5afQ=
Received: from DM6PR05CA0060.namprd05.prod.outlook.com (2603:10b6:5:335::29)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 01:41:55 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::b8) by DM6PR05CA0060.outlook.office365.com
 (2603:10b6:5:335::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Wed, 3 May 2023 01:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Wed, 3 May 2023 01:41:54 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 20:41:52 -0500
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
        Nevenko Stupar <Nevenko.Stupar@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 5/8] drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK modes
Date:   Tue, 2 May 2023 19:38:50 -0600
Message-ID: <20230503013853.2266793-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503013853.2266793-1-alex.hung@amd.com>
References: <20230503013853.2266793-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 86eabcb8-31f0-401e-bf11-08db4b779362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5sR421E78L2lpvacfj0nm7hPfA5oozTBTETuRQsxRX6xNnCHeUBDbsXHw35TBjzphZKWykcYoRJDMnu+zGTHM5q/Z01d3plw3GrRbnEhEyQdFY/IQxEzuAO41aErC7HxgnlYQQtAIEqFmKugU6JYfKe1hbQk/zKd/ObnmQ7rSVbIfhnSVWnAqh01E/WkO02ZuOYFPfAEpoG1BbNlz3ivhZJPLcYA0P+e/JWsuiDadXxHW1+0EvTElC+coOLwbcDVSPPbDWkDGNbG86/h+i/xRJ8AXN7bvFeSkyhArPF1cSyXTOgZBRnLAxqyLOhVm+oVJBYLeTr7jJH06GanUJUuE2HbO0oLKwXhbbRfy2cB2NWEKgDT6peChv0vyHdKtWYY4g6d7LfOx+SFlJIuYP0uMi82DZcDkva1fk3GoYHML8A/vDT7sawnR0tMUdQC3e5GNA60l4ymP51uRuhYn4CdmmtjsPx2FEGZKW5tQQiko6C66L7+6SarI1X2qaSe4CsDghKmqmEraqwqnuoZ3XZHngLAK2hyLwuKXF/Aq2megLorFjOclhqGzCjReifdGP6DIANeUepWokN60SddBJbjizzyCthF9dTRY51b1AJkHGPPyBYZFWuad2fFD2sA7Car7ZWi4lcxLy1aN6SZ95ty4xWSztg6Cbu1SngkvOHpKKlFb3YqhhE0YpPaDogTUmCD6mkd4Zf1t8XIP/hafdwuXGcq4fcCbFdU2oEnOJwL9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(8676002)(478600001)(316002)(36756003)(86362001)(7696005)(4326008)(82310400005)(6916009)(41300700001)(40480700001)(70586007)(70206006)(82740400003)(356005)(81166007)(5660300002)(40460700003)(8936002)(426003)(83380400001)(336012)(2616005)(54906003)(47076005)(26005)(186003)(16526019)(1076003)(2906002)(44832011)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:41:54.8189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86eabcb8-31f0-401e-bf11-08db4b779362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Due to bandwidth / arbitration issues at 200Mhz DCFCLK,
  we want to enforce minimum 60us of prefetch to avoid
  intermittent underflow issues
- Since 60us prefetch is already enforced for UCLK DPM0,
  and many DCFCLK's > 200Mhz are mapped to UCLK DPM1, in
  theory there should not be any UCLK DPM regressions by
  enforcing greater prefetch

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c   | 5 +++--
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h   | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 66f44a013fe5..958d27224f64 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -810,7 +810,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->SwathHeightY[k],
 					v->SwathHeightC[k],
 					TWait,
-					v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ?
+					(v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ||
+						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= MIN_DCFCLK_FREQ_MHZ) ?
 							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 					/* Output */
 					&v->DSTXAfterScaler[k],
@@ -3314,7 +3315,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->swath_width_chroma_ub_this_state[k],
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k], v->TWait,
-							v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ ?
+							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= MIN_DCFCLK_FREQ_MHZ) ?
 									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 
 							/* Output */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
index 500b3dd6052d..d98e36a9a09c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -53,6 +53,7 @@
 #define BPP_BLENDED_PIPE 0xffffffff
 
 #define MEM_STROBE_FREQ_MHZ 1600
+#define MIN_DCFCLK_FREQ_MHZ 200
 #define MEM_STROBE_MAX_DELIVERY_TIME_US 60.0
 
 struct display_mode_lib;
-- 
2.40.0

