Return-Path: <stable+bounces-100909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2269EE741
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD091188831D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248342135DE;
	Thu, 12 Dec 2024 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k3qpLUcS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84101714D7
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008330; cv=none; b=eW48DcdKpvX1XI/dxvwqEf8auCwrj76rDrW4wed07EjlihHSCrKbl6f9SUqh4yIKTS0leaUOkjSdmjpeJjCQxgqF3Ml8ob1GD+UaDnIabONQlttA6FC2FvhcWXn2YUAYy1oyqvTVsl6viKUXxfet9Q9W2FR0tw4to1je4A7UYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008330; c=relaxed/simple;
	bh=XsJ0ZcRPyiK5y7TIMZN8HLskGEb7OiHUyugkuirbYjs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZRYe6HFh9T31dSGz+OePpOc3U0rGJXG7GsL+l6reED5jh9oolh7vKpIHr4VBm/IzQMdsIZUNOFu3lczakysrhHq47bGx9F/uOUJXePwe/cYe6R1hYv+WJXDtrbo1iyDWTi5KSN/5lfXqeWbig7IGGX1BqrwShusjwMtZ9/KrJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k3qpLUcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F705C4CECE;
	Thu, 12 Dec 2024 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734008330;
	bh=XsJ0ZcRPyiK5y7TIMZN8HLskGEb7OiHUyugkuirbYjs=;
	h=Subject:To:Cc:From:Date:From;
	b=k3qpLUcSlg8ZT9LmKcx7uN9/f1m3DiEfiBlh3jf81sS4+yabdpLULwMCnyNXFoU7P
	 l0veabeIwHAIQOyvXISd40xdo8wiLKWNMjtR450uJ/yhP7jFN5Ng86FfP7o6ik4N02
	 tHbsdk/txO3drlOnCv8oI/N+hfFBE6pzvISufFlo=
Subject: FAILED: patch "[PATCH] drm/amd/display: Revert commit Update Interface to Check UCLK" failed to apply to 6.12-stable tree
To: Austin.Zheng@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,rodrigo.siqueira@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 12 Dec 2024 13:58:47 +0100
Message-ID: <2024121247-pantomime-moonlight-81f0@gregkh>
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
git cherry-pick -x 0e93b76cf92f229409e8da85c2a143868835fec3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121247-pantomime-moonlight-81f0@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e93b76cf92f229409e8da85c2a143868835fec3 Mon Sep 17 00:00:00 2001
From: Austin Zheng <Austin.Zheng@amd.com>
Date: Mon, 23 Sep 2024 10:07:32 -0400
Subject: [PATCH] drm/amd/display: Revert commit Update Interface to Check UCLK
 DPM

This reverts commit b8d046985c2dc41a0e264a391da4606099f8d44f.

Reverting as regression discovered on certain systems and golden values
need to updated.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 48057ac22cbd..57ad6ce88f3f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6038,15 +6038,8 @@ void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state *context)
 {
 	struct dc_power_profile profile = { 0 };
-	struct dc *dc = NULL;
 
-	if (!context || !context->clk_mgr || !context->clk_mgr->ctx || !context->clk_mgr->ctx->dc)
-		return profile;
-
-	dc = context->clk_mgr->ctx->dc;
-
-	if (dc->res_pool->funcs->get_power_profile)
-		profile.power_level = dc->res_pool->funcs->get_power_profile(context);
+	profile.power_level += !context->bw_ctx.bw.dcn.clk.p_state_change_support;
 
 	return profile;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 2e9c59e9e0c1..1cf9015e854a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1798,7 +1798,6 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 	}
 
 	if (s->pmo_dcn4.num_pstate_candidates > 0) {
-		s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.num_pstate_candidates-1].allow_state_increase = true;
 		s->pmo_dcn4.cur_pstate_candidate = -1;
 		return true;
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 8597e866bfe6..bfb8b8502d20 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -215,10 +215,6 @@ struct resource_funcs {
 
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 	void (*build_pipe_pix_clk_params)(struct pipe_ctx *pipe_ctx);
-	/*
-	 * Get indicator of power from a context that went through full validation
-	 */
-	int (*get_power_profile)(const struct dc_state *context);
 };
 
 struct audio_support{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index f6b840f046a5..3f4b9dba4112 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1812,11 +1812,6 @@ static void dcn315_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
-static int dcn315_get_power_profile(const struct dc_state *context)
-{
-	return !context->bw_ctx.bw.dcn.clk.p_state_change_support;
-}
-
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -1845,7 +1840,6 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.update_bw_bounding_box = dcn315_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn315_get_panel_config_defaults,
-	.get_power_profile = dcn315_get_power_profile,
 };
 
 static bool dcn315_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 59184abab1a7..f2653a86d3e7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1688,22 +1688,6 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 	}
 }
 
-static int dcn401_get_power_profile(const struct dc_state *context)
-{
-	int uclk_mhz = context->bw_ctx.bw.dcn.clk.dramclk_khz / 1000;
-	int dpm_level = 0;
-
-	for (int i = 0; i < context->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels; i++) {
-		if (context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz == 0 ||
-			uclk_mhz < context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
-			break;
-		if (uclk_mhz > context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
-			dpm_level++;
-	}
-
-	return dpm_level;
-}
-
 static struct resource_funcs dcn401_res_pool_funcs = {
 	.destroy = dcn401_destroy_resource_pool,
 	.link_enc_create = dcn401_link_encoder_create,
@@ -1730,7 +1714,6 @@ static struct resource_funcs dcn401_res_pool_funcs = {
 	.prepare_mcache_programming = dcn401_prepare_mcache_programming,
 	.build_pipe_pix_clk_params = dcn401_build_pipe_pix_clk_params,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
-	.get_power_profile = dcn401_get_power_profile,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)


