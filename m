Return-Path: <stable+bounces-16214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2858883F1B2
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1785281ABF
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C137200BD;
	Sat, 27 Jan 2024 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F4FtRh/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BE1B7E5
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397356; cv=none; b=KC96L+2YI94f84Z1Aq2WrHTlGONUgVAh7xQWpcN0a+sxepkAo3hN4NkNq5VLMWzzct6U0pcgjTzCkZSUBI4saOvIns/jXbtCiC2Sb5n3IO78owjDPpq6kaBGcQQIwjvcy3Gukzo4OJvqNm/fjAl55nvKZnaF5wVMloNvwAYVOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397356; c=relaxed/simple;
	bh=unphE86J6C1OeBUolLcd6x34pbQc9GRPCHD5+ucVI4E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XRRu8x1VdmBNR8ZOgjtlBnxLlyPHTuG+2vjxtFaDFCh1XnADvLneQ8yKYZGlCL9sCeA74vNVwK8hNUdVPtcodsuPJHJe55z8X6z1lL/hRu9vjs0/0No/Dad9HRseYrykp27XWP4Af2N2rDNmGfmuJG78W3r2+qoPZICBm3n9zKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F4FtRh/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D0BC43390;
	Sat, 27 Jan 2024 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397355;
	bh=unphE86J6C1OeBUolLcd6x34pbQc9GRPCHD5+ucVI4E=;
	h=Subject:To:Cc:From:Date:From;
	b=F4FtRh/JlIbMFa8Q1DyBq0w5+BgeBiTmPigAgw1z8rfzEnFt6XCwhJ/E8WZHgIKwT
	 t1k7MmI6dlX/CNaxEp6cqqcfPDkVH2e5T06Cgy+Scd/GvIKzATt1pEQZ2Zxb9p6Ltb
	 PhKLJd2k/N4nN2ZXIVoibH5bpibiB9nm7ql7Ux2E=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add logging resource checks" failed to apply to 6.1-stable tree
To: charlene.liu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sungjoon.kim@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:15:54 -0800
Message-ID: <2024012754-aneurism-congenial-8364@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8a51cc097dd590a86e8eec5398934ef389ff9a7b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012754-aneurism-congenial-8364@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

8a51cc097dd5 ("drm/amd/display: Add logging resource checks")
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

From 8a51cc097dd590a86e8eec5398934ef389ff9a7b Mon Sep 17 00:00:00 2001
From: Charlene Liu <charlene.liu@amd.com>
Date: Thu, 28 Dec 2023 13:19:33 -0500
Subject: [PATCH] drm/amd/display: Add logging resource checks

[Why]
When mapping resources, resources could be unavailable.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 69e726630241..aa7c02ba948e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3522,7 +3522,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	top_pipe_to_program = resource_get_otg_master_for_stream(
 				&context->res_ctx,
 				stream);
-
+	ASSERT(top_pipe_to_program != NULL);
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
@@ -4345,6 +4345,8 @@ static bool should_commit_minimal_transition_for_windowed_mpo_odm(struct dc *dc,
 
 	cur_pipe = resource_get_otg_master_for_stream(&dc->current_state->res_ctx, stream);
 	new_pipe = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+	if (!cur_pipe || !new_pipe)
+		return false;
 	cur_is_odm_in_use = resource_get_odm_slice_count(cur_pipe) > 1;
 	new_is_odm_in_use = resource_get_odm_slice_count(new_pipe) > 1;
 	if (cur_is_odm_in_use == new_is_odm_in_use)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f2abc1096ffb..9fbdb09697fd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2194,6 +2194,10 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 	for (stream_idx = 0; stream_idx < state->stream_count; stream_idx++) {
 		otg_master = resource_get_otg_master_for_stream(
 				&state->res_ctx, state->streams[stream_idx]);
+		if (!otg_master	|| otg_master->stream_res.tg == NULL) {
+			DC_LOG_DC("topology update: otg_master NULL stream_idx %d!\n", stream_idx);
+			return;
+		}
 		slice_count = resource_get_opp_heads_for_otg_master(otg_master,
 				&state->res_ctx, opp_heads);
 		for (slice_idx = 0; slice_idx < slice_count; slice_idx++) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 56feee0ff01b..88c6436b28b6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -434,8 +434,9 @@ bool dc_state_add_plane(
 
 	otg_master_pipe = resource_get_otg_master_for_stream(
 			&state->res_ctx, stream);
-	added = resource_append_dpp_pipes_for_plane_composition(state,
-			dc->current_state, pool, otg_master_pipe, plane_state);
+	if (otg_master_pipe)
+		added = resource_append_dpp_pipes_for_plane_composition(state,
+				dc->current_state, pool, otg_master_pipe, plane_state);
 
 	if (added) {
 		stream_status->plane_states[stream_status->plane_count] =


