Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D46779935
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbjHKVIx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjHKVIv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:51 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001C110DE
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBPj3W5spn47ln5Y2vl3doqo370FIh6TYxImrZlYLvQNVkTDs+ji4/IR/TG0TaBdpBPAgvuyyU+LTMMzAM4BXAp2vdKz93C/GCDxqPKOo/Cze1c2TDR0ALburDMsWuZL5cJYKdSiQ9DTAHjppZwQ9nRBB4xLdE+grhQ/tyb2oNKwCqBsUuoYPmXb/2ZD7IkI9g5NO/d30+pkT/maPLlyRXCFP25ru+8ZbZ/wNuGHYNbqfkd5lC7ygXITmEwQFzz6GuIR9vfcu+yreJ5Y+Wp2BFEx/lFVaVDx7TgO7gIhldR+VarZIoXK0EOdSYGVHmQ6L3MmcF3h8nE8kd828T2Z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+dCXU/1BUEKHoX3bw60/OXBof0uIpH5yRAyUVDtLB0=;
 b=L0YX8B4s+YnlEslobjWRsgYr5oSwwO0qtdOMYRNrL9+YoS7HN1Zt4g7PmxtFKcHFSGWA8iiZwmyyed82IDy944ySqCGZ27c5z2vfYB+wGyxWvWaSqatrQp7qcnbVDLm1WRWvPtYN0oK2RW+BWaxyqX4vrm9mlzqgKmi0qiP8JRyloFVU0ssGMYGTHws9Od3YXAybC5UPJTIdMDDxdsS64PM/IyqxfqlUZ8mS95qIq4EbpHbnkLxO1vjVTBEvNnnF4K6gyCgHqycOl2WVXqSsWo+OOKIaHkMgQnCSEWfPRYTqhB3XG+vt7y2GTykoPpz8tarxURu5x4CD/59IwJI9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+dCXU/1BUEKHoX3bw60/OXBof0uIpH5yRAyUVDtLB0=;
 b=Xc6S8v2AM+05i30cCiBghC16A/JQwKlKeX/7x4V2A+RstOYFJHjWdSA5j+/sav8cfWFSfXaVjfMSUSXBENCSj+Cvg8Kcw0BlQLieM+CYDDYKIaaTBgM82dvnAcqJ/ajqRgn4nWaVn5unEA65CZDKW8GWoH/bmNYXd/jxq6JFSVk=
Received: from MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::14)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:08:48 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::da) by MW4P222CA0009.outlook.office365.com
 (2603:10b6:303:114::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:43 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 07/10] drm/amd/display: Disable phantom OTG after enable for plane disable
Date:   Fri, 11 Aug 2023 16:07:05 -0500
Message-ID: <20230811210708.14512-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811210708.14512-1-mario.limonciello@amd.com>
References: <20230811210708.14512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 7949a687-c662-40f0-3314-08db9aaf27cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqRvjzxRmh+Zw3TUIoBkFYKSK/We4ov32h0om2br4lTLwHiA/MYuUbqSj24+OPYoS3XanMpBV7AQhzE2+bjej2kfHPGIKIyKVmGeFHCpEu8EZbAF6s9xOaV2waL6P3sWAdTHaGDFS1+Sp86/sLPmf/p3XKzoHG53hxU751iRRwF7JEgYuwQn/gan7z1UaPuD3w3ci4KNP/DSsG7deWovH95vT2Q4kH0JhnLaNe//xruGF/X/ahFKWsNCnH1SLiDew8nF5CSzMJbLSEhgnMNMAtNXc1Zb024LWhVJR7GCJBiJqmY0ZsREPRuk4/n/HcQI2FcXbcR+C6kGoXQzOxFQsYYnVuXgxM1HnkS8yUN6bAb47TIkJdgZixptE7sf/ViZiJsAG0nfnmP+NyxALZiSGcPSWmX2nOhf3FnF3MfUNMiIeKV/1HB/t2ib6vS18jGgzW1RxTXp4FnNsH9XImP6EApJW2xQCp4gAuSp1KUk9ymH3+nMxXZx+9ZiWuxQGFIRXkxzynCZHh/XDg8WHuyhNXUtkFmd5T9+Tq2t8hFJQpE0R57v0+0Qv84Gi82+hGFzUDAWrF8+bOhYIGhBRfuGZvwJs6x9lGDGv7O49VuewowtHj/uZPatrj7qir/Uc9IyigRwHvihJxR7oi0lNv8/Iu+pjjR0ja0e71EAjbHavJrotLNN7zdBQg5djxylOqxysUEfkB17ffI5OuZjVofzHcRlXRF6aHZRqD//e6EPOBL1mFGzuaM7nsQMCVe4wLjFDfqbvemqXWM2JqfmAk5Sug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(82310400008)(451199021)(186006)(1800799006)(40470700004)(36840700001)(46966006)(5660300002)(26005)(1076003)(8936002)(8676002)(41300700001)(82740400003)(40460700003)(36860700001)(36756003)(47076005)(2906002)(426003)(83380400001)(81166007)(356005)(2616005)(16526019)(44832011)(86362001)(336012)(4326008)(70586007)(70206006)(6916009)(40480700001)(6666004)(54906003)(478600001)(7696005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:47.9077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7949a687-c662-40f0-3314-08db9aaf27cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Need to disable phantom OTG after it's enabled
  in order to restore it to it's original state.
- If it's enabled and then an MCLK switch comes in
  we may not prefetch the correct data since the phantom
  OTG could already be in the middle of the frame.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dc55b106ad477c67f969f3432d9070c6846fb557)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 14 +++++++++++++-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |  8 ++++++++
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c9ed0346b88c..f16a9e410d16 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1079,6 +1079,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 	struct dc_state *dangling_context = dc_create_state(dc);
 	struct dc_state *current_ctx;
 	struct pipe_ctx *pipe;
+	struct timing_generator *tg;
 
 	if (dangling_context == NULL)
 		return;
@@ -1122,6 +1123,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 
 		if (should_disable && old_stream) {
 			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			tg = pipe->stream_res.tg;
 			/* When disabling plane for a phantom pipe, we must turn on the
 			 * phantom OTG so the disable programming gets the double buffer
 			 * update. Otherwise the pipe will be left in a partially disabled
@@ -1129,7 +1131,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			 * again for different use.
 			 */
 			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
-				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+				if (tg->funcs->enable_crtc)
+					tg->funcs->enable_crtc(tg);
 			}
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
@@ -1146,6 +1149,15 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 				dc->hwss.interdependent_update_lock(dc, dc->current_state, false);
 				dc->hwss.post_unlock_program_front_end(dc, dangling_context);
 			}
+			/* We need to put the phantom OTG back into it's default (disabled) state or we
+			 * can get corruption when transition from one SubVP config to a different one.
+			 * The OTG is set to disable on falling edge of VUPDATE so the plane disable
+			 * will still get it's double buffer update.
+			 */
+			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
+				if (tg->funcs->disable_phantom_crtc)
+					tg->funcs->disable_phantom_crtc(tg);
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index fe941b103de8..a974f86e718a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -167,6 +167,13 @@ static void optc32_phantom_crtc_post_enable(struct timing_generator *optc)
 	REG_WAIT(OTG_CLOCK_CONTROL, OTG_BUSY, 0, 1, 100000);
 }
 
+static void optc32_disable_phantom_otg(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_UPDATE(OTG_CONTROL, OTG_MASTER_EN, 0);
+}
+
 static void optc32_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing)
 {
@@ -260,6 +267,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.enable_crtc = optc32_enable_crtc,
 		.disable_crtc = optc32_disable_crtc,
 		.phantom_crtc_post_enable = optc32_phantom_crtc_post_enable,
+		.disable_phantom_crtc = optc32_disable_phantom_otg,
 		/* used by enable_timing_synchronization. Not need for FPGA */
 		.is_counter_moving = optc1_is_counter_moving,
 		.get_position = optc1_get_position,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index f96fb425345e..974f2c118a44 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -184,6 +184,7 @@ struct timing_generator_funcs {
 	bool (*disable_crtc)(struct timing_generator *tg);
 #ifdef CONFIG_DRM_AMD_DC_DCN
 	void (*phantom_crtc_post_enable)(struct timing_generator *tg);
+	void (*disable_phantom_crtc)(struct timing_generator *tg);
 #endif
 	bool (*immediate_disable_crtc)(struct timing_generator *tg);
 	bool (*is_counter_moving)(struct timing_generator *tg);
-- 
2.34.1

