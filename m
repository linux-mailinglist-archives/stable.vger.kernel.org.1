Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7C79AF44
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbjIKVGl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbjIKPGu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:06:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BD7CCC
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:06:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D82CC433C9;
        Mon, 11 Sep 2023 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444805;
        bh=wPyDfPWbr6ka6WjEUtrAuB+iVBAyeeRTl7ZPEwnjMI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCsCMU32X0GQ7848DQs365SOimREZCNyP7WG6b8rNKGEptT9d3wttR9Pkem+Px0GN
         qL3SZJbniC77VqPQYk0iypB6TG2GMv7LFFr9Y1SYsGtDha612WcUrPdWxdZSUPALTd
         Fvw1TQZea9sjnz1vLAVAiNEXAv4f84A5VdtrBM8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 085/600] drm/amd/display: ensure async flips are only accepted for fast updates
Date:   Mon, 11 Sep 2023 15:41:58 +0200
Message-ID: <20230911134636.121754356@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

commit a7c0cad0dc060bb77e9c9d235d68441b0fc69507 upstream.

We should be checking to see if async flips are supported in
amdgpu_dm_atomic_check() (i.e. not dm_crtc_helper_atomic_check()). Also,
async flipping isn't supported if a plane's framebuffer changes memory
domains during an atomic commit. So, move the check from
dm_crtc_helper_atomic_check() to amdgpu_dm_atomic_check() and check if
the memory domain has changed in amdgpu_dm_atomic_check().

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2733
Fixes: c1e18c44dc7f ("drm/amd/display: only accept async flips for fast updates")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |   24 ++++++++++++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   12 --------
 2 files changed, 21 insertions(+), 15 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7858,10 +7858,12 @@ static void amdgpu_dm_commit_planes(stru
 		 * fast updates.
 		 */
 		if (crtc->state->async_flip &&
-		    acrtc_state->update_type != UPDATE_TYPE_FAST)
+		    (acrtc_state->update_type != UPDATE_TYPE_FAST ||
+		     get_mem_type(old_plane_state->fb) != get_mem_type(fb)))
 			drm_warn_once(state->dev,
 				      "[PLANE:%d:%s] async flip with non-fast update\n",
 				      plane->base.id, plane->name);
+
 		bundle->flip_addrs[planes_count].flip_immediate =
 			crtc->state->async_flip &&
 			acrtc_state->update_type == UPDATE_TYPE_FAST &&
@@ -9813,6 +9815,11 @@ static int amdgpu_dm_atomic_check(struct
 
 	/* Remove exiting planes if they are modified */
 	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
+		if (old_plane_state->fb && new_plane_state->fb &&
+		    get_mem_type(old_plane_state->fb) !=
+		    get_mem_type(new_plane_state->fb))
+			lock_and_validation_needed = true;
+
 		ret = dm_update_plane_state(dc, state, plane,
 					    old_plane_state,
 					    new_plane_state,
@@ -10064,9 +10071,20 @@ static int amdgpu_dm_atomic_check(struct
 		struct dm_crtc_state *dm_new_crtc_state =
 			to_dm_crtc_state(new_crtc_state);
 
+		/*
+		 * Only allow async flips for fast updates that don't change
+		 * the FB pitch, the DCC state, rotation, etc.
+		 */
+		if (new_crtc_state->async_flip && lock_and_validation_needed) {
+			drm_dbg_atomic(crtc->dev,
+				       "[CRTC:%d:%s] async flips are only supported for fast updates\n",
+				       crtc->base.id, crtc->name);
+			ret = -EINVAL;
+			goto fail;
+		}
+
 		dm_new_crtc_state->update_type = lock_and_validation_needed ?
-							 UPDATE_TYPE_FULL :
-							 UPDATE_TYPE_FAST;
+			UPDATE_TYPE_FULL : UPDATE_TYPE_FAST;
 	}
 
 	/* Must be success */
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -406,18 +406,6 @@ static int dm_crtc_helper_atomic_check(s
 		return -EINVAL;
 	}
 
-	/*
-	 * Only allow async flips for fast updates that don't change the FB
-	 * pitch, the DCC state, rotation, etc.
-	 */
-	if (crtc_state->async_flip &&
-	    dm_crtc_state->update_type != UPDATE_TYPE_FAST) {
-		drm_dbg_atomic(crtc->dev,
-			       "[CRTC:%d:%s] async flips are only supported for fast updates\n",
-			       crtc->base.id, crtc->name);
-		return -EINVAL;
-	}
-
 	/* In some use cases, like reset, no stream is attached */
 	if (!dm_crtc_state->stream)
 		return 0;


