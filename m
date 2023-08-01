Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68C76ADCB
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjHAJdq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjHAJdJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3786C1FCA
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA1A3614F5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97EFC433C8;
        Tue,  1 Aug 2023 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882256;
        bh=OtBbTJXbei7AIMkTk0OMvawEXU0GjdvQbnpxyq9zbog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J2b6JlKG13eg95Qc413guxLOmzcWf39SUnUecMPfhSZRBAqM9V2BrurPRBCz7byRL
         UE/AJ0eJsyrcKdZSPunhBB14cNaRnCB34KyHzkbvHonZ/c5wa7NB5uqhJNl71pZTVS
         kbrLsJ8qjb9G9BWlZ2q9uD4hHWK1FlMc4DzUl3U0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Samson Tam <samson.tam@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 040/228] drm/amd/display: add ODM case when looking for first split pipe
Date:   Tue,  1 Aug 2023 11:18:18 +0200
Message-ID: <20230801091924.332598868@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Samson Tam <samson.tam@amd.com>

[ Upstream commit 59de751e3845d699e02dc4da47322b92d83a41e2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 36 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 20 +++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c429748c86cdb..629bc53f61877 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1913,6 +1913,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
+static bool commit_minimal_transition_state(struct dc *dc,
+		struct dc_state *transition_base_context);
+
 /**
  * dc_commit_streams - Commit current stream state
  *
@@ -1934,6 +1937,8 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	struct dc_state *context;
 	enum dc_status res = DC_OK;
 	struct dc_validation_set set[MAX_STREAMS] = {0};
+	struct pipe_ctx *pipe;
+	bool handle_exit_odm2to1 = false;
 
 	if (!streams_changed(dc, streams, stream_count))
 		return res;
@@ -1955,6 +1960,22 @@ enum dc_status dc_commit_streams(struct dc *dc,
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
@@ -3759,6 +3780,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	unsigned int i, j;
 	unsigned int pipe_in_use = 0;
 	bool subvp_in_use = false;
+	bool odm_in_use = false;
 
 	if (!transition_context)
 		return false;
@@ -3783,6 +3805,18 @@ static bool commit_minimal_transition_state(struct dc *dc,
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
@@ -3791,7 +3825,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	 * Reduce the scenarios to use dc_commit_state_no_check in the stage of flip. Especially
 	 * enter/exit MPO when DCN still have enough resources.
 	 */
-	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use) {
+	if (pipe_in_use != dc->res_pool->pipe_count && !subvp_in_use && !odm_in_use) {
 		dc_release_state(transition_context);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f0d05829288bd..a26e52abc9898 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1444,6 +1444,26 @@ static int acquire_first_split_pipe(
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
-- 
2.39.2



