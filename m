Return-Path: <stable+bounces-249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD27F75C0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C52A1C21050
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5E28E2C;
	Fri, 24 Nov 2023 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZfG6aiFk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA72C1AE
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFABC433C9;
	Fri, 24 Nov 2023 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834097;
	bh=Kw5JfWsEh6nxrTi3KMgYkots+luuGDmA5gmtAW/WNgI=;
	h=Subject:To:Cc:From:Date:From;
	b=ZfG6aiFk7Cn/RcM1RAPaF/8TNZoRfqIgnGIsMTr7OyhrOiq1S+rNEgxv5gO2MzXNb
	 AjsMLKTgdO1P86tltbyN5o3IO1XhV00pL95Lby3iskE3U+0N8CAHmw9bEFiO2NCR7D
	 szgydcIk3zxEqdBSILQlEgffoT9KBuYF7SEjiWoo=
Subject: FAILED: patch "[PATCH] drm/amd/display: Remove wait while locked" failed to apply to 6.5-stable tree
To: gabe.teeger@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,jun.lei@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:54:45 +0000
Message-ID: <2023112444-ribbon-phobia-e4f6@gregkh>
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
git cherry-pick -x d12f00c91fdfe3e50747f9e7e229fd8ede16b632
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112444-ribbon-phobia-e4f6@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

d12f00c91fdf ("drm/amd/display: Remove wait while locked")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d12f00c91fdfe3e50747f9e7e229fd8ede16b632 Mon Sep 17 00:00:00 2001
From: Gabe Teeger <gabe.teeger@amd.com>
Date: Mon, 14 Aug 2023 16:06:18 -0400
Subject: [PATCH] drm/amd/display: Remove wait while locked

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

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 69ffd4424dc7..1b8c2aef4633 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -78,3 +78,4 @@ DC_EDID += dc_edid_parser.o
 AMD_DISPLAY_DMUB = $(addprefix $(AMDDALPATH)/dc/,$(DC_DMUB))
 AMD_DISPLAY_EDID = $(addprefix $(AMDDALPATH)/dc/,$(DC_EDID))
 AMD_DISPLAY_FILES += $(AMD_DISPLAY_DMUB) $(AMD_DISPLAY_EDID)
+
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 025e0fdf486d..c8f301aabcf8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3501,6 +3501,45 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		top_pipe_to_program->stream->update_flags.raw = 0;
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
@@ -3519,24 +3558,9 @@ static void commit_planes_for_stream(struct dc *dc,
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
 
 	if (update_type == UPDATE_TYPE_FULL) {
 		dc_allow_idle_optimizations(dc, false);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index dd4c7a7faf28..971fa8bf6d1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1563,17 +1563,6 @@ static void dcn20_update_dchubp_dpp(
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
 


