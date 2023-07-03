Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CD746303
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGCS4y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjGCS4q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C3E71
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FEA460F24
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A569AC433C9;
        Mon,  3 Jul 2023 18:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410604;
        bh=iCaroraDxRykNmS3uPIdwW/nyWD72wqSmwB94HNSslE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfTmY9HO1ycrgGi+XW9moi3O/ZBfaYB2JaDvMIn5lEuh5p5eYOd3qdzDAa18LNRtG
         nbY8pncOI2azStsOYlQCcmyRRwICRcLg+D+3FVZtl56ft4lgJQrI5NiaqAq8ZyFiLP
         eGtSgERifx/Cc1qB+sK5286ui+BkFoY4WOqpOQk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aric Cyr <aric.cyr@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 03/11] drm/amd/display: Do not update DRR while BW optimizations pending
Date:   Mon,  3 Jul 2023 20:54:22 +0200
Message-ID: <20230703184519.217176801@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.121965745@linuxfoundation.org>
References: <20230703184519.121965745@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aric Cyr <aric.cyr@amd.com>

commit 32953485c558cecf08f33fbfa251e80e44cef981 upstream.

[why]
While bandwidth optimizations are pending, it's possible a pstate change
will occur.  During this time, VSYNC handler should not also try to update
DRR parameters causing pstate hang

[how]
Do not adjust DRR if optimize bandwidth is set.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c |   48 ++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 19 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -401,6 +401,13 @@ bool dc_stream_adjust_vmin_vmax(struct d
 {
 	int i;
 
+	/*
+	 * Don't adjust DRR while there's bandwidth optimizations pending to
+	 * avoid conflicting with firmware updates.
+	 */
+	if (dc->optimized_required || dc->wm_optimized_required)
+		return false;
+
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
@@ -2021,27 +2028,33 @@ void dc_post_update_surfaces_to_stream(s
 
 	post_surface_trace(dc);
 
-	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
-		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
-	else
+	/*
+	 * Only relevant for DCN behavior where we can guarantee the optimization
+	 * is safe to apply - retain the legacy behavior for DCE.
+	 */
+
+	if (dc->ctx->dce_version < DCE_VERSION_MAX)
 		TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
+	else {
+		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
 
-	if (is_flip_pending_in_pipes(dc, context))
-		return;
+		if (is_flip_pending_in_pipes(dc, context))
+			return;
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (context->res_ctx.pipe_ctx[i].stream == NULL ||
-		    context->res_ctx.pipe_ctx[i].plane_state == NULL) {
-			context->res_ctx.pipe_ctx[i].pipe_idx = i;
-			dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
-		}
+		for (i = 0; i < dc->res_pool->pipe_count; i++)
+			if (context->res_ctx.pipe_ctx[i].stream == NULL ||
+					context->res_ctx.pipe_ctx[i].plane_state == NULL) {
+				context->res_ctx.pipe_ctx[i].pipe_idx = i;
+				dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
+			}
 
-	process_deferred_updates(dc);
+		process_deferred_updates(dc);
 
-	dc->hwss.optimize_bandwidth(dc, context);
+		dc->hwss.optimize_bandwidth(dc, context);
 
-	if (dc->debug.enable_double_buffered_dsc_pg_support)
-		dc->hwss.update_dsc_pg(dc, context, true);
+		if (dc->debug.enable_double_buffered_dsc_pg_support)
+			dc->hwss.update_dsc_pg(dc, context, true);
+	}
 
 	dc->optimized_required = false;
 	dc->wm_optimized_required = false;
@@ -3866,12 +3879,9 @@ void dc_commit_updates_for_stream(struct
 			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
 				new_pipe->plane_state->force_full_update = true;
 		}
-	} else if (update_type == UPDATE_TYPE_FAST && dc_ctx->dce_version >= DCE_VERSION_MAX) {
+	} else if (update_type == UPDATE_TYPE_FAST) {
 		/*
 		 * Previous frame finished and HW is ready for optimization.
-		 *
-		 * Only relevant for DCN behavior where we can guarantee the optimization
-		 * is safe to apply - retain the legacy behavior for DCE.
 		 */
 		dc_post_update_surfaces_to_stream(dc);
 	}


