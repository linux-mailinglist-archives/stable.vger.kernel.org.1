Return-Path: <stable+bounces-146461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA0AC5338
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8663F17FB8C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB17227F737;
	Tue, 27 May 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmbgt7HK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051413A244;
	Tue, 27 May 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364268; cv=none; b=gkM9/WQXTWiUrZkWocEzgvicuh8q6YPJzto+S0daredHPQGlpvkZO2hMTx/KDdBcusaIuSU7a3OdE/jKGdlCHNFJCtN9bpdAGALdsyyED4IY4aOXWv5pHSrl6wUBJhnmCF62AWzWWMw2ENeP9yG4qwawmJVH7KCgNHfIh0K3YpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364268; c=relaxed/simple;
	bh=PXIiai3zXouy7fIC7kpdEWoEDN/ZX+EJvrv3egI5OVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQIOPa8mLa6A/Kf0i1m8t6lQS7GBbGmK8gJTtthRIoautym1D011hptYOTR1Z1N4TKivJHAxeJyJx5+xFehcbkJIgAlUwZte/3Ol32HDIDuGxhNmRrRyDOyWrOhDkJDaWwH5LUFfYNYs0Oum/fw0xv16scmrWsYq7Ic75XfbEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qmbgt7HK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C32BC4CEE9;
	Tue, 27 May 2025 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748364267;
	bh=PXIiai3zXouy7fIC7kpdEWoEDN/ZX+EJvrv3egI5OVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmbgt7HKDF9IZ8XimlEsUYdwmDXVNhVmOPsTVG+ERHqqcFoTgwlnYp+rcNxuORcPv
	 jwlsB0qTo3k5gRECxNvhEX68ecUiXSAe9ww1qnatTjz8pcOZfDXpYA/IISD3+Pq4Ta
	 dIgx1Qk48t6dLDQbzq+yDzYxQo5wgxRR5y45jMog=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alvin Lee <alvin.lee2@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 001/626] drm/amd/display: Configure DTBCLK_P with OPTC only for dcn401
Date: Tue, 27 May 2025 18:18:14 +0200
Message-ID: <20250527162445.105890436@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Dillon Varone <dillon.varone@amd.com>

[ Upstream commit 3c6c8d1a1e3f033f1abf84d6d54c268c35b0fcdd ]

[WHY]
DTBCLK_P is used to generate virtual pixel clock, and to drive the HPO
stream encoder clock. Programming the required clock when
enabling/disabling both components can cause issues.
For example, if HPO is being disabled and clock source is changed to
REFCLK, virtual pixel rate will then be wrong, causing issues in CRTC.

[HOW]
Only program the DTBCLK_P when programming CRTC, as its expected it will
be enabled prior to HPO, and disabled after HPO in all valid cases.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 874697e12793 ("drm/amd/display: Defer BW-optimization-blocked DRR adjustments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   3 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 135 +++++++++++++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   7 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   4 +-
 4 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 0b889004509ad..62402c7be0a5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -580,9 +580,6 @@ static void dccg401_set_dpstreamclk(
 		int otg_inst,
 		int dp_hpo_inst)
 {
-	/* set the dtbclk_p source */
-	dccg401_set_dtbclk_p_src(dccg, src, otg_inst);
-
 	/* enabled to select one of the DTBCLKs for pipe */
 	if (src == REFCLK)
 		dccg401_disable_dpstreamclk(dccg, dp_hpo_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 62f1e597787e6..b6b333a2461f8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -844,6 +844,13 @@ enum dc_status dcn401_enable_stream_timing(
 				odm_slice_width, last_odm_slice_width);
 	}
 
+	/* set DTBCLK_P */
+	if (dc->res_pool->dccg->funcs->set_dtbclk_p_src) {
+		if (dc_is_dp_signal(stream->signal) || dc_is_virtual_signal(stream->signal)) {
+			dc->res_pool->dccg->funcs->set_dtbclk_p_src(dc->res_pool->dccg, DPREFCLK, pipe_ctx->stream_res.tg->inst);
+		}
+	}
+
 	/* HW program guide assume display already disable
 	 * by unplug sequence. OTG assume stop.
 	 */
@@ -1007,8 +1014,6 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 				dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
 			}
 		} else {
-			/* need to set DTBCLK_P source to DPREFCLK for DP8B10B */
-			dccg->funcs->set_dtbclk_p_src(dccg, DPREFCLK, tg->inst);
 			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
 					link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 		}
@@ -1773,3 +1778,129 @@ void dcn401_program_outstanding_updates(struct dc *dc,
 	if (hubbub->funcs->program_compbuf_segments)
 		hubbub->funcs->program_compbuf_segments(hubbub, context->bw_ctx.bw.dcn.arb_regs.compbuf_size, true);
 }
+
+void dcn401_reset_back_end_for_pipe(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context)
+{
+	int i;
+	struct dc_link *link = pipe_ctx->stream->link;
+	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+	if (pipe_ctx->stream_res.stream_enc == NULL) {
+		pipe_ctx->stream = NULL;
+		return;
+	}
+
+	/* DPMS may already disable or */
+	/* dpms_off status is incorrect due to fastboot
+	 * feature. When system resume from S4 with second
+	 * screen only, the dpms_off would be true but
+	 * VBIOS lit up eDP, so check link status too.
+	 */
+	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+		dc->link_srv->set_dpms_off(pipe_ctx);
+	else if (pipe_ctx->stream_res.audio)
+		dc->hwss.disable_audio_stream(pipe_ctx);
+
+	/* free acquired resources */
+	if (pipe_ctx->stream_res.audio) {
+		/*disable az_endpoint*/
+		pipe_ctx->stream_res.audio->funcs->az_disable(pipe_ctx->stream_res.audio);
+
+		/*free audio*/
+		if (dc->caps.dynamic_audio == true) {
+			/*we have to dynamic arbitrate the audio endpoints*/
+			/*we free the resource, need reset is_audio_acquired*/
+			update_audio_usage(&dc->current_state->res_ctx, dc->res_pool,
+					pipe_ctx->stream_res.audio, false);
+			pipe_ctx->stream_res.audio = NULL;
+		}
+	}
+
+	/* by upper caller loop, parent pipe: pipe0, will be reset last.
+	 * back end share by all pipes and will be disable only when disable
+	 * parent pipe.
+	 */
+	if (pipe_ctx->top_pipe == NULL) {
+
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+
+		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+
+		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+		if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
+			pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
+					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
+
+		if (pipe_ctx->stream_res.tg->funcs->set_drr)
+			pipe_ctx->stream_res.tg->funcs->set_drr(
+					pipe_ctx->stream_res.tg, NULL);
+		/* TODO - convert symclk_ref_cnts for otg to a bit map to solve
+		 * the case where the same symclk is shared across multiple otg
+		 * instances
+		 */
+		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+			link->phy_state.symclk_ref_cnts.otg = 0;
+		if (link->phy_state.symclk_state == SYMCLK_ON_TX_OFF) {
+			link_hwss->disable_link_output(link,
+					&pipe_ctx->link_res, pipe_ctx->stream->signal);
+			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		}
+
+		/* reset DTBCLK_P */
+		if (dc->res_pool->dccg->funcs->set_dtbclk_p_src)
+			dc->res_pool->dccg->funcs->set_dtbclk_p_src(dc->res_pool->dccg, REFCLK, pipe_ctx->stream_res.tg->inst);
+	}
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++)
+		if (&dc->current_state->res_ctx.pipe_ctx[i] == pipe_ctx)
+			break;
+
+	if (i == dc->res_pool->pipe_count)
+		return;
+
+/*
+ * In case of a dangling plane, setting this to NULL unconditionally
+ * causes failures during reset hw ctx where, if stream is NULL,
+ * it is expected that the pipe_ctx pointers to pipes and plane are NULL.
+ */
+	pipe_ctx->stream = NULL;
+	DC_LOG_DEBUG("Reset back end for pipe %d, tg:%d\n",
+					pipe_ctx->pipe_idx, pipe_ctx->stream_res.tg->inst);
+}
+
+void dcn401_reset_hw_ctx_wrap(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	int i;
+	struct dce_hwseq *hws = dc->hwseq;
+
+	/* Reset Back End*/
+	for (i = dc->res_pool->pipe_count - 1; i >= 0 ; i--) {
+		struct pipe_ctx *pipe_ctx_old =
+			&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx_old->stream)
+			continue;
+
+		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
+			continue;
+
+		if (!pipe_ctx->stream ||
+				pipe_need_reprogram(pipe_ctx_old, pipe_ctx)) {
+			struct clock_source *old_clk = pipe_ctx_old->clock_source;
+
+			if (hws->funcs.reset_back_end_for_pipe)
+				hws->funcs.reset_back_end_for_pipe(dc, pipe_ctx_old, dc->current_state);
+			if (hws->funcs.enable_stream_gating)
+				hws->funcs.enable_stream_gating(dc, pipe_ctx_old);
+			if (old_clk)
+				old_clk->funcs->cs_power_down(old_clk);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index a27e62081685d..6256429c8a4f6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -84,4 +84,11 @@ void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct
 void dcn401_wait_for_det_buffer_update(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master);
 void dcn401_interdependent_update_lock(struct dc *dc, struct dc_state *context, bool lock);
 void dcn401_program_outstanding_updates(struct dc *dc, struct dc_state *context);
+void dcn401_reset_back_end_for_pipe(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context);
+void dcn401_reset_hw_ctx_wrap(
+		struct dc *dc,
+		struct dc_state *context);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index a2ca07235c83d..d6f36b8e1a261 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -111,7 +111,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.power_down = dce110_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
-	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
+	.reset_hw_ctx_wrap = dcn401_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn401_enable_stream_timing,
 	.edp_backlight_control = dce110_edp_backlight_control,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
@@ -136,7 +136,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = NULL,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
-	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
+	.reset_back_end_for_pipe = dcn401_reset_back_end_for_pipe,
 	.populate_mcm_luts = NULL,
 };
 
-- 
2.39.5




