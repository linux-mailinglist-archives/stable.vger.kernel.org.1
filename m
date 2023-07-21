Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9646175BF8D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGUHW7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjGUHWo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC7FC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFBF661059
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DB4C433C8;
        Fri, 21 Jul 2023 07:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924154;
        bh=zP2IzdmokeACy/pq1j2GKJpRikB4pMk2RdWIiqi3p8U=;
        h=Subject:To:Cc:From:Date:From;
        b=DGU7BmgmIfJMKC9YrP/0vwgTBnYMW4ZkJ5Wuk6+AJpuHN3iIey5c9UA9gFDus9SAD
         Q/vzTE0VZa1kFDwHjIDUjlWQWVPLfYCFhAo1cjLEIwQJ607ybJ8dMxUcoARp6NJw32
         05kw44rMocDp+NWj4e4EJ0qrs/P1Le+TAajqAYEs=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix flickering caused by S/G mode" failed to apply to 6.4-stable tree
To:     hamza.mahfooz@amd.com, Roman.Li@amd.com, alexander.deucher@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:22:31 +0200
Message-ID: <2023072131-oncoming-ditzy-f611@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8f7f1b020ea641f21e7c88db55170a4d15834668
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072131-oncoming-ditzy-f611@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f7f1b020ea641f21e7c88db55170a4d15834668 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Fri, 14 Apr 2023 14:26:27 -0400
Subject: [PATCH] drm/amd/display: fix flickering caused by S/G mode

Currently, on a handful of ASICs. We allow the framebuffer for a given
plane to exist in either VRAM or GTT. However, if the plane's new
framebuffer is in a different memory domain than it's previous
framebuffer, flipping between them can cause the screen to flicker. So,
to fix this, don't perform an immediate flip in the aforementioned case.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
Reviewed-by: Roman Li <Roman.Li@amd.com>
Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)")
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 73b52bf76461..8a3c04ff9bff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7901,6 +7901,13 @@ static void amdgpu_dm_commit_cursors(struct drm_atomic_state *state)
 			amdgpu_dm_plane_handle_cursor_update(plane, old_plane_state);
 }
 
+static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
+{
+	struct amdgpu_bo *abo = gem_to_amdgpu_bo(fb->obj[0]);
+
+	return abo->tbo.resource ? abo->tbo.resource->mem_type : 0;
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct dc_state *dc_state,
 				    struct drm_device *dev,
@@ -8043,11 +8050,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		/*
 		 * Only allow immediate flips for fast updates that don't
-		 * change FB pitch, DCC state, rotation or mirroing.
+		 * change memory domain, FB pitch, DCC state, rotation or
+		 * mirroring.
 		 */
 		bundle->flip_addrs[planes_count].flip_immediate =
 			crtc->state->async_flip &&
-			acrtc_state->update_type == UPDATE_TYPE_FAST;
+			acrtc_state->update_type == UPDATE_TYPE_FAST &&
+			get_mem_type(old_plane_state->fb) == get_mem_type(fb);
 
 		timestamp_ns = ktime_get_ns();
 		bundle->flip_addrs[planes_count].flip_timestamp_in_us = div_u64(timestamp_ns, 1000);

