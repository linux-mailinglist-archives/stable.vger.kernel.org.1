Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA00771846
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHGCVx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHGCVt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FC7171A
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktwCdjhNNI7j9NSJYySbgOl2PUkvTW8eOiZg9ukOrNTYbeX7rhhwFXO1etfcGYYi8VbthwrR8zefEhSZL6OTAaVNKIJILFEF7sivtH9e8H3/iEJpaClbwcV5xA6DjzY3zg1cGzY3JVcl/dkuj8mL/+wfkTau4XtVXjpy3j936zCV7lxVb3KE+JjqyX5GCuo1pOn4rA12I7MmmExBklqn34SrBhMjT6mCE5vdYe8Ldtt2YaKLhBnDIIiolVEBZzW/70iy9O15whWTmbzzdJcctz9kccNfH4t79iwpYs0fsE9SxlbKtOD55o8lr47fscLgyKwDr1bVu/o/hRaanjaI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC05DPFNQKm5JjY4hbhK+jVp7JO4y2GW5R1Ql9CL3Eo=;
 b=K0hybnRq7WJpwfuWl8bIZR7wEYLUncO8z0yLf151OJIfY5sCcg5HSLkduF31x5AHpYBPRZTAN62O3zsdkWnrfaE/uk32CZWL7tID1W2x7m6m/GJl0sTTBZ95W7886n4AkrY1utgqcLcB8+MFQVnczyMP/MvCFp+mSzFR3O7nZszAA2AiXpceYrMK+RTKhblaNllay+9F5yS6P3FW4IvJPw6VrtIMfc6jAwwpILzjWi2sIAySVjkxmW+qQY7Sln/f5uJBI/yvvdLArnRgH0ehrwmk+h0MfxTG2WNZ3K+UONn7YTzFlAA5pHp7tz3+khxmMgN2QmHXHfMmEXVm2Nq8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC05DPFNQKm5JjY4hbhK+jVp7JO4y2GW5R1Ql9CL3Eo=;
 b=v1Nn67rfKuoiV27eU/mVjZu+e4BcByftc1wsYOieJHl0Q5FQWHv/MpGH7SdP3ROiNviuV3taaWg00lRmS7LdOl6b+v0GSuUW2+Txqo8OPqiSrYyxNkKETfYY9uRb2EUqDEBxEjv7+EHfepYXMITumAMryJ1f31AP9gAk6NqcqRA=
Received: from SJ0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:a03:3a1::30)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:21:44 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::9c) by SJ0PR03CA0385.outlook.office365.com
 (2603:10b6:a03:3a1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 02:21:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:40 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:38 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Alan Liu <HaoPing.Liu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y 08/10] drm/amd/display: Disable phantom OTG after enable for plane disable
Date:   Mon, 7 Aug 2023 10:20:53 +0800
Message-ID: <20230807022055.2798020-8-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 13cb2186-04ee-4445-fc03-08db96ed0af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63BhgyoJWbHO+Swo2kxN69iEiAIxTXz83c2zCQsHWNGoSr9DHO4yVoJ1j7jo5kA8ED+NoRs8/123osGaOCfWCxnea5WUdu2xSGOcKNTCb9m7IVCqvXzbrYdjfroYKV4c/qjxK+7HKnYvT2VYBV8lXGwyoYvzUlhvmp5YzUNk3ed5u8r409fw6Q+6IQfacvZmlbyR/clpdo2uctL5xtIADBJLtYHYimiqpXrhcnHujAfp4XK2W5twfMo9QIpoLwrCNXWvAO40Hp2mnvaxUcWerRCYgqbwCIIV8Wk4ptzeyIEfPHao8jpzQEILUNtzBRcOFVX3AtZg9NPhhibh9vw3jjFpH82f8XL9R4igsJfv/qAEneMzbcc6lf5c2TU3ohOLCkTSUfmXjWjuba1vK8tSMhNuDTKqcghe4UrmVJP7cGjT7yr8D3BDAVKepxGtLDk3Irvymbos/oyzlHOmX0ZVpFG0MdPA27zoM8VARS8gBEfd7YHGEK2PoCLnermBZ6wD4dTnjUf+dBpHEWmjMcOYNxEaFs9bsAZVzT6QrZS049M0KJCh59gr/pCyyBDZvtVAaCZXnSGXApKSCLouFR2H34Owr3MiPI5YJTXLR6Qbgp2ADYXgETXMdbeRKYKOSwclesulsPf7Ee4GG8C5SzLNOTFuZjBv7xSQkaoZXyy/NM3/dYpxaxbMNGWo2OkSUPvg+711PM9C08TPSw8PvUQRY9JYFehTrie15FkBJD8/JwIcz01roBfblD+8XAIcrT/5gQbWh+6KQYmm5rucgMGQhVMCD4b8k/KV6n6TkYJBYdU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(82310400008)(186006)(1800799003)(40470700004)(46966006)(36840700001)(40480700001)(336012)(40460700003)(2616005)(36756003)(4326008)(316002)(6916009)(86362001)(478600001)(81166007)(54906003)(356005)(70206006)(6666004)(70586007)(7696005)(82740400003)(41300700001)(1076003)(26005)(426003)(8936002)(8676002)(47076005)(36860700001)(2906002)(83380400001)(5660300002)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:43.6959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cb2186-04ee-4445-fc03-08db96ed0af5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

