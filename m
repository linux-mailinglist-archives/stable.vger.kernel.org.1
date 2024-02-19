Return-Path: <stable+bounces-20645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4934A85AAC0
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F409E282B0A
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA2481A6;
	Mon, 19 Feb 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2BvrKhqF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885547F79
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366689; cv=none; b=kqhP6y6kX1LXvoMjCTaiOSJVwIc4tVnA9kEJEnmYfj8vRNxgHH0xQD8yklTBslxrtyGOdLZ10NeA8K0jZVZFuZY1hexqEiaV6RqhL/9FNi4Kdq8Z+Jv0bnyXDDf5xyr++HsC9sAbN2LGwS+fGelaN2qLQAgPm35rMJDOGd8tJ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366689; c=relaxed/simple;
	bh=i2JRvN8oJPXtLnFtuFg72DDOyMrVIMryPeNg1yWe4VE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gqTGXUPe/TvMEY9WekHgpxD1JBavhX1fWw05xAAV4rSD86Gm7UVC0lGVSWNy8o5x09TLqAP4srn6aNYutwEyzZuFlZoUTSW0ZWGgIofy10wi6U7VKUhcWKeUtyE6PPMR9F8E70mK9wEb869vbCiCsVxrJWEBe4nDaY7WqH5RzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2BvrKhqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C84C433C7;
	Mon, 19 Feb 2024 18:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366688;
	bh=i2JRvN8oJPXtLnFtuFg72DDOyMrVIMryPeNg1yWe4VE=;
	h=Subject:To:Cc:From:Date:From;
	b=2BvrKhqFfvGzaOa0kddTWDS5RFT4t5abRp6fwtgYaueliJWbdw0DLyKuRYGDhBlQb
	 sVLM3VObMFSVRDTs3LBRWLITc/7R3gdkKJGMXlOlU38EdSJewqHd1vOOgkCdNBjbI3
	 94fK0w4kMQ3MFbJp1S5M8faTW6Att7NRS1oo/UvE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Update phantom pipe enable / disable" failed to apply to 6.6-stable tree
To: alvin.lee2@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,samson.tam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:17:58 +0100
Message-ID: <2024021958-alabaster-zipping-c367@gregkh>
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
git cherry-pick -x ca8179ba11f211cdcb6c12ddd83814eaec999738
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021958-alabaster-zipping-c367@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

ca8179ba11f2 ("drm/amd/display: Update phantom pipe enable / disable sequence")
09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")
abd26a3252cb ("drm/amd/display: Add dml2 copy functions")
ed6e2782e974 ("drm/amd/display: For cursor P-State allow for SubVP")
f583db812bc9 ("drm/amd/display: Update FAMS sequence for DCN30 & DCN32")
ddd5298c63e4 ("drm/amd/display: Update cursor limits based on SW cursor fallback limits")
7966f319c66d ("drm/amd/display: Introduce DML2")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
13c0e836316a ("drm/amd/display: Adjust code style for hw_sequencer.h")
1288d7020809 ("drm/amd/display: Improve x86 and dmub ips handshake")
ad3b63a0d298 ("drm/amd/display: add new windowed mpo odm minimal transition sequence")
177ea58bef72 ("drm/amd/display: reset stream slice count for new ODM policy")
c0f8b83188c7 ("drm/amd/display: disable IPS")
93a66cef607c ("drm/amd/display: Add IPS control flag")
dc01c4b79bfe ("drm/amd/display: Update driver and IPS interop")
83b5b7bb8673 ("drm/amd/display: minior logging improvements")
15c6798ae26d ("drm/amd/display: add seamless pipe topology transition check")
c06ef68a7946 ("drm/amd/display: Add check for vrr_active_fixed")
c51d87202d1f ("drm/amd/display: do not attempt ODM power optimization if minimal transition doesn't exist")
a4246c635166 ("drm/amd/display: fix the white screen issue when >= 64GB DRAM")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca8179ba11f211cdcb6c12ddd83814eaec999738 Mon Sep 17 00:00:00 2001
From: Alvin Lee <alvin.lee2@amd.com>
Date: Fri, 26 Jan 2024 16:47:20 -0500
Subject: [PATCH] drm/amd/display: Update phantom pipe enable / disable
 sequence

Previously we would call apply_ctx_to_hw to enable and disable
phantom pipes. However, apply_ctx_to_hw can potentially update
non-phantom pipes as well which is undesired. Instead of calling
apply_ctx_to_hw as a whole, call the relevant helpers for each
phantom pipe when enabling / disabling which will avoid us modifying
hardware state for non-phantom pipes unknowingly.

The use case is for an FRL display where FRL_Update is requested
by the display. In this case link_state_valid flag is cleared in
a passive callback thread and should be handled in the next stream /
link update. However, due to the call to apply_ctx_to_hw for the
phantom pipes during a flip, the main pipes were modified outside
of the desired sequence (driver does not handle link_state_valid = 0
on flips).

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index aa7c02ba948e..2c424e435962 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3817,7 +3817,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		 * programming has completed (we turn on phantom OTG in order
 		 * to complete the plane disable for phantom pipes).
 		 */
-		dc->hwss.apply_ctx_to_hw(dc, context);
+
+		if (dc->hwss.disable_phantom_streams)
+			dc->hwss.disable_phantom_streams(dc, context);
 	}
 
 	if (update_type != UPDATE_TYPE_FAST)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 2352428bcea3..01493c49bd7a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1476,7 +1476,7 @@ static enum dc_status dce110_enable_stream_timing(
 	return DC_OK;
 }
 
-static enum dc_status apply_single_controller_ctx_to_hw(
+enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context,
 		struct dc *dc)
@@ -2302,7 +2302,7 @@ enum dc_status dce110_apply_ctx_to_hw(
 		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe)
 			continue;
 
-		status = apply_single_controller_ctx_to_hw(
+		status = dce110_apply_single_controller_ctx_to_hw(
 				pipe_ctx,
 				context,
 				dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
index 08028a1779ae..ed3cc3648e8e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
@@ -39,6 +39,10 @@ enum dc_status dce110_apply_ctx_to_hw(
 		struct dc *dc,
 		struct dc_state *context);
 
+enum dc_status dce110_apply_single_controller_ctx_to_hw(
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context,
+		struct dc *dc);
 
 void dce110_enable_stream(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 4853ecac53f9..931ac8ed7069 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2561,7 +2561,7 @@ void dcn20_setup_vupdate_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		tg->funcs->setup_vertical_interrupt2(tg, start_line);
 }
 
-static void dcn20_reset_back_end_for_pipe(
+void dcn20_reset_back_end_for_pipe(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
index b94c85340abf..d950b3e54ec2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
@@ -84,6 +84,10 @@ enum dc_status dcn20_enable_stream_timing(
 void dcn20_disable_stream_gating(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn20_enable_stream_gating(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn20_setup_vupdate_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx);
+void dcn20_reset_back_end_for_pipe(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context);
 void dcn20_init_blank(
 		struct dc *dc,
 		struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 6c9299c7683d..aa36d7a56ca8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1474,9 +1474,44 @@ void dcn32_update_dsc_pg(struct dc *dc,
 	}
 }
 
+void dcn32_disable_phantom_streams(struct dc *dc, struct dc_state *context)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	int i;
+
+	for (i = dc->res_pool->pipe_count - 1; i >= 0 ; i--) {
+		struct pipe_ctx *pipe_ctx_old =
+			&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx_old->stream)
+			continue;
+
+		if (dc_state_get_pipe_subvp_type(dc->current_state, pipe_ctx_old) != SUBVP_PHANTOM)
+			continue;
+
+		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
+			continue;
+
+		if (!pipe_ctx->stream || pipe_need_reprogram(pipe_ctx_old, pipe_ctx) ||
+				(pipe_ctx->stream && dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM)) {
+			struct clock_source *old_clk = pipe_ctx_old->clock_source;
+
+			if (hws->funcs.reset_back_end_for_pipe)
+				hws->funcs.reset_back_end_for_pipe(dc, pipe_ctx_old, dc->current_state);
+			if (hws->funcs.enable_stream_gating)
+				hws->funcs.enable_stream_gating(dc, pipe_ctx_old);
+			if (old_clk)
+				old_clk->funcs->cs_power_down(old_clk);
+		}
+	}
+}
+
 void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context)
 {
 	unsigned int i;
+	enum dc_status status = DC_OK;
+	struct dce_hwseq *hws = dc->hwseq;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -1497,16 +1532,39 @@ void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context)
 		}
 	}
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx_old =
+					&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
-		if (new_pipe->stream && dc_state_get_pipe_subvp_type(context, new_pipe) == SUBVP_PHANTOM) {
-			// If old context or new context has phantom pipes, apply
-			// the phantom timings now. We can't change the phantom
-			// pipe configuration safely without driver acquiring
-			// the DMCUB lock first.
-			dc->hwss.apply_ctx_to_hw(dc, context);
-			break;
+		if (pipe_ctx->stream == NULL)
+			continue;
+
+		if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM)
+			continue;
+
+		if (pipe_ctx->stream == pipe_ctx_old->stream &&
+			pipe_ctx->stream->link->link_state_valid) {
+			continue;
 		}
+
+		if (pipe_ctx_old->stream && !pipe_need_reprogram(pipe_ctx_old, pipe_ctx))
+			continue;
+
+		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe)
+			continue;
+
+		if (hws->funcs.apply_single_controller_ctx_to_hw)
+			status = hws->funcs.apply_single_controller_ctx_to_hw(
+					pipe_ctx,
+					context,
+					dc);
+
+		ASSERT(status == DC_OK);
+
+#ifdef CONFIG_DRM_AMD_DC_FP
+		if (hws->funcs.resync_fifo_dccg_dio)
+			hws->funcs.resync_fifo_dccg_dio(hws, dc, context);
+#endif
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index cecf7f0f5671..069e20bc87c0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -111,6 +111,8 @@ void dcn32_update_dsc_pg(struct dc *dc,
 
 void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context);
 
+void dcn32_disable_phantom_streams(struct dc *dc, struct dc_state *context);
+
 void dcn32_init_blank(
 		struct dc *dc,
 		struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 427cfc8c24a4..e8ac94a005b8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -109,6 +109,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.commit_subvp_config = dcn32_commit_subvp_config,
 	.enable_phantom_streams = dcn32_enable_phantom_streams,
+	.disable_phantom_streams = dcn32_disable_phantom_streams,
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.subvp_pipe_control_lock_fast = dcn32_subvp_pipe_control_lock_fast,
@@ -159,6 +160,8 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn32_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
+	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
 };
 
 void dcn32_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index a54399383318..64ca7c66509b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -379,6 +379,7 @@ struct hw_sequencer_funcs {
 			struct dc_cursor_attributes *cursor_attr);
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
+	void (*disable_phantom_streams)(struct dc *dc, struct dc_state *context);
 	void (*subvp_pipe_control_lock)(struct dc *dc,
 			struct dc_state *context,
 			bool lock,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 6137cf09aa54..b3c62a82cb1c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -165,8 +165,15 @@ struct hwseq_private_funcs {
 	void (*set_pixels_per_cycle)(struct pipe_ctx *pipe_ctx);
 	void (*resync_fifo_dccg_dio)(struct dce_hwseq *hws, struct dc *dc,
 			struct dc_state *context);
+	enum dc_status (*apply_single_controller_ctx_to_hw)(
+			struct pipe_ctx *pipe_ctx,
+			struct dc_state *context,
+			struct dc *dc);
 	bool (*is_dp_dig_pixel_rate_div_policy)(struct pipe_ctx *pipe_ctx);
 #endif
+	void (*reset_back_end_for_pipe)(struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			struct dc_state *context);
 };
 
 struct dce_hwseq {


