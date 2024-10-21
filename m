Return-Path: <stable+bounces-87108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58C9A6311
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC901C2189C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EEC1E32D7;
	Mon, 21 Oct 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdjTTESR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088F39FD6;
	Mon, 21 Oct 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506617; cv=none; b=AgQmpo1JVQFDLWUtnRRz+WQ8BDjqAXFAm6a1X/AU37hhY3YFTWIhvBr6LqXs49LI4sGJ/HWtp+B5hUe3JRLYc14JaDL0EvK6sB6lXteKhxINmm8Kw9MoRtW39Ldh2v6HDtItUVRcGlLGNUWwB17vId/8kvbDX8J+eiaSzc5l7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506617; c=relaxed/simple;
	bh=x5R7P4IOrQAsaa/HkuwcqR/SRbEOo7xY5m4Gqi9Fk5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaPKpwogkMAhUB4AQcr+o0/Ncrp5N7adm7LHYufFLnKOfvwH1GNL5ouWTfctaYmDJtOTbXz3b6zeK5BFU7SnhtNnr1olGO/8uIDDtC5SQ8ts6mHYcQIvhpHfqOd1Zf9644fIUOnhrp0TENtjCKd+F2YZB2GxK9AZI4qvTlTbBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdjTTESR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93858C4CEC3;
	Mon, 21 Oct 2024 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729506617;
	bh=x5R7P4IOrQAsaa/HkuwcqR/SRbEOo7xY5m4Gqi9Fk5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdjTTESRrMAf3tiJNdPvzxYgSbtSekMuqCyeaYWYXwHX2BX46ekjR9VGbsH0Wy6El
	 rmrbDiAvvpcLh/Furxq4v1u5qNIotPv8U0rGnVz6CjcER2gXofsodV0bmfc2xiN6pA
	 cWATS0faA8oi2cZI9k0kZuc6E9bWrR34nCDGQAaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dri-devel@lists.freedesktop.org,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Martin Krastev <martin.krastev@broadcom.com>
Subject: [PATCH 6.11 064/135] drm/vmwgfx: Cleanup kms setup without 3d
Date: Mon, 21 Oct 2024 12:23:40 +0200
Message-ID: <20241021102301.834286912@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
References: <20241021102259.324175287@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zack Rusin <zack.rusin@broadcom.com>

commit 512a9721cae0d88d34ff441f2f5917cd149af8af upstream.

Do not validate format equality for the non 3d cases to allow xrgb to
argb copies and make sure the dx binding flags are only used
on dx compatible surfaces.

Fixes basic 2d kms setup on configurations without 3d. There's little
practical benefit to it because kms framebuffer coherence is disabled
on configurations without 3d but with those changes the code actually
makes sense.

v2: Remove the now unused format variable

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Martin Krastev <martin.krastev@broadcom.com>
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240827043905.472825-1-zack.rusin@broadcom.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c     |   29 -----------------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |    9 ++++++---
 2 files changed, 6 insertions(+), 32 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1283,7 +1283,6 @@ static int vmw_kms_new_framebuffer_surfa
 {
 	struct drm_device *dev = &dev_priv->drm;
 	struct vmw_framebuffer_surface *vfbs;
-	enum SVGA3dSurfaceFormat format;
 	struct vmw_surface *surface;
 	int ret;
 
@@ -1320,34 +1319,6 @@ static int vmw_kms_new_framebuffer_surfa
 		return -EINVAL;
 	}
 
-	switch (mode_cmd->pixel_format) {
-	case DRM_FORMAT_ARGB8888:
-		format = SVGA3D_A8R8G8B8;
-		break;
-	case DRM_FORMAT_XRGB8888:
-		format = SVGA3D_X8R8G8B8;
-		break;
-	case DRM_FORMAT_RGB565:
-		format = SVGA3D_R5G6B5;
-		break;
-	case DRM_FORMAT_XRGB1555:
-		format = SVGA3D_A1R5G5B5;
-		break;
-	default:
-		DRM_ERROR("Invalid pixel format: %p4cc\n",
-			  &mode_cmd->pixel_format);
-		return -EINVAL;
-	}
-
-	/*
-	 * For DX, surface format validation is done when surface->scanout
-	 * is set.
-	 */
-	if (!has_sm4_context(dev_priv) && format != surface->metadata.format) {
-		DRM_ERROR("Invalid surface format for requested mode.\n");
-		return -EINVAL;
-	}
-
 	vfbs = kzalloc(sizeof(*vfbs), GFP_KERNEL);
 	if (!vfbs) {
 		ret = -ENOMEM;
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -2276,9 +2276,12 @@ int vmw_dumb_create(struct drm_file *fil
 	const struct SVGA3dSurfaceDesc *desc = vmw_surface_get_desc(format);
 	SVGA3dSurfaceAllFlags flags = SVGA3D_SURFACE_HINT_TEXTURE |
 				      SVGA3D_SURFACE_HINT_RENDERTARGET |
-				      SVGA3D_SURFACE_SCREENTARGET |
-				      SVGA3D_SURFACE_BIND_SHADER_RESOURCE |
-				      SVGA3D_SURFACE_BIND_RENDER_TARGET;
+				      SVGA3D_SURFACE_SCREENTARGET;
+
+	if (vmw_surface_is_dx_screen_target_format(format)) {
+		flags |= SVGA3D_SURFACE_BIND_SHADER_RESOURCE |
+			 SVGA3D_SURFACE_BIND_RENDER_TARGET;
+	}
 
 	/*
 	 * Without mob support we're just going to use raw memory buffer



