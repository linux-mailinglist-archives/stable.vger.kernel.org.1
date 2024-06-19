Return-Path: <stable+bounces-53735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D5190E5EF
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D1B1C216A1
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392997E0F2;
	Wed, 19 Jun 2024 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hda42jzs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C67D40E
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786298; cv=none; b=GQvdwppcB8wvA5sh4u1ZhhGu5rG/m5KEx747DDvJUVGalmkypSNNAQxCm6+qmhTtR6R8t9q+Z4P3zQZwHgHeqG3CRHy+FUaHGkZwa1uDWs5o6AuQti53UDv8hQWoKNOiNokQaNBPkpejdljFPEU/8CoMCHVt2AeQJUT5fel6jKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786298; c=relaxed/simple;
	bh=86PmWu1eFbRYB2M+yAo4ukF53gS4tEPQJItl1LlcLV0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SsRrhJkj6yfjs2H4uhDcVTZ5CzPXNlCd5zowYR5gaW1CZwVVo7VkPDPPEL1+sHQdwtzcUJBUTggtMXGN5uo/6f8+3i2nhznqCf5MPHn5Y5jZmPsS1qaXdtp1XJN85RZkvMAlT1l6YwAfdXQUIvrWYcWJNdqPTlDUvDC7cj2XHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hda42jzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BC3C2BBFC;
	Wed, 19 Jun 2024 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786297;
	bh=86PmWu1eFbRYB2M+yAo4ukF53gS4tEPQJItl1LlcLV0=;
	h=Subject:To:Cc:From:Date:From;
	b=hda42jzsXHLFkdLpCJzXDBBvRiE53dT81DlvHXUMqe7iUaISg/xVOcCdVNn3tpymn
	 pwk342wLnoYG5Wld5nDODEfXnSfmVtntIxbWipw16V9e9Etah4T61FZNCXHfKEWc1c
	 wyAy0kdrAWnaHEc+er+XIh9ZiTbKTm0uRw1L5T08=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix disable otg wa logic in DCN316" failed to apply to 5.4-stable tree
To: fudong.wang@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:38:05 +0200
Message-ID: <2024061905-december-ligament-9689@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 27e718ac8b8194d13eee5738c4d3fd247736186e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061905-december-ligament-9689@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

27e718ac8b81 ("drm/amd/display: fix disable otg wa logic in DCN316")
72002056f771 ("drm/amd/display: Display distortion after hotplug 5K tiled display")
d5c6909e7460 ("drm/amd/display: Add DCN314 clock manager")
8a077d9caa3a ("drm/amd/display: disable otg toggle w/a on boot")
66a197203794 ("drm/amd/display: Check zero planes for OTG disable W/A on clock change")
f94903996140 ("drm/amd/display: Add DCN315 CLK_MGR")
c477eaa6a79d ("drm/amd/display: Add DCN316 resource and SMU clock manager")
5f0c74915815 ("drm/amd/display: Fix for otg synchronization logic")
59d41458f143 ("Merge tag 'drm-next-2022-01-14' of git://anongit.freedesktop.org/drm/drm")

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


