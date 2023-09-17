Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC917A3B7B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbjIQUSN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbjIQUSF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:18:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7958F1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:17:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E50C433C8;
        Sun, 17 Sep 2023 20:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981879;
        bh=SehNVzGmva21IZADFw45mq7V8Uw4oIweINHjbD2mdjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItqTo3BsaHJN3OFS5d8Ma/Y6jYMKuwq64c1SACk+8Geky24puVRF3paGiVD7RMQ0S
         uzO1nFsfzI+zjbVPSvPanaFgR7sm1ysiTnXsae+3xvGt2nKHjDJnCWPikw7Y5FxDMI
         TEwE+uMckV4cFSK+z7WKuPlf+GlLUQNzL1ZTg1CY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 184/219] drm/amdgpu: register a dirty framebuffer callback for fbcon
Date:   Sun, 17 Sep 2023 21:15:11 +0200
Message-ID: <20230917191047.603461873@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

commit 0a611560f53bfd489e33f4a718c915f1a6123d03 upstream.

fbcon requires that we implement &drm_framebuffer_funcs.dirty.
Otherwise, the framebuffer might take a while to flush (which would
manifest as noticeable lag). However, we can't enable this callback for
non-fbcon cases since it may cause too many atomic commits to be made at
once. So, implement amdgpu_dirtyfb() and only enable it for fbcon
framebuffers (we can use the "struct drm_file file" parameter in the
callback to check for this since it is only NULL when called by fbcon,
at least in the mainline kernel) on devices that support atomic KMS.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org # 6.1+
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2519
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -38,6 +38,8 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
@@ -493,11 +495,29 @@ bool amdgpu_display_ddc_probe(struct amd
 	return true;
 }
 
+static int amdgpu_dirtyfb(struct drm_framebuffer *fb, struct drm_file *file,
+			  unsigned int flags, unsigned int color,
+			  struct drm_clip_rect *clips, unsigned int num_clips)
+{
+
+	if (file)
+		return -ENOSYS;
+
+	return drm_atomic_helper_dirtyfb(fb, file, flags, color, clips,
+					 num_clips);
+}
+
 static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
 	.destroy = drm_gem_fb_destroy,
 	.create_handle = drm_gem_fb_create_handle,
 };
 
+static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
+	.destroy = drm_gem_fb_destroy,
+	.create_handle = drm_gem_fb_create_handle,
+	.dirty = amdgpu_dirtyfb
+};
+
 uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 					  uint64_t bo_flags)
 {
@@ -1100,7 +1120,11 @@ static int amdgpu_display_gem_fb_verify_
 	if (ret)
 		goto err;
 
-	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
+	if (drm_drv_uses_atomic_modeset(dev))
+		ret = drm_framebuffer_init(dev, &rfb->base,
+					   &amdgpu_fb_funcs_atomic);
+	else
+		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
 
 	if (ret)
 		goto err;


