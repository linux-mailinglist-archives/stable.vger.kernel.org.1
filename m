Return-Path: <stable+bounces-179564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C67B5681D
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 13:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3210116343B
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E446D1A7;
	Sun, 14 Sep 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHoYTNYb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90691D554
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850503; cv=none; b=lwbK/EWbpEsRgKc0f3eV2hioK+oqXVTT8pB8+kL//UUS1r8atWvOq1UXUyOFB4BvB9iodN4Lq/DViJof7j5a/YDOwPTvSWe0msLRUhNtKfIWUtQz62EJFBLNbQHdXLS2xqrPK3AyPNAJwY3D/NGLQvhRo4R3GHQUCBdXRpNoIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850503; c=relaxed/simple;
	bh=iIjHEZ8RIz3TnjSidEA1O2/3Ob1UOwem6HPsesabp1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMCcXvsli5XlpwQCZlWztspHj0CRhuHqHnadVcYIBjKNM1MuA8Xr4JNijqXZxTO6X1ZjpVxYqTedpfYkbvHYmr/S0EommKfwKAmZ7epSiNoUI8opK1LcSZB/jrFb1d70Gc1jyD+i3iKyyHa2b0FEqCaaiDW8+t9/W4TbG4J8jWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHoYTNYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61F1C4CEF5;
	Sun, 14 Sep 2025 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757850501;
	bh=iIjHEZ8RIz3TnjSidEA1O2/3Ob1UOwem6HPsesabp1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHoYTNYbkERyCn9amiQm/5eqERVx/J7nKGnevzfWPY4zHkhgyNcvOQ5CRZG6oXkYN
	 qWuEy8Xx7iaJc9xgY0AQaCn8dwYpBAs53v5vhM/iZ+g3eAgDv0/lrSxroE8jLRjvDF
	 0Wbi8/bXRGLzLUecBG6EXD25lkWThGI/LAkGPPL7mMXCuoBGLn2zq6JdZarSVjqipx
	 Q/IshCOXMUpwVsvdaDKUm6vHhXJElLzsY2uPaqAwIJ8u5c70sVBtw+N7Wwv8WZmRzl
	 mOFLAMzs/Kuv4sEfAhkmwkFveHBEbDl3p80Dg/RJ6kw1Z45snhpI+8YFnkNM6sp7qL
	 IrMXv2Vy9UyfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] drm/amd/display: Destroy cached state in complete() callback
Date: Sun, 14 Sep 2025 07:48:17 -0400
Message-ID: <20250914114818.12813-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091312-armful-thus-2400@gregkh>
References: <2025091312-armful-thus-2400@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 45cc102f8e6520ac07637c7e09f61dcc3772e125 ]

[Why]
When the suspend sequence has been aborted after prepare() but
before suspend() the resume() callback never gets called. The PM core
will call complete() when this happens. As the state has been cached
in prepare() it needs to be destroyed in complete() if it's still around.

[How]
Create a helper for destroying cached state and call it both in resume()
and complete() callbacks. If resume has been called the state will be
destroyed and it's a no-op for complete().  If resume hasn't been called
(such as an aborted suspend) then destroy the state in complete().

Fixes: 50e0bae34fa6 ("drm/amd/display: Add and use new dm_prepare_suspend() callback")
Reviewed-by: Alex Hung <alex.hung@amd.com>
Link: https://lore.kernel.org/r/20250602014432.3538345-4-superm1@kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 60f71f0db7b1 ("drm/amd/display: Drop dm_prepare_suspend() and dm_complete()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 100 +++++++++++-------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2d94fec5b545d..0eaa1574ff288 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3073,6 +3073,64 @@ static int dm_cache_state(struct amdgpu_device *adev)
 	return adev->dm.cached_state ? 0 : r;
 }
 
+static void dm_destroy_cached_state(struct amdgpu_device *adev)
+{
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct dm_plane_state *dm_new_plane_state;
+	struct drm_plane_state *new_plane_state;
+	struct dm_crtc_state *dm_new_crtc_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	int i;
+
+	if (!dm->cached_state)
+		return;
+
+	/* Force mode set in atomic commit */
+	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
+		new_crtc_state->active_changed = true;
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		reset_freesync_config_for_crtc(dm_new_crtc_state);
+	}
+
+	/*
+	 * atomic_check is expected to create the dc states. We need to release
+	 * them here, since they were duplicated as part of the suspend
+	 * procedure.
+	 */
+	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		if (dm_new_crtc_state->stream) {
+			WARN_ON(kref_read(&dm_new_crtc_state->stream->refcount) > 1);
+			dc_stream_release(dm_new_crtc_state->stream);
+			dm_new_crtc_state->stream = NULL;
+		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
+	}
+
+	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
+		dm_new_plane_state = to_dm_plane_state(new_plane_state);
+		if (dm_new_plane_state->dc_state) {
+			WARN_ON(kref_read(&dm_new_plane_state->dc_state->refcount) > 1);
+			dc_plane_state_release(dm_new_plane_state->dc_state);
+			dm_new_plane_state->dc_state = NULL;
+		}
+	}
+
+	drm_atomic_helper_resume(ddev, dm->cached_state);
+
+	dm->cached_state = NULL;
+}
+
+static void dm_complete(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	dm_destroy_cached_state(adev);
+}
+
 static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3306,12 +3364,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *new_crtc_state;
-	struct dm_crtc_state *dm_new_crtc_state;
-	struct drm_plane *plane;
-	struct drm_plane_state *new_plane_state;
-	struct dm_plane_state *dm_new_plane_state;
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
@@ -3470,40 +3522,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	}
 	drm_connector_list_iter_end(&iter);
 
-	/* Force mode set in atomic commit */
-	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
-		new_crtc_state->active_changed = true;
-		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-		reset_freesync_config_for_crtc(dm_new_crtc_state);
-	}
-
-	/*
-	 * atomic_check is expected to create the dc states. We need to release
-	 * them here, since they were duplicated as part of the suspend
-	 * procedure.
-	 */
-	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
-		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-		if (dm_new_crtc_state->stream) {
-			WARN_ON(kref_read(&dm_new_crtc_state->stream->refcount) > 1);
-			dc_stream_release(dm_new_crtc_state->stream);
-			dm_new_crtc_state->stream = NULL;
-		}
-		dm_new_crtc_state->base.color_mgmt_changed = true;
-	}
-
-	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-		dm_new_plane_state = to_dm_plane_state(new_plane_state);
-		if (dm_new_plane_state->dc_state) {
-			WARN_ON(kref_read(&dm_new_plane_state->dc_state->refcount) > 1);
-			dc_plane_state_release(dm_new_plane_state->dc_state);
-			dm_new_plane_state->dc_state = NULL;
-		}
-	}
-
-	drm_atomic_helper_resume(ddev, dm->cached_state);
-
-	dm->cached_state = NULL;
+	dm_destroy_cached_state(adev);
 
 	/* Do mst topology probing after resuming cached state*/
 	drm_connector_list_iter_begin(ddev, &iter);
@@ -3552,6 +3571,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.prepare_suspend = dm_prepare_suspend,
 	.suspend = dm_suspend,
 	.resume = dm_resume,
+	.complete = dm_complete,
 	.is_idle = dm_is_idle,
 	.wait_for_idle = dm_wait_for_idle,
 	.check_soft_reset = dm_check_soft_reset,
-- 
2.51.0


