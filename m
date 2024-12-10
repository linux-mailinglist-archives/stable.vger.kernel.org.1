Return-Path: <stable+bounces-100361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3919EAC2F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1758728FCCE
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14730223E6F;
	Tue, 10 Dec 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JEcfPlvQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624C223E69
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823035; cv=none; b=NTMT2M/IUYHTB/KE1ZeSwSeSI8DzFD58/pKKeHoL3kg1cpENIECLEmwIg1GAU2g6hquV7wGcYLRP8ZDeWYwd291//qH2cDKY5Mw8mXCbKwmn9PIgoSIHvCAc1O3DBeU9rlkNFoUAiXumOIiOEpt0E+SL939tzz7evqJnkYoKdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823035; c=relaxed/simple;
	bh=34+oRY/obWLpRBAsKaXj00nYbSTYBJE6beSNS5VZEvY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fGyzvf8oJ7B+iuSr9dutRG6MDnpC5yxr1rjgneJUP7/qTGE2+k0fZieQxzNPMi6vkdnzF/fWc5wJpwscgFkSp65gv6mrEFaoWs6eN23okRgw6B3P9oV3QIp9GVr/4PIhM2NQEaMUHVg9f76ooumo4CdMoT/2zegXpTcwARrVe6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEcfPlvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95D3C4CED6;
	Tue, 10 Dec 2024 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823035;
	bh=34+oRY/obWLpRBAsKaXj00nYbSTYBJE6beSNS5VZEvY=;
	h=Subject:To:Cc:From:Date:From;
	b=JEcfPlvQ7a8amTa/OoqJo+w2FGM+sDXchMxAhQgI9erLps/JlH+Ow14jQWvHcxdIn
	 UhQ3mUFGrqXHEsHuw7yaKVeJj1y0UdZKvrDBV3yCElSVg9gHnhp0xNNyRjBbomwUvC
	 gobRiKk/dHc4AvGBd5ZX4e1VuBIPb7QPr7FcjgD4=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add hblank borrowing support" failed to apply to 6.12-stable tree
To: chris.park@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:29:51 +0100
Message-ID: <2024121051-disarray-pug-440c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0c0a19430bfdfedab437e77b9262e8e62ced384e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121051-disarray-pug-440c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c0a19430bfdfedab437e77b9262e8e62ced384e Mon Sep 17 00:00:00 2001
From: Chris Park <chris.park@amd.com>
Date: Fri, 15 Nov 2024 15:44:52 -0500
Subject: [PATCH] drm/amd/display: Add hblank borrowing support

[WHY]
Some DSC timing failed at bandwidth validation due to hactive
can't be evenly divided on each ODM segment.

[HOW]
Borrow from hblank to increase hactive to support these timing.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 619fad17de55..626f75b6ad00 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2094,7 +2094,8 @@ int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
 	count = resource_get_odm_slice_count(otg_master);
 	h_active = timing->h_addressable +
 			timing->h_border_left +
-			timing->h_border_right;
+			timing->h_border_right +
+			otg_master->hblank_borrow;
 	width = h_active / count;
 
 	if (otg_master->stream_res.tg)
@@ -4026,6 +4027,41 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	return res;
 }
 
+/**
+ * decide_hblank_borrow - Decides the horizontal blanking borrow value for a given pipe context.
+ * @pipe_ctx: Pointer to the pipe context structure.
+ *
+ * This function calculates the horizontal blanking borrow value for a given pipe context based on the
+ * display stream compression (DSC) configuration. If the horizontal active pixels (hactive) are less
+ * than the total width of the DSC slices, it sets the hblank_borrow value to the difference. If the
+ * total horizontal timing minus the hblank_borrow value is less than 32, it resets the hblank_borrow
+ * value to 0.
+ */
+static void decide_hblank_borrow(struct pipe_ctx *pipe_ctx)
+{
+	uint32_t hactive;
+	uint32_t ceil_slice_width;
+	struct dc_stream_state *stream = NULL;
+
+	if (!pipe_ctx)
+		return;
+
+	stream = pipe_ctx->stream;
+
+	if (stream->timing.flags.DSC) {
+		hactive = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+
+		/* Assume if determined slices does not divide Hactive evenly, Hborrow is needed for padding*/
+		if (hactive % stream->timing.dsc_cfg.num_slices_h != 0) {
+			ceil_slice_width = (hactive / stream->timing.dsc_cfg.num_slices_h) + 1;
+			pipe_ctx->hblank_borrow = ceil_slice_width * stream->timing.dsc_cfg.num_slices_h - hactive;
+
+			if (stream->timing.h_total - hactive - pipe_ctx->hblank_borrow < 32)
+				pipe_ctx->hblank_borrow = 0;
+		}
+	}
+}
+
 /**
  * dc_validate_global_state() - Determine if hardware can support a given state
  *
@@ -4064,6 +4100,10 @@ enum dc_status dc_validate_global_state(
 			if (pipe_ctx->stream != stream)
 				continue;
 
+			/* Decide whether hblank borrow is needed and save it in pipe_ctx */
+			if (dc->debug.enable_hblank_borrow)
+				decide_hblank_borrow(pipe_ctx);
+
 			if (dc->res_pool->funcs->patch_unknown_plane_state &&
 					pipe_ctx->plane_state &&
 					pipe_ctx->plane_state->tiling_info.gfx9.swizzle == DC_SW_UNKNOWN) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1dda5fc2e212..e9b9126c0401 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1069,6 +1069,7 @@ struct dc_debug_options {
 	unsigned int scale_to_sharpness_policy;
 	bool skip_full_updated_if_possible;
 	unsigned int enable_oled_edp_power_up_opt;
+	bool enable_hblank_borrow;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index c8d8e335fa37..0e310fd48b5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -120,7 +120,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	spl_in->odm_slice_index = resource_get_odm_slice_index(pipe_ctx);
 	// Make spl input basic out info output_size width point to stream h active
 	spl_in->basic_out.output_size.width =
-		stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+		stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->hblank_borrow;
 	// Make spl input basic out info output_size height point to v active
 	spl_in->basic_out.output_size.height =
 		stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index f66493528f42..c6a5a8614679 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -445,6 +445,21 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	timing->vblank_nom = timing->v_total - timing->v_active;
 }
 
+/**
+ * adjust_dml21_hblank_timing_config_from_pipe_ctx - Adjusts the horizontal blanking timing configuration
+ *                                                   based on the pipe context.
+ * @timing: Pointer to the dml2_timing_cfg structure to be adjusted.
+ * @pipe: Pointer to the pipe_ctx structure containing the horizontal blanking borrow value.
+ *
+ * This function modifies the horizontal active and blank end timings by adding and subtracting
+ * the horizontal blanking borrow value from the pipe context, respectively.
+ */
+static void adjust_dml21_hblank_timing_config_from_pipe_ctx(struct dml2_timing_cfg *timing, struct pipe_ctx *pipe)
+{
+	timing->h_active += pipe->hblank_borrow;
+	timing->h_blank_end -= pipe->hblank_borrow;
+}
+
 static void populate_dml21_output_config_from_stream_state(struct dml2_link_output_cfg *output,
 		struct dc_stream_state *stream, const struct pipe_ctx *pipe)
 {
@@ -732,6 +747,7 @@ static const struct scaler_data *get_scaler_data_for_plane(
 			temp_pipe->plane_state = pipe->plane_state;
 			temp_pipe->plane_res.scl_data.taps = pipe->plane_res.scl_data.taps;
 			temp_pipe->stream_res = pipe->stream_res;
+			temp_pipe->hblank_borrow = pipe->hblank_borrow;
 			dml_ctx->config.callbacks.build_scaling_params(temp_pipe);
 			break;
 		}
@@ -996,6 +1012,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], dml_ctx);
+		adjust_dml21_hblank_timing_config_from_pipe_ctx(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, &context->res_ctx.pipe_ctx[stream_index]);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index]);
 		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index]);
 
@@ -1134,12 +1151,12 @@ void dml21_populate_pipe_ctx_dlg_params(struct dml2_context *dml_ctx, struct dc_
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
 	union dml2_global_sync_programming *global_sync = &stream_programming->global_sync;
 
-	hactive = timing->h_addressable + timing->h_border_left + timing->h_border_right;
+	hactive = timing->h_addressable + timing->h_border_left + timing->h_border_right + pipe_ctx->hblank_borrow;
 	vactive = timing->v_addressable + timing->v_border_bottom + timing->v_border_top;
 	hblank_start = pipe_ctx->stream->timing.h_total - pipe_ctx->stream->timing.h_front_porch;
 	vblank_start = pipe_ctx->stream->timing.v_total - pipe_ctx->stream->timing.v_front_porch;
 
-	hblank_end = hblank_start - timing->h_addressable - timing->h_border_left - timing->h_border_right;
+	hblank_end = hblank_start - timing->h_addressable - timing->h_border_left - timing->h_border_right - pipe_ctx->hblank_borrow;
 	vblank_end = vblank_start - timing->v_addressable - timing->v_border_top - timing->v_border_bottom;
 
 	if (dml_ctx->config.svp_pstate.callbacks.get_pipe_subvp_type(context, pipe_ctx) == SUBVP_PHANTOM) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index d7f8b2dcaa6b..fa11f075d1f9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1049,7 +1049,8 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 
 		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->hblank_borrow +
+				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
 		dsc_cfg.color_depth = stream->timing.display_color_depth;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5de11e2837c0..307782592789 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -820,6 +820,7 @@ enum dc_status dcn401_enable_stream_timing(
 	int opp_cnt = 1;
 	int opp_inst[MAX_PIPES] = {0};
 	struct pipe_ctx *opp_heads[MAX_PIPES] = {0};
+	struct dc_crtc_timing patched_crtc_timing = stream->timing;
 	bool manual_mode;
 	unsigned int tmds_div = PIXEL_RATE_DIV_NA;
 	unsigned int unused_div = PIXEL_RATE_DIV_NA;
@@ -874,9 +875,13 @@ enum dc_status dcn401_enable_stream_timing(
 	if (dc->hwseq->funcs.PLAT_58856_wa && (!dc_is_dp_signal(stream->signal)))
 		dc->hwseq->funcs.PLAT_58856_wa(context, pipe_ctx);
 
+	/* if we are borrowing from hblank, h_addressable needs to be adjusted */
+	if (dc->debug.enable_hblank_borrow)
+		patched_crtc_timing.h_addressable = patched_crtc_timing.h_addressable + pipe_ctx->hblank_borrow;
+
 	pipe_ctx->stream_res.tg->funcs->program_timing(
 			pipe_ctx->stream_res.tg,
-			&stream->timing,
+			&patched_crtc_timing,
 			pipe_ctx->pipe_dlg_param.vready_offset,
 			pipe_ctx->pipe_dlg_param.vstartup_start,
 			pipe_ctx->pipe_dlg_param.vupdate_offset,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 3061dca47dd2..2edd5b38ce4f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -478,6 +478,8 @@ struct pipe_ctx {
 	/* subvp_index: only valid if the pipe is a SUBVP_MAIN*/
 	uint8_t subvp_index;
 	struct pixel_rate_divider pixel_rate_divider;
+	/* pixels borrowed from hblank to hactive */
+	uint8_t hblank_borrow;
 };
 
 /* Data used for dynamic link encoder assignment.
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 41cab9ad6885..5d66bfc7fe6e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -808,7 +808,8 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		enum optc_dsc_mode optc_dsc_mode;
 
 		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->hblank_borrow +
+				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
 		dsc_cfg.color_depth = stream->timing.display_color_depth;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 984d23bcbc27..12d247a7ec45 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2804,6 +2804,7 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_opp_head(
 		free_pipe->plane_res.xfm = pool->transforms[free_pipe_idx];
 		free_pipe->plane_res.dpp = pool->dpps[free_pipe_idx];
 		free_pipe->plane_res.mpcc_inst = pool->dpps[free_pipe_idx]->inst;
+		free_pipe->hblank_borrow = otg_master->hblank_borrow;
 		if (free_pipe->stream->timing.flags.DSC == 1) {
 			dcn20_acquire_dsc(free_pipe->stream->ctx->dc,
 					&new_ctx->res_ctx,


