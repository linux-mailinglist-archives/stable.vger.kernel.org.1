Return-Path: <stable+bounces-65551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78694A97D
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90272B291FA
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34E2E419;
	Wed,  7 Aug 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DjjnMkop"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B83339B1
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039788; cv=none; b=jDEXvZk/ttx4TpRA9xr44b7so5Acu6Klv86KutFDmc29apKly6Hp0tUc1Jtgsdob3DnxVsAQ8+mqZnzp0VZI9V3iQMcjjXkkwGOnBK3j00EKNMljvr2yDS/7FkcQvM7xCoKNBQdp/X2xsDdMUkc/pHpiF8mZ05slhLgTTfjNcd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039788; c=relaxed/simple;
	bh=yQiD9aro0OB+c5O0v0/slQ6PGAv17/ykgpgEX2TfpVw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PrNnasyG/9Awa3LdLiTphg8xRu+SSBiLAeReDQ8oPi3M7dCB/zPT+hL/ObKvpF2bdCnGhInIe4gGc6smIA038aPzb9jd3v+H9g1wCHDzUqSShG8AfSV/TbdJUizwTrc1inLg8h3Pl8UxSFPXHWV4ht7S6fZ91fuT+N6/EFWPX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DjjnMkop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FBEC32781;
	Wed,  7 Aug 2024 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039788;
	bh=yQiD9aro0OB+c5O0v0/slQ6PGAv17/ykgpgEX2TfpVw=;
	h=Subject:To:Cc:From:Date:From;
	b=DjjnMkopV/wrP0kYB6xug+GhCspC/rwJHsp947EWShR1guYYSoOLUm/cJmHs6OQgW
	 OpogJ4QQMfSgOHebpCmKO8euXjgIySBgxmzvLJdgN17Sq4z3ONcNdg0fkzHYfjSVHD
	 BzvUr/OqoPHgwH9dleu7Ku83LFoKfiTFnto7onM4=
Subject: FAILED: patch "[PATCH] drm/amd/display: Attempt to avoid empty TUs when endpoint is" failed to apply to 6.10-stable tree
To: michael.strauss@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:09:44 +0200
Message-ID: <2024080744-managing-spotted-b0f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 37256027b45fe48d1cd23954db90d1c53401e29a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080744-managing-spotted-b0f4@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

37256027b45f ("drm/amd/display: Attempt to avoid empty TUs when endpoint is DPIA")
532a0d2ad292 ("drm/amd/display: Revert "dc: Keep VBios pixel rate div setting util next mode set"")
47745acc5e8d ("drm/amd/display: Add trigger FIFO resync path for DCN35")
4d4d3ff16db2 ("drm/amd/display: Keep VBios pixel rate div setting util next mode set")

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


