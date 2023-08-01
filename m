Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9076AF09
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjHAJom (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjHAJoS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C5130CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 879096150E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9380EC433C7;
        Tue,  1 Aug 2023 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882900;
        bh=xLjSVerhn4X//0sE/dQM5fnkdHrDCmB3fKjFWIt4+Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHHayNoIgPJ7kWUzlUBZ9mLbanQixH1SLWYfzI9dflB6ewPTgRdEXfVBABho5RdYR
         kVqoAnv4QvmEMX3INQMc8vQKwxzHAsQp+XMIELmO1f/5+HBgOQwLyBkUdfs2/ZkOBH
         pSSXJ3NjGylGMg5iFgOp9ZYcbD5uM2hNyWHeMBlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Wheeler <daniel.wheeler@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 043/239] drm/amd/display: update extended blank for dcn314 onwards
Date:   Tue,  1 Aug 2023 11:18:27 +0200
Message-ID: <20230801091927.124141481@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gabe Teeger <gabe.teeger@amd.com>

[ Upstream commit 469a62938a45ef382c9cb7b9fec6c6c1fcd781c0 ]

[Why]
Flickering and underflow was observed when testing extended
blank on dcn314.

[What]
Vstartup is contrainted by vblank_nom, so adjusting it to include
non-adjusted vtotal in its calculation during freesync video
means that Vstartup is not changed when vtotal changes.
This fixed the flickering + underflow.

dc_extended_blank_supported function was removed
because extended blank is only relevant to when
zstate is supported. The increased vtotal during
freesync can be passed to dml regardless of whether
extended blank is supported or not, so this function is
not needed.

Updates were made recently in dml to the calculation of
min_dst_y_next_start. Dml input for dcn314 will now
always use the newer calculation for min_dst_y_next_start.
Dml input for older dcn versions remains untouched.

The variable optimized_min_dst_y_next_start
is replaced everywhere with min_dst_y_next_start,
and the updated dml allows min_dst_y_next_start to
increase to an optimized value during freesync video,
then return to default when freesync is disengaged.

Also removed registry key for controlling
extended blank feature.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 2a9482e55968 ("drm/amd/display: Prevent vtotal from being set to 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 -----------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 --
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 ++--
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 23 +++++++++----------
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  3 +--
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 14 +++++++----
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   | 16 ++++---------
 .../amd/display/dc/dml/display_mode_structs.h |  3 +--
 8 files changed, 29 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7f6bdad57c920..d22095a3a265a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2632,9 +2632,6 @@ static enum surface_update_type check_update_surfaces_for_stream(
 				stream_update->vrr_active_variable))
 			su_flags->bits.fams_changed = 1;
 
-		if (stream_update->crtc_timing_adjust && dc_extended_blank_supported(dc))
-			su_flags->bits.crtc_timing_adjust = 1;
-
 		if (su_flags->raw != 0)
 			overall_type = UPDATE_TYPE_FULL;
 
@@ -4900,21 +4897,3 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 	if (pipe->stream_res.abm && pipe->stream_res.abm->funcs->set_abm_pause)
 		pipe->stream_res.abm->funcs->set_abm_pause(pipe->stream_res.abm, !enable, i, pipe->stream_res.tg->inst);
 }
-
-/**
- * dc_extended_blank_supported - Decide whether extended blank is supported
- *
- * @dc: [in] Current DC state
- *
- * Extended blank is a freesync optimization feature to be enabled in the
- * future.  During the extra vblank period gained from freesync, we have the
- * ability to enter z9/z10.
- *
- * Return:
- * Indicate whether extended blank is supported (%true or %false)
- */
-bool dc_extended_blank_supported(struct dc *dc)
-{
-	return dc->debug.extended_blank_optimization && !dc->debug.disable_z10
-		&& dc->caps.zstate_support && dc->caps.is_apu;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 07d86b961c798..9279990e43694 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2125,8 +2125,6 @@ struct dc_sink_init_data {
 	bool converter_disable_audio;
 };
 
-bool dc_extended_blank_supported(struct dc *dc);
-
 struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params);
 
 /* Newer interfaces  */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index c38be3c6c234e..a621b6a27c1fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2128,7 +2128,7 @@ void dcn20_optimize_bandwidth(
 			dc->clk_mgr,
 			context,
 			true);
-	if (dc_extended_blank_supported(dc) && context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW) {
+	if (context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW) {
 		for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
@@ -2136,7 +2136,7 @@ void dcn20_optimize_bandwidth(
 				&& pipe_ctx->stream->adjust.v_total_min == pipe_ctx->stream->adjust.v_total_max
 				&& pipe_ctx->stream->adjust.v_total_max > pipe_ctx->stream->timing.v_total)
 					pipe_ctx->plane_res.hubp->funcs->program_extended_blank(pipe_ctx->plane_res.hubp,
-						pipe_ctx->dlg_regs.optimized_min_dst_y_next_start);
+						pipe_ctx->dlg_regs.min_dst_y_next_start);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index f1c1a4b5fcac3..7661f8946aa31 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -948,10 +948,10 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 {
 	int plane_count;
 	int i;
-	unsigned int optimized_min_dst_y_next_start_us;
+	unsigned int min_dst_y_next_start_us;
 
 	plane_count = 0;
-	optimized_min_dst_y_next_start_us = 0;
+	min_dst_y_next_start_us = 0;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (context->res_ctx.pipe_ctx[i].plane_state)
 			plane_count++;
@@ -973,19 +973,18 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
+		struct dc_stream_state *current_stream = context->streams[0];
 		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 		bool is_pwrseq0 = link->link_index == 0;
+		bool isFreesyncVideo;
 
-		if (dc_extended_blank_supported(dc)) {
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				if (context->res_ctx.pipe_ctx[i].stream == context->streams[0]
-					&& context->res_ctx.pipe_ctx[i].stream->adjust.v_total_min == context->res_ctx.pipe_ctx[i].stream->adjust.v_total_max
-					&& context->res_ctx.pipe_ctx[i].stream->adjust.v_total_min > context->res_ctx.pipe_ctx[i].stream->timing.v_total) {
-						optimized_min_dst_y_next_start_us =
-							context->res_ctx.pipe_ctx[i].dlg_regs.optimized_min_dst_y_next_start_us;
-						break;
-				}
+		isFreesyncVideo = current_stream->adjust.v_total_min == current_stream->adjust.v_total_max;
+		isFreesyncVideo = isFreesyncVideo && current_stream->timing.v_total < current_stream->adjust.v_total_min;
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			if (context->res_ctx.pipe_ctx[i].stream == current_stream && isFreesyncVideo) {
+				min_dst_y_next_start_us = context->res_ctx.pipe_ctx[i].dlg_regs.min_dst_y_next_start_us;
+				break;
 			}
 		}
 
@@ -993,7 +992,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000))
+		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || min_dst_y_next_start_us > 5000))
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 2244e4fb8c96d..fcde8f21b8be0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -987,8 +987,7 @@ static void dml_rq_dlg_get_dlg_params(
 
 	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
 	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
-	disp_dlg_regs->optimized_min_dst_y_next_start_us = 0;
-	disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
+	disp_dlg_regs->min_dst_y_next_start_us = 0;
 	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
 
 	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 9e54e3d0eb780..1d00eb9e73c62 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -286,6 +286,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool upscaled = false;
+	bool isFreesyncVideo = false;
 
 	dc_assert_fp_enabled();
 
@@ -299,9 +300,16 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		if (dc_extended_blank_supported(dc) && pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min
-			&& pipe->stream->adjust.v_total_min > timing->v_total)
+		isFreesyncVideo = pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min;
+		isFreesyncVideo = isFreesyncVideo && pipe->stream->adjust.v_total_min > timing->v_total;
+
+		if (!isFreesyncVideo) {
+			pipes[pipe_cnt].pipe.dest.vblank_nom =
+				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
+		} else {
 			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+			pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
+		}
 
 		if (pipe->plane_state &&
 				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
@@ -323,8 +331,6 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
-		pipes[pipe_cnt].pipe.dest.vblank_nom =
-				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
 		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index ea4eb66066c42..4f945458b2b7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -1051,7 +1051,6 @@ static void dml_rq_dlg_get_dlg_params(
 
 	float vba__refcyc_per_req_delivery_pre_l = get_refcyc_per_req_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
 	float vba__refcyc_per_req_delivery_l = get_refcyc_per_req_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
-	int blank_lines = 0;
 
 	memset(disp_dlg_regs, 0, sizeof(*disp_dlg_regs));
 	memset(disp_ttu_regs, 0, sizeof(*disp_ttu_regs));
@@ -1075,17 +1074,10 @@ static void dml_rq_dlg_get_dlg_params(
 	min_ttu_vblank = get_min_ttu_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);	// From VBA
 
 	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
-	disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
-	disp_dlg_regs->optimized_min_dst_y_next_start_us = 0;
-	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
-	blank_lines = (dst->vblank_end + dst->vtotal_min - dst->vblank_start - dst->vstartup_start - 1);
-	if (blank_lines < 0)
-		blank_lines = 0;
-	if (blank_lines != 0) {
-		disp_dlg_regs->optimized_min_dst_y_next_start = vba__min_dst_y_next_start;
-		disp_dlg_regs->optimized_min_dst_y_next_start_us = (disp_dlg_regs->optimized_min_dst_y_next_start * dst->hactive) / (unsigned int) dst->pixel_rate_mhz;
-		disp_dlg_regs->min_dst_y_next_start = disp_dlg_regs->optimized_min_dst_y_next_start;
-	}
+	disp_dlg_regs->min_dst_y_next_start_us =
+		(vba__min_dst_y_next_start * dst->hactive) / (unsigned int) dst->pixel_rate_mhz;
+	disp_dlg_regs->min_dst_y_next_start = vba__min_dst_y_next_start * dml_pow(2, 2);
+
 	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
 
 	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 3c077164f3620..ff0246a9458fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -619,8 +619,7 @@ struct _vcs_dpi_display_dlg_regs_st {
 	unsigned int refcyc_h_blank_end;
 	unsigned int dlg_vblank_end;
 	unsigned int min_dst_y_next_start;
-	unsigned int optimized_min_dst_y_next_start;
-	unsigned int optimized_min_dst_y_next_start_us;
+	unsigned int min_dst_y_next_start_us;
 	unsigned int refcyc_per_htotal;
 	unsigned int refcyc_x_after_scaler;
 	unsigned int dst_y_after_scaler;
-- 
2.39.2



