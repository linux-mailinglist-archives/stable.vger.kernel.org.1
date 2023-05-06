Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE416F8EDE
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjEFFzi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjEFFzh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:55:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060914C00
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC2F6162F
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2365FC433D2;
        Sat,  6 May 2023 05:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352535;
        bh=oxv/Y+wJtnXpo6fvu4wEVepQmmj72e7GlIZ4i8+xM1A=;
        h=Subject:To:Cc:From:Date:From;
        b=eisJZl6vzv5Z+SRc0OXNbm1i1l4ULfLC3YS2y62KdLlBrJ4XpR9du40/muZVJksML
         aB9OSjGB0QHG+Yg4dMy0scHIvyRejhTcIzUJ3YPRdXLFLX/1VV3Zhi+Sz3j7CV/gEv
         verT6vTjuSpmnHHQF/zAolF14ihxq8xVhemoB3hE=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: Fix Legacy Display Unit atomic drm support" failed to apply to 5.10-stable tree
To:     krastevm@vmware.com, mombasawalam@vmware.com,
        stable@vger.kernel.org, zackr@vmware.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:02:21 +0900
Message-ID: <2023050621-flattery-unsworn-2e5d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x a37a512db3fa1b65fe9087003e5b2072cefb3667
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050621-flattery-unsworn-2e5d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a37a512db3fa1b65fe9087003e5b2072cefb3667 Mon Sep 17 00:00:00 2001
From: Martin Krastev <krastevm@vmware.com>
Date: Mon, 20 Mar 2023 22:09:49 -0400
Subject: [PATCH] drm/vmwgfx: Fix Legacy Display Unit atomic drm support

Legacy Display Unit (LDU) fb dirty support used a custom fb dirty callback. Latter
handled only the DIRTYFB IOCTL presentation path but not the ADDFB2/PAGE_FLIP/RMFB
IOCTL path, common for Wayland compositors.

Get rid of the custom callback in favor of drm_atomic_helper_dirtyfb and unify the
handling of the presentation paths inside of vmw_ldu_primary_plane_atomic_update.
This also homogenizes the fb dirty callbacks across all DUs: LDU, SOU and STDU.

Signed-off-by: Martin Krastev <krastevm@vmware.com>
Reviewed-by: Maaz Mombasawala <mombasawalam@vmware.com>
Fixes: 2f5544ff0300 ("drm/vmwgfx: Use atomic helper function for dirty fb IOCTL")
Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230321020949.335012-3-zack@kde.org

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 5162a7a12792..b62207be3363 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1396,70 +1396,10 @@ static void vmw_framebuffer_bo_destroy(struct drm_framebuffer *framebuffer)
 	kfree(vfbd);
 }
 
-static int vmw_framebuffer_bo_dirty(struct drm_framebuffer *framebuffer,
-				    struct drm_file *file_priv,
-				    unsigned int flags, unsigned int color,
-				    struct drm_clip_rect *clips,
-				    unsigned int num_clips)
-{
-	struct vmw_private *dev_priv = vmw_priv(framebuffer->dev);
-	struct vmw_framebuffer_bo *vfbd =
-		vmw_framebuffer_to_vfbd(framebuffer);
-	struct drm_clip_rect norect;
-	int ret, increment = 1;
-
-	drm_modeset_lock_all(&dev_priv->drm);
-
-	if (!num_clips) {
-		num_clips = 1;
-		clips = &norect;
-		norect.x1 = norect.y1 = 0;
-		norect.x2 = framebuffer->width;
-		norect.y2 = framebuffer->height;
-	} else if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY) {
-		num_clips /= 2;
-		increment = 2;
-	}
-
-	switch (dev_priv->active_display_unit) {
-	case vmw_du_legacy:
-		ret = vmw_kms_ldu_do_bo_dirty(dev_priv, &vfbd->base, 0, 0,
-					      clips, num_clips, increment);
-		break;
-	default:
-		ret = -EINVAL;
-		WARN_ONCE(true, "Dirty called with invalid display system.\n");
-		break;
-	}
-
-	vmw_cmd_flush(dev_priv, false);
-
-	drm_modeset_unlock_all(&dev_priv->drm);
-
-	return ret;
-}
-
-static int vmw_framebuffer_bo_dirty_ext(struct drm_framebuffer *framebuffer,
-					struct drm_file *file_priv,
-					unsigned int flags, unsigned int color,
-					struct drm_clip_rect *clips,
-					unsigned int num_clips)
-{
-	struct vmw_private *dev_priv = vmw_priv(framebuffer->dev);
-
-	if (dev_priv->active_display_unit == vmw_du_legacy &&
-	    vmw_cmd_supported(dev_priv))
-		return vmw_framebuffer_bo_dirty(framebuffer, file_priv, flags,
-						color, clips, num_clips);
-
-	return drm_atomic_helper_dirtyfb(framebuffer, file_priv, flags, color,
-					 clips, num_clips);
-}
-
 static const struct drm_framebuffer_funcs vmw_framebuffer_bo_funcs = {
 	.create_handle = vmw_framebuffer_bo_create_handle,
 	.destroy = vmw_framebuffer_bo_destroy,
-	.dirty = vmw_framebuffer_bo_dirty_ext,
+	.dirty = drm_atomic_helper_dirtyfb,
 };
 
 /**
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 3de7b4b6a230..db81e635dc06 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -507,11 +507,6 @@ void vmw_du_connector_destroy_state(struct drm_connector *connector,
  */
 int vmw_kms_ldu_init_display(struct vmw_private *dev_priv);
 int vmw_kms_ldu_close_display(struct vmw_private *dev_priv);
-int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
-			    struct vmw_framebuffer *framebuffer,
-			    unsigned int flags, unsigned int color,
-			    struct drm_clip_rect *clips,
-			    unsigned int num_clips, int increment);
 int vmw_kms_update_proxy(struct vmw_resource *res,
 			 const struct drm_clip_rect *clips,
 			 unsigned num_clips,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index c0e42f2ed144..a82fa9700370 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -275,6 +275,7 @@ static const struct drm_crtc_funcs vmw_legacy_crtc_funcs = {
 	.atomic_duplicate_state = vmw_du_crtc_duplicate_state,
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
 };
 
 
@@ -314,6 +315,12 @@ static const struct
 drm_connector_helper_funcs vmw_ldu_connector_helper_funcs = {
 };
 
+static int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
+				   struct vmw_framebuffer *framebuffer,
+				   unsigned int flags, unsigned int color,
+				   struct drm_mode_rect *clips,
+				   unsigned int num_clips);
+
 /*
  * Legacy Display Plane Functions
  */
@@ -332,7 +339,6 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
 	struct drm_framebuffer *fb;
 	struct drm_crtc *crtc = new_state->crtc ?: old_state->crtc;
 
-
 	ldu = vmw_crtc_to_ldu(crtc);
 	dev_priv = vmw_priv(plane->dev);
 	fb       = new_state->fb;
@@ -345,8 +351,31 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
 		vmw_ldu_del_active(dev_priv, ldu);
 
 	vmw_ldu_commit_list(dev_priv);
-}
 
+	if (vfb && vmw_cmd_supported(dev_priv)) {
+		struct drm_mode_rect fb_rect = {
+			.x1 = 0,
+			.y1 = 0,
+			.x2 = vfb->base.width,
+			.y2 = vfb->base.height
+		};
+		struct drm_mode_rect *damage_rects = drm_plane_get_damage_clips(new_state);
+		u32 rect_count = drm_plane_get_damage_clips_count(new_state);
+		int ret;
+
+		if (!damage_rects) {
+			damage_rects = &fb_rect;
+			rect_count = 1;
+		}
+
+		ret = vmw_kms_ldu_do_bo_dirty(dev_priv, vfb, 0, 0, damage_rects, rect_count);
+
+		drm_WARN_ONCE(plane->dev, ret,
+			"vmw_kms_ldu_do_bo_dirty failed with: ret=%d\n", ret);
+
+		vmw_cmd_flush(dev_priv, false);
+	}
+}
 
 static const struct drm_plane_funcs vmw_ldu_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
@@ -577,11 +606,11 @@ int vmw_kms_ldu_close_display(struct vmw_private *dev_priv)
 }
 
 
-int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
-			    struct vmw_framebuffer *framebuffer,
-			    unsigned int flags, unsigned int color,
-			    struct drm_clip_rect *clips,
-			    unsigned int num_clips, int increment)
+static int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
+				   struct vmw_framebuffer *framebuffer,
+				   unsigned int flags, unsigned int color,
+				   struct drm_mode_rect *clips,
+				   unsigned int num_clips)
 {
 	size_t fifo_size;
 	int i;
@@ -597,7 +626,7 @@ int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
 		return -ENOMEM;
 
 	memset(cmd, 0, fifo_size);
-	for (i = 0; i < num_clips; i++, clips += increment) {
+	for (i = 0; i < num_clips; i++, clips++) {
 		cmd[i].header = SVGA_CMD_UPDATE;
 		cmd[i].body.x = clips->x1;
 		cmd[i].body.y = clips->y1;

