Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7C675BFA5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjGUHYt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGUHYs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5681715
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3562E61136
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C741C433C7;
        Fri, 21 Jul 2023 07:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924286;
        bh=qIA+ZEJWarj/KkSl4yHVKQXZRAnpTI1b0xEDWN7mO/Y=;
        h=Subject:To:Cc:From:Date:From;
        b=ohwT+s0AO7gnkRKjNrL7vewXz7dkxY1wueEDcXda/reYXzqNiB9Oo2w3ygzwi9KSH
         3SaccE9jX/LN17OiPsaoPAg3t8uU9RU92aYKYq51zX1JSlGNHZLuCH9HtCXBAtOGiR
         J0B5dzEGcxnc8ZsqsZwrbgbszrXSBvv41BYwXvQo=
Subject: FAILED: patch "[PATCH] drm/amd/display: add ODM case when looking for first split" failed to apply to 6.1-stable tree
To:     samson.tam@amd.com, Alvin.Lee2@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com,
        stylon.wang@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:24:39 +0200
Message-ID: <2023072139-passenger-economy-e0b6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 24e461e84f1c6d58fa1032f06d97e277dd0b4adf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072139-passenger-economy-e0b6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

24e461e84f1c ("drm/amd/display: add ODM case when looking for first split pipe")
e4c1b01bc35b ("drm/amd/display: Use min transition for all SubVP plane add/remove")
9e7d03e8b046 ("drm/amd/display: Use min transition for SubVP into MPO")
1e8fd864afdc ("drm/amd/display: skip commit minimal transition state")
f6ae69f49fcf ("drm/amd/display: Include surface of unaffected streams")
0e986cea0347 ("drm/amd/display: Copy DC context in the commit streams")
7b36f4d18e3e ("drm/amd/display: Enable new commit sequence only for DCN32x")
10fdb0a11c55 ("drm/amd/display: Rework context change check")
03ce7b387e8b ("drm/amd/display: Check if link state is valid")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24e461e84f1c6d58fa1032f06d97e277dd0b4adf Mon Sep 17 00:00:00 2001
From: Samson Tam <samson.tam@amd.com>
Date: Tue, 9 May 2023 16:40:19 -0400
Subject: [PATCH] drm/amd/display: add ODM case when looking for first split
 pipe

[Why]
When going from ODM 2:1 single display case to max displays, second
odm pipe needs to be repurposed for one of the new single displays.
However, acquire_first_split_pipe() only handles MPC case and not
ODM case

[How]
Add ODM conditions in acquire_first_split_pipe()
Add commit_minimal_transition_state() in commit_streams() to handle
odm 2:1 exit first, and then process new streams
Handle ODM condition in commit_minimal_transition_state()

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index af929ee11af5..0e9403f21dae 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2008,6 +2008,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
+static bool commit_minimal_transition_state(struct dc *dc,
+		struct dc_state *transition_base_context);
+
 /**
  * dc_commit_streams - Commit current stream state
  *
@@ -2029,6 +2032,8 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	struct dc_state *context;
 	enum dc_status res = DC_OK;
 	struct dc_validation_set set[MAX_STREAMS] = {0};
+	struct pipe_ctx *pipe;
+	bool handle_exit_odm2to1 = false;
 
 	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
 		return res;
@@ -2053,6 +2058,22 @@ enum dc_status dc_commit_streams(struct dc *dc,
 		}
 	}
 
+	/* Check for case where we are going from odm 2:1 to max
+	 *  pipe scenario.  For these cases, we will call
+	 *  commit_minimal_transition_state() to exit out of odm 2:1
+	 *  first before processing new streams
+	 */
+	if (stream_count == dc->res_pool->pipe_count) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe->next_odm_pipe)
+				handle_exit_odm2to1 = true;
+		}
+	}
+
+	if (handle_exit_odm2to1)
+		res = commit_minimal_transition_state(dc, dc->current_state);
+
 	context = dc_create_state(dc);
 	if (!context)
 		goto context_alloc_fail;
@@ -3912,6 +3933,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	unsigned int i, j;
 	unsigned int pipe_in_use = 0;
 	bool subvp_in_use = false;
+	bool odm_in_use = false;
 
 	if (!transition_context)
 		return false;
@@ -3940,6 +3962,18 @@ static bool commit_minimal_transition_state(struct dc *dc,
 		}
 	}
 
+	/* If ODM is enabled and we are adding or removing planes from any ODM
+	 * pipe, we must use the minimal transition.
+	 */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->next_odm_pipe) {
+			odm_in_use = true;
+			break;
+		}
+	}
+
 	/* When the OS add a new surface if we have been used all of pipes with odm combine
 	 * and mpc split feature, it need use commit_minimal_transition_state to transition safely.
 	 * After OS exit MPO, it will back to use odm and mpc split with all of pipes, we need
@@ -3948,7 +3982,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	 * Reduce the scenarios to use dc_commit_state_no_check in the stage of flip. Especially
 	 * enter/exit MPO when DCN still have enough resources.
 	 */
-	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use) {
+	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use && !odm_in_use) {
 		dc_release_state(transition_context);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7e1e5532f88f..c72540d37aef 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1445,6 +1445,26 @@ static int acquire_first_split_pipe(
 			split_pipe->plane_res.mpcc_inst = pool->dpps[i]->inst;
 			split_pipe->pipe_idx = i;
 
+			split_pipe->stream = stream;
+			return i;
+		} else if (split_pipe->prev_odm_pipe &&
+				split_pipe->prev_odm_pipe->plane_state == split_pipe->plane_state) {
+			split_pipe->prev_odm_pipe->next_odm_pipe = split_pipe->next_odm_pipe;
+			if (split_pipe->next_odm_pipe)
+				split_pipe->next_odm_pipe->prev_odm_pipe = split_pipe->prev_odm_pipe;
+
+			if (split_pipe->prev_odm_pipe->plane_state)
+				resource_build_scaling_params(split_pipe->prev_odm_pipe);
+
+			memset(split_pipe, 0, sizeof(*split_pipe));
+			split_pipe->stream_res.tg = pool->timing_generators[i];
+			split_pipe->plane_res.hubp = pool->hubps[i];
+			split_pipe->plane_res.ipp = pool->ipps[i];
+			split_pipe->plane_res.dpp = pool->dpps[i];
+			split_pipe->stream_res.opp = pool->opps[i];
+			split_pipe->plane_res.mpcc_inst = pool->dpps[i]->inst;
+			split_pipe->pipe_idx = i;
+
 			split_pipe->stream = stream;
 			return i;
 		}

