Return-Path: <stable+bounces-224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472827F759F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01939281563
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF32C1B4;
	Fri, 24 Nov 2023 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdoemxCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE9286BF
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57476C433C8;
	Fri, 24 Nov 2023 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700833929;
	bh=Whg/ypPw374uXlKM2qKlDMjeE1EGMAFdlDRB3Sv3SFg=;
	h=Subject:To:Cc:From:Date:From;
	b=gdoemxCVodJsHCU3eKbrLPpdTE3FuXvqRH/nE6lphmGw/YAXgAcq1c/6xa+3P0zuA
	 L9Q0sn5gPMUg5XWgwl01ERlZCDV4AyoyYd/NLv7e6sbW6foxUYXww3CtLuZymbHC8U
	 lp8cCfJKODkTxaCrfG6GKvVpgMj3Sml0v0+LSNIM=
Subject: FAILED: patch "[PATCH] drm/amdgpu: register a dirty framebuffer callback for fbcon" failed to apply to 6.6-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:52:07 +0000
Message-ID: <2023112407-proposal-handbrake-772d@gregkh>
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
git cherry-pick -x 1c6b6bd0780f2f9e460567c4ccf1d69c3fb212cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112407-proposal-handbrake-772d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

1c6b6bd0780f ("drm/amdgpu: register a dirty framebuffer callback for fbcon")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c6b6bd0780f2f9e460567c4ccf1d69c3fb212cf Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Tue, 15 Aug 2023 09:13:37 -0400
Subject: [PATCH] drm/amdgpu: register a dirty framebuffer callback for fbcon

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index d20dd3f852fc..363e6a2cad8c 100644
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
@@ -532,11 +534,29 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
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
@@ -1139,7 +1159,11 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
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


