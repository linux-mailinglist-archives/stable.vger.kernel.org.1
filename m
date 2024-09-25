Return-Path: <stable+bounces-77231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D28985AAB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341BD1C23B8E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2C17C9E7;
	Wed, 25 Sep 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm6d2+Mx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138517C9A0;
	Wed, 25 Sep 2024 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264662; cv=none; b=dEVIBzfN4lhItuKclEMbLkMowQ9BgQbnQ+MXC774xQq+2ceNJSY3yng/6wTSTb/V9EirC6a5hcxH1q+suyz9opq7mPwLiHD6wXMh1lKrXUZY8uvgVrN3YAHKT7wqQ1ZAA30JU6TPUU9lFFXgO3yWiBShE9ZMQPUw+UBvp2kdkNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264662; c=relaxed/simple;
	bh=ypUhCwZGscsAPSWKG6DQ2iJ0HUlY2+WvcklS72ShEYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJllk7K8ACMAzF59AxOx4+cEaDi1+ze+ZpLI2W6Ib2UvnlxrSktnjaMPQcqXiyauaGh071zLjZXBXQUrcqjN0VY4Dgh6zOkXzz9Zsj66ILNHzQODFEmj9YBKrCjs7FuUaNR+BDAE0wrghr+DrOJq3gF/nKDdPGEcmYj0/vVv4bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm6d2+Mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8F2C4CEC3;
	Wed, 25 Sep 2024 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264661;
	bh=ypUhCwZGscsAPSWKG6DQ2iJ0HUlY2+WvcklS72ShEYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fm6d2+Mx+Oj27VsOvBOzr49bLNZ/7g/N2N7Tu+u6Ki00a7v8omKk9/I4TXN33HNxh
	 yIJiTA+1FEqPjokrWbFz/cZ4Ppn8RBH//T1i3CqgkbbXJOcUFLazqyJC4f8pnW/Qa6
	 s405Od7tNizC5Ftt0KnemG8npkIh7SwLni6O3qM4YBP+KY8ggMnYAKFocK4KmYRD21
	 CWA9QghuRQ4mLCztbMcqANAjXTsUUiejaGelVeCFobIoXYp8cXueI1KuWWrgOON5uI
	 JEy3jE11QIU4JC9hE9NBZjWGio2ZJkK2BLdTF26HkGXl5x4w0JE/8HG6oAavwF0mDn
	 frhFC9JdFlARg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nicholas.kazlauskas@amd.com,
	wayne.lin@amd.com,
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	aric.cyr@amd.com,
	relja.vojvodic@amd.com,
	alvin.lee2@amd.com,
	chiahsuan.chung@amd.com,
	wenjing.liu@amd.com,
	george.shen@amd.com,
	michael.strauss@amd.com,
	moadhuri@amd.com,
	martin.leung@amd.com,
	roman.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 133/244] drm/amd/display: Check null pointers before multiple uses
Date: Wed, 25 Sep 2024 07:25:54 -0400
Message-ID: <20240925113641.1297102-133-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit fdd5ecbbff751c3b9061d8ebb08e5c96119915b4 ]

[WHAT & HOW]
Poniters, such as stream_enc and dc->bw_vbios, are null checked previously
in the same function, so Coverity warns "implies that stream_enc and
dc->bw_vbios might be null". They are used multiple times in the
subsequent code and need to be checked.

This fixes 10 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 96 ++++++++++---------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  8 +-
 .../display/dc/link/accessories/link_dp_cts.c |  5 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  5 +-
 .../dc/resource/dce112/dce112_resource.c      |  5 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  3 +
 .../resource/dcn32/dcn32_resource_helpers.c   | 10 +-
 7 files changed, 76 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 87e36d51c56d8..4a88412fdfab1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -636,57 +636,59 @@ void hwss_build_fast_sequence(struct dc *dc,
 	while (current_pipe) {
 		current_mpc_pipe = current_pipe;
 		while (current_mpc_pipe) {
-			if (dc->hwss.set_flip_control_gsl && current_mpc_pipe->plane_state && current_mpc_pipe->plane_state->update_flags.raw) {
-				block_sequence[*num_steps].params.set_flip_control_gsl_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].params.set_flip_control_gsl_params.flip_immediate = current_mpc_pipe->plane_state->flip_immediate;
-				block_sequence[*num_steps].func = HUBP_SET_FLIP_CONTROL_GSL;
-				(*num_steps)++;
-			}
-			if (dc->hwss.program_triplebuffer && dc->debug.enable_tri_buf && current_mpc_pipe->plane_state->update_flags.raw) {
-				block_sequence[*num_steps].params.program_triplebuffer_params.dc = dc;
-				block_sequence[*num_steps].params.program_triplebuffer_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].params.program_triplebuffer_params.enableTripleBuffer = current_mpc_pipe->plane_state->triplebuffer_flips;
-				block_sequence[*num_steps].func = HUBP_PROGRAM_TRIPLEBUFFER;
-				(*num_steps)++;
-			}
-			if (dc->hwss.update_plane_addr && current_mpc_pipe->plane_state->update_flags.bits.addr_update) {
-				if (resource_is_pipe_type(current_mpc_pipe, OTG_MASTER) &&
-						stream_status->mall_stream_config.type == SUBVP_MAIN) {
-					block_sequence[*num_steps].params.subvp_save_surf_addr.dc_dmub_srv = dc->ctx->dmub_srv;
-					block_sequence[*num_steps].params.subvp_save_surf_addr.addr = &current_mpc_pipe->plane_state->address;
-					block_sequence[*num_steps].params.subvp_save_surf_addr.subvp_index = current_mpc_pipe->subvp_index;
-					block_sequence[*num_steps].func = DMUB_SUBVP_SAVE_SURF_ADDR;
+			if (current_mpc_pipe->plane_state) {
+				if (dc->hwss.set_flip_control_gsl && current_mpc_pipe->plane_state->update_flags.raw) {
+					block_sequence[*num_steps].params.set_flip_control_gsl_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].params.set_flip_control_gsl_params.flip_immediate = current_mpc_pipe->plane_state->flip_immediate;
+					block_sequence[*num_steps].func = HUBP_SET_FLIP_CONTROL_GSL;
+					(*num_steps)++;
+				}
+				if (dc->hwss.program_triplebuffer && dc->debug.enable_tri_buf && current_mpc_pipe->plane_state->update_flags.raw) {
+					block_sequence[*num_steps].params.program_triplebuffer_params.dc = dc;
+					block_sequence[*num_steps].params.program_triplebuffer_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].params.program_triplebuffer_params.enableTripleBuffer = current_mpc_pipe->plane_state->triplebuffer_flips;
+					block_sequence[*num_steps].func = HUBP_PROGRAM_TRIPLEBUFFER;
+					(*num_steps)++;
+				}
+				if (dc->hwss.update_plane_addr && current_mpc_pipe->plane_state->update_flags.bits.addr_update) {
+					if (resource_is_pipe_type(current_mpc_pipe, OTG_MASTER) &&
+							stream_status->mall_stream_config.type == SUBVP_MAIN) {
+						block_sequence[*num_steps].params.subvp_save_surf_addr.dc_dmub_srv = dc->ctx->dmub_srv;
+						block_sequence[*num_steps].params.subvp_save_surf_addr.addr = &current_mpc_pipe->plane_state->address;
+						block_sequence[*num_steps].params.subvp_save_surf_addr.subvp_index = current_mpc_pipe->subvp_index;
+						block_sequence[*num_steps].func = DMUB_SUBVP_SAVE_SURF_ADDR;
+						(*num_steps)++;
+					}
+
+					block_sequence[*num_steps].params.update_plane_addr_params.dc = dc;
+					block_sequence[*num_steps].params.update_plane_addr_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].func = HUBP_UPDATE_PLANE_ADDR;
 					(*num_steps)++;
 				}
 
-				block_sequence[*num_steps].params.update_plane_addr_params.dc = dc;
-				block_sequence[*num_steps].params.update_plane_addr_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = HUBP_UPDATE_PLANE_ADDR;
-				(*num_steps)++;
-			}
-
-			if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_flags.bits.gamma_change) {
-				block_sequence[*num_steps].params.set_input_transfer_func_params.dc = dc;
-				block_sequence[*num_steps].params.set_input_transfer_func_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].params.set_input_transfer_func_params.plane_state = current_mpc_pipe->plane_state;
-				block_sequence[*num_steps].func = DPP_SET_INPUT_TRANSFER_FUNC;
-				(*num_steps)++;
-			}
+				if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_flags.bits.gamma_change) {
+					block_sequence[*num_steps].params.set_input_transfer_func_params.dc = dc;
+					block_sequence[*num_steps].params.set_input_transfer_func_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].params.set_input_transfer_func_params.plane_state = current_mpc_pipe->plane_state;
+					block_sequence[*num_steps].func = DPP_SET_INPUT_TRANSFER_FUNC;
+					(*num_steps)++;
+				}
 
-			if (dc->hwss.program_gamut_remap && current_mpc_pipe->plane_state->update_flags.bits.gamut_remap_change) {
-				block_sequence[*num_steps].params.program_gamut_remap_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = DPP_PROGRAM_GAMUT_REMAP;
-				(*num_steps)++;
-			}
-			if (current_mpc_pipe->plane_state->update_flags.bits.input_csc_change) {
-				block_sequence[*num_steps].params.setup_dpp_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = DPP_SETUP_DPP;
-				(*num_steps)++;
-			}
-			if (current_mpc_pipe->plane_state->update_flags.bits.coeff_reduction_change) {
-				block_sequence[*num_steps].params.program_bias_and_scale_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = DPP_PROGRAM_BIAS_AND_SCALE;
-				(*num_steps)++;
+				if (dc->hwss.program_gamut_remap && current_mpc_pipe->plane_state->update_flags.bits.gamut_remap_change) {
+					block_sequence[*num_steps].params.program_gamut_remap_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].func = DPP_PROGRAM_GAMUT_REMAP;
+					(*num_steps)++;
+				}
+				if (current_mpc_pipe->plane_state->update_flags.bits.input_csc_change) {
+					block_sequence[*num_steps].params.setup_dpp_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].func = DPP_SETUP_DPP;
+					(*num_steps)++;
+				}
+				if (current_mpc_pipe->plane_state->update_flags.bits.coeff_reduction_change) {
+					block_sequence[*num_steps].params.program_bias_and_scale_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].func = DPP_PROGRAM_BIAS_AND_SCALE;
+					(*num_steps)++;
+				}
 			}
 			if (hws->funcs.set_output_transfer_func && current_mpc_pipe->stream->update_flags.bits.out_tf) {
 				block_sequence[*num_steps].params.set_output_transfer_func_params.dc = dc;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 2532ad410cb56..456e19e0d415c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2283,6 +2283,9 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
+	if (!hwseq)
+		return;
+
 	/* P-State support transitions:
 	 * Natural -> FPO: 		P-State disabled in prepare, force disallow anytime is safe
 	 * FPO -> Natural: 		Unforce anytime after FW disable is safe (P-State will assert naturally)
@@ -2290,7 +2293,7 @@ void dcn20_post_unlock_program_front_end(
 	 * FPO -> Unsupported:	P-State disabled in prepare, unforce disallow anytime is safe
 	 * FPO <-> SubVP:		Force disallow is maintained on the FPO / SubVP pipes
 	 */
-	if (hwseq && hwseq->funcs.update_force_pstate)
+	if (hwseq->funcs.update_force_pstate)
 		dc->hwseq->funcs.update_force_pstate(dc, context);
 
 	/* Only program the MALL registers after all the main and phantom pipes
@@ -2529,6 +2532,9 @@ bool dcn20_wait_for_blank_complete(
 {
 	int counter;
 
+	if (!opp)
+		return false;
+
 	for (counter = 0; counter < 1000; counter++) {
 		if (!opp->funcs->dpg_is_pending(opp))
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 555c1c484cfdd..df3781081da7a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -804,8 +804,11 @@ bool dp_set_test_pattern(
 			break;
 		}
 
+		if (!pipe_ctx->stream)
+			return false;
+
 		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable) {
-			if (pipe_ctx->stream && should_use_dmub_lock(pipe_ctx->stream->link)) {
+			if (should_use_dmub_lock(pipe_ctx->stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index b76737b7b9e41..3e47a6735912a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -74,7 +74,10 @@ void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
-	if (stream_enc && stream_enc->funcs->disable_fifo)
+	if (!stream_enc)
+		return;
+
+	if (stream_enc->funcs->disable_fifo)
 		stream_enc->funcs->disable_fifo(stream_enc);
 	if (stream_enc->funcs->set_input_mode)
 		stream_enc->funcs->set_input_mode(stream_enc, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 88afb2a30eef5..162856c523e40 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -1067,7 +1067,10 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 	struct dm_pp_clock_levels clks = {0};
 	int memory_type_multiplier = MEMORY_TYPE_MULTIPLIER_CZ;
 
-	if (dc->bw_vbios && dc->bw_vbios->memory_type == bw_def_hbm)
+	if (!dc->bw_vbios)
+		return;
+
+	if (dc->bw_vbios->memory_type == bw_def_hbm)
 		memory_type_multiplier = MEMORY_TYPE_HBM;
 
 	/*do system clock  TODO PPLIB: after PPLIB implement,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 969658313fd65..a43ffa53890af 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1651,6 +1651,9 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
 		else
 			phantom_plane = dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state);
 
+		if (!phantom_plane)
+			continue;
+
 		memcpy(&phantom_plane->address, &curr_pipe->plane_state->address, sizeof(phantom_plane->address));
 		memcpy(&phantom_plane->scaling_quality, &curr_pipe->plane_state->scaling_quality,
 				sizeof(phantom_plane->scaling_quality));
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index d184105ce2b3e..47c8a9fbe7546 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -218,12 +218,12 @@ bool dcn32_is_center_timing(struct pipe_ctx *pipe)
 				pipe->stream->timing.v_addressable != pipe->stream->src.height) {
 			is_center_timing = true;
 		}
-	}
 
-	if (pipe->plane_state) {
-		if (pipe->stream->timing.v_addressable != pipe->plane_state->dst_rect.height &&
-				pipe->stream->timing.v_addressable != pipe->plane_state->src_rect.height) {
-			is_center_timing = true;
+		if (pipe->plane_state) {
+			if (pipe->stream->timing.v_addressable != pipe->plane_state->dst_rect.height &&
+					pipe->stream->timing.v_addressable != pipe->plane_state->src_rect.height) {
+				is_center_timing = true;
+			}
 		}
 	}
 
-- 
2.43.0


