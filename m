Return-Path: <stable+bounces-66585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EC494F040
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE471F235E2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9DB17BB03;
	Mon, 12 Aug 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZdLxcN1K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02E172773
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474062; cv=none; b=RBiL8jbL5YSRC+bzfgLuEWMwytVtLcABNNCccTtmgamflhGLTGtLvGrcuqT2gi4FvC3vqzhH6kVjP6i6nFCQgSNQ4NO5i+U6oOKIBwiLALr0NP7Ar++8YqPePWRU25GuOTpYjf49J/atL1J6AKayFen28xHsQ6N4SjoPtbqSf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474062; c=relaxed/simple;
	bh=Bly2bdfOSdmNFUXR3IDUjBcw3Z0Q3cGVh07qYDEgGOM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DAZBY7H+simYlBBymbsTK2/NOPJb9x4uAKEBADOL0cSQMNp2+YJY79nYUXb1GCwli+Icah6BaJAMpYWts0TD1hR1gdNFi/3pezyJqnio809HAUAI/8W53+Oi6qcsEeD8iFwSJ8oSpVYrJkLZJzSe4wEEgDp9XKRwiRxyGCbcKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZdLxcN1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4668DC32782;
	Mon, 12 Aug 2024 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474062;
	bh=Bly2bdfOSdmNFUXR3IDUjBcw3Z0Q3cGVh07qYDEgGOM=;
	h=Subject:To:Cc:From:Date:From;
	b=ZdLxcN1KfHA+izFoqJ9SOjCsFgUG0o7j9rX/1YLnGmgtB/VSTl5y4d/1JM49KAaCe
	 ZHVShHvW8mdAOtw4xtj+DLDqM1BD0GIY46yP0rya6wTTnGlR0fQE32kaZjiMzVS/BW
	 FRYotvEYrzNc+oUSPDJFTKhO9hwAp4MT1XmRP43M=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add HW cursor visual confirm" failed to apply to 6.10-stable tree
To: ryanseto@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:47:25 +0200
Message-ID: <2024081225-customize-semantic-0c0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0b8de7a04f7c14abd28bd8b9f3e1e5737a3702e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081225-customize-semantic-0c0b@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

0b8de7a04f7c ("drm/amd/display: Add HW cursor visual confirm")
f63f86b5affc ("drm/amd/display: Separate setting and programming of cursor")
00c391102abc ("drm/amd/display: Add misc DC changes for DCN401")
da87132f641e ("drm/amd/display: Add some DCN401 reg name to macro definitions")

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


