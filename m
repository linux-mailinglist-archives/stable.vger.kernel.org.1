Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29197A33F5
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 08:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjIQGOG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 02:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIQGNe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 02:13:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58033186
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 23:13:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A21C433C8;
        Sun, 17 Sep 2023 06:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694931209;
        bh=chNoW4m28EH8mTzaTSWa+dJx15Ur+dGzSLMbeMeuBEk=;
        h=Subject:To:Cc:From:Date:From;
        b=Fmm62p46meM1I8pvwKQyqmLtqKP8RrbxuisCI/auUbZk9xoD/B3/Y1jnhMAtduwdO
         nhvqcgm+uBGWRjeGczcGPnlrxATBDWdQSod7fjfpAkqLh6ifY/1hBd6ec6ZFJuh1tB
         Od90aydZXsbiR8fPqEM7MC+zcjHvpZs/6aHxMP9I=
Subject: FAILED: patch "[PATCH] drm/amd/display: update blank state on ODM changes" failed to apply to 6.5-stable tree
To:     wenjing.liu@amd.com, alexander.deucher@amd.com,
        dillon.varone@amd.com, hamza.mahfooz@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 17 Sep 2023 08:13:26 +0200
Message-ID: <2023091726-surrender-surviving-7052@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 1482650bc7ef01ebb24ec2c3a2e4d50e45da4d8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091726-surrender-surviving-7052@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

1482650bc7ef ("drm/amd/display: update blank state on ODM changes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1482650bc7ef01ebb24ec2c3a2e4d50e45da4d8c Mon Sep 17 00:00:00 2001
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
index 65fa9e21ad9c..87c1ac40240b 100644
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
@@ -1722,11 +1699,16 @@ static void dcn20_program_pipe(
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

