Return-Path: <stable+bounces-530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4027F7B79
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD541C20E9C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8F39FF3;
	Fri, 24 Nov 2023 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PPrvmUxr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005E39FC3;
	Fri, 24 Nov 2023 18:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEE4C433C8;
	Fri, 24 Nov 2023 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849128;
	bh=Urj0r1H1gzCuJQpw5wzoUuJ8tqrNIfY9FmNUdG+N0fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPrvmUxrgfjaFqcYzsJW0AFkK6+FsuE9OuqkxXLe3LK1Puy9m262aDApKiakpZH6v
	 NXkDvilvueqX9oBrDf7WO4gLS/pwdML+/Lgi1xCG5vZ5Nr4rYU2qnR2lE0vt88FMQx
	 S215C4hmwHPR74Cz8808GmH0EWWddshaGnhQ4cOE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dillon Varone <dillon.varone@amd.com>,
	Stylon Wang <stylon.wang@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 051/530] drm/amd/display: add seamless pipe topology transition check
Date: Fri, 24 Nov 2023 17:43:37 +0000
Message-ID: <20231124172029.608586820@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjing Liu <wenjing.liu@amd.com>

[ Upstream commit 15c6798ae26d5c7a7776f4f7d0c1fa8c462688a2 ]

[why]
We have a few cases where we need to perform update topology update
in dc update interface. However some of the updates are not seamless
This could cause user noticible glitches. To enforce seamless transition
we are adding a checking condition and error logging so the corruption
as result of non seamless transition can be easily spotted.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 +++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 52 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  4 ++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  3 ++
 5 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3b9d6fa50d170..14c3c1907b953 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4328,6 +4328,14 @@ bool dc_update_planes_and_stream(struct dc *dc,
 				update_type,
 				context);
 	} else {
+		if (!stream_update &&
+				dc->hwss.is_pipe_topology_transition_seamless &&
+				!dc->hwss.is_pipe_topology_transition_seamless(
+						dc, dc->current_state, context)) {
+
+			DC_LOG_ERROR("performing non-seamless pipe topology transition with surface only update!\n");
+			BREAK_TO_DEBUGGER();
+		}
 		commit_planes_for_stream(
 				dc,
 				srf_updates,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index cae5e1e68c860..018376146d977 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1619,3 +1619,55 @@ void dcn32_blank_phantom(struct dc *dc,
 	if (tg->funcs->is_tg_enabled(tg))
 		hws->funcs.wait_for_blank_complete(opp);
 }
+
+bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
+		const struct dc_state *cur_ctx,
+		const struct dc_state *new_ctx)
+{
+	int i;
+	const struct pipe_ctx *cur_pipe, *new_pipe;
+	bool is_seamless = true;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		cur_pipe = &cur_ctx->res_ctx.pipe_ctx[i];
+		new_pipe = &new_ctx->res_ctx.pipe_ctx[i];
+
+		if (resource_is_pipe_type(cur_pipe, FREE_PIPE) ||
+				resource_is_pipe_type(new_pipe, FREE_PIPE))
+			/* adding or removing free pipes is always seamless */
+			continue;
+		else if (resource_is_pipe_type(cur_pipe, OTG_MASTER)) {
+			if (resource_is_pipe_type(new_pipe, OTG_MASTER))
+				if (cur_pipe->stream->stream_id == new_pipe->stream->stream_id)
+				/* OTG master with the same stream is seamless */
+					continue;
+		} else if (resource_is_pipe_type(cur_pipe, OPP_HEAD)) {
+			if (resource_is_pipe_type(new_pipe, OPP_HEAD)) {
+				if (cur_pipe->stream_res.tg == new_pipe->stream_res.tg)
+					/*
+					 * OPP heads sharing the same timing
+					 * generator is seamless
+					 */
+					continue;
+			}
+		} else if (resource_is_pipe_type(cur_pipe, DPP_PIPE)) {
+			if (resource_is_pipe_type(new_pipe, DPP_PIPE)) {
+				if (cur_pipe->stream_res.opp == new_pipe->stream_res.opp)
+					/*
+					 * DPP pipes sharing the same OPP head is
+					 * seamless
+					 */
+					continue;
+			}
+		}
+
+		/*
+		 * This pipe's transition doesn't fall under any seamless
+		 * conditions
+		 */
+		is_seamless = false;
+		break;
+	}
+
+	return is_seamless;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 616d5219119e9..9992e40acd217 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -120,4 +120,8 @@ void dcn32_blank_phantom(struct dc *dc,
 		int width,
 		int height);
 
+bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
+		const struct dc_state *cur_ctx,
+		const struct dc_state *new_ctx);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index eb4227926006a..1edadff39a5ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -116,6 +116,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.update_dsc_pg = dcn32_update_dsc_pg,
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
 	.blank_phantom = dcn32_blank_phantom,
+	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 7a702e216e530..66e680902c95c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -401,6 +401,9 @@ struct hw_sequencer_funcs {
 			struct dc_state *context,
 			struct pipe_ctx *phantom_pipe);
 	void (*apply_update_flags_for_phantom)(struct pipe_ctx *phantom_pipe);
+	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
+			const struct dc_state *cur_ctx,
+			const struct dc_state *new_ctx);
 
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
-- 
2.42.0




