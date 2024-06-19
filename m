Return-Path: <stable+bounces-53717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6543D90E5CB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAF81F22035
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83279B84;
	Wed, 19 Jun 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESs3S1s3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1225FBB1
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786221; cv=none; b=ED64f++MksfdMVERx/dx4+4qaYffEmBAxZDJygi+fbEiunkv1FfG7aZCUxymuOYLlaBxhFGRS6g08z2XYWO0Eh3Y13/nEP/E4ABKnLkym1hEH7ur5QBuNrKUB/GJ7MYSaLcyIcyC3JHlHcI/9cWesneqR2OIUU8Kqf4NzQrT3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786221; c=relaxed/simple;
	bh=SDEGqCPhEjbRZRblRqVebsl/ri/1HZIPwtaT8hQ3lE0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EkYmcQsSJWMWuACF0E3YMeIOph/FZXCx7QHnLT6TyIh1Fc8un5KEBQdm8Z3kJ1KPXrIyhKPp8rFdHZZczZrC5DHlNukb74DY/+G3a0lgdj+uuGtGpos2ddSq50iA5C2CCTEmf5+FHmR2UsxY9FqnRV1RbarxBb5YzZeKCLKX66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESs3S1s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE0DC2BBFC;
	Wed, 19 Jun 2024 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786221;
	bh=SDEGqCPhEjbRZRblRqVebsl/ri/1HZIPwtaT8hQ3lE0=;
	h=Subject:To:Cc:From:Date:From;
	b=ESs3S1s3opbZ0pwieozeM+g8nzo11b7Zv9t6r3QsR36Ac2mimLFQeFwlhm4OcykOz
	 6/Zav15wmk/ylrfU72AYsivVTLs0PA3Sop5bC+cLswALrHZ3rR3fMN8k5uOttuAGPw
	 N0F9TEAhpooF9+IpItPI8sGNyAPsZqmcuQ3oy/E0=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix a bug to dereference already freed old" failed to apply to 5.15-stable tree
To: wenjing.liu@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,josip.pavic@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:36:51 +0200
Message-ID: <2024061951-molar-perky-7e18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 621cf07a3f25337b17becd4c9486308c0988ea49
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061951-molar-perky-7e18@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

621cf07a3f25 ("drm/amd/display: fix a bug to dereference already freed old current state memory")
b04c21abe21f ("drm/amd/display: skip forcing odm in minimal transition")
d62d5551dd61 ("drm/amd/display: Backup and restore only on full updates")
2d5bb791e24f ("drm/amd/display: Implement update_planes_and_stream_v3 sequence")
d2dea1f14038 ("drm/amd/display: Generalize new minimal transition path")
0701117efd1e ("Revert "drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel"")
a9b1a4f684b3 ("drm/amd/display: Add more checks for exiting idle in DC")
dcbf438d4834 ("drm/amd/display: Unify optimize_required flags and VRR adjustments")
8457bddc266c ("drm/amd/display: Revert "Rework DC Z10 restore"")
2a8e918f48bd ("drm/amd/display: add power_state and pme_pending flag")
e6f82bd44b40 ("drm/amd/display: Rework DC Z10 restore")
012fe0674af0 ("drm/amd/display: Add logging resource checks")
a465536ebff8 ("drm/amd/display: revert "Optimize VRR updates to only necessary ones"")
ca1ecae145b2 ("drm/amd/display: Add null pointer guards where needed")
a71e1310a43f ("drm/amd/display: Add more mechanisms for tests")
012a04b1d6af ("drm/amd/display: Refactor phantom resource allocation")
09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")
8e57c06bf4b0 ("drm/amd/display: Refactor DMCUB enter/exit idle interface")
6e4337f695c2 ("drm/amd/display: Unify optimize_required flags and VRR adjustments")
0f657938e434 ("drm/amd/display: do not send commands to DMUB if DMUB is inactive from S3")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 621cf07a3f25337b17becd4c9486308c0988ea49 Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Mon, 4 Mar 2024 18:16:43 -0500
Subject: [PATCH] drm/amd/display: fix a bug to dereference already freed old
 current state memory

[why]
During minimal transition commit, the base state could be freed if it is current state.
This is because after committing minimal transition state, the current state will be
swapped to the minimal transition state and the old current state will be released.
the release could cause the old current state's memory to be freed. However dc
will derefernce this memory when release minimal transition state. Therefore, we
need to retain the old current state until we release minimal transition state.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2c7c3a788ab3..7222917e48bb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4203,7 +4203,6 @@ static void release_minimal_transition_state(struct dc *dc,
 {
 	restore_minimal_pipe_split_policy(dc, base_context, policy);
 	dc_state_release(minimal_transition_context);
-	/* restore previous pipe split and odm policy */
 }
 
 static void force_vsync_flip_in_minimal_transition_context(struct dc_state *context)
@@ -4258,7 +4257,7 @@ static bool is_pipe_topology_transition_seamless_with_intermediate_step(
 					intermediate_state, final_state);
 }
 
-static void swap_and_free_current_context(struct dc *dc,
+static void swap_and_release_current_context(struct dc *dc,
 		struct dc_state *new_context, struct dc_stream_state *stream)
 {
 
@@ -4320,7 +4319,7 @@ static bool commit_minimal_transition_based_on_new_context(struct dc *dc,
 			commit_planes_for_stream(dc, srf_updates,
 					surface_count, stream, NULL,
 					UPDATE_TYPE_FULL, intermediate_context);
-			swap_and_free_current_context(
+			swap_and_release_current_context(
 					dc, intermediate_context, stream);
 			dc_state_retain(dc->current_state);
 			success = true;
@@ -4337,6 +4336,7 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
 	bool success = false;
 	struct pipe_split_policy_backup policy;
 	struct dc_state *intermediate_context;
+	struct dc_state *old_current_state = dc->current_state;
 	struct dc_surface_update srf_updates[MAX_SURFACE_NUM] = {0};
 	int surface_count;
 
@@ -4352,8 +4352,10 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
 	 * with the current state.
 	 */
 	restore_planes_and_stream_state(&dc->scratch.current_state, stream);
+	dc_state_retain(old_current_state);
 	intermediate_context = create_minimal_transition_state(dc,
-			dc->current_state, &policy);
+			old_current_state, &policy);
+
 	if (intermediate_context) {
 		if (is_pipe_topology_transition_seamless_with_intermediate_step(
 				dc,
@@ -4366,14 +4368,15 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
 			commit_planes_for_stream(dc, srf_updates,
 					surface_count, stream, NULL,
 					UPDATE_TYPE_FULL, intermediate_context);
-			swap_and_free_current_context(
+			swap_and_release_current_context(
 					dc, intermediate_context, stream);
 			dc_state_retain(dc->current_state);
 			success = true;
 		}
 		release_minimal_transition_state(dc, intermediate_context,
-				dc->current_state, &policy);
+				old_current_state, &policy);
 	}
+	dc_state_release(old_current_state);
 	/*
 	 * Restore stream and plane states back to the values associated with
 	 * new context.
@@ -4497,12 +4500,14 @@ static bool commit_minimal_transition_state(struct dc *dc,
 			dc->debug.pipe_split_policy != MPC_SPLIT_AVOID ? "MPC in Use" :
 			"Unknown");
 
+	dc_state_retain(transition_base_context);
 	transition_context = create_minimal_transition_state(dc,
 			transition_base_context, &policy);
 	if (transition_context) {
 		ret = dc_commit_state_no_check(dc, transition_context);
 		release_minimal_transition_state(dc, transition_context, transition_base_context, &policy);
 	}
+	dc_state_release(transition_base_context);
 
 	if (ret != DC_OK) {
 		/* this should never happen */
@@ -4840,7 +4845,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 				context);
 	}
 	if (dc->current_state != context)
-		swap_and_free_current_context(dc, context, stream);
+		swap_and_release_current_context(dc, context, stream);
 	return true;
 }
 
@@ -4942,7 +4947,7 @@ static bool update_planes_and_stream_v3(struct dc *dc,
 		commit_planes_and_stream_update_with_new_context(dc,
 				srf_updates, surface_count, stream,
 				stream_update, update_type, new_context);
-		swap_and_free_current_context(dc, new_context, stream);
+		swap_and_release_current_context(dc, new_context, stream);
 	}
 
 	return true;


