Return-Path: <stable+bounces-220248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD9QFx01o2kI+gQAu9opvQ
	(envelope-from <stable+bounces-220248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4C1C5F63
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BB84309D6CB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E8375249;
	Sat, 28 Feb 2026 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QumqkXwD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B18375240;
	Sat, 28 Feb 2026 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300152; cv=none; b=QnoR71+A0NBOvhvAuPPjXmGkEVMUWI6K5SWntBbaZvyOd9jC28MuOqYxNwAPjLE1aKbP7NVWdQqFr3X0T2YRqHzbZmrqxrMcoW+RtlN/ADU03rBcY6ilru46koqSTxkVfdHiT7c5iNbq5uKM8wSM2YfVd7NENPrrB8A7SckQGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300152; c=relaxed/simple;
	bh=8kH7fjcXz01elzl6DePsFy3ZBZZVGKgi8oVdueZK7DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a89/SMeZtt86O61llOmklCt6fArqAnueUz5L1+D9CtxNX/ZEB1Bj2dzIOA2Qy+2e13JFN8T9O5U2+Wej72HHxuqWCW17whLatn+0V8+RWwXH0LDE+KMU7BQZSksUDq4TOQVtXnqGbY6TbRL1TLmVN+CD7fuXpW6506DoXPIVNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QumqkXwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F324C2BC87;
	Sat, 28 Feb 2026 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300152;
	bh=8kH7fjcXz01elzl6DePsFy3ZBZZVGKgi8oVdueZK7DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QumqkXwD/EE1PXP1jn9gPV6Ur0NkXZgiVhCfNB1J8/8zB7yn7vkZBWJYw5AXrXTwD
	 wBfY4O3XaoQuo7ycvMziCbSzNYaZKDxTnpVRdSvxzKllW0R0p4LPia3D6nk2DzJQ2/
	 bqZg5rtCN02gRAnXhtikzrHw8Gzqc+3eHqrVH/FMsk0wqKgTSZ+NFbPsgqECnIm7xj
	 Hsp3fLsUYf0Iq+nLVuYeE+Z3zFmTp4HPl+bP5HUj6mN+FXz7Q3CCqwabXhpPKdWpct
	 roMTCXr+b0E+NsCSStdF8c5S+nwoQLuUVnXlWSbhZN4aAW4iQWH2Q6PmBLR/9ilsNN
	 VMH2kIOY0BX1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Yihan Zhu <yihan.zhu@amd.com>,
	Matthew Stewart <matthew.stewart2@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 170/844] drm/amd/display: Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS on DCN35
Date: Sat, 28 Feb 2026 12:21:23 -0500
Message-ID: <20260228173244.1509663-171-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220248-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 69F4C1C5F63
X-Rspamd-Action: no action

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 75372d75a4e23783583998ed99d5009d555850da ]

[Why]
A backport of the change made for DCN401 that addresses an issue where
we turn off the PHY PLL when disabling TMDS output, which causes the
OTG to remain stuck.

The OTG being stuck can lead to a hang in the DCHVM's ability to ACK
invalidations when it thinks the HUBP is still on but it's not receiving
global sync.

The transition to PLL_ON needs to be atomic as there's no guarantee
that the thread isn't pre-empted or is able to complete before the
IOMMU watchdog times out.

[How]
Backport the implementation from dcn401 back to dcn35.

There's a functional difference in when the eDP output is disabled in
dcn401 code so we don't want to utilize it directly.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 52 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  3 ++
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index cb2dfd34b5e2e..88542ca715573 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1726,3 +1726,55 @@ void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe
 {
 	dc_dmub_srv_program_cursor_now(dc, pipe);
 }
+
+static void disable_link_output_symclk_on_tx_off(struct dc_link *link, enum dp_link_encoding link_encoding)
+{
+	struct dc *dc = link->ctx->dc;
+	struct pipe_ctx *pipe_ctx = NULL;
+	uint8_t i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx->stream && pipe_ctx->stream->link == link && pipe_ctx->top_pipe == NULL) {
+			pipe_ctx->clock_source->funcs->program_pix_clk(
+					pipe_ctx->clock_source,
+					&pipe_ctx->stream_res.pix_clk_params,
+					link_encoding,
+					&pipe_ctx->pll_settings);
+			break;
+		}
+	}
+}
+
+void dcn35_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct dc *dc = link->ctx->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
+		link->dc->hwss.edp_backlight_control(link, false);
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	if (dc_is_tmds_signal(signal) && link->phy_state.symclk_ref_cnts.otg > 0) {
+		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
+		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
+	} else {
+		link_hwss->disable_link_output(link, link_res, signal);
+		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	}
+	/*
+	 * Add the logic to extract BOTH power up and power down sequences
+	 * from enable/disable link output and only call edp panel control
+	 * in enable_link_dp and disable_link_dp once.
+	 */
+	if (dmcu != NULL && dmcu->funcs->unlock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+
+	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 1ff41dba556c0..e3459546a908a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -108,5 +108,8 @@ void dcn35_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe
 void dcn35_notify_cursor_offload_drr_update(struct dc *dc, struct dc_state *context,
 					    const struct dc_stream_state *stream);
 void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn35_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal);
 
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 5a66c9db26709..81bd36f3381db 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -113,7 +113,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dcn32_disable_link_output,
+	.disable_link_output = dcn35_disable_link_output,
 	.z10_restore = dcn35_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
-- 
2.51.0


