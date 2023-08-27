Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E78789B8B
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjH0GmP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 02:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjH0Gln (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 02:41:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC25197
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 23:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3239460A6F
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 06:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D63C433C8;
        Sun, 27 Aug 2023 06:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693118499;
        bh=cmqwyMJRCAxM90n/+nCKt/JrbstXFNHAtWsX1k/FIso=;
        h=Subject:To:Cc:From:Date:From;
        b=UKDTYCYmM+aQ3JDqdy39LfvT1u7pHvFLWpvTeOXXrGOWycJZhxT571OfCWUgA65yy
         Tp0UwS+zhBu3fP4JPwqk0PmtDiH+cr0HJA+Y1TMIuIMcufK3JrIaawgnc+eXAxeXA1
         MOCC7GxUj8KZOD+VvhdCYtlkwOLgTlTzvdyqZNs8=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: Fix possible invalid drm gem put calls" failed to apply to 6.1-stable tree
To:     zackr@vmware.com, iforbes@vmware.com, mombasawalam@vmware.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 27 Aug 2023 08:41:36 +0200
Message-ID: <2023082736-canal-swimsuit-6b7b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f9e96bf1905479f18e83a3a4c314a8dfa56ede2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082736-canal-swimsuit-6b7b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f9e96bf19054 ("drm/vmwgfx: Fix possible invalid drm gem put calls")
9ef8d83e8e25 ("drm/vmwgfx: Do not drop the reference to the handle too soon")
668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
39985eea5a6d ("drm/vmwgfx: Abstract placement selection")
e0029da927fa ("drm/vmwgfx: Rename dummy to is_iomem")
cb8097a45da1 ("drm/vmwgfx: Cleanup the vmw bo usage in the cursor paths")
6703e28f976d ("drm/vmwgfx: Simplify fb pinning")
09881d2940bb ("drm/vmwgfx: Rename vmw_buffer_object to vmw_bo")
6b2e8aa45126 ("drm/vmwgfx: Remove the duplicate bo_free function")
f87c1f0b7b79 ("drm/ttm: prevent moving of pinned BOs")
aebd8f0c6f82 ("Merge v6.2-rc6 into drm-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9e96bf1905479f18e83a3a4c314a8dfa56ede2c Mon Sep 17 00:00:00 2001
From: Zack Rusin <zackr@vmware.com>
Date: Fri, 18 Aug 2023 00:13:01 -0400
Subject: [PATCH] drm/vmwgfx: Fix possible invalid drm gem put calls

vmw_bo_unreference sets the input buffer to null on exit, resulting in
null ptr deref's on the subsequent drm gem put calls.

This went unnoticed because only very old userspace would be exercising
those paths but it wouldn't be hard to hit on old distros with brand
new kernels.

Introduce a new function that abstracts unrefing of user bo's to make
the code cleaner and more explicit.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Reported-by: Ian Forbes <iforbes@vmware.com>
Fixes: 9ef8d83e8e25 ("drm/vmwgfx: Do not drop the reference to the handle too soon")
Cc: <stable@vger.kernel.org> # v6.4+
Reviewed-by: Maaz Mombasawala<mombasawalam@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230818041301.407636-1-zack@kde.org

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 82094c137855..c43853597776 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -497,10 +497,9 @@ static int vmw_user_bo_synccpu_release(struct drm_file *filp,
 		if (!(flags & drm_vmw_synccpu_allow_cs)) {
 			atomic_dec(&vmw_bo->cpu_writers);
 		}
-		ttm_bo_put(&vmw_bo->tbo);
+		vmw_user_bo_unref(vmw_bo);
 	}
 
-	drm_gem_object_put(&vmw_bo->tbo.base);
 	return ret;
 }
 
@@ -540,8 +539,7 @@ int vmw_user_bo_synccpu_ioctl(struct drm_device *dev, void *data,
 			return ret;
 
 		ret = vmw_user_bo_synccpu_grab(vbo, arg->flags);
-		vmw_bo_unreference(&vbo);
-		drm_gem_object_put(&vbo->tbo.base);
+		vmw_user_bo_unref(vbo);
 		if (unlikely(ret != 0)) {
 			if (ret == -ERESTARTSYS || ret == -EBUSY)
 				return -EBUSY;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
index 50a836e70994..1d433fceed3d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
@@ -195,6 +195,14 @@ static inline struct vmw_bo *vmw_bo_reference(struct vmw_bo *buf)
 	return buf;
 }
 
+static inline void vmw_user_bo_unref(struct vmw_bo *vbo)
+{
+	if (vbo) {
+		ttm_bo_put(&vbo->tbo);
+		drm_gem_object_put(&vbo->tbo.base);
+	}
+}
+
 static inline struct vmw_bo *to_vmw_bo(struct drm_gem_object *gobj)
 {
 	return container_of((gobj), struct vmw_bo, tbo.base);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index d30c0e3d3ab7..98e0723ca6f5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1164,8 +1164,7 @@ static int vmw_translate_mob_ptr(struct vmw_private *dev_priv,
 	}
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_MOB, VMW_BO_DOMAIN_MOB);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
-	ttm_bo_put(&vmw_bo->tbo);
-	drm_gem_object_put(&vmw_bo->tbo.base);
+	vmw_user_bo_unref(vmw_bo);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -1221,8 +1220,7 @@ static int vmw_translate_guest_ptr(struct vmw_private *dev_priv,
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM,
 			     VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
-	ttm_bo_put(&vmw_bo->tbo);
-	drm_gem_object_put(&vmw_bo->tbo.base);
+	vmw_user_bo_unref(vmw_bo);
 	if (unlikely(ret != 0))
 		return ret;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index b62207be3363..1489ad73c103 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1665,10 +1665,8 @@ static struct drm_framebuffer *vmw_kms_fb_create(struct drm_device *dev,
 
 err_out:
 	/* vmw_user_lookup_handle takes one ref so does new_fb */
-	if (bo) {
-		vmw_bo_unreference(&bo);
-		drm_gem_object_put(&bo->tbo.base);
-	}
+	if (bo)
+		vmw_user_bo_unref(bo);
 	if (surface)
 		vmw_surface_unreference(&surface);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index 7e112319a23c..fb85f244c3d0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -451,8 +451,7 @@ int vmw_overlay_ioctl(struct drm_device *dev, void *data,
 
 	ret = vmw_overlay_update_stream(dev_priv, buf, arg, true);
 
-	vmw_bo_unreference(&buf);
-	drm_gem_object_put(&buf->tbo.base);
+	vmw_user_bo_unref(buf);
 
 out_unlock:
 	mutex_unlock(&overlay->mutex);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index e7226db8b242..1e81ff2422cf 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -809,8 +809,7 @@ static int vmw_shader_define(struct drm_device *dev, struct drm_file *file_priv,
 				    shader_type, num_input_sig,
 				    num_output_sig, tfile, shader_handle);
 out_bad_arg:
-	vmw_bo_unreference(&buffer);
-	drm_gem_object_put(&buffer->tbo.base);
+	vmw_user_bo_unref(buffer);
 	return ret;
 }
 

