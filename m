Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54487A3B79
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbjIQUSN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbjIQUSA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:18:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A5A137
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:17:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B02C433C7;
        Sun, 17 Sep 2023 20:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981872;
        bh=xvfI+eUOuRPJT8MJpoF94F7Wbo/9GCEio1Hd9nQXWKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0POz85UZxLT4srUbleYXuEFaJRbS+3z6QP1ymiurqwzZOGCU266Qv9v70pYjjX5a
         WLmMNAq63eFdHsy54r4ueI+f8ylnwTzwyjgAiqqF7sqeE9ipY1yXv/E9yFCaIMwMA4
         UjtIhwS1HFAp4YAZwhcnoW9McVpFldtiqb2/17B8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jun Lei <jun.lei@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 183/219] drm/amd/display: Remove wait while locked
Date:   Sun, 17 Sep 2023 21:15:10 +0200
Message-ID: <20230917191047.564563937@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabe Teeger <gabe.teeger@amd.com>

commit 5a3ccb1400339268c5e3dc1fa044a7f6c7f59a02 upstream.

[Why]
We wait for mpc idle while in a locked state, leading to potential
deadlock.

[What]
Move the wait_for_idle call to outside of HW lock. This and a
call to wait_drr_doublebuffer_pending_clear are moved added to a new
static helper function called wait_for_outstanding_hw_updates, to make
the interface clearer.

Cc: stable@vger.kernel.org
Fixes: 8f0d304d21b3 ("drm/amd/display: Do not commit pipe when updating DRR")
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/Makefile            |    1 
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   58 ++++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   11 ---
 3 files changed, 42 insertions(+), 28 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -82,3 +82,4 @@ DC_EDID += dc_edid_parser.o
 AMD_DISPLAY_DMUB = $(addprefix $(AMDDALPATH)/dc/,$(DC_DMUB))
 AMD_DISPLAY_EDID = $(addprefix $(AMDDALPATH)/dc/,$(DC_EDID))
 AMD_DISPLAY_FILES += $(AMD_DISPLAY_DMUB) $(AMD_DISPLAY_EDID)
+
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3361,6 +3361,45 @@ void dc_dmub_update_dirty_rect(struct dc
 	}
 }
 
+static void wait_for_outstanding_hw_updates(struct dc *dc, const struct dc_state *dc_context)
+{
+/*
+ * This function calls HWSS to wait for any potentially double buffered
+ * operations to complete. It should be invoked as a pre-amble prior
+ * to full update programming before asserting any HW locks.
+ */
+	int pipe_idx;
+	int opp_inst;
+	int opp_count = dc->res_pool->pipe_count;
+	struct hubp *hubp;
+	int mpcc_inst;
+	const struct pipe_ctx *pipe_ctx;
+
+	for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+		pipe_ctx = &dc_context->res_ctx.pipe_ctx[pipe_idx];
+
+		if (!pipe_ctx->stream)
+			continue;
+
+		if (pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear)
+			pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear(pipe_ctx->stream_res.tg);
+
+		hubp = pipe_ctx->plane_res.hubp;
+		if (!hubp)
+			continue;
+
+		mpcc_inst = hubp->inst;
+		// MPCC inst is equal to pipe index in practice
+		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
+			if (dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst]) {
+				dc->res_pool->mpc->funcs->wait_for_idle(dc->res_pool->mpc, mpcc_inst);
+				dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst] = false;
+				break;
+			}
+		}
+	}
+}
+
 static void commit_planes_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
@@ -3378,24 +3417,9 @@ static void commit_planes_for_stream(str
 	// dc->current_state anymore, so we have to cache it before we apply
 	// the new SubVP context
 	subvp_prev_use = false;
-
-
 	dc_z10_restore(dc);
-
-	if (update_type == UPDATE_TYPE_FULL) {
-		/* wait for all double-buffer activity to clear on all pipes */
-		int pipe_idx;
-
-		for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[pipe_idx];
-
-			if (!pipe_ctx->stream)
-				continue;
-
-			if (pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear)
-				pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear(pipe_ctx->stream_res.tg);
-		}
-	}
+	if (update_type == UPDATE_TYPE_FULL)
+		wait_for_outstanding_hw_updates(dc, context);
 
 	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
 		/* Optimize seamless boot flag keeps clocks and watermarks high until
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1515,17 +1515,6 @@ static void dcn20_update_dchubp_dpp(
 			|| plane_state->update_flags.bits.global_alpha_change
 			|| plane_state->update_flags.bits.per_pixel_alpha_change) {
 		// MPCC inst is equal to pipe index in practice
-		int mpcc_inst = hubp->inst;
-		int opp_inst;
-		int opp_count = dc->res_pool->pipe_count;
-
-		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
-			if (dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst]) {
-				dc->res_pool->mpc->funcs->wait_for_idle(dc->res_pool->mpc, mpcc_inst);
-				dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst] = false;
-				break;
-			}
-		}
 		hws->funcs.update_mpcc(dc, pipe_ctx);
 	}
 


