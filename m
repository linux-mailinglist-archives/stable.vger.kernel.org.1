Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED6701548
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEMIiz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMIiy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 04:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2561D4C07
        for <stable@vger.kernel.org>; Sat, 13 May 2023 01:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF5106114E
        for <stable@vger.kernel.org>; Sat, 13 May 2023 08:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223F5C433D2;
        Sat, 13 May 2023 08:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683967126;
        bh=LmaNz9ygqhTXiT+bE2CrZml3RgsQ4zGISyTmhzliGYQ=;
        h=Subject:To:Cc:From:Date:From;
        b=X0BzF3BvW2oUczD1zYtFiK/+cVgW/3T1BMWzwmYHAlqnIXjixz17SCtCQKOw/HLkH
         nAa/VqqsMN3NyQBGA4HFHFreQ+TX7canQ4ClWBDSaQ9QqdCtrenzUjLvo77GlIbAGx
         WCxhQ1Bj3UjoHp2C/EcYCzr7aDZ1oEIO5pg24w3U=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix flickering caused by S/G mode" failed to apply to 5.10-stable tree
To:     hamza.mahfooz@amd.com, Roman.Li@amd.com, alexander.deucher@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 17:36:54 +0900
Message-ID: <2023051354-sculptor-harddisk-19a9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 08da182175db4c7f80850354849d95f2670e8cd9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051354-sculptor-harddisk-19a9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

08da182175db ("drm/amd/display: fix flickering caused by S/G mode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08da182175db4c7f80850354849d95f2670e8cd9 Mon Sep 17 00:00:00 2001
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
index b619d7cdb525..8d17fd5a817e 100644
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

