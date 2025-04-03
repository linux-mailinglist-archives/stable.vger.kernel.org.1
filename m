Return-Path: <stable+bounces-127975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105DA7ADC2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEB4188E020
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47929261E4F;
	Thu,  3 Apr 2025 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvkvyEyZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D04261E47;
	Thu,  3 Apr 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707660; cv=none; b=D1fxssW0AlvAkZS9+qPGn7GOVTq5dMXzH45OAE37/7bk6mbEfMee1Ti08+nM1PZGfCwAHGXkDFcBD2VJq+oN8ErUN3VQ1pXYEZEZQip9DK/06CZt/7Ou1J+NBKH+TrSErAfndn96BXG6YJ9+xNlDo7i4kRL4L0PfvNb9FTkviR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707660; c=relaxed/simple;
	bh=M/wqt9H7ZmTOQzCHcV4voKIlYfrs7dNZt7/qJ00KdGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPhRsZvIQPnY4mbmVb5s0EE7O9yZrV4i3fPzLkMb+GZ3miGaIRVSz6x8Qrd8ayUu8UC56dKVq2KI7gGN3hcGDBavUAOnT8KuR2wuj4bBVLABI0jXKDcoL0FDufiKwknJ2XImwjxCRBvtXtm+govPxRYxw+ZgqzaqkQ9UxHw3TaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvkvyEyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFB7C4CEE3;
	Thu,  3 Apr 2025 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707659;
	bh=M/wqt9H7ZmTOQzCHcV4voKIlYfrs7dNZt7/qJ00KdGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvkvyEyZ9Gkx3C3pTbfjVqfZAdlGZZI50VnrUZnlRN0e8PqKpsex7wHn9ddzzokAd
	 y/JePFKEh1LJGzTM25rCzcxiKU4H+5lntO3Z701HaEJA5SdbAVK4c5NVfnStspzK2D
	 mleqRY4FvGPKom1tNWY63CqtFqQLogluRXjsy5s80CdlGshPHPUeGRsbJW2JwV2Tvg
	 3Q/GU52zA2xtTX76wyjteP+DtceXbkbb/kPO7XvhwFTJ6GaFHavBJLq9L7fHUZGuDD
	 R6xJzlaIJUYGm4uvKiSpWOLWNJ3gZARqVe/yvKUq6ZClY6ZB4j2NVl3NMjpsgbqFt0
	 3IQi4gT63eBhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Katsnelson <mike.katsnelson@amd.com>,
	Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 20/44] drm/amd/display: stop DML2 from removing pipes based on planes
Date: Thu,  3 Apr 2025 15:12:49 -0400
Message-Id: <20250403191313.2679091-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

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


