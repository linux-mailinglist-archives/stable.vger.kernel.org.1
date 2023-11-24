Return-Path: <stable+bounces-273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219F7F761B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890B5B21417
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30512C871;
	Fri, 24 Nov 2023 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YXEukl+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E82C864
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC4FC433CD;
	Fri, 24 Nov 2023 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835323;
	bh=kmtwnCgJSL6D6qMfkKLAw7NIOnD9LrQ0p05yQiwtxAc=;
	h=Subject:To:Cc:From:Date:From;
	b=YXEukl+2DyLMEfCkMquO6oDz3ARuBHLxIWJMikPuQbEDMG38SdhlcWyUkZF7Uwm4B
	 i9iIidsKG/1GkrLs8ihaI6OIE7BkC8tZyzhsS70KBZqBaA8abJoIajWS0YhfG7gm/9
	 MFzz/sHFvsIYwdf4X5AXBzIAe/RrS1YTDZAc94z8=
Subject: FAILED: patch "[PATCH] drm/amd/display: update blank state on ODM changes" failed to apply to 6.5-stable tree
To: wenjing.liu@amd.com,alexander.deucher@amd.com,dillon.varone@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:15:13 +0000
Message-ID: <2023112412-lagoon-yonder-7f24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 15e6b396f5ac259126f2447fcd2279ed5d3dd14f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112412-lagoon-yonder-7f24@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

15e6b396f5ac ("drm/amd/display: update blank state on ODM changes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15e6b396f5ac259126f2447fcd2279ed5d3dd14f Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Mon, 14 Aug 2023 17:11:16 -0400
Subject: [PATCH] drm/amd/display: update blank state on ODM changes

When we are dynamically adding new ODM slices, we didn't update
blank state, if the pipe used by new ODM slice is previously blanked,
we will continue outputting blank pixel data on that slice causing
right half of the screen showing blank image.

The previous fix was a temporary hack to directly update current state
when committing new state. This could potentially cause hw and sw
state synchronization issues and it is not permitted by dc commit
design.

Cc: stable@vger.kernel.org
Fixes: 7fbf451e7639 ("drm/amd/display: Reinit DPG when exiting dynamic ODM")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index d3caba52d2fc..f3db16cd10db 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1106,29 +1106,6 @@ void dcn20_blank_pixel_data(
 			v_active,
 			offset);
 
-	if (!blank && dc->debug.enable_single_display_2to1_odm_policy) {
-		/* when exiting dynamic ODM need to reinit DPG state for unused pipes */
-		struct pipe_ctx *old_odm_pipe = dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx].next_odm_pipe;
-
-		odm_pipe = pipe_ctx->next_odm_pipe;
-
-		while (old_odm_pipe) {
-			if (!odm_pipe || old_odm_pipe->pipe_idx != odm_pipe->pipe_idx)
-				dc->hwss.set_disp_pattern_generator(dc,
-						old_odm_pipe,
-						CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
-						CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-						COLOR_DEPTH_888,
-						NULL,
-						0,
-						0,
-						0);
-			old_odm_pipe = old_odm_pipe->next_odm_pipe;
-			if (odm_pipe)
-				odm_pipe = odm_pipe->next_odm_pipe;
-		}
-	}
-
 	if (!blank)
 		if (stream_res->abm) {
 			dc->hwss.set_pipe(pipe_ctx);
@@ -1732,11 +1709,16 @@ static void dcn20_program_pipe(
 		struct dc_state *context)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-	/* Only need to unblank on top pipe */
 
-	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->stream->update_flags.bits.abm_level)
-			&& !pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe)
-		hws->funcs.blank_pixel_data(dc, pipe_ctx, !pipe_ctx->plane_state->visible);
+	/* Only need to unblank on top pipe */
+	if (resource_is_pipe_type(pipe_ctx, OTG_MASTER)) {
+		if (pipe_ctx->update_flags.bits.enable ||
+				pipe_ctx->update_flags.bits.odm ||
+				pipe_ctx->stream->update_flags.bits.abm_level)
+			hws->funcs.blank_pixel_data(dc, pipe_ctx,
+					!pipe_ctx->plane_state ||
+					!pipe_ctx->plane_state->visible);
+	}
 
 	/* Only update TG on top pipe */
 	if (pipe_ctx->update_flags.bits.global_sync && !pipe_ctx->top_pipe


