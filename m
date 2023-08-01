Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ECD76AF5A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjHAJqz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjHAJoy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE746AB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAB68614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01160C433C7;
        Tue,  1 Aug 2023 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882955;
        bh=1aWNvOIlgGqbmxCYPMZZBgY8zwveYlyahJXT4pawId4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBUfFEFQY5ND7YGjOpMtpnYNrpMPDxw/uIurGqNSqbZMQbMBPAaEHb0cHZNtwZ8OF
         DBp4zw7HMdosonkqGTzDGtB4POZAriZf+xphnluSvNH5cpanPpkES0cd7GbOX0voxJ
         ETKHDm3inWKTtuspWhBO7Dz95PPQ2240n6gknDQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Wheeler <daniel.wheeler@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 034/239] drm/amd/display: add pixel rate based CRB allocation support
Date:   Tue,  1 Aug 2023 11:18:18 +0200
Message-ID: <20230801091926.835410028@linuxfoundation.org>
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

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[ Upstream commit 9ba90d760e9354c124fa9bbea08017d96699a82c ]

This feature is meant to unblock PSTATE for certain high end display
configs on dcn315. This is achieved by allocating CRB to detile buffer
based on display requirements to meet pstate latency hiding needs.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 49f26218c344 ("drm/amd/display: fix dcn315 single stream crb allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  1 +
 .../amd/display/dc/dcn315/dcn315_resource.c   | 97 ++++++++++++++++++-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 25 ++++-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |  3 +
 .../dc/dml/dcn31/display_mode_vba_31.c        | 39 +++++---
 .../drm/amd/display/dc/dml/display_mode_vba.c |  6 ++
 6 files changed, 154 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 7e7cd5b64e6a1..7445ed27852a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -103,6 +103,7 @@ static void dcn31_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigne
 	default:
 		break;
 	}
+	DC_LOG_DEBUG("Set DET%d to %d segments\n", hubp_inst, det_size_segments);
 	/* Should never be hit, if it is we have an erroneous hw config*/
 	ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
 			+ hubbub2->det3_size + hubbub2->compbuf_size_segments <= hubbub2->crb_size_segs);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 41c972c8eb198..42a0157fd8133 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -136,6 +136,9 @@
 
 #define DCN3_15_MAX_DET_SIZE 384
 #define DCN3_15_CRB_SEGMENT_SIZE_KB 64
+#define DCN3_15_MAX_DET_SEGS (DCN3_15_MAX_DET_SIZE / DCN3_15_CRB_SEGMENT_SIZE_KB)
+/* Minimum 2 extra segments need to be in compbuf and claimable to guarantee seamless mpo transitions */
+#define MIN_RESERVED_DET_SEGS 2
 
 enum dcn31_clk_src_array_id {
 	DCN31_CLK_SRC_PLL0,
@@ -1636,21 +1639,57 @@ static bool is_dual_plane(enum surface_pixel_format format)
 	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
+static int source_format_to_bpp (enum source_format_class SourcePixelFormat)
+{
+	if (SourcePixelFormat == dm_444_64)
+		return 8;
+	else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16)
+		return 2;
+	else if (SourcePixelFormat == dm_444_8)
+		return 1;
+	else if (SourcePixelFormat == dm_rgbe_alpha)
+		return 5;
+	else if (SourcePixelFormat == dm_420_8)
+		return 3;
+	else if (SourcePixelFormat == dm_420_12)
+		return 6;
+	else
+		return 4;
+}
+
+static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	struct resource_context *res_ctx = &context->res_ctx;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+
+		/*Don't apply if MPO to avoid transition issues*/
+		if (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state != res_ctx->pipe_ctx[i].plane_state)
+			return false;
+	}
+	return true;
+}
+
 static int dcn315_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
 	bool fast_validate)
 {
-	int i, pipe_cnt;
+	int i, pipe_cnt, crb_idx, crb_pipes;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	const int max_usable_det = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB;
+	int remaining_det_segs = max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB;
+	bool pixel_rate_crb = allow_pixel_rate_crb(dc, context);
 
 	DC_FP_START();
 	dcn31x_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 	DC_FP_END();
 
-	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+	for (i = 0, pipe_cnt = 0, crb_pipes = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_crtc_timing *timing;
 
 		if (!res_ctx->pipe_ctx[i].stream)
@@ -1671,6 +1710,23 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 		DC_FP_START();
 		dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
+		if (pixel_rate_crb && !pipe->top_pipe && !pipe->prev_odm_pipe) {
+			int bpp = source_format_to_bpp(pipes[pipe_cnt].pipe.src.source_format);
+			/* Ceil to crb segment size */
+			int approx_det_segs_required_for_pstate = dcn_get_approx_det_segs_required_for_pstate(
+					&context->bw_ctx.dml.soc, timing->pix_clk_100hz, bpp, DCN3_15_CRB_SEGMENT_SIZE_KB);
+			if (approx_det_segs_required_for_pstate <= 2 * DCN3_15_MAX_DET_SEGS) {
+				bool split_required = approx_det_segs_required_for_pstate > DCN3_15_MAX_DET_SEGS;
+				split_required = split_required || timing->pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc);
+				split_required = split_required || (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+				if (split_required)
+					approx_det_segs_required_for_pstate += approx_det_segs_required_for_pstate % 2;
+				pipes[pipe_cnt].pipe.src.det_size_override = approx_det_segs_required_for_pstate;
+				remaining_det_segs -= approx_det_segs_required_for_pstate;
+			} else
+				remaining_det_segs = -1;
+			crb_pipes++;
+		}
 		DC_FP_END();
 
 		if (pipes[pipe_cnt].dout.dsc_enable) {
@@ -1689,16 +1745,49 @@ static int dcn315_populate_dml_pipes_from_context(
 				break;
 			}
 		}
-
 		pipe_cnt++;
 	}
 
+	/* Spread remaining unreserved crb evenly among all pipes, use default policy if not enough det or single pipe */
+	if (pixel_rate_crb) {
+		for (i = 0, pipe_cnt = 0, crb_idx = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &res_ctx->pipe_ctx[i];
+			if (!pipe->stream)
+				continue;
+
+			if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
+				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
+						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+
+				if (remaining_det_segs < 0 || crb_pipes == 1)
+					pipes[pipe_cnt].pipe.src.det_size_override = 0;
+				if (remaining_det_segs > MIN_RESERVED_DET_SEGS)
+					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
+							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
+				if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
+					/* Clamp to 2 pipe split max det segments */
+					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override - 2 * (DCN3_15_MAX_DET_SEGS);
+					pipes[pipe_cnt].pipe.src.det_size_override = 2 * DCN3_15_MAX_DET_SEGS;
+				}
+				if (pipes[pipe_cnt].pipe.src.det_size_override > DCN3_15_MAX_DET_SEGS || split_required) {
+					/* If we are splitting we must have an even number of segments */
+					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override % 2;
+					pipes[pipe_cnt].pipe.src.det_size_override -= pipes[pipe_cnt].pipe.src.det_size_override % 2;
+				}
+				/* Convert segments into size for DML use */
+				pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
+				crb_idx++;
+			}
+			pipe_cnt++;
+		}
+	}
+
 	if (pipe_cnt)
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes =
 				(max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB / pipe_cnt) * DCN3_15_CRB_SEGMENT_SIZE_KB;
 	if (context->bw_ctx.dml.ip.det_buffer_size_kbytes > DCN3_15_MAX_DET_SIZE)
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_15_MAX_DET_SIZE;
-	ASSERT(context->bw_ctx.dml.ip.det_buffer_size_kbytes >= DCN3_15_DEFAULT_DET_SIZE);
+
 	dc->config.enable_4to1MPC = false;
 	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
 		if (is_dual_plane(pipe->plane_state->format)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 59836570603ac..19d034341e640 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -483,7 +483,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel)
 {
-	int i, pipe_idx, active_hubp_count = 0;
+	int i, pipe_idx, total_det = 0, active_hubp_count = 0;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 
 	dc_assert_fp_enabled();
@@ -563,6 +563,18 @@ void dcn31_calculate_wm_and_dlg_fp(
 			if (context->res_ctx.pipe_ctx[i].stream)
 				context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = 0;
 	}
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		context->res_ctx.pipe_ctx[i].det_buffer_size_kb =
+				get_det_buffer_size_kbytes(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		if (context->res_ctx.pipe_ctx[i].det_buffer_size_kb > 384)
+			context->res_ctx.pipe_ctx[i].det_buffer_size_kb /= 2;
+		total_det += context->res_ctx.pipe_ctx[i].det_buffer_size_kb;
+		pipe_idx++;
+	}
+	context->bw_ctx.bw.dcn.compbuf_size_kb = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - total_det;
 }
 
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
@@ -815,3 +827,14 @@ int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc)
 {
 	return soc->clock_limits[0].dispclk_mhz * 10000.0 / (1.0 + soc->dcn_downspread_percent / 100.0);
 }
+
+int dcn_get_approx_det_segs_required_for_pstate(
+		struct _vcs_dpi_soc_bounding_box_st *soc,
+		int pix_clk_100hz, int bpp, int seg_size_kb)
+{
+	/* Roughly calculate required crb to hide latency. In practice there is slightly
+	 * more buffer available for latency hiding
+	 */
+	return (int)(soc->dram_clock_change_latency_us * pix_clk_100hz * bpp
+					/ 10240000 + seg_size_kb - 1) /	seg_size_kb;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index 687d3522cc33e..8f9c8faed2605 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -47,6 +47,9 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc);
+int dcn_get_approx_det_segs_required_for_pstate(
+		struct _vcs_dpi_soc_bounding_box_st *soc,
+		int pix_clk_100hz, int bpp, int seg_size_kb);
 
 int dcn31x_populate_dml_pipes_from_context(struct dc *dc,
 					  struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index bd674dc30df33..a0f44eef7763f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -532,7 +532,8 @@ static void CalculateStutterEfficiency(
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
 		int NumberOfActivePlanes,
-		unsigned int DETBufferSizeInKByte,
+		bool DETSharedByAllDPP,
+		unsigned int DETBufferSizeInKByte[],
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
 		enum scan_direction_class SourceScan[],
@@ -3118,7 +3119,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->SurfaceWidthC[k],
 				v->SurfaceHeightY[k],
 				v->SurfaceHeightC[k],
-				v->DETBufferSizeInKByte[0] * 1024,
+				v->DETBufferSizeInKByte[k] * 1024,
 				v->BlockHeight256BytesY[k],
 				v->BlockHeight256BytesC[k],
 				v->SurfaceTiling[k],
@@ -3313,7 +3314,8 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	CalculateSwathAndDETConfiguration(
 			false,
 			v->NumberOfActivePlanes,
-			v->DETBufferSizeInKByte[0],
+			mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[0],
+			v->DETBufferSizeInKByte,
 			dummy1,
 			dummy2,
 			v->SourceScan,
@@ -3779,14 +3781,16 @@ static noinline void CalculatePrefetchSchedulePerPlane(
 		&v->VReadyOffsetPix[k]);
 }
 
-static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int *DETBufferSizeInKByte)
+static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int DETBufferSizeInKByte[])
 {
 	int i, total_pipes = 0;
 	for (i = 0; i < NumberOfActivePlanes; i++)
 		total_pipes += NoOfDPPThisState[i];
-	*DETBufferSizeInKByte = ((config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB) / 64 / total_pipes) * 64;
-	if (*DETBufferSizeInKByte > DCN3_15_MAX_DET_SIZE)
-		*DETBufferSizeInKByte = DCN3_15_MAX_DET_SIZE;
+	DETBufferSizeInKByte[0] = ((config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB) / 64 / total_pipes) * 64;
+	if (DETBufferSizeInKByte[0] > DCN3_15_MAX_DET_SIZE)
+		DETBufferSizeInKByte[0] = DCN3_15_MAX_DET_SIZE;
+	for (i = 1; i < NumberOfActivePlanes; i++)
+		DETBufferSizeInKByte[i] = DETBufferSizeInKByte[0];
 }
 
 
@@ -4026,7 +4030,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	CalculateSwathAndDETConfiguration(
 			true,
 			v->NumberOfActivePlanes,
-			v->DETBufferSizeInKByte[0],
+			mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[0],
+			v->DETBufferSizeInKByte,
 			v->MaximumSwathWidthLuma,
 			v->MaximumSwathWidthChroma,
 			v->SourceScan,
@@ -4166,6 +4171,10 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						|| (v->PlaneRequiredDISPCLK > v->MaxDispclkRoundedDownToDFSGranularity)) {
 					v->DISPCLK_DPPCLK_Support[i][j] = false;
 				}
+				if (mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[k] > DCN3_15_MAX_DET_SIZE && v->NoOfDPP[i][j][k] < 2) {
+					v->MPCCombine[i][j][k] = true;
+					v->NoOfDPP[i][j][k] = 2;
+				}
 			}
 			v->TotalNumberOfActiveDPP[i][j] = 0;
 			v->TotalNumberOfSingleDPPPlanes[i][j] = 0;
@@ -4642,12 +4651,13 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				v->ODMCombineEnableThisState[k] = v->ODMCombineEnablePerState[i][k];
 			}
 
-			if (v->NumberOfActivePlanes > 1 && mode_lib->project == DML_PROJECT_DCN315)
-				PatchDETBufferSizeInKByte(v->NumberOfActivePlanes, v->NoOfDPPThisState, v->ip.config_return_buffer_size_in_kbytes, &v->DETBufferSizeInKByte[0]);
+			if (v->NumberOfActivePlanes > 1 && mode_lib->project == DML_PROJECT_DCN315 && !v->DETSizeOverride[0])
+				PatchDETBufferSizeInKByte(v->NumberOfActivePlanes, v->NoOfDPPThisState, v->ip.config_return_buffer_size_in_kbytes, v->DETBufferSizeInKByte);
 			CalculateSwathAndDETConfiguration(
 					false,
 					v->NumberOfActivePlanes,
-					v->DETBufferSizeInKByte[0],
+					mode_lib->project == DML_PROJECT_DCN315 && v->DETSizeOverride[0],
+					v->DETBufferSizeInKByte,
 					v->MaximumSwathWidthLuma,
 					v->MaximumSwathWidthChroma,
 					v->SourceScan,
@@ -6611,7 +6621,8 @@ static void CalculateStutterEfficiency(
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
 		int NumberOfActivePlanes,
-		unsigned int DETBufferSizeInKByte,
+		bool DETSharedByAllDPP,
+		unsigned int DETBufferSizeInKByteA[],
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
 		enum scan_direction_class SourceScan[],
@@ -6695,6 +6706,10 @@ static void CalculateSwathAndDETConfiguration(
 
 	*ViewportSizeSupport = true;
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
+		unsigned int DETBufferSizeInKByte = DETBufferSizeInKByteA[k];
+
+		if (DETSharedByAllDPP && DPPPerPlane[k])
+			DETBufferSizeInKByte /= DPPPerPlane[k];
 		if ((SourcePixelFormat[k] == dm_444_64 || SourcePixelFormat[k] == dm_444_32 || SourcePixelFormat[k] == dm_444_16 || SourcePixelFormat[k] == dm_mono_16
 				|| SourcePixelFormat[k] == dm_mono_8 || SourcePixelFormat[k] == dm_rgbe)) {
 			if (SurfaceTiling[k] == dm_sw_linear
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index f9653f511baa3..2f63ae954826c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -571,6 +571,10 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.OutputLinkDPRate[mode_lib->vba.NumberOfActivePlanes] = dout->dp_rate;
 		mode_lib->vba.ODMUse[mode_lib->vba.NumberOfActivePlanes] = dst->odm_combine_policy;
 		mode_lib->vba.DETSizeOverride[mode_lib->vba.NumberOfActivePlanes] = src->det_size_override;
+		if (src->det_size_override)
+			mode_lib->vba.DETBufferSizeInKByte[mode_lib->vba.NumberOfActivePlanes] = src->det_size_override;
+		else
+			mode_lib->vba.DETBufferSizeInKByte[mode_lib->vba.NumberOfActivePlanes] = ip->det_buffer_size_kbytes;
 		//TODO: Need to assign correct values to dp_multistream vars
 		mode_lib->vba.OutputMultistreamEn[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_en;
 		mode_lib->vba.OutputMultistreamId[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_id;
@@ -785,6 +789,8 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 					mode_lib->vba.pipe_plane[k] =
 							mode_lib->vba.NumberOfActivePlanes;
 					mode_lib->vba.DPPPerPlane[mode_lib->vba.NumberOfActivePlanes]++;
+					if (src_k->det_size_override)
+						mode_lib->vba.DETBufferSizeInKByte[mode_lib->vba.NumberOfActivePlanes] = src_k->det_size_override;
 					if (mode_lib->vba.SourceScan[mode_lib->vba.NumberOfActivePlanes]
 							== dm_horz) {
 						mode_lib->vba.ViewportWidth[mode_lib->vba.NumberOfActivePlanes] +=
-- 
2.39.2



