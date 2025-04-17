Return-Path: <stable+bounces-133820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4DA927C8
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC8819E38B8
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340625F971;
	Thu, 17 Apr 2025 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W5oU7eFz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9F257434;
	Thu, 17 Apr 2025 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914239; cv=none; b=mFmO6F21eN2fs/yrnlEfRtuBPDhix5YqTqoAuWMNZNuirT49YnHglu7vg+9TaOGZNwNgDhbKM4zgRRMyQwW6NCGLQBLn61bRA2EeUEjSlPRc9qkWfjEGDHOGAKoTGkieKWf35m2bM+Tm6TojAgIMBbMo5cipN7+MSXAYS1R0ung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914239; c=relaxed/simple;
	bh=wDRntvp5/p1IiIJy6yNMuYBbNtdxTCrYYdEygHAETU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5txi9WJ7/y3/yOKP5/da8hbQCoGR/KIbDfSBjIHbKious+FJqHjSC74qEPEoOC8KwwvX7TRSVyh05kQKlENE1d1uTvkZ05XJ0tPxDnp1q34vaI+pwT+vD4+fcdHwTWSaxPx/rJef8McEnpH4glTI3PSzJvi2blJFFQ1qyPZZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W5oU7eFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C49C4CEEC;
	Thu, 17 Apr 2025 18:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914239;
	bh=wDRntvp5/p1IiIJy6yNMuYBbNtdxTCrYYdEygHAETU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5oU7eFzgj6jXT54wMFbeB9Op3nk6TusTD64t7rDVa9Ps9c4g4p2/8lPy0U62uBHA
	 6TyKcvXlCdfVo9LF/LdNq0/QG4g7tUQo4kmdpa0qyNrrKuCsW6hbDLOEvJ/jlUeoGj
	 nri2Bfp/d3VGAfpW5qZt2ymjPtN5J2ZcqoLzN3s0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Mike Katsnelson <mike.katsnelson@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 144/414] drm/amd/display: stop DML2 from removing pipes based on planes
Date: Thu, 17 Apr 2025 19:48:22 +0200
Message-ID: <20250417175117.218688749@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Katsnelson <mike.katsnelson@amd.com>

[ Upstream commit 8adeff83a3b07fa6d0958ed51e1b38ba7469e448 ]

[Why]
Transitioning from low to high resolutions at high refresh rates caused grey corruption.
During the transition state, there is a period where plane size is based on low resultion
state and ODM slices are based on high resoultion state, causing the entire plane to be
contained in one ODM slice. DML2 would turn off the pipe for the ODM slice with no plane,
causing an underflow since the pixel rate for the higher resolution cannot be supported on
one pipe. This change stops DML2 from turning off pipes that are mapped to an ODM slice
with no plane. This is possible to do without negative consequences because pipes can now
take the minimum viewport and draw with zero recout size, removing the need to have the
pipe turned off.

[How]
In map_pipes_from_plane(), remove "check" that skips ODM slices that are not covered by
the plane. This prevents the pipes for those ODM slices from being freed.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Mike Katsnelson <mike.katsnelson@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 26 -------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 1ed21c1b86a5b..a966abd407881 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -532,26 +532,6 @@ static void calculate_odm_slices(const struct dc_stream_state *stream, unsigned
 	odm_slice_end_x[odm_factor - 1] = stream->src.width - 1;
 }
 
-static bool is_plane_in_odm_slice(const struct dc_plane_state *plane, unsigned int slice_index, unsigned int *odm_slice_end_x, unsigned int num_slices)
-{
-	unsigned int slice_start_x, slice_end_x;
-
-	if (slice_index == 0)
-		slice_start_x = 0;
-	else
-		slice_start_x = odm_slice_end_x[slice_index - 1] + 1;
-
-	slice_end_x = odm_slice_end_x[slice_index];
-
-	if (plane->clip_rect.x + plane->clip_rect.width < slice_start_x)
-		return false;
-
-	if (plane->clip_rect.x > slice_end_x)
-		return false;
-
-	return true;
-}
-
 static void add_odm_slice_to_odm_tree(struct dml2_context *ctx,
 		struct dc_state *state,
 		struct dc_pipe_mapping_scratch *scratch,
@@ -791,12 +771,6 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 	sort_pipes_for_splitting(&scratch->pipe_pool);
 
 	for (odm_slice_index = 0; odm_slice_index < scratch->odm_info.odm_factor; odm_slice_index++) {
-		// We build the tree for one ODM slice at a time.
-		// Each ODM slice shares a common OPP
-		if (!is_plane_in_odm_slice(plane, odm_slice_index, scratch->odm_info.odm_slice_end_x, scratch->odm_info.odm_factor)) {
-			continue;
-		}
-
 		// Now we have a list of all pipes to be used for this plane/stream, now setup the tree.
 		scratch->odm_info.next_higher_pipe_for_odm_slice[odm_slice_index] = add_plane_to_blend_tree(ctx, state,
 				plane,
-- 
2.39.5




