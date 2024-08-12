Return-Path: <stable+bounces-67196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5C594F44F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400B31C20C8B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C779187335;
	Mon, 12 Aug 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yIChP38c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B011134AC;
	Mon, 12 Aug 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480124; cv=none; b=nD6yzo0zwYrmB26RveL36bOu23ag/sftwi4PBh6ZmxhkUflVt7AtIAlOhpUZb6kKg2Wfjn0fumWs58YYFVqow1uUQqYwejIIXKro1l56+PFHaiBDa2Hnjzok6ABMK4IZPRQbDbGj1OcGGoktCqpczvZpKGn/1r6EO+5ukkYQRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480124; c=relaxed/simple;
	bh=i/Wmf3lLuEZeJkcI/9bVi1hje8zA02m/hMhS3v9m9i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDVbKg7MN00B8YEemfJlpW/wrErhAnuJcUzBQdxC4pSMz+u9xaXvGu1ygvEVbShJfHasSeJZxN3wB8oSx25AM7u8yqblFgnJTMdVRAt26WqzwWM9/Vfl4rMmILn9GRvPW/RIfVcAzhahP4kmUpEj4LjvwfxGjrheAVpr+5q5IO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yIChP38c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E014C32782;
	Mon, 12 Aug 2024 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480123;
	bh=i/Wmf3lLuEZeJkcI/9bVi1hje8zA02m/hMhS3v9m9i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yIChP38c5NcIIaNMykuhYDZJu3bNYyxIfF+C6EhZn34Y42lNRFvghk0wEE8Z8eJpD
	 LARGfRiiS1DUZfuxKW8c5MsRkDGWplxAGuHhwv9dCzzPTzo44b/8snDEHeyEN/HBva
	 hZzm3LEQi+qHNyPhHOkCnArfh+6piCUCTnB7H3sw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dillon Varone <dillon.varone@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 103/263] drm/amd/display: reduce ODM slice count to initial new dc state only when needed
Date: Mon, 12 Aug 2024 18:01:44 +0200
Message-ID: <20240812160150.486973818@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjing Liu <wenjing.liu@amd.com>

[ Upstream commit 9a29c4adb0997be6ba3dd92dfba14ea75a8c6ce4 ]

[why]
We need to decrease ODM slice when adding or removing planes because MPO
support takes precedence over dynamic ODM combine. However there is a case where
we remove ODM combine even for ODM combine required timing in the initial new
dc state. This is normally okay because ODM will be added back after we pass DML
bandwidth validation. However since we remove ODM combine in the initial new
state, the previous ODM pipe allocation is lost. This may cause the new plane to
take away the original secondary OPP head pipe that is still required in the new
state.

For a timing that requires ODM 2:1 but optimized with ODM 4:1, if we add an MPO
plane, we will not have enough pipe to preserve ODM 4:1. In this case we should
reduce ODM slice count then try to add the MPO plane again. By reducing, we are
gradually remove 1 ODM slice from right most side one at a time until we have
enough free pipes for the new plane. If we remove ODM combine entirely, we could
use the pipe at ODM slice index 1 as a DPP pipe for the new plane. But ODM slice
1 is still needed as the timing requires ODM 2:1. This transition is not
seamless and user will see corruption on the screen.

[how]
Remove single ODM slice one at time until we have enough pipes for a new plane.
Remove previous logic to always remove ODM combine entirely.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 45 +++++++------
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 67 +++++++++++++------
 2 files changed, 71 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 15819416a2f36..a2ca66a268c2d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2508,6 +2508,17 @@ static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
 	}
 }
 
+static int get_num_of_free_pipes(const struct resource_pool *pool, const struct dc_state *context)
+{
+	int i;
+	int count = 0;
+
+	for (i = 0; i < pool->pipe_count; i++)
+		if (resource_is_pipe_type(&context->res_ctx.pipe_ctx[i], FREE_PIPE))
+			count++;
+	return count;
+}
+
 enum dc_status resource_add_otg_master_for_stream_output(struct dc_state *new_ctx,
 		const struct resource_pool *pool,
 		struct dc_stream_state *stream)
@@ -2641,37 +2652,33 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 		struct dc_state *cur_ctx,
 		struct resource_pool *pool)
 {
-	struct pipe_ctx *opp_head_pipe, *sec_pipe, *tail_pipe;
+	struct pipe_ctx *sec_pipe, *tail_pipe;
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	int opp_head_count;
+	int i;
 
 	if (!pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe) {
 		ASSERT(0);
 		return false;
 	}
 
-	opp_head_pipe = otg_master_pipe;
-	while (opp_head_pipe) {
+	opp_head_count = resource_get_opp_heads_for_otg_master(otg_master_pipe,
+			&new_ctx->res_ctx, opp_heads);
+	if (get_num_of_free_pipes(pool, new_ctx) < opp_head_count)
+		/* not enough free pipes */
+		return false;
+
+	for (i = 0; i < opp_head_count; i++) {
 		sec_pipe = pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe(
 				cur_ctx,
 				new_ctx,
 				pool,
-				opp_head_pipe);
-		if (!sec_pipe) {
-			/* try tearing down MPCC combine */
-			int pipe_idx = acquire_first_split_pipe(
-					&new_ctx->res_ctx, pool,
-					otg_master_pipe->stream);
-
-			if (pipe_idx >= 0)
-				sec_pipe = &new_ctx->res_ctx.pipe_ctx[pipe_idx];
-		}
-
-		if (!sec_pipe)
-			return false;
-
+				opp_heads[i]);
+		ASSERT(sec_pipe);
 		sec_pipe->plane_state = plane_state;
 
 		/* establish pipe relationship */
-		tail_pipe = get_tail_pipe(opp_head_pipe);
+		tail_pipe = get_tail_pipe(opp_heads[i]);
 		tail_pipe->bottom_pipe = sec_pipe;
 		sec_pipe->top_pipe = tail_pipe;
 		sec_pipe->bottom_pipe = NULL;
@@ -2682,8 +2689,6 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 		} else {
 			sec_pipe->prev_odm_pipe = NULL;
 		}
-
-		opp_head_pipe = opp_head_pipe->next_odm_pipe;
 	}
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 76bb05f4d6bf3..52a1cfc5feed8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -437,6 +437,19 @@ enum dc_status dc_state_remove_stream(
 	return DC_OK;
 }
 
+static void remove_mpc_combine_for_stream(const struct dc *dc,
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		struct dc_stream_status *status)
+{
+	int i;
+
+	for (i = 0; i < status->plane_count; i++)
+		resource_update_pipes_for_plane_with_slice_count(
+				new_ctx, cur_ctx, dc->res_pool,
+				status->plane_states[i], 1);
+}
+
 bool dc_state_add_plane(
 		const struct dc *dc,
 		struct dc_stream_state *stream,
@@ -447,8 +460,12 @@ bool dc_state_add_plane(
 	struct pipe_ctx *otg_master_pipe;
 	struct dc_stream_status *stream_status = NULL;
 	bool added = false;
+	int odm_slice_count;
+	int i;
 
 	stream_status = dc_state_get_stream_status(state, stream);
+	otg_master_pipe = resource_get_otg_master_for_stream(
+			&state->res_ctx, stream);
 	if (stream_status == NULL) {
 		dm_error("Existing stream not found; failed to attach surface!\n");
 		goto out;
@@ -456,22 +473,39 @@ bool dc_state_add_plane(
 		dm_error("Surface: can not attach plane_state %p! Maximum is: %d\n",
 				plane_state, MAX_SURFACE_NUM);
 		goto out;
+	} else if (!otg_master_pipe) {
+		goto out;
 	}
 
-	if (stream_status->plane_count == 0 && dc->config.enable_windowed_mpo_odm)
-		/* ODM combine could prevent us from supporting more planes
-		 * we will reset ODM slice count back to 1 when all planes have
-		 * been removed to maximize the amount of planes supported when
-		 * new planes are added.
-		 */
-		resource_update_pipes_for_stream_with_slice_count(
-				state, dc->current_state, dc->res_pool, stream, 1);
+	added = resource_append_dpp_pipes_for_plane_composition(state,
+			dc->current_state, pool, otg_master_pipe, plane_state);
 
-	otg_master_pipe = resource_get_otg_master_for_stream(
-			&state->res_ctx, stream);
-	if (otg_master_pipe)
+	if (!added) {
+		/* try to remove MPC combine to free up pipes */
+		for (i = 0; i < state->stream_count; i++)
+			remove_mpc_combine_for_stream(dc, state,
+					dc->current_state,
+					&state->stream_status[i]);
 		added = resource_append_dpp_pipes_for_plane_composition(state,
-				dc->current_state, pool, otg_master_pipe, plane_state);
+					dc->current_state, pool,
+					otg_master_pipe, plane_state);
+	}
+
+	if (!added) {
+		/* try to decrease ODM slice count gradually to free up pipes */
+		odm_slice_count = resource_get_odm_slice_count(otg_master_pipe);
+		for (i = odm_slice_count - 1; i > 0; i--) {
+			resource_update_pipes_for_stream_with_slice_count(state,
+					dc->current_state, dc->res_pool, stream,
+					i);
+			added = resource_append_dpp_pipes_for_plane_composition(
+					state,
+					dc->current_state, pool,
+					otg_master_pipe, plane_state);
+			if (added)
+				break;
+		}
+	}
 
 	if (added) {
 		stream_status->plane_states[stream_status->plane_count] =
@@ -531,15 +565,6 @@ bool dc_state_remove_plane(
 
 	stream_status->plane_states[stream_status->plane_count] = NULL;
 
-	if (stream_status->plane_count == 0 && dc->config.enable_windowed_mpo_odm)
-		/* ODM combine could prevent us from supporting more planes
-		 * we will reset ODM slice count back to 1 when all planes have
-		 * been removed to maximize the amount of planes supported when
-		 * new planes are added.
-		 */
-		resource_update_pipes_for_stream_with_slice_count(
-				state, dc->current_state, dc->res_pool, stream, 1);
-
 	return true;
 }
 
-- 
2.43.0




