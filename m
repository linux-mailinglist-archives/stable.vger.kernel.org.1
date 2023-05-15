Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9057037D5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbjEORYa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244044AbjEORYJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67210A24
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B172762C7D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A645BC433EF;
        Mon, 15 May 2023 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171373;
        bh=+iRjEQMc3XFyo9r2LvJ0OjVw+r0+8kI64r7VWxDMRAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dT3LddSN+Z5Nj+9niEErF8bzU90a/VNjJ1T494DA34okhor9ZwTSRaISxEp0L94H9
         vWYiKXivLWGnxr18KzrpF+rgtOwyybX+TPHFIo+4AR7fjlul2kSGJ9S+8YVohqX3PV
         uAYBqwbrCN7mqRKv9bKKKJJN2bD2gBTAohM+iNIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.2 188/242] drm/amd/display: Fix 4to1 MPC black screen with DPP RCO
Date:   Mon, 15 May 2023 18:28:34 +0200
Message-Id: <20230515161727.587793293@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

commit bf224e00a9f54e2bf14b4d720a09c3d2f4aa4aa8 upstream.

[Why]
DPP Root clock optimization when combined with 4to1 MPC combine results
in the screen turning black.

This is because the DPPCLK is stopped during the middle of an
optimize_bandwidth sequence during commit_minimal_transition without
going through plane power down/power up.

[How]
The intent of a 0Hz DPP clock through update_clocks is to disable the
DTO. This differs from the behavior of stopping the DPPCLK entirely
(utilizing a 0Hz clock on some ASIC) so it's better to move this logic
to reside next to plane power up/power down where we gate the HUBP/DPP
DOMAIN.

The new  sequence should be:
Power down: PG enabled -> RCO on
Power up: RCO off -> PG disabled

Rename power_on_plane to power_on_plane_resources to reflect the
actual operation that's occurring.

Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |   12 ++++++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c        |    8 +++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c         |   13 +------
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c       |   23 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c      |   10 ++++++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h      |    2 +
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c       |    1 
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h              |   23 +++++++-------
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h |    4 ++
 9 files changed, 71 insertions(+), 25 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -728,11 +728,15 @@ void dcn10_hubp_pg_control(
 	}
 }
 
-static void power_on_plane(
+static void power_on_plane_resources(
 	struct dce_hwseq *hws,
 	int plane_id)
 {
 	DC_LOGGER_INIT(hws->ctx->logger);
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, plane_id, true);
+
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 1);
@@ -1239,11 +1243,15 @@ void dcn10_plane_atomic_power_down(struc
 			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
 
 		dpp->funcs->dpp_reset(dpp);
+
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 0);
 		DC_LOG_DEBUG(
 				"Power gated front end %d\n", hubp->inst);
 	}
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
 }
 
 /* disable HW used by plane.
@@ -2464,7 +2472,7 @@ static void dcn10_enable_plane(
 
 	undo_DEGVIDCN10_253_wa(dc);
 
-	power_on_plane(dc->hwseq,
+	power_on_plane_resources(dc->hwseq,
 		pipe_ctx->plane_res.hubp->inst);
 
 	/* enable DCFCLK current DCHUB */
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1110,11 +1110,15 @@ void dcn20_blank_pixel_data(
 }
 
 
-static void dcn20_power_on_plane(
+static void dcn20_power_on_plane_resources(
 	struct dce_hwseq *hws,
 	struct pipe_ctx *pipe_ctx)
 {
 	DC_LOGGER_INIT(hws->ctx->logger);
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, pipe_ctx->plane_res.dpp->inst, true);
+
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 1);
@@ -1138,7 +1142,7 @@ static void dcn20_enable_plane(struct dc
 	//if (dc->debug.sanity_checks) {
 	//	dcn10_verify_allow_pstate_change_high(dc);
 	//}
-	dcn20_power_on_plane(dc->hwseq, pipe_ctx);
+	dcn20_power_on_plane_resources(dc->hwseq, pipe_ctx);
 
 	/* enable DCFCLK current DCHUB */
 	pipe_ctx->plane_res.hubp->funcs->hubp_clk_cntl(pipe_ctx->plane_res.hubp, true);
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -66,17 +66,8 @@ void dccg31_update_dpp_dto(struct dccg *
 		REG_UPDATE(DPPCLK_DTO_CTRL,
 				DPPCLK_DTO_ENABLE[dpp_inst], 1);
 	} else {
-		//DTO must be enabled to generate a 0Hz clock output
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp) {
-			REG_UPDATE(DPPCLK_DTO_CTRL,
-					DPPCLK_DTO_ENABLE[dpp_inst], 1);
-			REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
-					DPPCLK0_DTO_PHASE, 0,
-					DPPCLK0_DTO_MODULO, 1);
-		} else {
-			REG_UPDATE(DPPCLK_DTO_CTRL,
-					DPPCLK_DTO_ENABLE[dpp_inst], 0);
-		}
+		REG_UPDATE(DPPCLK_DTO_CTRL,
+				DPPCLK_DTO_ENABLE[dpp_inst], 0);
 	}
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
 }
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -289,8 +289,31 @@ static void dccg314_set_valid_pixel_rate
 	dccg314_set_dtbclk_dto(dccg, &dto_params);
 }
 
+static void dccg314_dpp_root_clock_control(
+		struct dccg *dccg,
+		unsigned int dpp_inst,
+		bool clock_on)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (clock_on) {
+		/* turn off the DTO and leave phase/modulo at max */
+		REG_UPDATE(DPPCLK_DTO_CTRL, DPPCLK_DTO_ENABLE[dpp_inst], 0);
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+			  DPPCLK0_DTO_PHASE, 0xFF,
+			  DPPCLK0_DTO_MODULO, 0xFF);
+	} else {
+		/* turn on the DTO to generate a 0hz clock */
+		REG_UPDATE(DPPCLK_DTO_CTRL, DPPCLK_DTO_ENABLE[dpp_inst], 1);
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+			  DPPCLK0_DTO_PHASE, 0,
+			  DPPCLK0_DTO_MODULO, 1);
+	}
+}
+
 static const struct dccg_funcs dccg314_funcs = {
 	.update_dpp_dto = dccg31_update_dpp_dto,
+	.dpp_root_clock_control = dccg314_dpp_root_clock_control,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
 	.dccg_init = dccg31_init,
 	.set_dpstreamclk = dccg314_set_dpstreamclk,
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -392,6 +392,16 @@ void dcn314_set_pixels_per_cycle(struct
 				pix_per_cycle);
 }
 
+void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
+{
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpp)
+		return;
+
+	if (hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control)
+		hws->ctx->dc->res_pool->dccg->funcs->dpp_root_clock_control(
+			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on);
+}
+
 void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
 {
 	struct dc_context *ctx = hws->ctx;
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -43,4 +43,6 @@ void dcn314_set_pixels_per_cycle(struct
 
 void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
 
+void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
+
 #endif /* __DC_HWSS_DCN314_H__ */
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -137,6 +137,7 @@ static const struct hwseq_private_funcs
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
 	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
+	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
 	.hubp_pg_control = dcn314_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -148,18 +148,21 @@ struct dccg_funcs {
 		struct dccg *dccg,
 		int inst);
 
-void (*set_pixel_rate_div)(
-        struct dccg *dccg,
-        uint32_t otg_inst,
-        enum pixel_rate_div k1,
-        enum pixel_rate_div k2);
+	void (*set_pixel_rate_div)(struct dccg *dccg,
+			uint32_t otg_inst,
+			enum pixel_rate_div k1,
+			enum pixel_rate_div k2);
 
-void (*set_valid_pixel_rate)(
-        struct dccg *dccg,
-	int ref_dtbclk_khz,
-        int otg_inst,
-        int pixclk_khz);
+	void (*set_valid_pixel_rate)(
+			struct dccg *dccg,
+			int ref_dtbclk_khz,
+			int otg_inst,
+			int pixclk_khz);
 
+	void (*dpp_root_clock_control)(
+			struct dccg *dccg,
+			unsigned int dpp_inst,
+			bool clock_on);
 };
 
 #endif //__DAL_DCCG_H__
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -115,6 +115,10 @@ struct hwseq_private_funcs {
 	void (*plane_atomic_disable)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*enable_power_gating_plane)(struct dce_hwseq *hws,
 		bool enable);
+	void (*dpp_root_clock_control)(
+			struct dce_hwseq *hws,
+			unsigned int dpp_inst,
+			bool clock_on);
 	void (*dpp_pg_control)(struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool power_on);


