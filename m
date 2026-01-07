Return-Path: <stable+bounces-206160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F04CFEE4F
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F15F733D64DC
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C879366567;
	Wed,  7 Jan 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwwW2UIt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035EA366DDA
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800908; cv=none; b=MSKJ9ud9Nj/h+wTaehTeFtn6avdyyUufU0f6xTKgKGuc6vXcM4hLNap9w6jXb+8E03hmZbbzXFT2YmaI2MBR8sgsnWy3xFLQtif9WmBsTkw/3IDwtLezFS90XHZTmefwGbeS5JNunHs7WWTQetOLyn81Q9xgJ7aPaSp7EOJjtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800908; c=relaxed/simple;
	bh=C3MM0qDVq0p2kq1ix9xqPjyViAgaY/ZbaeVvy+41pU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K61Kc3JWqpFg8T8IHrrhZxpp7exgGwL3lfZUL8nuq7njIMWQH9qtiqRkqvEzprFT8W53c8Bxr0lRZDq/AVDR8CUeP04HcOsvbTDTX/WrlNv8op6+dfObEjZlsfNMV3XztU2XYYrYSnrIVncG0SGNSpHgt2Qac7LnO+5ybEp8XhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwwW2UIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB9BC4CEF1;
	Wed,  7 Jan 2026 15:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767800906;
	bh=C3MM0qDVq0p2kq1ix9xqPjyViAgaY/ZbaeVvy+41pU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwwW2UItoL+DFtXhJNh3V3p4e5IQlJd0AqIky60pJlf4d72YaNDNOFyt3ni5G9Hlk
	 suIXtrR/7LJ5XCyGHmfQ4KzTkjYsS2H5Q0ri1tWTqC+wc7NKeE5+CJQ7EgS+aDxOjF
	 NnJvUdTsatdXtewtDF7gnJNih00kLg4YCUTSrnbF6C91fFmPIYQiPqQRnAlnQa8Lk0
	 8493XZ/zR/vio+0gs7J4QjtqLyQF39+oV8EaL1Nv3zp5TDC548AQmVLR1e6xUUe/Y6
	 BSLcW73tre1q03reATwX37Us22Gsc+wZldTPqf2ZLw2dvYrdJPU+uk8SJsMTlErrHF
	 VZUlxjoQQnv/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Stefan Christ <contact@stefanchrist.eu>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/gma500: Remove unused helper psb_fbdev_fb_setcolreg()
Date: Wed,  7 Jan 2026 10:48:24 -0500
Message-ID: <20260107154824.4057632-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010529-blade-subsoil-11e8@gregkh>
References: <2026010529-blade-subsoil-11e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit be729f9de6c64240645dc80a24162ac4d3fe00a8 ]

Remove psb_fbdev_fb_setcolreg(), which hasn't been called in almost
a decade.

Gma500 commit 4d8d096e9ae8 ("gma500: introduce the framebuffer support
code") added the helper psb_fbdev_fb_setcolreg() for setting the fbdev
palette via fbdev's fb_setcolreg callback. Later
commit 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for
fb_ops") set several default helpers for fbdev emulation, including
fb_setcmap.

The fbdev subsystem always prefers fb_setcmap over fb_setcolreg. [1]
Hence, the gma500 code is no longer in use and gma500 has been using
drm_fb_helper_setcmap() for several years without issues.

Fixes: 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for fb_ops")
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Stefan Christ <contact@stefanchrist.eu>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.10+
Link: https://elixir.bootlin.com/linux/v6.16.9/source/drivers/video/fbdev/core/fbcmap.c#L246 # [1]
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Link: https://lore.kernel.org/r/20250929082338.18845-1-tzimmermann@suse.de
[ adapted patch from fbdev.c to framebuffer.c where the function was named psbfb_setcolreg() instead of psb_fbdev_fb_setcolreg() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gma500/framebuffer.c | 42 ----------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index aa3ecf771fd3..4eeec2471f35 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -35,47 +35,6 @@ static const struct drm_framebuffer_funcs psb_fb_funcs = {
 	.create_handle = drm_gem_fb_create_handle,
 };
 
-#define CMAP_TOHW(_val, _width) ((((_val) << (_width)) + 0x7FFF - (_val)) >> 16)
-
-static int psbfb_setcolreg(unsigned regno, unsigned red, unsigned green,
-			   unsigned blue, unsigned transp,
-			   struct fb_info *info)
-{
-	struct drm_fb_helper *fb_helper = info->par;
-	struct drm_framebuffer *fb = fb_helper->fb;
-	uint32_t v;
-
-	if (!fb)
-		return -ENOMEM;
-
-	if (regno > 255)
-		return 1;
-
-	red = CMAP_TOHW(red, info->var.red.length);
-	blue = CMAP_TOHW(blue, info->var.blue.length);
-	green = CMAP_TOHW(green, info->var.green.length);
-	transp = CMAP_TOHW(transp, info->var.transp.length);
-
-	v = (red << info->var.red.offset) |
-	    (green << info->var.green.offset) |
-	    (blue << info->var.blue.offset) |
-	    (transp << info->var.transp.offset);
-
-	if (regno < 16) {
-		switch (fb->format->cpp[0] * 8) {
-		case 16:
-			((uint32_t *) info->pseudo_palette)[regno] = v;
-			break;
-		case 24:
-		case 32:
-			((uint32_t *) info->pseudo_palette)[regno] = v;
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static vm_fault_t psbfb_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -146,7 +105,6 @@ static int psbfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 static const struct fb_ops psbfb_unaccel_ops = {
 	.owner = THIS_MODULE,
 	DRM_FB_HELPER_DEFAULT_OPS,
-	.fb_setcolreg = psbfb_setcolreg,
 	.fb_fillrect = drm_fb_helper_cfb_fillrect,
 	.fb_copyarea = drm_fb_helper_cfb_copyarea,
 	.fb_imageblit = drm_fb_helper_cfb_imageblit,
-- 
2.51.0


