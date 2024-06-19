Return-Path: <stable+bounces-53733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6483990E5ED
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB251F21602
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18577D41D;
	Wed, 19 Jun 2024 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="euMX2PHZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05977D414
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786291; cv=none; b=Ye/+gzs6q2Jhds7fxdBAJ4xuAfVSU6F2Rd/n+KxXekiJ94syHDaRYDKQCVBy+64Md/pO8egmFQGPLACRu/AJyQ3Ts0VESp/JqTJMY19VvCrXVLIDIRXZO3b32VkkU9WnkcI61K6csV08TfDUUsRwohnCvtU+EGxqqBXmt4N0FZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786291; c=relaxed/simple;
	bh=cI+XIImRXt162AJM8uovI7O98p/1AKhGcZ00Z/sntks=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F9WO+/AtHRDfntDewQHoaJaeqV93wiMv2IGr+q9+JU839iDk3YTK1mVoM3LuCvGeoztRlLRVgkhw2K8uN9lZ+DS1fbJskI22hjnHlYrBw6+5IdYp2c63LSbW/S4c13GPtjULJHVA3W8MLrP6Ziwdfaxwiyptws4G4vf4PSlqoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=euMX2PHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326F9C2BBFC;
	Wed, 19 Jun 2024 08:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786291;
	bh=cI+XIImRXt162AJM8uovI7O98p/1AKhGcZ00Z/sntks=;
	h=Subject:To:Cc:From:Date:From;
	b=euMX2PHZ1INwbGOtjn5HYN2GmmzCTdM9djFMgg2wi3rHXXrI+sxQzV1WKrdL57eZZ
	 tFjp9XVrCA1Mx6k+Cpgwrr6pqce9Uaxx1zo9Ry01CoEDgEOAYik7gIM5iJMX6d1vXn
	 kFK1GeoOXTiPATIUUEDT4cgQN+96x3IvBwMpD+xo=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix disable otg wa logic in DCN316" failed to apply to 6.6-stable tree
To: fudong.wang@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:38:03 +0200
Message-ID: <2024061903-municipal-untagged-2a85@gregkh>
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
git cherry-pick -x 27e718ac8b8194d13eee5738c4d3fd247736186e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061903-municipal-untagged-2a85@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

27e718ac8b81 ("drm/amd/display: fix disable otg wa logic in DCN316")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27e718ac8b8194d13eee5738c4d3fd247736186e Mon Sep 17 00:00:00 2001
From: Fudongwang <fudong.wang@amd.com>
Date: Tue, 26 Mar 2024 16:03:16 +0800
Subject: [PATCH] drm/amd/display: fix disable otg wa logic in DCN316

[Why]
Wrong logic cause screen corruption.

[How]
Port logic from DCN35/314.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Fudongwang <fudong.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index e4ed888f8403..20ca7afa9cb4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -99,20 +99,25 @@ static int dcn316_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
+static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context,
+		bool safe_to_lower, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = safe_to_lower
+			? &context->res_ctx.pipe_ctx[i]
+			: &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
-		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
-				     dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
+				     !pipe->stream->link_enc)) {
 			if (disable) {
-				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
+					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+
 				reset_sync_context_for_pipe(dc, context, i);
 			} else
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
@@ -207,11 +212,11 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn316_disable_otg_wa(clk_mgr_base, context, true);
+		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn316_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn316_disable_otg_wa(clk_mgr_base, context, false);
+		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
 	}


