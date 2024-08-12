Return-Path: <stable+bounces-66660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783394F09B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432A21F216C2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54C117995B;
	Mon, 12 Aug 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MDNnXxi9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972524B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474314; cv=none; b=Nnasev3/4Xi73EvFYdka25W8Lo3kJW3it+n0gLk6FqiaPa6hSHQ+mwk+J52c+AevGNSdg4nmNumqFKux5BPcCiAl1xNLEes5Os3em4OiXHBQ2434OlyKb4CpFiSFgW0WM4ljpYUsZ24R9cxIux4m56qubMvHwn3ie86i+m1jt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474314; c=relaxed/simple;
	bh=Tkd7za6VKolh6Nku4YH/r0rn/AUUCTJXE3yMIPt0vF0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FfrPfkhsxAFwVe+I7hsGc7N3k/qoEMi0sL8q8KKH7lN9nlbym5gBvSTpq/ppD2J1stOEYxACb53wewnDSHQKgzcvWWkYR06rqBWqeZoOx27H+GAkSguFNzURX//zBlu0zxccs7BU5CZBZlQPa1OmkEcq5uxLMDXS9Uw6f58tpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MDNnXxi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063A4C32782;
	Mon, 12 Aug 2024 14:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474314;
	bh=Tkd7za6VKolh6Nku4YH/r0rn/AUUCTJXE3yMIPt0vF0=;
	h=Subject:To:Cc:From:Date:From;
	b=MDNnXxi96QugxsLtYenktzQ/nkz7rKGUH/sEX8ieLdFbVRjFCRK4niDJ3LqJHxWFW
	 8e4BeOubAi353yWxRMsRNJ29WDpguGcATxtN1PgZ3iMbB7iOPHTXSYKrhySi2Qrb5V
	 8AhaN5SRwszf7DjQoWQrMoTB/6Fg4XIcDE45wnWE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use sw cursor for DCN401 with rotation" failed to apply to 4.19-stable tree
To: aurabindo.pillai@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,rodrigo.siqueira@amd.com,sunpeng.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:49:42 +0200
Message-ID: <2024081242-unveiling-sedative-231a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2ffa97c50a8b0598975e47c890032e71958425a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081242-unveiling-sedative-231a@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

2ffa97c50a8b ("drm/amd/display: Use sw cursor for DCN401 with rotation")
1b04dcca4fb1 ("drm/amd/display: Introduce overlay cursor mode")
730ac573868b ("drm/amd/display: Convert some legacy DRM debug macros into appropriate categories")
e582c097d3d1 ("drm/amd/display: Always use legacy way of setting cursor on DCE")
66eba12a5482 ("drm/amd/display: Do cursor programming with rest of pipe")
f63f86b5affc ("drm/amd/display: Separate setting and programming of cursor")
27f03bc680ef ("drm/amd/display: Guard cursor idle reallow by DC debug option")
0701117efd1e ("Revert "drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel"")
1b5b72b4d67c ("drm/amd/display: Fix MST Null Ptr for RV")
a9b1a4f684b3 ("drm/amd/display: Add more checks for exiting idle in DC")
dcbf438d4834 ("drm/amd/display: Unify optimize_required flags and VRR adjustments")
8457bddc266c ("drm/amd/display: Revert "Rework DC Z10 restore"")
e6f82bd44b40 ("drm/amd/display: Rework DC Z10 restore")
a465536ebff8 ("drm/amd/display: revert "Optimize VRR updates to only necessary ones"")
012a04b1d6af ("drm/amd/display: Refactor phantom resource allocation")
09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")
8e57c06bf4b0 ("drm/amd/display: Refactor DMCUB enter/exit idle interface")
6e4337f695c2 ("drm/amd/display: Unify optimize_required flags and VRR adjustments")
0f657938e434 ("drm/amd/display: do not send commands to DMUB if DMUB is inactive from S3")
0f5afa190b89 ("drm/amd/display: add CRTC gamma TF driver-specific property")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ffa97c50a8b0598975e47c890032e71958425a0 Mon Sep 17 00:00:00 2001
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Date: Mon, 10 Jun 2024 18:22:59 +0000
Subject: [PATCH] drm/amd/display: Use sw cursor for DCN401 with rotation

[WHAT & HOW]
On DCN401, the cursor composition to the plane happens after scaler.
So the cursor isn't stretched with the rest of the surface. Temporarily
disable hardware cursor in case when hardware rotation is enabled
such that userspace falls back to software cursor.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cefc2569a50f..6e757ee2d74b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11093,8 +11093,12 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	int cursor_scale_w, cursor_scale_h;
 	int i;
 
-	/* Overlay cursor not supported on HW before DCN */
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
+	/* Overlay cursor not supported on HW before DCN
+	 * DCN401 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
+	 * as previous DCN generations, so enable native mode on DCN401 in addition to DCE
+	 */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0 ||
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
 		*cursor_mode = DM_CURSOR_NATIVE_MODE;
 		return 0;
 	}
@@ -11237,7 +11241,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct drm_plane *plane;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct drm_plane_state *old_plane_state, *new_plane_state, *new_cursor_state;
 	enum dc_status status;
 	int ret, i;
 	bool lock_and_validation_needed = false;
@@ -11465,19 +11469,39 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			drm_dbg_atomic(dev, "MPO enablement requested on crtc:[%p]\n", crtc);
 	}
 
-	/* Check cursor planes restrictions */
+	/* Check cursor restrictions */
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		enum amdgpu_dm_cursor_mode required_cursor_mode;
+		int is_rotated, is_scaled;
 
 		/* Overlay cusor not subject to native cursor restrictions */
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
 			continue;
 
+		/* Check if rotation or scaling is enabled on DCN401 */
+		if ((drm_plane_mask(crtc->cursor) & new_crtc_state->plane_mask) &&
+		    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
+			new_cursor_state = drm_atomic_get_new_plane_state(state, crtc->cursor);
+
+			is_rotated = new_cursor_state &&
+				((new_cursor_state->rotation & DRM_MODE_ROTATE_MASK) != DRM_MODE_ROTATE_0);
+			is_scaled = new_cursor_state && ((new_cursor_state->src_w >> 16 != new_cursor_state->crtc_w) ||
+				(new_cursor_state->src_h >> 16 != new_cursor_state->crtc_h));
+
+			if (is_rotated || is_scaled) {
+				drm_dbg_driver(
+					crtc->dev,
+					"[CRTC:%d:%s] cannot enable hardware cursor due to rotation/scaling\n",
+					crtc->base.id, crtc->name);
+				ret = -EINVAL;
+				goto fail;
+			}
+		}
+
 		/* If HW can only do native cursor, check restrictions again */
 		ret = dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
 					      &required_cursor_mode);
-
 		if (ret) {
 			drm_dbg_driver(crtc->dev,
 				       "[CRTC:%d:%s] Checking cursor mode failed\n",


