Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1E7A39FB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbjIQT5U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbjIQT4t (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:56:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E9EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:56:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728EEC433C7;
        Sun, 17 Sep 2023 19:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980603;
        bh=VXGS6YsGhfKWDurSh0nHD9Jvh8eNrWsygFaY+9JPXhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1/B0T0rRg/1afHWKtOvew4G9i/AJQr1nuNMs3S42oJobXMTHXPf+CgroAEEPpQoU
         1qOk4ROx9HeCzyUUMXc3zdR8V1kFjJbeRPszbpr0VaLpcF+QUDK85cBb1r/35UHC6x
         IjtorGVBDi7U5BmcYv8eM5H3muqu+b37gId4211I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.5 241/285] drm/amdgpu: register a dirty framebuffer callback for fbcon
Date:   Sun, 17 Sep 2023 21:14:01 +0200
Message-ID: <20230917191059.712099168@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -529,11 +531,29 @@ bool amdgpu_display_ddc_probe(struct amd
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
@@ -1136,7 +1156,11 @@ static int amdgpu_display_gem_fb_verify_
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


