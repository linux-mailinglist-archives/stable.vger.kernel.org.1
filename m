Return-Path: <stable+bounces-109538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CB2A16E07
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C841D169B06
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5A81E32DC;
	Mon, 20 Jan 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SAZfgFOn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837681E32BE
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381633; cv=none; b=IYtJh2+q8zsnutA4aa66jM7bZgTqrakST1c+8U2Eb8+NqbTk8Tb5039WQyNN+lk6TQG/UMQITNqjF1T5wa5Fe+3WAx0+j3OOhqC5ECpY/ObveM/kdX+rbEWKGywVXftnGIZOvQaahgDQ/HdR8oXPLGM3LQaMY2Sn25YIYaalmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381633; c=relaxed/simple;
	bh=nRSE/BCq1lUAsuJxoEWYLpdVsG5QBvWkTyXlD3YxP0Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qPKGKriIVWUtkrF3tXlBnogo4tzXAnmDTY0rtMWke1g1hlZFI74ssj48WO9kARNlQp2hVBm/t4HAb+nGFnA/IvlFDKzUBtVMz5Qg+NgBfelGuxnS/yHapl1glmcTc9Pejn3mc2RLMkAh2ULTxYtuPUgVydqDo48I0mNuUA2LzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SAZfgFOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A537FC4CEDD;
	Mon, 20 Jan 2025 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737381633;
	bh=nRSE/BCq1lUAsuJxoEWYLpdVsG5QBvWkTyXlD3YxP0Q=;
	h=Subject:To:Cc:From:Date:From;
	b=SAZfgFOnpLVZcGVeoK88bKBqVVOIOEq6epQhgs9Oz2okqIh8WPO6so/E/j0SZheo9
	 27zmjMmEMz8jvXLrllJm8kO8DUUdNdpz14z5IMwfqKD+4idZKqM7VLPMwqDFt/eivG
	 VThDHKXT/4VSV8tx36asUxgym0NkbCrEDrq4jyCA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Do not elevate mem_type change to full" failed to apply to 6.6-stable tree
To: sunpeng.li@amd.com,alexander.deucher@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 15:00:30 +0100
Message-ID: <2025012030-xerox-tremor-f7d9@gregkh>
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
git cherry-pick -x 35ca53b7b0f0ffd16c6675fd76abac9409cf83e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012030-xerox-tremor-f7d9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


