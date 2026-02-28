Return-Path: <stable+bounces-220211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFz/Mdcwo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 108001C5964
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EA8E330F71D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BD64DA551;
	Sat, 28 Feb 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di/gpas4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720E4DA54B;
	Sat, 28 Feb 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300116; cv=none; b=V9OQk+K7Kk2XFswUxe0sOVbElT3ZCcDmmOYEVQKdrOnhzypIPHlqoC8Me9becWOA+8d0WlZb0W/iO+hek1AeCBgMOamOR+mIzJd2q+OpUXXFmDRV6wjog4xaNEkJjL264tgeFvLKxbco77AewitP7ZRxX4tiXiFH5hMTw4x0VE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300116; c=relaxed/simple;
	bh=oebkLr1MOMbtNP7pNpSiDx60nHAn9VCedlTylHJXxHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiMK1o1a1AHuQ8QzKJ/c7bgv8yx1QUP+Moycf1hlt5xtxWolLhl7BYmLKGdxPhLC1kXk2H+3WjpG759CqILlTIY2T1tSfEXCszIQYgYvzDwcwFnJQkSBb9fcDouMccj6Ii6ZeXV8SMAqtGvSVvgGaApGPXEfVlAYZcMWlaB9YuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di/gpas4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D76EC116D0;
	Sat, 28 Feb 2026 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300116;
	bh=oebkLr1MOMbtNP7pNpSiDx60nHAn9VCedlTylHJXxHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Di/gpas4w8gvh+YJfgY67xSFkyIzwrEGoHxu0pzBIObatkxj+8bGE+cIR9+6M8veT
	 O67ZoL7T5k53IOT35BTNxcdNfCEvaliHYBACOrHfnf4PuGJ9isqkCcfRGwcwUg+ano
	 RII0fOMhrupweIVxAh76vGsm1s/6SCerEiTGZeXgMdFPW5dUTihRMvlBlD+T0y9ylb
	 DsJsAqusGsVOsdRhJYY7NyJLiK3QUt1ZhyDh95212w/kIFStvNEHP4T/gaOBW/LMRy
	 JDqgsLQ9hIjrNo3yETtFU15BCQoI+c++5B/5teDRax4efnTtZ+nKb28tK9Qe3GtQJg
	 iabczt5+6L/Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Relja Vojvodic <rvojvodi@amd.com>,
	Chris Park <chris.park@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 133/844] drm/amd/display: Correct DSC padding accounting
Date: Sat, 28 Feb 2026 12:20:46 -0500
Message-ID: <20260228173244.1509663-134-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220211-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 108001C5964
X-Rspamd-Action: no action

From: Relja Vojvodic <rvojvodi@amd.com>

[ Upstream commit c7062be3380cb20c8b1c4a935a13f1848ead0719 ]

[WHY]
- After the addition of all OVT patches, DSC padding was being accounted
  for multiple times, effectively doubling the padding
- This caused compliance failures or corruption

[HOW]
- Add padding to DSC pic width when required by HW, and do not re-add
  when calculating reg values
- Do not add padding when computing PPS values, and instead track padding
  separately to add when calculating slice width values

Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c             | 3 ++-
 .../gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c  | 6 +++---
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 4ee6ed610de0b..3e239124c17d8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -108,7 +108,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index be1f3caf4096f..24af5e94c7fce 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1063,7 +1063,7 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		if (should_use_dto_dscclk)
 			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 7aa0f452e8f7a..cb2dfd34b5e2e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -364,7 +364,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 635f614c06734..770c9cd128ae8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -841,7 +841,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		if (should_use_dto_dscclk)
 			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
@@ -857,6 +857,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
 		dsc_cfg.pic_width *= opp_cnt;
+		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 
 		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 6679c1a14f2fe..8d10aac9c510c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1660,8 +1660,8 @@ bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx)
 		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe || !stream || !stream->timing.flags.DSC)
 			continue;
 
-		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left
-				+ stream->timing.h_border_right) / opp_cnt;
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding
+				+ stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top
 				+ stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
@@ -1669,7 +1669,7 @@ bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx)
 		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		if (!pipe_ctx->stream_res.dsc->funcs->dsc_validate_stream(pipe_ctx->stream_res.dsc, &dsc_cfg))
 			return false;
-- 
2.51.0


