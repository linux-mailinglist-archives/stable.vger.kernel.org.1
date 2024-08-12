Return-Path: <stable+bounces-66584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D394F03E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CEC1C218C6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B9184557;
	Mon, 12 Aug 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZTT4gokF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFD184558
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474059; cv=none; b=nOW4z6XNsymM59mzickXzNMW7etaPsOB92anFmK6vIKhYkBrFbmkiqhoyYyTCseHat8Vm4zDGl1hW4y3tBLe9noGhfFHw3IahT43yrUCNC4l2CIT9S4Jvye3mbN4NOoZRsLHJ9aCaEn6cBlBjOIOjUDgJYMDXy4+mgHQPqj/HRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474059; c=relaxed/simple;
	bh=HcJnSE7KM4vGy1jLbajp7gLQC+yL78r7QOriI8bVjWQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KVB5ZptTYwtyWN6vA1V9U1zIsVMIiJZM/wfWoCPM7SwSfNphl7OTfy0TOMp5uF0M7mQ7J8SM0OZFrJuwcsK+4rsHA3N9Y1vu8ZuUm/kE8sRUlnb7XVdX4I5zKahtMVbzRleZeBEIYjALG9jxshH7LCFZF919PZFgydgULKhkZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZTT4gokF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B627C32782;
	Mon, 12 Aug 2024 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474059;
	bh=HcJnSE7KM4vGy1jLbajp7gLQC+yL78r7QOriI8bVjWQ=;
	h=Subject:To:Cc:From:Date:From;
	b=ZTT4gokFckNx7ry7ZzQxnXBLmvHt/Oc95thj7XW2h3qy+vUJdsUiWRUXgXiPojxxw
	 bYseksVeyV8DXusL4LrdbpfNV97vmRcux1L1jY9/vAtfTc+M2OfT+MMbXwNLyfC3RP
	 1vxRHXu1DFNWA1DDIF21ygFEhuGDA80JqSOVj7/Y=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add HW cursor visual confirm" failed to apply to 6.6-stable tree
To: ryanseto@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:47:25 +0200
Message-ID: <2024081225-albatross-dastardly-d4a3@gregkh>
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
git cherry-pick -x 0b8de7a04f7c14abd28bd8b9f3e1e5737a3702e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081225-albatross-dastardly-d4a3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0b8de7a04f7c ("drm/amd/display: Add HW cursor visual confirm")
f63f86b5affc ("drm/amd/display: Separate setting and programming of cursor")
00c391102abc ("drm/amd/display: Add misc DC changes for DCN401")
da87132f641e ("drm/amd/display: Add some DCN401 reg name to macro definitions")
ef319dff5475 ("drm/amd/display: add support for chroma offset")
a41aa6a7d0a6 ("drm/amd/display: Add comments to improve the code readability")
5324e2b205a2 ("drm/amd/display: Add driver support for future FAMS versions")
f3736c0d979a ("drm/amd/display: Add code comments clock and encode code")
8b2cb32cf0c6 ("drm/amd/display: FEC overhead should be checked once for mst slot nums")
4df96ba66760 ("drm/amd/display: Add timing pixel encoding for mst mode validation")
2dbe9c2b2685 ("drm/amd/display: add DCN 351 version for microcode load")
1c5c36530a57 ("drm/amd/display: Set DCN351 BB and IP the same as DCN35")
5034b935f62a ("drm/amd/display: Modify DHCUB waterwark structures and functions")
9d43241953f7 ("drm/amd/display: Refactor DML2 interfaces")
8cffa89bd5e2 ("drm/amd/display: Expand DML2 callbacks")
2d5bb791e24f ("drm/amd/display: Implement update_planes_and_stream_v3 sequence")
88867807564e ("drm/amd/display: Refactor DPP into a component directory")
27f03bc680ef ("drm/amd/display: Guard cursor idle reallow by DC debug option")
eed4edda910f ("drm/amd/display: Support long vblank feature")
caef6c453cf2 ("drm/amd/display: Add DML2 folder to include path")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b8de7a04f7c14abd28bd8b9f3e1e5737a3702e2 Mon Sep 17 00:00:00 2001
From: Ryan Seto <ryanseto@amd.com>
Date: Fri, 14 Jun 2024 14:23:41 -0400
Subject: [PATCH] drm/amd/display: Add HW cursor visual confirm

[WHY]
Added HW cursor visual confirm

[HOW]
Added visual confirm logic when programming cursor positions.
HW is programmed on cursor updates since cursor can change without flips.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9b24f448ce50..de0633f98158 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -416,6 +416,35 @@ bool dc_stream_program_cursor_position(
 		if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
 			dc_allow_idle_optimizations(dc, true);
 
+		/* apply/update visual confirm */
+		if (dc->debug.visual_confirm == VISUAL_CONFIRM_HW_CURSOR) {
+			/* update software state */
+			uint32_t color_value = MAX_TG_COLOR_VALUE;
+			int i;
+
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+				/* adjust visual confirm color for all pipes with current stream */
+				if (stream == pipe_ctx->stream) {
+					if (stream->cursor_position.enable) {
+						pipe_ctx->visual_confirm_color.color_r_cr = color_value;
+						pipe_ctx->visual_confirm_color.color_g_y = 0;
+						pipe_ctx->visual_confirm_color.color_b_cb = 0;
+					} else {
+						pipe_ctx->visual_confirm_color.color_r_cr = 0;
+						pipe_ctx->visual_confirm_color.color_g_y = 0;
+						pipe_ctx->visual_confirm_color.color_b_cb = color_value;
+					}
+
+					/* programming hardware */
+					if (pipe_ctx->plane_state)
+						dc->hwss.update_visual_confirm_color(dc, pipe_ctx,
+								pipe_ctx->plane_res.hubp->mpcc_id);
+				}
+			}
+		}
+
 		return true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e0334b573f2d..64241de70f15 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -476,6 +476,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_SUBVP = 14,
 	VISUAL_CONFIRM_MCLK_SWITCH = 16,
 	VISUAL_CONFIRM_FAMS2 = 19,
+	VISUAL_CONFIRM_HW_CURSOR = 20,
 };
 
 enum dc_psr_power_opts {


