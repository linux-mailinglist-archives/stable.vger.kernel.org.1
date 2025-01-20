Return-Path: <stable+bounces-109539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A3A16E0C
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDDE3AAA1E
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005A21E32BE;
	Mon, 20 Jan 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fkPELxK+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E91E32C5
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381641; cv=none; b=fbYz2c9d8O9UMFSXxP9/WW6GE4ruiKFSGhoi1VHBP+Ixm5mqvZ2KQYmHOJL8lqyYqLu7ev/QRgnnP0pLcnWZXzWI1wvpxBKMF9TKEJiwAYnV+gKiwUXhjUbqpfArK2kOCwJ4m4cctcvINMtr5eMYIXsfkrJRwu5zagoHGNzf1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381641; c=relaxed/simple;
	bh=Ffg+lLWqcld/M2n5a6e1f7FEyOGQ4uqKfmtCcyZ+4/w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LPI+Rvc3iDUaEq9p7ICNniTQiCRQ3RvDfcKCeTNza2SYXX0s6jXCzPInZY4Btkj9VIYKWcJVSxHCTYqGGGibUTd6YZsNIyeFsSHctaAs0DW2IEtVi377nVBcjJhxm2cvaveWT4y+txV4tYLtOnHaoomF+8jwz4IGKQIWHwXk3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fkPELxK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A40C4CEDD;
	Mon, 20 Jan 2025 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737381641;
	bh=Ffg+lLWqcld/M2n5a6e1f7FEyOGQ4uqKfmtCcyZ+4/w=;
	h=Subject:To:Cc:From:Date:From;
	b=fkPELxK+rJnHqyYG/LUxszmyAfdnYdntxLQzX/cB8Gkr9UHvwYwaqQX+aLDoq6J1d
	 OoScyL0b69vIET1r3XLDcjmIaLNmR7eJcJKERyOIcEuFNM7RL47d43JuoDl3822vOj
	 z9qO6AYB4nJWORSBtWeT0g+SnpHE7BgcZ7h5m9os=
Subject: FAILED: patch "[PATCH] drm/amd/display: Do not elevate mem_type change to full" failed to apply to 6.1-stable tree
To: sunpeng.li@amd.com,alexander.deucher@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 15:00:31 +0100
Message-ID: <2025012030-alongside-scenic-3cc9@gregkh>
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
git cherry-pick -x 35ca53b7b0f0ffd16c6675fd76abac9409cf83e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012030-alongside-scenic-3cc9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 35ca53b7b0f0ffd16c6675fd76abac9409cf83e0 Mon Sep 17 00:00:00 2001
From: Leo Li <sunpeng.li@amd.com>
Date: Wed, 11 Dec 2024 12:06:24 -0500
Subject: [PATCH] drm/amd/display: Do not elevate mem_type change to full
 update

[Why]

There should not be any need to revalidate bandwidth on memory placement
change, since the fb is expected to be pinned to DCN-accessable memory
before scanout. For APU it's DRAM, and DGPU, it's VRAM. However, async
flips + memory type change needs to be rejected.

[How]

Do not set lock_and_validation_needed on mem_type change. Instead,
reject an async_flip request if the crtc's buffer(s) changed mem_type.

This may fix stuttering/corruption experienced with PSR SU and PSR1
panels, if the compositor allocates fbs in both VRAM carveout and GTT
and flips between them.

Fixes: a7c0cad0dc06 ("drm/amd/display: ensure async flips are only accepted for fast updates")
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4caacd1671b7a013ad04cd8b6398f002540bdd4d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 56b47e02db0b..dcc5d8ded662 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11379,6 +11379,25 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
+					    struct drm_atomic_state *state,
+					    struct drm_crtc_state *crtc_state)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *new_plane_state, *old_plane_state;
+
+	drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
+		new_plane_state = drm_atomic_get_plane_state(state, plane);
+		old_plane_state = drm_atomic_get_plane_state(state, plane);
+
+		if (old_plane_state->fb && new_plane_state->fb &&
+		    get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
  *
@@ -11576,10 +11595,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 	/* Remove exiting planes if they are modified */
 	for_each_oldnew_plane_in_descending_zpos(state, plane, old_plane_state, new_plane_state) {
-		if (old_plane_state->fb && new_plane_state->fb &&
-		    get_mem_type(old_plane_state->fb) !=
-		    get_mem_type(new_plane_state->fb))
-			lock_and_validation_needed = true;
 
 		ret = dm_update_plane_state(dc, state, plane,
 					    old_plane_state,
@@ -11874,9 +11889,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		/*
 		 * Only allow async flips for fast updates that don't change
-		 * the FB pitch, the DCC state, rotation, etc.
+		 * the FB pitch, the DCC state, rotation, mem_type, etc.
 		 */
-		if (new_crtc_state->async_flip && lock_and_validation_needed) {
+		if (new_crtc_state->async_flip &&
+		    (lock_and_validation_needed ||
+		     amdgpu_dm_crtc_mem_type_changed(dev, state, new_crtc_state))) {
 			drm_dbg_atomic(crtc->dev,
 				       "[CRTC:%d:%s] async flips are only supported for fast updates\n",
 				       crtc->base.id, crtc->name);


