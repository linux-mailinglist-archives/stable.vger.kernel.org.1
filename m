Return-Path: <stable+bounces-58485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472A92B749
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B0F281D4A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6C15D5C4;
	Tue,  9 Jul 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pyMBYZ6w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A341586C0;
	Tue,  9 Jul 2024 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524079; cv=none; b=roRMsH/n4Y3bxBVN69iZ3LUxhg4WybkLVECr8ed/Pc32IWgFTdQ2VL1T8llTMsr30fvhkiIj5VCXx+j5vPmRJo7zA53lD75c6A1+1kyu4sYV5lhkWANRbRh/RXy9seWSHMqtbq8162lDUMzDif8Ifn6WbKdzd1Pc0q1OWTl4mHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524079; c=relaxed/simple;
	bh=IDXnVwrGYg7CbwfK+KVrPeRiVKYjRw87WKA67EHXjhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0XyeGjhg1lDJCyYLWrioRarNudhJMy+8Yy5SJvPyeg1D2PoS0cNHna2h4GAMrmuENTkF4OdJF7txzRnwLds3BKM7eRKfmDoXbQ9X10SeL53AfGc1vhXpcHlBwyO5GXxdLgRxogGz3ITmJ+7vDt8vbLwaUtC4wqPeYe7MRnSCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pyMBYZ6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777EFC3277B;
	Tue,  9 Jul 2024 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524078;
	bh=IDXnVwrGYg7CbwfK+KVrPeRiVKYjRw87WKA67EHXjhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyMBYZ6wvnHpsccOxlYVfWFoN9+XRbWtyh4drb86IiTWBd44/kADc+YQDDIxly5Nz
	 gonbeRB7FhbB4PjTgL4bzMaWEw4n/YtcUxwkwgHf1SMSdwiUjkPwU1EsJdTJc2689f
	 psUDq5IrkCaOxqPFVPYKFq6duxq70uTZjoIAy9Vw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alvin Lee <alvin.lee2@amd.com>,
	Roman Li <roman.li@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 033/197] drm/amd/display: update pipe topology log to support subvp
Date: Tue,  9 Jul 2024 13:08:07 +0200
Message-ID: <20240709110710.200991615@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjing Liu <wenjing.liu@amd.com>

[ Upstream commit 5db346c256bbacc634ff515a1a9202cd4b61d8c7 ]

[why]
There is an ambiguity in subvp pipe topology log. The log doesn't show
subvp relation to main stream and it is not clear that certain stream
is an internal stream for subvp pipes.

[how]
Separate subvp pipe topology logging from main pipe topology. Log main
stream indices instead of the internal stream for subvp pipes.
The following is a sample log showing 2 streams with subvp enabled on
both:

   pipe topology update
 ________________________
| plane0  slice0  stream0|
|DPP1----OPP1----OTG1----|
| plane0  slice0  stream1|
|DPP0----OPP0----OTG0----|
|    (phantom pipes)     |
| plane0  slice0  stream0|
|DPP3----OPP3----OTG3----|
| plane0  slice0  stream1|
|DPP2----OPP2----OTG2----|
|________________________|

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 3ac31c9a707d ("drm/amd/display: Do not return negative stream id for array")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 96 +++++++++++++------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 37a8e530cc951..d0bdfdf270ac9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2168,50 +2168,84 @@ static void resource_log_pipe(struct dc *dc, struct pipe_ctx *pipe,
 	}
 }
 
-void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
+static void resource_log_pipe_for_stream(struct dc *dc, struct dc_state *state,
+		struct pipe_ctx *otg_master, int stream_idx)
 {
-	struct pipe_ctx *otg_master;
 	struct pipe_ctx *opp_heads[MAX_PIPES];
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
 
-	int stream_idx, slice_idx, dpp_idx, plane_idx, slice_count, dpp_count;
+	int slice_idx, dpp_idx, plane_idx, slice_count, dpp_count;
 	bool is_primary;
 	DC_LOGGER_INIT(dc->ctx->logger);
 
+	slice_count = resource_get_opp_heads_for_otg_master(otg_master,
+			&state->res_ctx, opp_heads);
+	for (slice_idx = 0; slice_idx < slice_count; slice_idx++) {
+		plane_idx = -1;
+		if (opp_heads[slice_idx]->plane_state) {
+			dpp_count = resource_get_dpp_pipes_for_opp_head(
+					opp_heads[slice_idx],
+					&state->res_ctx,
+					dpp_pipes);
+			for (dpp_idx = 0; dpp_idx < dpp_count; dpp_idx++) {
+				is_primary = !dpp_pipes[dpp_idx]->top_pipe ||
+						dpp_pipes[dpp_idx]->top_pipe->plane_state != dpp_pipes[dpp_idx]->plane_state;
+				if (is_primary)
+					plane_idx++;
+				resource_log_pipe(dc, dpp_pipes[dpp_idx],
+						stream_idx, slice_idx,
+						plane_idx, slice_count,
+						is_primary);
+			}
+		} else {
+			resource_log_pipe(dc, opp_heads[slice_idx],
+					stream_idx, slice_idx, plane_idx,
+					slice_count, true);
+		}
+
+	}
+}
+
+static int resource_stream_to_stream_idx(struct dc_state *state,
+		struct dc_stream_state *stream)
+{
+	int i, stream_idx = -1;
+
+	for (i = 0; i < state->stream_count; i++)
+		if (state->streams[i] == stream) {
+			stream_idx = i;
+			break;
+		}
+	return stream_idx;
+}
+
+void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
+{
+	struct pipe_ctx *otg_master;
+	int stream_idx, phantom_stream_idx;
+	DC_LOGGER_INIT(dc->ctx->logger);
+
 	DC_LOG_DC("    pipe topology update");
 	DC_LOG_DC("  ________________________");
 	for (stream_idx = 0; stream_idx < state->stream_count; stream_idx++) {
+		if (state->streams[stream_idx]->is_phantom)
+			continue;
+
 		otg_master = resource_get_otg_master_for_stream(
 				&state->res_ctx, state->streams[stream_idx]);
-		if (!otg_master	|| otg_master->stream_res.tg == NULL) {
-			DC_LOG_DC("topology update: otg_master NULL stream_idx %d!\n", stream_idx);
-			return;
-		}
-		slice_count = resource_get_opp_heads_for_otg_master(otg_master,
-				&state->res_ctx, opp_heads);
-		for (slice_idx = 0; slice_idx < slice_count; slice_idx++) {
-			plane_idx = -1;
-			if (opp_heads[slice_idx]->plane_state) {
-				dpp_count = resource_get_dpp_pipes_for_opp_head(
-						opp_heads[slice_idx],
-						&state->res_ctx,
-						dpp_pipes);
-				for (dpp_idx = 0; dpp_idx < dpp_count; dpp_idx++) {
-					is_primary = !dpp_pipes[dpp_idx]->top_pipe ||
-							dpp_pipes[dpp_idx]->top_pipe->plane_state != dpp_pipes[dpp_idx]->plane_state;
-					if (is_primary)
-						plane_idx++;
-					resource_log_pipe(dc, dpp_pipes[dpp_idx],
-							stream_idx, slice_idx,
-							plane_idx, slice_count,
-							is_primary);
-				}
-			} else {
-				resource_log_pipe(dc, opp_heads[slice_idx],
-						stream_idx, slice_idx, plane_idx,
-						slice_count, true);
-			}
+		resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
+	}
+	if (state->phantom_stream_count > 0) {
+		DC_LOG_DC(" |    (phantom pipes)     |");
+		for (stream_idx = 0; stream_idx < state->stream_count; stream_idx++) {
+			if (state->stream_status[stream_idx].mall_stream_config.type != SUBVP_MAIN)
+				continue;
 
+			phantom_stream_idx = resource_stream_to_stream_idx(state,
+					state->stream_status[stream_idx].mall_stream_config.paired_stream);
+			otg_master = resource_get_otg_master_for_stream(
+					&state->res_ctx, state->streams[phantom_stream_idx]);
+			resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
 		}
 	}
 	DC_LOG_DC(" |________________________|\n");
-- 
2.43.0




