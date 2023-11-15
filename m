Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD67ECADF
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 19:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjKOS7z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 13:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKOS7y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 13:59:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA19FA
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 10:59:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C97C433C9;
        Wed, 15 Nov 2023 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700074790;
        bh=y5kvFIXLmZ6QEUM4h8ojPkIzSIBaxAbjBDPs2sNBAzI=;
        h=Subject:To:Cc:From:Date:From;
        b=O9U08xR8K9rDNKcTXniUQ6cy/A8ZEsdMmBpbhZaP3E4KNjRWGxHMf0BUFO8yY5Oyq
         KTMrRjDlTrVbdTM+t9XDuX3XrPNJq7JDHtnTXDqtQavhSH2jsxlzngbtdTaf+MHcHh
         p7fWnXEigEom8qSKv5NPvnsmAR6Ha6upD216fN90=
Subject: FAILED: patch "[PATCH] Revert "drm/amd/display: Remove v_startup workaround for" failed to apply to 6.5-stable tree
To:     hamza.mahfooz@amd.com, alexander.deucher@amd.com,
        harry.wentland@amd.com, jerry.zuo@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 15 Nov 2023 13:59:46 -0500
Message-ID: <2023111546-lankiness-ruckus-6ae3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
git cherry-pick -x 63461ea3fb403be0d040be3c88e621b55672e26a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023111546-lankiness-ruckus-6ae3@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

63461ea3fb40 ("Revert "drm/amd/display: Remove v_startup workaround for dcn3+"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63461ea3fb403be0d040be3c88e621b55672e26a Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Thu, 31 Aug 2023 15:17:14 -0400
Subject: [PATCH] Revert "drm/amd/display: Remove v_startup workaround for
 dcn3+"

This reverts commit 3a31e8b89b7240d9a17ace8a1ed050bdcb560f9e.

We still need to call dcn20_adjust_freesync_v_startup() for older DCN3+
ASICs. Otherwise, it can cause DP to HDMI 2.1 PCONs to fail to light up.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2809
Reviewed-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 0989a0152ae8..1bfdf0271fdf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1099,6 +1099,10 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
 						pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
+		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
+			dcn20_adjust_freesync_v_startup(
+				&context->res_ctx.pipe_ctx[i].stream->timing,
+				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
 
 		pipe_idx++;
 	}
@@ -1927,7 +1931,6 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
-	int i = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -1951,15 +1954,6 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	dcn20_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
-			dcn20_adjust_freesync_v_startup(
-				&context->res_ctx.pipe_ctx[i].stream->timing,
-				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
-	}
-
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
@@ -2232,7 +2226,6 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
-	int i = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -2261,15 +2254,6 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	dcn21_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
-			dcn20_adjust_freesync_v_startup(
-				&context->res_ctx.pipe_ctx[i].stream->timing,
-				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
-	}
-
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;

