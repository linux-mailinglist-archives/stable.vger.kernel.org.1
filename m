Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B262761332
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjGYLIt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjGYLIf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC89468F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64AE861655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4853EC433C8;
        Tue, 25 Jul 2023 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283216;
        bh=bPq0HG5x6Bsrc/jsnofwFn6cmwOQrRu0SCu+20rJHSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GydNR+WohEHl6tDX6iwNFUporz2MLyOvMpvm0k19Nl4YwTGwg8TasmgN3bQOpZOXb
         9nZwYgxFIFzpFx/JYl17bBCGx66lG/0Ya5O+I6PXoeniVOc0Tz5Sy5s0TPSGAJ9iub
         JOH48NJPNNAdkwJuggTMd5YAVGgvGQ9rWji5MndQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>, Alan Liu <HaoPing.Liu@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 180/183] drm/amd/display: force connector state when bpc changes during compliance
Date:   Tue, 25 Jul 2023 12:46:48 +0200
Message-ID: <20230725104514.204598641@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

commit 028c4ccfb8127255d60f8d9edde96cacf2958082 upstream.

[Why]
During DP DSC compliance tests, bpc requested would
change between sub-tests, which requires stream
to be recommited.

[How]
Force connector to disconnect and reconnect whenever
there is a bpc change in automated test.

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Adjustments for headers that were moved around in later commits. ]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         |   55 +++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h         |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  125 ++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c          |  139 +-------------
 drivers/gpu/drm/amd/display/dc/dm_helpers.h               |    6 
 5 files changed, 209 insertions(+), 121 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -40,6 +40,9 @@
 #include "dc/dc_stat.h"
 #include "amdgpu_dm_trace.h"
 #include "dc/inc/dc_link_ddc.h"
+#include "dpcd_defs.h"
+#include "dc/inc/link_dpcd.h"
+#include "link_service_types.h"
 
 #include "vid.h"
 #include "amdgpu.h"
@@ -1273,6 +1276,21 @@ static void mmhub_read_system_context(st
 
 }
 
+static void force_connector_state(
+	struct amdgpu_dm_connector *aconnector,
+	enum drm_connector_force force_state)
+{
+	struct drm_connector *connector = &aconnector->base;
+
+	mutex_lock(&connector->dev->mode_config.mutex);
+	aconnector->base.force = force_state;
+	mutex_unlock(&connector->dev->mode_config.mutex);
+
+	mutex_lock(&aconnector->hpd_lock);
+	drm_kms_helper_connector_hotplug_event(connector);
+	mutex_unlock(&aconnector->hpd_lock);
+}
+
 static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 {
 	struct hpd_rx_irq_offload_work *offload_work;
@@ -1281,6 +1299,9 @@ static void dm_handle_hpd_rx_offload_wor
 	struct amdgpu_device *adev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	unsigned long flags;
+	union test_response test_response;
+
+	memset(&test_response, 0, sizeof(test_response));
 
 	offload_work = container_of(work, struct hpd_rx_irq_offload_work, work);
 	aconnector = offload_work->offload_wq->aconnector;
@@ -1305,8 +1326,24 @@ static void dm_handle_hpd_rx_offload_wor
 		goto skip;
 
 	mutex_lock(&adev->dm.dc_lock);
-	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST)
+	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
 		dc_link_dp_handle_automated_test(dc_link);
+
+		if (aconnector->timing_changed) {
+			/* force connector disconnect and reconnect */
+			force_connector_state(aconnector, DRM_FORCE_OFF);
+			msleep(100);
+			force_connector_state(aconnector, DRM_FORCE_UNSPECIFIED);
+		}
+
+		test_response.bits.ACK = 1;
+
+		core_link_write_dpcd(
+		dc_link,
+		DP_TEST_RESPONSE,
+		&test_response.raw,
+		sizeof(test_response));
+	}
 	else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
 			hpd_rx_irq_check_link_loss_status(dc_link, &offload_work->data) &&
 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
@@ -3076,6 +3113,10 @@ void amdgpu_dm_update_connector_after_de
 						    aconnector->edid);
 		}
 
+		aconnector->timing_requested = kzalloc(sizeof(struct dc_crtc_timing), GFP_KERNEL);
+		if (!aconnector->timing_requested)
+			dm_error("%s: failed to create aconnector->requested_timing\n", __func__);
+
 		drm_connector_update_edid_property(connector, aconnector->edid);
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
 		update_connector_ext_caps(aconnector);
@@ -3087,6 +3128,8 @@ void amdgpu_dm_update_connector_after_de
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
+		kfree(aconnector->timing_requested);
+		aconnector->timing_requested = NULL;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 		/* Set CP to DESIRED if it was ENABLED, so we can re-enable it again on hotplug */
 		if (connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
@@ -3131,6 +3174,8 @@ static void handle_hpd_irq_helper(struct
 	if (aconnector->fake_enable)
 		aconnector->fake_enable = false;
 
+	aconnector->timing_changed = false;
+
 	if (!dc_link_detect_sink(aconnector->dc_link, &new_connection_type))
 		DRM_ERROR("KMS: Failed to detect connector\n");
 
@@ -5896,6 +5941,14 @@ create_stream_for_sink(struct amdgpu_dm_
 			stream, &mode, &aconnector->base, con_state, old_stream,
 			requested_bpc);
 
+	if (aconnector->timing_changed) {
+		DC_LOG_DEBUG("%s: overriding timing for automated test, bpc %d, changing to %d\n",
+				__func__,
+				stream->timing.display_color_depth,
+				aconnector->timing_requested->display_color_depth);
+		stream->timing = *aconnector->timing_requested;
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* SST DSC determination policy */
 	update_dsc_caps(aconnector, sink, stream, &dsc_caps);
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -31,6 +31,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_plane.h>
+#include "link_service_types.h"
 
 /*
  * This file contains the definition for amdgpu_display_manager
@@ -650,6 +651,10 @@ struct amdgpu_dm_connector {
 
 	/* Record progress status of mst*/
 	uint8_t mst_status;
+
+	/* Automated testing */
+	bool timing_changed;
+	struct dc_crtc_timing *timing_requested;
 };
 
 static inline void amdgpu_dm_set_mst_status(uint8_t *status,
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -38,6 +38,9 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_dm_mst_types.h"
+#include "dpcd_defs.h"
+#include "dc/inc/core_types.h"
+#include "dc_link_dp.h"
 
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
@@ -1056,6 +1059,128 @@ void dm_helpers_mst_enable_stream_featur
 					 sizeof(new_downspread));
 }
 
+bool dm_helpers_dp_handle_test_pattern_request(
+		struct dc_context *ctx,
+		const struct dc_link *link,
+		union link_test_pattern dpcd_test_pattern,
+		union test_misc dpcd_test_params)
+{
+	enum dp_test_pattern test_pattern;
+	enum dp_test_pattern_color_space test_pattern_color_space =
+			DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED;
+	enum dc_color_depth requestColorDepth = COLOR_DEPTH_UNDEFINED;
+	enum dc_pixel_encoding requestPixelEncoding = PIXEL_ENCODING_UNDEFINED;
+	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (pipes[i].stream == NULL)
+			continue;
+
+		if (pipes[i].stream->link == link && !pipes[i].top_pipe &&
+			!pipes[i].prev_odm_pipe) {
+			pipe_ctx = &pipes[i];
+			break;
+		}
+	}
+
+	if (pipe_ctx == NULL)
+		return false;
+
+	switch (dpcd_test_pattern.bits.PATTERN) {
+	case LINK_TEST_PATTERN_COLOR_RAMP:
+		test_pattern = DP_TEST_PATTERN_COLOR_RAMP;
+	break;
+	case LINK_TEST_PATTERN_VERTICAL_BARS:
+		test_pattern = DP_TEST_PATTERN_VERTICAL_BARS;
+	break; /* black and white */
+	case LINK_TEST_PATTERN_COLOR_SQUARES:
+		test_pattern = (dpcd_test_params.bits.DYN_RANGE ==
+				TEST_DYN_RANGE_VESA ?
+				DP_TEST_PATTERN_COLOR_SQUARES :
+				DP_TEST_PATTERN_COLOR_SQUARES_CEA);
+	break;
+	default:
+		test_pattern = DP_TEST_PATTERN_VIDEO_MODE;
+	break;
+	}
+
+	if (dpcd_test_params.bits.CLR_FORMAT == 0)
+		test_pattern_color_space = DP_TEST_PATTERN_COLOR_SPACE_RGB;
+	else
+		test_pattern_color_space = dpcd_test_params.bits.YCBCR_COEFS ?
+				DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 :
+				DP_TEST_PATTERN_COLOR_SPACE_YCBCR601;
+
+	switch (dpcd_test_params.bits.BPC) {
+	case 0: // 6 bits
+		requestColorDepth = COLOR_DEPTH_666;
+		break;
+	case 1: // 8 bits
+		requestColorDepth = COLOR_DEPTH_888;
+		break;
+	case 2: // 10 bits
+		requestColorDepth = COLOR_DEPTH_101010;
+		break;
+	case 3: // 12 bits
+		requestColorDepth = COLOR_DEPTH_121212;
+		break;
+	default:
+		break;
+	}
+
+	switch (dpcd_test_params.bits.CLR_FORMAT) {
+	case 0:
+		requestPixelEncoding = PIXEL_ENCODING_RGB;
+		break;
+	case 1:
+		requestPixelEncoding = PIXEL_ENCODING_YCBCR422;
+		break;
+	case 2:
+		requestPixelEncoding = PIXEL_ENCODING_YCBCR444;
+		break;
+	default:
+		requestPixelEncoding = PIXEL_ENCODING_RGB;
+		break;
+	}
+
+	if ((requestColorDepth != COLOR_DEPTH_UNDEFINED
+		&& pipe_ctx->stream->timing.display_color_depth != requestColorDepth)
+		|| (requestPixelEncoding != PIXEL_ENCODING_UNDEFINED
+		&& pipe_ctx->stream->timing.pixel_encoding != requestPixelEncoding)) {
+		DC_LOG_DEBUG("%s: original bpc %d pix encoding %d, changing to %d  %d\n",
+				__func__,
+				pipe_ctx->stream->timing.display_color_depth,
+				pipe_ctx->stream->timing.pixel_encoding,
+				requestColorDepth,
+				requestPixelEncoding);
+		pipe_ctx->stream->timing.display_color_depth = requestColorDepth;
+		pipe_ctx->stream->timing.pixel_encoding = requestPixelEncoding;
+
+		dp_update_dsc_config(pipe_ctx);
+
+		aconnector->timing_changed = true;
+		/* store current timing */
+		if (aconnector->timing_requested)
+			*aconnector->timing_requested = pipe_ctx->stream->timing;
+		else
+			DC_LOG_ERROR("%s: timing storage failed\n", __func__);
+
+	}
+
+	dc_link_dp_set_test_pattern(
+		(struct dc_link *) link,
+		test_pattern,
+		test_pattern_color_space,
+		NULL,
+		NULL,
+		0);
+
+	return false;
+}
+
 void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
 {
        // TODO
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4264,124 +4264,6 @@ static void dp_test_send_phy_test_patter
 		test_pattern_size);
 }
 
-static void dp_test_send_link_test_pattern(struct dc_link *link)
-{
-	union link_test_pattern dpcd_test_pattern;
-	union test_misc dpcd_test_params;
-	enum dp_test_pattern test_pattern;
-	enum dp_test_pattern_color_space test_pattern_color_space =
-			DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED;
-	enum dc_color_depth requestColorDepth = COLOR_DEPTH_UNDEFINED;
-	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
-	struct pipe_ctx *pipe_ctx = NULL;
-	int i;
-
-	memset(&dpcd_test_pattern, 0, sizeof(dpcd_test_pattern));
-	memset(&dpcd_test_params, 0, sizeof(dpcd_test_params));
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (pipes[i].stream == NULL)
-			continue;
-
-		if (pipes[i].stream->link == link && !pipes[i].top_pipe && !pipes[i].prev_odm_pipe) {
-			pipe_ctx = &pipes[i];
-			break;
-		}
-	}
-
-	if (pipe_ctx == NULL)
-		return;
-
-	/* get link test pattern and pattern parameters */
-	core_link_read_dpcd(
-			link,
-			DP_TEST_PATTERN,
-			&dpcd_test_pattern.raw,
-			sizeof(dpcd_test_pattern));
-	core_link_read_dpcd(
-			link,
-			DP_TEST_MISC0,
-			&dpcd_test_params.raw,
-			sizeof(dpcd_test_params));
-
-	switch (dpcd_test_pattern.bits.PATTERN) {
-	case LINK_TEST_PATTERN_COLOR_RAMP:
-		test_pattern = DP_TEST_PATTERN_COLOR_RAMP;
-	break;
-	case LINK_TEST_PATTERN_VERTICAL_BARS:
-		test_pattern = DP_TEST_PATTERN_VERTICAL_BARS;
-	break; /* black and white */
-	case LINK_TEST_PATTERN_COLOR_SQUARES:
-		test_pattern = (dpcd_test_params.bits.DYN_RANGE ==
-				TEST_DYN_RANGE_VESA ?
-				DP_TEST_PATTERN_COLOR_SQUARES :
-				DP_TEST_PATTERN_COLOR_SQUARES_CEA);
-	break;
-	default:
-		test_pattern = DP_TEST_PATTERN_VIDEO_MODE;
-	break;
-	}
-
-	if (dpcd_test_params.bits.CLR_FORMAT == 0)
-		test_pattern_color_space = DP_TEST_PATTERN_COLOR_SPACE_RGB;
-	else
-		test_pattern_color_space = dpcd_test_params.bits.YCBCR_COEFS ?
-				DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 :
-				DP_TEST_PATTERN_COLOR_SPACE_YCBCR601;
-
-	switch (dpcd_test_params.bits.BPC) {
-	case 0: // 6 bits
-		requestColorDepth = COLOR_DEPTH_666;
-		break;
-	case 1: // 8 bits
-		requestColorDepth = COLOR_DEPTH_888;
-		break;
-	case 2: // 10 bits
-		requestColorDepth = COLOR_DEPTH_101010;
-		break;
-	case 3: // 12 bits
-		requestColorDepth = COLOR_DEPTH_121212;
-		break;
-	default:
-		break;
-	}
-
-	switch (dpcd_test_params.bits.CLR_FORMAT) {
-	case 0:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_RGB;
-		break;
-	case 1:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_YCBCR422;
-		break;
-	case 2:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_YCBCR444;
-		break;
-	default:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_RGB;
-		break;
-	}
-
-
-	if (requestColorDepth != COLOR_DEPTH_UNDEFINED
-			&& pipe_ctx->stream->timing.display_color_depth != requestColorDepth) {
-		DC_LOG_DEBUG("%s: original bpc %d, changing to %d\n",
-				__func__,
-				pipe_ctx->stream->timing.display_color_depth,
-				requestColorDepth);
-		pipe_ctx->stream->timing.display_color_depth = requestColorDepth;
-	}
-
-	dp_update_dsc_config(pipe_ctx);
-
-	dc_link_dp_set_test_pattern(
-			link,
-			test_pattern,
-			test_pattern_color_space,
-			NULL,
-			NULL,
-			0);
-}
-
 static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video)
 {
 	union audio_test_mode            dpcd_test_mode = {0};
@@ -4494,8 +4376,25 @@ void dc_link_dp_handle_automated_test(st
 		test_response.bits.ACK = 0;
 	}
 	if (test_request.bits.LINK_TEST_PATTRN) {
-		dp_test_send_link_test_pattern(link);
-		test_response.bits.ACK = 1;
+		union test_misc dpcd_test_params;
+		union link_test_pattern dpcd_test_pattern;
+
+		memset(&dpcd_test_pattern, 0, sizeof(dpcd_test_pattern));
+		memset(&dpcd_test_params, 0, sizeof(dpcd_test_params));
+
+		/* get link test pattern and pattern parameters */
+		core_link_read_dpcd(
+				link,
+				DP_TEST_PATTERN,
+				&dpcd_test_pattern.raw,
+				sizeof(dpcd_test_pattern));
+		core_link_read_dpcd(
+				link,
+				DP_TEST_MISC0,
+				&dpcd_test_params.raw,
+				sizeof(dpcd_test_params));
+		test_response.bits.ACK = dm_helpers_dp_handle_test_pattern_request(link->ctx, link,
+				dpcd_test_pattern, dpcd_test_params) ? 1 : 0;
 	}
 
 	if (test_request.bits.AUDIO_TEST_PATTERN) {
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -156,6 +156,12 @@ enum dc_edid_status dm_helpers_read_loca
 		struct dc_link *link,
 		struct dc_sink *sink);
 
+bool dm_helpers_dp_handle_test_pattern_request(
+		struct dc_context *ctx,
+		const struct dc_link *link,
+		union link_test_pattern dpcd_test_pattern,
+		union test_misc dpcd_test_params);
+
 void dm_set_dcn_clocks(
 		struct dc_context *ctx,
 		struct dc_clocks *clks);


