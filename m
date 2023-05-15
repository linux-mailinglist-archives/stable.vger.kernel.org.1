Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F227035E9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbjEOREn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbjEOREX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:04:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731248A62
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E273B62A73
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054EAC4339B;
        Mon, 15 May 2023 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170089;
        bh=mkHv8jNQ8YrbaDzIU1tB6Awa1EgljThdPhZyDaTQlmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDgB7/90SE6sdsGSaPqXybHEtTHLsXAtIW7PBs1hlvz8PkZ+aCat5No/lKNWSjtfD
         6Qkm/DehJKNM/0qgJQKBM8FQD6dhXeyCRewljZknq/7ixBmYOgcKIut1/lDRhjSPkb
         lPxNs+lVYqfzXDyO7JPobbMdvgL91UTeBPbDCurc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zack Rusin <zackr@vmware.com>,
        Maaz Mombasawala <mombasawalam@vmware.com>,
        Martin Krastev <krastevm@vmware.com>,
        Michael Banack <banackm@vmware.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/239] drm/vmwgfx: Remove explicit and broken vblank handling
Date:   Mon, 15 May 2023 18:24:26 +0200
Message-Id: <20230515161721.654019985@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zack Rusin <zackr@vmware.com>

[ Upstream commit 2e10cdc6e85de5998b0b140deff01765ceb92f64 ]

The explicit vblank handling was never finished. The driver never had
the full implementation of vblank and what was there is emulated
by DRM when the driver doesn't pretend to be implementing it itself.

Let DRM handle the vblank emulation and stop pretending the driver is
doing anything special with vblank. In the future it would make sense
to implement helpers for full vblank handling because vkms and
amdgpu_vkms already have that code. Exporting it to common helpers and
having all three drivers share it would make sense (that would be largely
just to allow more of igt to run).

Signed-off-by: Zack Rusin <zackr@vmware.com>
Reviewed-by: Maaz Mombasawala <mombasawalam@vmware.com>
Reviewed-by: Martin Krastev <krastevm@vmware.com>
Reviewed-by: Michael Banack <banackm@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20221022040236.616490-15-zack@kde.org
Stable-dep-of: a37a512db3fa ("drm/vmwgfx: Fix Legacy Display Unit atomic drm support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  |  3 ---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 34 ----------------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  8 -------
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 31 +------------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 26 ---------------------
 5 files changed, 1 insertion(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 0bc1ebc43002b..1ec9c53a7bf43 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1221,9 +1221,6 @@ int vmw_kms_write_svga(struct vmw_private *vmw_priv,
 bool vmw_kms_validate_mode_vram(struct vmw_private *dev_priv,
 				uint32_t pitch,
 				uint32_t height);
-u32 vmw_get_vblank_counter(struct drm_crtc *crtc);
-int vmw_enable_vblank(struct drm_crtc *crtc);
-void vmw_disable_vblank(struct drm_crtc *crtc);
 int vmw_kms_present(struct vmw_private *dev_priv,
 		    struct drm_file *file_priv,
 		    struct vmw_framebuffer *vfb,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 13721bcf047c0..d5c4da2b05b1a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -31,7 +31,6 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_sysfs.h>
-#include <drm/drm_vblank.h>
 
 #include "vmwgfx_kms.h"
 
@@ -832,15 +831,6 @@ void vmw_du_crtc_atomic_begin(struct drm_crtc *crtc,
 void vmw_du_crtc_atomic_flush(struct drm_crtc *crtc,
 			      struct drm_atomic_state *state)
 {
-	struct drm_pending_vblank_event *event = crtc->state->event;
-
-	if (event) {
-		crtc->state->event = NULL;
-
-		spin_lock_irq(&crtc->dev->event_lock);
-		drm_crtc_send_vblank_event(crtc, event);
-		spin_unlock_irq(&crtc->dev->event_lock);
-	}
 }
 
 
@@ -2158,30 +2148,6 @@ bool vmw_kms_validate_mode_vram(struct vmw_private *dev_priv,
 		 dev_priv->max_primary_mem : dev_priv->vram_size);
 }
 
-
-/*
- * Function called by DRM code called with vbl_lock held.
- */
-u32 vmw_get_vblank_counter(struct drm_crtc *crtc)
-{
-	return 0;
-}
-
-/*
- * Function called by DRM code called with vbl_lock held.
- */
-int vmw_enable_vblank(struct drm_crtc *crtc)
-{
-	return -EINVAL;
-}
-
-/*
- * Function called by DRM code called with vbl_lock held.
- */
-void vmw_disable_vblank(struct drm_crtc *crtc)
-{
-}
-
 /**
  * vmw_du_update_layout - Update the display unit with topology from resolution
  * plugin and generate DRM uevent
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index b8761f16dd785..a56e5d0ca3c65 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -28,7 +28,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_vblank.h>
 
 #include "vmwgfx_kms.h"
 
@@ -235,9 +234,6 @@ static const struct drm_crtc_funcs vmw_legacy_crtc_funcs = {
 	.atomic_duplicate_state = vmw_du_crtc_duplicate_state,
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
-	.get_vblank_counter = vmw_get_vblank_counter,
-	.enable_vblank = vmw_enable_vblank,
-	.disable_vblank = vmw_disable_vblank,
 };
 
 
@@ -507,10 +503,6 @@ int vmw_kms_ldu_init_display(struct vmw_private *dev_priv)
 	dev_priv->ldu_priv->last_num_active = 0;
 	dev_priv->ldu_priv->fb = NULL;
 
-	ret = drm_vblank_init(dev, num_display_units);
-	if (ret != 0)
-		goto err_free;
-
 	vmw_kms_create_implicit_placement_property(dev_priv);
 
 	for (i = 0; i < num_display_units; ++i) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index 9c79873f62f06..e1f36a09c59c1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -29,7 +29,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_vblank.h>
 
 #include "vmwgfx_kms.h"
 
@@ -320,9 +319,6 @@ static const struct drm_crtc_funcs vmw_screen_object_crtc_funcs = {
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.get_vblank_counter = vmw_get_vblank_counter,
-	.enable_vblank = vmw_enable_vblank,
-	.disable_vblank = vmw_disable_vblank,
 };
 
 /*
@@ -730,7 +726,6 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc *crtc = new_state->crtc;
-	struct drm_pending_vblank_event *event = NULL;
 	struct vmw_fence_obj *fence = NULL;
 	int ret;
 
@@ -754,24 +749,6 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
-	/* For error case vblank event is send from vmw_du_crtc_atomic_flush */
-	event = crtc->state->event;
-	if (event && fence) {
-		struct drm_file *file_priv = event->base.file_priv;
-
-		ret = vmw_event_fence_action_queue(file_priv,
-						   fence,
-						   &event->base,
-						   &event->event.vbl.tv_sec,
-						   &event->event.vbl.tv_usec,
-						   true);
-
-		if (unlikely(ret != 0))
-			DRM_ERROR("Failed to queue event on fence.\n");
-		else
-			crtc->state->event = NULL;
-	}
-
 	if (fence)
 		vmw_fence_obj_unreference(&fence);
 }
@@ -947,7 +924,7 @@ static int vmw_sou_init(struct vmw_private *dev_priv, unsigned unit)
 int vmw_kms_sou_init_display(struct vmw_private *dev_priv)
 {
 	struct drm_device *dev = &dev_priv->drm;
-	int i, ret;
+	int i;
 
 	/* Screen objects won't work if GMR's aren't available */
 	if (!dev_priv->has_gmr)
@@ -957,12 +934,6 @@ int vmw_kms_sou_init_display(struct vmw_private *dev_priv)
 		return -ENOSYS;
 	}
 
-	ret = -ENOMEM;
-
-	ret = drm_vblank_init(dev, VMWGFX_NUM_DISPLAY_UNITS);
-	if (unlikely(ret != 0))
-		return ret;
-
 	for (i = 0; i < VMWGFX_NUM_DISPLAY_UNITS; ++i)
 		vmw_sou_init(dev_priv, i);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 8650c3aea8f0a..0090abe892548 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -29,7 +29,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_vblank.h>
 
 #include "vmwgfx_kms.h"
 #include "vmw_surface_cache.h"
@@ -925,9 +924,6 @@ static const struct drm_crtc_funcs vmw_stdu_crtc_funcs = {
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.get_vblank_counter = vmw_get_vblank_counter,
-	.enable_vblank = vmw_enable_vblank,
-	.disable_vblank = vmw_disable_vblank,
 };
 
 
@@ -1591,7 +1587,6 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
 	struct drm_crtc *crtc = new_state->crtc;
 	struct vmw_screen_target_display_unit *stdu;
-	struct drm_pending_vblank_event *event;
 	struct vmw_fence_obj *fence = NULL;
 	struct vmw_private *dev_priv;
 	int ret;
@@ -1640,23 +1635,6 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
-	/* In case of error, vblank event is send in vmw_du_crtc_atomic_flush */
-	event = crtc->state->event;
-	if (event && fence) {
-		struct drm_file *file_priv = event->base.file_priv;
-
-		ret = vmw_event_fence_action_queue(file_priv,
-						   fence,
-						   &event->base,
-						   &event->event.vbl.tv_sec,
-						   &event->event.vbl.tv_usec,
-						   true);
-		if (ret)
-			DRM_ERROR("Failed to queue event on fence.\n");
-		else
-			crtc->state->event = NULL;
-	}
-
 	if (fence)
 		vmw_fence_obj_unreference(&fence);
 }
@@ -1883,10 +1861,6 @@ int vmw_kms_stdu_init_display(struct vmw_private *dev_priv)
 	if (!(dev_priv->capabilities & SVGA_CAP_GBOBJECTS))
 		return -ENOSYS;
 
-	ret = drm_vblank_init(dev, VMWGFX_NUM_DISPLAY_UNITS);
-	if (unlikely(ret != 0))
-		return ret;
-
 	dev_priv->active_display_unit = vmw_du_screen_target;
 
 	for (i = 0; i < VMWGFX_NUM_DISPLAY_UNITS; ++i) {
-- 
2.39.2



