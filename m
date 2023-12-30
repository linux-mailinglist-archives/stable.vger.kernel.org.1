Return-Path: <stable+bounces-8764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855048204C7
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F572820D1
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDFB79E0;
	Sat, 30 Dec 2023 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gP4aG2z5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601F79CD;
	Sat, 30 Dec 2023 12:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC48C433C7;
	Sat, 30 Dec 2023 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937702;
	bh=JuUX+7ty6SOGdrK5kKeZVY+89t7JyQL4s5BSuxfmQms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gP4aG2z5qFgyDGjXGXBf+FkiG7/SVCOuJYVfgSmK7TA1SIT/SBSNrEg9ZVwDxoaST
	 escF2kSeRWzLRtDQZmPcC7/LQqE8/9CeNjqrWLdV9PL0P5ZdGj4651aeySVwQ41Xay
	 Jcyr2KyEAU35OjsRYI93xdarEaCSfjesVts4fLRo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Bin Li <binli@gnome.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 007/156] drm/amd/display: fix hw rotated modes when PSR-SU is enabled
Date: Sat, 30 Dec 2023 11:57:41 +0000
Message-ID: <20231230115812.587997409@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

[ Upstream commit f528ee145bd0076cd0ed7e7b2d435893e6329e98 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    |  3 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f5fdb61c821d0..d63360127834b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5170,6 +5170,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	if (plane->type == DRM_PLANE_TYPE_CURSOR)
 		return;
 
+	if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
+		goto ffu;
+
 	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	clips = drm_plane_get_damage_clips(new_plane_state);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 100d62162b717..99880b08cda0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
 	struct fixed31_32 v_scale_ratio;
 	enum dc_rotation_angle rotation;
 	bool mirror;
+	struct dc_stream_state *stream;
 };
 
 /* IPP related types */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 79befa17bb037..13ccb57379c7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3407,7 +3407,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
 		.v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
 		.rotation = pipe_ctx->plane_state->rotation,
-		.mirror = pipe_ctx->plane_state->horizontal_mirror
+		.mirror = pipe_ctx->plane_state->horizontal_mirror,
+		.stream = pipe_ctx->stream,
 	};
 	bool pipe_split_on = false;
 	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 4566bc7abf17e..aa252dc263267 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1075,8 +1075,16 @@ void hubp2_cursor_set_position(
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
-- 
2.43.0




