Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3097B899D
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbjJDS1i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbjJDS1i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:27:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BB0AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:27:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CA7C433C8;
        Wed,  4 Oct 2023 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444052;
        bh=m31jh0cq+nbz9IARiKi/Qg0ABVGqXBgI/JO3nZn0d5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1570CP0Dm+uPb4fA9oAwSFoYV65/mzrsIAVnITMfn5g0+hB0PXCjs7EhYwHKYfkKF
         Vz61RXIf67Rxb772NF+/MI0Du7PTI+2lDcidLmImes+noN0oZOA18yyRoq3UsLxNah
         1VbfKOMFag9z8UBcNAvK9YEdz578l1Pd+5MQ/b94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Park <chris.park@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 113/321] drm/amd/display: Update DPG test pattern programming
Date:   Wed,  4 Oct 2023 19:54:18 +0200
Message-ID: <20231004175234.470233927@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjing Liu <wenjing.liu@amd.com>

[ Upstream commit ad4455c614b27e6b24a4e6bd70114545c1660ff9 ]

[Why]
Last ODM slice could be slightly larger than other slice because it can be
including the residual.

[How]
Update DPG pattern programming sequence to use a different width for
last odm slice.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: f77d1a49902b ("drm/amd/display: fix a regression in blank pixel data caused by coding mistake")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  45 ++++----
 .../display/dc/link/accessories/link_dp_cts.c | 107 +++++++++---------
 2 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 7c344132a0072..704d02d89fb34 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1054,9 +1054,9 @@ void dcn20_blank_pixel_data(
 	enum controller_dp_color_space test_pattern_color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
 	struct pipe_ctx *odm_pipe;
 	int odm_cnt = 1;
-
-	int width = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
-	int height = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
+	int h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+	int v_active = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
+	int odm_slice_width, last_odm_slice_width, offset = 0;
 
 	if (stream->link->test_pattern_enabled)
 		return;
@@ -1066,8 +1066,8 @@ void dcn20_blank_pixel_data(
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		odm_cnt++;
-
-	width = width / odm_cnt;
+	odm_slice_width = h_active / odm_cnt;
+	last_odm_slice_width = h_active - odm_slice_width * (odm_cnt - 1);
 
 	if (blank) {
 		dc->hwss.set_abm_immediate_disable(pipe_ctx);
@@ -1080,29 +1080,32 @@ void dcn20_blank_pixel_data(
 		test_pattern = CONTROLLER_DP_TEST_PATTERN_VIDEOMODE;
 	}
 
-	dc->hwss.set_disp_pattern_generator(dc,
-			pipe_ctx,
-			test_pattern,
-			test_pattern_color_space,
-			stream->timing.display_color_depth,
-			&black_color,
-			width,
-			height,
-			0);
+	odm_pipe = pipe_ctx;
 
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+	while (odm_pipe->next_odm_pipe) {
 		dc->hwss.set_disp_pattern_generator(dc,
-				odm_pipe,
-				dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE && blank ?
-						CONTROLLER_DP_TEST_PATTERN_COLORRAMP : test_pattern,
+				pipe_ctx,
+				test_pattern,
 				test_pattern_color_space,
 				stream->timing.display_color_depth,
 				&black_color,
-				width,
-				height,
-				0);
+				odm_slice_width,
+				v_active,
+				offset);
+		offset += odm_slice_width;
+		odm_pipe = odm_pipe->next_odm_pipe;
 	}
 
+	dc->hwss.set_disp_pattern_generator(dc,
+			odm_pipe,
+			test_pattern,
+			test_pattern_color_space,
+			stream->timing.display_color_depth,
+			&black_color,
+			last_odm_slice_width,
+			v_active,
+			offset);
+
 	if (!blank && dc->debug.enable_single_display_2to1_odm_policy) {
 		/* when exiting dynamic ODM need to reinit DPG state for unused pipes */
 		struct pipe_ctx *old_odm_pipe = dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx].next_odm_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index db9f1baa27e5e..bce0428ad6123 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -428,15 +428,24 @@ static void set_crtc_test_pattern(struct dc_link *link,
 		stream->timing.display_color_depth;
 	struct bit_depth_reduction_params params;
 	struct output_pixel_processor *opp = pipe_ctx->stream_res.opp;
-	int width = pipe_ctx->stream->timing.h_addressable +
+	struct pipe_ctx *odm_pipe;
+	int odm_cnt = 1;
+	int h_active = pipe_ctx->stream->timing.h_addressable +
 		pipe_ctx->stream->timing.h_border_left +
 		pipe_ctx->stream->timing.h_border_right;
-	int height = pipe_ctx->stream->timing.v_addressable +
+	int v_active = pipe_ctx->stream->timing.v_addressable +
 		pipe_ctx->stream->timing.v_border_bottom +
 		pipe_ctx->stream->timing.v_border_top;
+	int odm_slice_width, last_odm_slice_width, offset = 0;
 
 	memset(&params, 0, sizeof(params));
 
+	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		odm_cnt++;
+
+	odm_slice_width = h_active / odm_cnt;
+	last_odm_slice_width = h_active - odm_slice_width * (odm_cnt - 1);
+
 	switch (test_pattern) {
 	case DP_TEST_PATTERN_COLOR_SQUARES:
 		controller_test_pattern =
@@ -473,16 +482,13 @@ static void set_crtc_test_pattern(struct dc_link *link,
 	{
 		/* disable bit depth reduction */
 		pipe_ctx->stream->bit_depth_params = params;
-		opp->funcs->opp_program_bit_depth_reduction(opp, &params);
-		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
+		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern) {
+			opp->funcs->opp_program_bit_depth_reduction(opp, &params);
 			pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
 				controller_test_pattern, color_depth);
-		else if (link->dc->hwss.set_disp_pattern_generator) {
-			struct pipe_ctx *odm_pipe;
+		} else if (link->dc->hwss.set_disp_pattern_generator) {
 			enum controller_dp_color_space controller_color_space;
-			int opp_cnt = 1;
-			int offset = 0;
-			int dpg_width = width;
+			struct output_pixel_processor *odm_opp;
 
 			switch (test_pattern_color_space) {
 			case DP_TEST_PATTERN_COLOR_SPACE_RGB:
@@ -502,36 +508,33 @@ static void set_crtc_test_pattern(struct dc_link *link,
 				break;
 			}
 
-			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-				opp_cnt++;
-			dpg_width = width / opp_cnt;
-			offset = dpg_width;
-
-			link->dc->hwss.set_disp_pattern_generator(link->dc,
-					pipe_ctx,
-					controller_test_pattern,
-					controller_color_space,
-					color_depth,
-					NULL,
-					dpg_width,
-					height,
-					0);
-
-			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-				struct output_pixel_processor *odm_opp = odm_pipe->stream_res.opp;
-
+			odm_pipe = pipe_ctx;
+			while (odm_pipe->next_odm_pipe) {
+				odm_opp = odm_pipe->stream_res.opp;
 				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 				link->dc->hwss.set_disp_pattern_generator(link->dc,
-						odm_pipe,
+						pipe_ctx,
 						controller_test_pattern,
 						controller_color_space,
 						color_depth,
 						NULL,
-						dpg_width,
-						height,
+						odm_slice_width,
+						v_active,
 						offset);
-				offset += offset;
+				offset += odm_slice_width;
+				odm_pipe = odm_pipe->next_odm_pipe;
 			}
+			odm_opp = odm_pipe->stream_res.opp;
+			odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
+			link->dc->hwss.set_disp_pattern_generator(link->dc,
+					odm_pipe,
+					controller_test_pattern,
+					controller_color_space,
+					color_depth,
+					NULL,
+					last_odm_slice_width,
+					v_active,
+					offset);
 		}
 	}
 	break;
@@ -540,23 +543,17 @@ static void set_crtc_test_pattern(struct dc_link *link,
 		/* restore bitdepth reduction */
 		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &params);
 		pipe_ctx->stream->bit_depth_params = params;
-		opp->funcs->opp_program_bit_depth_reduction(opp, &params);
-		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
+		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern) {
+			opp->funcs->opp_program_bit_depth_reduction(opp, &params);
 			pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
-				CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
-				color_depth);
-		else if (link->dc->hwss.set_disp_pattern_generator) {
-			struct pipe_ctx *odm_pipe;
-			int opp_cnt = 1;
-			int dpg_width;
-
-			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-				opp_cnt++;
-
-			dpg_width = width / opp_cnt;
-			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-				struct output_pixel_processor *odm_opp = odm_pipe->stream_res.opp;
+					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
+					color_depth);
+		} else if (link->dc->hwss.set_disp_pattern_generator) {
+			struct output_pixel_processor *odm_opp;
 
+			odm_pipe = pipe_ctx;
+			while (odm_pipe->next_odm_pipe) {
+				odm_opp = odm_pipe->stream_res.opp;
 				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 				link->dc->hwss.set_disp_pattern_generator(link->dc,
 						odm_pipe,
@@ -564,19 +561,23 @@ static void set_crtc_test_pattern(struct dc_link *link,
 						CONTROLLER_DP_COLOR_SPACE_UDEFINED,
 						color_depth,
 						NULL,
-						dpg_width,
-						height,
-						0);
+						odm_slice_width,
+						v_active,
+						offset);
+				offset += odm_slice_width;
+				odm_pipe = odm_pipe->next_odm_pipe;
 			}
+			odm_opp = odm_pipe->stream_res.opp;
+			odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 			link->dc->hwss.set_disp_pattern_generator(link->dc,
-					pipe_ctx,
+					odm_pipe,
 					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
 					CONTROLLER_DP_COLOR_SPACE_UDEFINED,
 					color_depth,
 					NULL,
-					dpg_width,
-					height,
-					0);
+					last_odm_slice_width,
+					v_active,
+					offset);
 		}
 	}
 	break;
-- 
2.40.1



