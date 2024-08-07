Return-Path: <stable+bounces-65552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C594A97C
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6B11F28381
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CD650271;
	Wed,  7 Aug 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xJtPknkh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530F21373
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039797; cv=none; b=Ypo7dmcZIeWDOyVi9daqlhi8pADnp0WW6zEtoDDg+Mj2mcR1nLd3ps4giJWh4VKS6/WievJeyv737TA72/07Y+btFTRgUqVqhum3ZqPBm62z7UjlSf693t8plEEK80+oZ2bPosQysd6ohVRm3ionYuDjqHALXWm7Re4/MPaF9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039797; c=relaxed/simple;
	bh=P2gXR4Bgf3+j5LsxR5zpOFyoWC+0pft5d6/Mo3xGGT8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HvPoeDFsUgPz3PApQItbbcZl/8xjIN7zIa3bnjtZrXheYrVWbSAkUfZS6jGsbFXvYo4PL57P+cRtRSjODe8difsM6EDlsNDnBJFo5lEm/9Xf1223jpOXOxzmAqhHnCEg1QW7Dfk8EC7Xet82EyYyzDg/w9eD2waVrKnK8KA67Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xJtPknkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E03C32781;
	Wed,  7 Aug 2024 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039796;
	bh=P2gXR4Bgf3+j5LsxR5zpOFyoWC+0pft5d6/Mo3xGGT8=;
	h=Subject:To:Cc:From:Date:From;
	b=xJtPknkhxOqtsfrkHvpXRG41MV4PBzhBkoZQxwuT2yBrNA8vU2XwWIQQqMHOYnYFo
	 xxKaxpBhzEbrWEYsKI6PmKcP2/x5UC2gU62rh4Liu4ft8nL1qxR+inEVBi2eQIOuhW
	 Cj8qWpsFNZ7SDKR3+3mTwT6gv9YFly+Of0pvHViw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Attempt to avoid empty TUs when endpoint is" failed to apply to 6.6-stable tree
To: michael.strauss@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:09:45 +0200
Message-ID: <2024080745-radiation-faucet-f866@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 37256027b45fe48d1cd23954db90d1c53401e29a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080745-radiation-faucet-f866@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

37256027b45f ("drm/amd/display: Attempt to avoid empty TUs when endpoint is DPIA")
532a0d2ad292 ("drm/amd/display: Revert "dc: Keep VBios pixel rate div setting util next mode set"")
47745acc5e8d ("drm/amd/display: Add trigger FIFO resync path for DCN35")
4d4d3ff16db2 ("drm/amd/display: Keep VBios pixel rate div setting util next mode set")
eed4edda910f ("drm/amd/display: Support long vblank feature")
2d7f3d1a5866 ("drm/amd/display: Implement wait_for_odm_update_pending_complete")
c7b33856139d ("drm/amd/display: Drop some unnecessary guards")
6a068e64fb25 ("drm/amd/display: Update phantom pipe enable / disable sequence")
db8391479f44 ("drm/amd/display: correct static screen event mask")
9af68235ad3d ("drm/amd/display: Fix static screen event mask definition change")
f6154d8babbb ("drm/amd/display: Refactor INIT into component folder")
a71e1310a43f ("drm/amd/display: Add more mechanisms for tests")
85fce153995e ("drm/amd/display: change static screen wait frame_count for ips")
09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")
ec39a6d00382 ("drm/amd/display: add debug option for ExtendedVBlank DLG adjust")
198891fd2902 ("drm/amd/display: Create one virtual connector in DC")
abd26a3252cb ("drm/amd/display: Add dml2 copy functions")
43484c4bdb6e ("drm/amd/display: Added delay to DPM log")
3d0fe4945465 ("drm/amd/display: Refactor OPTC into component folder")
6c22fb07e0c2 ("drm/amd/display: Refactor DSC into component folder")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 37256027b45fe48d1cd23954db90d1c53401e29a Mon Sep 17 00:00:00 2001
From: Michael Strauss <michael.strauss@amd.com>
Date: Tue, 7 May 2024 12:03:15 -0400
Subject: [PATCH] drm/amd/display: Attempt to avoid empty TUs when endpoint is
 DPIA

[WHY]
Empty SST TUs are illegal to transmit over a USB4 DP tunnel.
Current policy is to configure stream encoder to pack 2 pixels per pclk
even when ODM combine is not in use, allowing seamless dynamic ODM
reconfiguration. However, in extreme edge cases where average pixel
count per TU is less than 2, this can lead to unexpected empty TU
generation during compliance testing. For example, VIC 1 with a 1xHBR3
link configuration will average 1.98 pix/TU.

[HOW]
Calculate average pixel count per TU, and block 2 pixels per clock if
endpoint is a DPIA tunnel and pixel clock is low enough that we will
never require 2:1 ODM combine.

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 4f87316e1318..0602921399cd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1529,3 +1529,75 @@ void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
 		}
 	}
 }
+
+static bool should_avoid_empty_tu(struct pipe_ctx *pipe_ctx)
+{
+	/* Calculate average pixel count per TU, return false if under ~2.00 to
+	 * avoid empty TUs. This is only required for DPIA tunneling as empty TUs
+	 * are legal to generate for native DP links. Assume TU size 64 as there
+	 * is currently no scenario where it's reprogrammed from HW default.
+	 * MTPs have no such limitation, so this does not affect MST use cases.
+	 */
+	unsigned int pix_clk_mhz;
+	unsigned int symclk_mhz;
+	unsigned int avg_pix_per_tu_x1000;
+	unsigned int tu_size_bytes = 64;
+	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+	struct dc_link_settings *link_settings = &pipe_ctx->link_config.dp_link_settings;
+	const struct dc *dc = pipe_ctx->stream->link->dc;
+
+	if (pipe_ctx->stream->link->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
+		return false;
+
+	// Not necessary for MST configurations
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+		return false;
+
+	pix_clk_mhz = timing->pix_clk_100hz / 10000;
+
+	// If this is true, can't block due to dynamic ODM
+	if (pix_clk_mhz > dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz)
+		return false;
+
+	switch (link_settings->link_rate) {
+	case LINK_RATE_LOW:
+		symclk_mhz = 162;
+		break;
+	case LINK_RATE_HIGH:
+		symclk_mhz = 270;
+		break;
+	case LINK_RATE_HIGH2:
+		symclk_mhz = 540;
+		break;
+	case LINK_RATE_HIGH3:
+		symclk_mhz = 810;
+		break;
+	default:
+		// We shouldn't be tunneling any other rates, something is wrong
+		ASSERT(0);
+		return false;
+	}
+
+	avg_pix_per_tu_x1000 = (1000 * pix_clk_mhz * tu_size_bytes)
+		/ (symclk_mhz * link_settings->lane_count);
+
+	// Add small empirically-decided margin to account for potential jitter
+	return (avg_pix_per_tu_x1000 < 2020);
+}
+
+bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
+{
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+
+	if (!is_h_timing_divisible_by_2(pipe_ctx->stream))
+		return false;
+
+	if (should_avoid_empty_tu(pipe_ctx))
+		return false;
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal) && !dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) &&
+		dc->debug.enable_dp_dig_pixel_rate_div_policy)
+		return true;
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index bc05beba5f2c..e27b3609020f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -97,4 +97,6 @@ void dcn35_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
 		int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
 
+bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
+
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 30e6a6398839..428912f37129 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -161,7 +161,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
-	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.is_dp_dig_pixel_rate_div_policy = dcn35_is_dp_dig_pixel_rate_div_policy,
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,


