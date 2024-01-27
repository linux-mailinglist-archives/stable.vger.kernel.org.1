Return-Path: <stable+bounces-16135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C624583F0EE
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA862810EC
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE051DDD6;
	Sat, 27 Jan 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="orzarw9F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B818E07
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395110; cv=none; b=ICseYAWLZpYUrxGlsfF/jD034tLsuyIibg1cwmwOFHEDYop6mM4S8bLZyzjM46x4JBR1XW/Ot5xo+juPexxy4M2I3inxLDopWNjUCI59iT+jx9xKqQv89ATaFO5Mk1n9fJP64yUGH0TwCgVwYo2polCeRxUJE0yServaBCche5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395110; c=relaxed/simple;
	bh=rcTAi7ITr+ysUqdBNpjiFB2QQn8MWBXAaVWQ5WXhDA8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X9ZMzphgEsHn8sOmppoFf8bNBvGTLzf8zRL56h9FVxK6Jz/BTOEVQrJaO5zUA/kGHElWicoL0AIF2kWbKe8G6voAzqakyt+C36uUukEEEPcbcythXVhjeJfEoof4SG7fkWwgYQ5a1f9NtNDuq23lBAYqSs10lEy062ShaSERYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=orzarw9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9BAC433F1;
	Sat, 27 Jan 2024 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395110;
	bh=rcTAi7ITr+ysUqdBNpjiFB2QQn8MWBXAaVWQ5WXhDA8=;
	h=Subject:To:Cc:From:Date:From;
	b=orzarw9Fcl0LoHveiY7eKkw5lkf07Y3tvf5I0m/z3qTCeKxaZemZkKOnPCq37QeXr
	 PoO+EDvipHbW+SeggM9PUyduA3KwjGEyjlT20EgRq2GBK8/3x3dNEGy35XIfD/DvY9
	 pHVG77zf0KrdWu2UyA40P/AhhIH6Y8wd7MdNII50=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is enabled" failed to apply to 6.6-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,binli@gnome.org,kai.heng.feng@canonical.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:38:29 -0800
Message-ID: <2024012729-directive-freeness-e772@gregkh>
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
git cherry-pick -x 0497ae6f8830816d9277a8d5c8d9bf5966f292e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012729-directive-freeness-e772@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0497ae6f8830 ("drm/amd/display: fix hw rotated modes when PSR-SU is enabled")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0497ae6f8830816d9277a8d5c8d9bf5966f292e1 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Tue, 5 Dec 2023 14:55:04 -0500
Subject: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is enabled

We currently don't support dirty rectangles on hardware rotated modes.
So, if a user is using hardware rotated modes with PSR-SU enabled,
use PSR-SU FFU for all rotated planes (including cursor planes).

Cc: stable@vger.kernel.org
Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Bin Li <binli@gnome.org>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6aabe8a3ffef..90868a54d4dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5241,6 +5241,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	if (plane->type == DRM_PLANE_TYPE_CURSOR)
 		return;
 
+	if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
+		goto ffu;
+
 	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	clips = drm_plane_get_damage_clips(new_plane_state);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 9649934ea186..e2a3aa8812df 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
 	struct fixed31_32 v_scale_ratio;
 	enum dc_rotation_angle rotation;
 	bool mirror;
+	struct dc_stream_state *stream;
 };
 
 /* IPP related types */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 139cf31d2e45..89c3bf0fe0c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
 	if (src_y_offset < 0)
 		src_y_offset = 0;
 	/* Save necessary cursor info x, y position. w, h is saved in attribute func. */
-	hubp->cur_rect.x = src_x_offset + param->viewport.x;
-	hubp->cur_rect.y = src_y_offset + param->viewport.y;
+	if (param->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
+	    param->rotation != ROTATION_ANGLE_0) {
+		hubp->cur_rect.x = 0;
+		hubp->cur_rect.y = 0;
+		hubp->cur_rect.w = param->stream->timing.h_addressable;
+		hubp->cur_rect.h = param->stream->timing.v_addressable;
+	} else {
+		hubp->cur_rect.x = src_x_offset + param->viewport.x;
+		hubp->cur_rect.y = src_y_offset + param->viewport.y;
+	}
 }
 
 void hubp2_clk_cntl(struct hubp *hubp, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 2b8b8366538e..cdb903116eb7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
 		.v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
 		.rotation = pipe_ctx->plane_state->rotation,
-		.mirror = pipe_ctx->plane_state->horizontal_mirror
+		.mirror = pipe_ctx->plane_state->horizontal_mirror,
+		.stream = pipe_ctx->stream,
 	};
 	bool pipe_split_on = false;
 	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||


