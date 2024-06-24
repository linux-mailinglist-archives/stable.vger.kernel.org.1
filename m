Return-Path: <stable+bounces-55055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158BB9153E4
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942711F24629
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3299F19DFAF;
	Mon, 24 Jun 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="catd0Sdr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E610819DFA8
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246782; cv=none; b=mkRH9IqUi3b7gJjSZcuUMuOeM2Ukev4GOaONJPcME6TKQ3n3p9JS6ASJirMKRfEN5ie7f8XYaZq4N07x/Jqm8J4qqWZGszQcdv4eX+S3NCtwr7A5wszviopnYwZtKL72Ej4u7JjRf97TuVqcMjjb5JYltZGrzX2XvATXzNn4UEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246782; c=relaxed/simple;
	bh=4exri3XlDU79bhwuPIPO3sGrcbmd47cFY2ChO9/Fg9U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OUx1ii9aF+p+StX2mUqQkxZnNzvSIt9MIOL0iubFlNPGYSX7+tZF5QA7uU7nHTo7NATzr0H3rXSGaQ+pwarfI1RhTOs+E076tfLPZnruydmTty+dfIx+Ejq5LM6MlXOfE71rZmTky9SeVI3oBqtXc9VlFefetK4OiW/CeVp+IlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=catd0Sdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C501C2BBFC;
	Mon, 24 Jun 2024 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719246781;
	bh=4exri3XlDU79bhwuPIPO3sGrcbmd47cFY2ChO9/Fg9U=;
	h=Subject:To:Cc:From:Date:From;
	b=catd0SdrtuBWVz9Mab3a84uGJE/2epKEucvsceZYg1DpTdZZOlkVfM51aAzlju2SW
	 BPEbYjVbuVZP680jam2ja7FLTgJ0hul9mGdwTaE7FTDs4CBTG6Czt8NK0zEpfQeI90
	 TbmXqfPYgqEKUEEBQpp1Xxk2jmch+jlo3t4VAfrs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Attempt to avoid empty TUs when endpoint is" failed to apply to 6.6-stable tree
To: michael.strauss@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:32:58 +0200
Message-ID: <2024062458-impotency-swifter-6e17@gregkh>
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
git cherry-pick -x c03d770c0b014a3007a5874bf6b3c3e64d32aaac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062458-impotency-swifter-6e17@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c03d770c0b014a3007a5874bf6b3c3e64d32aaac Mon Sep 17 00:00:00 2001
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
index 5295f52e4fc8..dcced89c07b3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1439,3 +1439,75 @@ void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
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
index a731c8880d60..f0ea7d1511ae 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -95,4 +95,6 @@ void dcn35_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
 		int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
 
+bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
+
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index df3bf77f3fb4..199781233fd5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -158,7 +158,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
-	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.is_dp_dig_pixel_rate_div_policy = dcn35_is_dp_dig_pixel_rate_div_policy,
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,


