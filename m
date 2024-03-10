Return-Path: <stable+bounces-27216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9D87777E
	for <lists+stable@lfdr.de>; Sun, 10 Mar 2024 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9247C1C209CD
	for <lists+stable@lfdr.de>; Sun, 10 Mar 2024 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F533771E;
	Sun, 10 Mar 2024 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIz5U4Zm"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA51374D1
	for <stable@vger.kernel.org>; Sun, 10 Mar 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710084581; cv=none; b=T5wiUIInKLbN/eQwbiYmDGPbC8oVjSTIQT1yrJNgVhC+/I8KyPqUzABV1xwQrQFdj5m7IzRyWA+mMVSHv/sKmFcYUWV3jcX6Wm0WztC5x9r0nw4WRacLaCsorWxfkQ4e+CFFO59lLrhQy6csytvX709/cWS3z1rJJN+yz1QAPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710084581; c=relaxed/simple;
	bh=QRhsEiFtqdqt/h4rY0EMxat5Sl6En8prG7Kx7893nps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XtF3IiU7Af5I1CGEo+girF6ARNJNDOViXHQZYfGmlXjl7rX2+21UwTNoHs/QlukKwhQKU5KaDmogz5foDWe36VOBOZLHQRnvp3Sl8G1K02/i2P6uSqGmmlxydRVYvrrfJ27gcWWOZcljoiekKPULiLY2XNk1O0vKrbPPdzCAuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIz5U4Zm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513298d6859so3239081e87.3
        for <stable@vger.kernel.org>; Sun, 10 Mar 2024 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710084577; x=1710689377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K6H55q1iw/mSiSbGdXBAQ1bJbWPVp1l+9lky4PtCrOI=;
        b=HIz5U4ZmyCbglxnMRvXV9rBQuGJ7eJ3srf0Hr5NHVBKS+iqBvFPrCkelamJJxwSGvs
         yEAZ0F6OJT3xc+76Ye8WhTnOQS/1MxYfJS3ScDCX3yuJjoP3e7mZmXL2Yri+9/Mx7HXF
         SjkMUsDo9Bk5B3nA94FI8HpbtDLheg5j6lPo9WEE73xymm411tj9IiSndRyzRGCyxkTU
         L6yWtfkJgKTACiqPLOi6Qgys9jwpD8z8Wxr+zUkBdld2alQEMXIBU+Iu5AK/4R716IAy
         B9mo8Umg6HJNJikaMfQW/mbldRmwfyjqmEmV/fsuwiUG5L/va+ywnbyi4HSzZDE7CJ4n
         IGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710084577; x=1710689377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6H55q1iw/mSiSbGdXBAQ1bJbWPVp1l+9lky4PtCrOI=;
        b=hI7yy0nbHumQ7uFHajRi90nMak0AQhLMN2g1qNnbquUXTuZmbtEE/pkKKDQ7c4+lUy
         M8jUJOCEhuR6wakWUhvQ7p+8lEIe2tXhA44o44fkPxHLhBsBUBgW5m6efMsXivsjWX51
         Lv6vMtjvHzY3hhW5sW9sUosRIL/vWVE5KKC7yU3+sNTk/7gig7C6sBW2sUfB7q4zkoF3
         ofyzaIiiLji6VpxZB5xn04NV0UGKrxY6rWwXFbpkHCLHztazNFt6Bpe1ujNu6IghrFdI
         UyLuPYWlpAdrVOhVqA0kFsIRfh6trpHFlOpH/dUllEosaNGXeO8RRWQbdxGQtnHsBUJF
         xUsg==
X-Forwarded-Encrypted: i=1; AJvYcCXuoP5L3e9MTMtZ/DtNEY0UW3wr0GIDXxvSj8oLkz90p7qMuL9AHUR+nEE9rOihg0b7OIHEwC7/KLmYRzepve0yZnXhe3Zn
X-Gm-Message-State: AOJu0Yz6uhnwA7Gw8zsHva/JuduJwNIHOyGpGfBRc4AnTcTlea7dT00N
	EPQybykXKqLAc4qI1zR5ebyMi2KKDMzgoFr1NnEY8fmqf4GvKewR
X-Google-Smtp-Source: AGHT+IEGLNxsHQar1zC+kAzqyhEs8tshHEH8y7bfNjlds8VGm4xtRAnXFyVyIKH7uZWxVlPucNuuRQ==
X-Received: by 2002:a05:6512:2388:b0:513:a724:3b9f with SMTP id c8-20020a056512238800b00513a7243b9fmr1318551lfv.7.1710084577187;
        Sun, 10 Mar 2024 08:29:37 -0700 (PDT)
Received: from betty.fdsoft.se (213-67-237-183-no99.tbcn.telia.com. [213.67.237.183])
        by smtp.gmail.com with ESMTPSA id fb8-20020a056512124800b00513a7d633e9sm167582lfb.82.2024.03.10.08.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 08:29:36 -0700 (PDT)
Received: from ester.fdsoft.se ([192.168.1.2])
	by betty.fdsoft.se with esmtp (Exim 4.97.1)
	(envelope-from <frej.drejhammar@gmail.com>)
	id 1rjL7H-000000002E9-3im8;
	Sun, 10 Mar 2024 16:29:36 +0100
From: Frej Drejhammar <frej.drejhammar@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Frej Drejhammar <frej.drejhammar@gmail.com>,
	stable@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH] drm: Don't return unsupported formats in drm_mode_legacy_fb_format
Date: Sun, 10 Mar 2024 16:28:03 +0100
Message-ID: <20240310152803.3315-1-frej.drejhammar@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch changes drm_mode_legacy_fb_format() to only return formats
which are supported by the current drm-device. The motivation for this
change is to fix a regression introduced by commit
c91acda3a380 ("drm/gem: Check for valid formats") which stops the Xorg
modesetting driver from working on the Beagleboard Black (it uses the
tilcdc kernel driver).

When the Xorg modesetting driver starts up, it tries to determine the
default bpp for the device. It does this by allocating a dumb 32bpp
frame buffer (using DRM_IOCTL_MODE_CREATE_DUMB) and then calling
drmModeAddFB() with that frame buffer asking for a 24-bit depth and 32
bpp. As the modesetting driver uses drmModeAddFB() which doesn't
supply a format, the kernel's drm_mode_legacy_fb_format() is called to
provide a format matching the requested depth and bpp. If the
drmModeAddFB() call fails, it forces both depth and bpp to 24. If
drmModeAddFB() succeeds, depth is assumed to be 24 and bpp 32. The
dummy frame buffer is then removed (using drmModeRmFB()).

If the modesetting driver finds that both the default bpp and depth
are 24, it forces the use of a 32bpp shadow buffer and a 24bpp front
buffer. Following this, the driver reads the user-specified color
depth option and tries to create a framebuffer of that depth, but if
the use of a shadow buffer has been forced, the bpp and depth of it
overrides the user-supplied option.

The Xorg modesetting driver on top of the tilcdc kernel driver used to
work on the Beagleboard Black if a 16 bit color depth was
configured. The hardware in the Beagleboard Black supports the RG16,
BG24, and XB24 formats. When drm_mode_legacy_fb_format() was called to
request a format for a 24-bit depth and 32 bpp, it would return the
unsupported RG24 format which drmModeAddFB() would happily accept (as
there was no check for a valid format). As a shadow buffer wasn't
forced, the modesetting driver would try the user specified 16 bit
color depth and drm_mode_legacy_fb_format() would return RG16 which is
supported by the hardware. Color depths of 24 bits were not supported,
as the unsupported RG24 would be detected when drmModeSetCrtc() was
called.

Following commit c91acda3a380 ("drm/gem: Check for valid formats"),
which adds a check for a valid (supported by the hardware) format to
the code path for the kernel part of drmModeAddFB(), the modesetting
driver fails to configure and add a frame buffer. This is because the
call to create a 24-bit depth and 32 bpp framebuffer during detection
of the default bpp will now fail and a 24-bit depth and 24 bpp front
buffer will be forced. As drm_mode_legacy_fb_format() will return RG24
which isn't supported, the creation of that framebuffer will also
fail.

To fix the regression, this patch extends drm_mode_legacy_fb_format()
to list all formats with a particular bpp and color depth known to the
kernel, and have it probe the current drm-device for a supported
format. This fixes the regression and, as a bonus, a color depth of 24
bits on the Beagleboard Black is now working.

As this patch changes drm_mode_legacy_fb_format() which is used by
other drivers, it has, in addition to the Beagleboard Black, also been
tested with the nouveau and modesetting drivers on a NVIDIA NV96, and
with the intel and modesetting drivers on an intel HD Graphics 4000
chipset.

Signed-off-by: Frej Drejhammar <frej.drejhammar@gmail.com>
Fixes: c91acda3a380 ("drm/gem: Check for valid formats")
Cc: stable@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/armada/armada_fbdev.c         |  2 +-
 drivers/gpu/drm/drm_fb_helper.c               |  2 +-
 drivers/gpu/drm/drm_fbdev_dma.c               |  3 +-
 drivers/gpu/drm/drm_fbdev_generic.c           |  3 +-
 drivers/gpu/drm/drm_fourcc.c                  | 91 ++++++++++++++++---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c     |  3 +-
 drivers/gpu/drm/gma500/fbdev.c                |  2 +-
 drivers/gpu/drm/i915/display/intel_fbdev_fb.c |  3 +-
 drivers/gpu/drm/msm/msm_fbdev.c               |  3 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c          |  2 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c         |  3 +-
 drivers/gpu/drm/tegra/fbdev.c                 |  3 +-
 drivers/gpu/drm/tiny/ofdrm.c                  |  6 +-
 drivers/gpu/drm/xe/display/intel_fbdev_fb.c   |  3 +-
 include/drm/drm_fourcc.h                      |  3 +-
 15 files changed, 104 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index d223176912b6..82f312f76980 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -54,7 +54,7 @@ static int armada_fbdev_create(struct drm_fb_helper *fbh,
 	mode.width = sizes->surface_width;
 	mode.height = sizes->surface_height;
 	mode.pitches[0] = armada_pitch(mode.width, sizes->surface_bpp);
-	mode.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+	mode.pixel_format = drm_mode_legacy_fb_format(dev, sizes->surface_bpp,
 					sizes->surface_depth);
 
 	size = mode.pitches[0] * mode.height;
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d612133e2cf7..62f81a14fb2e 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1453,7 +1453,7 @@ static uint32_t drm_fb_helper_find_format(struct drm_fb_helper *fb_helper, const
 	 * the framebuffer emulation can only deal with such
 	 * formats, specifically RGB/BGA formats.
 	 */
-	format = drm_mode_legacy_fb_format(bpp, depth);
+	format = drm_mode_legacy_fb_format(dev, bpp, depth);
 	if (!format)
 		goto err;
 
diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index 6c9427bb4053..cdb315c6d110 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -90,7 +90,8 @@ static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
 		    sizes->surface_width, sizes->surface_height,
 		    sizes->surface_bpp);
 
-	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_mode_legacy_fb_format(dev,
+					   sizes->surface_bpp, sizes->surface_depth);
 	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
 					       sizes->surface_height, format);
 	if (IS_ERR(buffer))
diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index d647d89764cb..aba8c272560c 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -84,7 +84,8 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
 		    sizes->surface_width, sizes->surface_height,
 		    sizes->surface_bpp);
 
-	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_mode_legacy_fb_format(dev,
+					   sizes->surface_bpp, sizes->surface_depth);
 	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
 					       sizes->surface_height, format);
 	if (IS_ERR(buffer))
diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 193cf8ed7912..034f2087af9a 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -29,47 +29,97 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_print.h>
+
+/*
+ * Internal helper to find a valid format among a list of potentially
+ * valid formats.
+ *
+ * Traverses the variadic arguments until a format supported by @dev
+ * or an DRM_FORMAT_INVALID argument is found. If a supported format
+ * is found it is returned, otherwise DRM_FORMAT_INVALID is returned.
+ */
+static uint32_t select_valid_format(struct drm_device *dev, ...)
+{
+	va_list va;
+	uint32_t fmt = DRM_FORMAT_INVALID;
+	uint32_t to_try;
+
+	va_start(va, dev);
+
+	for (to_try = va_arg(va, uint32_t);
+	     to_try != DRM_FORMAT_INVALID;
+	     to_try = va_arg(va, uint32_t)) {
+		if (drm_any_plane_has_format(dev, to_try, 0)) {
+			fmt = to_try;
+			break;
+		}
+	}
+
+	va_end(va);
+
+	return fmt;
+}
 
 /**
  * drm_mode_legacy_fb_format - compute drm fourcc code from legacy description
+ * @dev: DRM device
  * @bpp: bits per pixels
  * @depth: bit depth per pixel
  *
  * Computes a drm fourcc pixel format code for the given @bpp/@depth values.
  * Useful in fbdev emulation code, since that deals in those values.
  */
-uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth)
+uint32_t drm_mode_legacy_fb_format(struct drm_device *dev,
+				   uint32_t bpp, uint32_t depth)
 {
 	uint32_t fmt = DRM_FORMAT_INVALID;
 
 	switch (bpp) {
 	case 1:
 		if (depth == 1)
-			fmt = DRM_FORMAT_C1;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_C1,
+						  DRM_FORMAT_INVALID);
 		break;
 
 	case 2:
 		if (depth == 2)
-			fmt = DRM_FORMAT_C2;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_C2,
+						  DRM_FORMAT_INVALID);
 		break;
 
 	case 4:
 		if (depth == 4)
-			fmt = DRM_FORMAT_C4;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_C4,
+						  DRM_FORMAT_INVALID);
 		break;
 
 	case 8:
 		if (depth == 8)
-			fmt = DRM_FORMAT_C8;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_C8,
+						  DRM_FORMAT_INVALID);
 		break;
 
 	case 16:
 		switch (depth) {
 		case 15:
-			fmt = DRM_FORMAT_XRGB1555;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_XRGB1555,
+						  DRM_FORMAT_XBGR1555,
+						  DRM_FORMAT_RGBX5551,
+						  DRM_FORMAT_BGRX5551,
+						  DRM_FORMAT_INVALID);
 			break;
 		case 16:
-			fmt = DRM_FORMAT_RGB565;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_RGB565,
+						  DRM_FORMAT_BGR565,
+						  DRM_FORMAT_INVALID);
 			break;
 		default:
 			break;
@@ -78,19 +128,36 @@ uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth)
 
 	case 24:
 		if (depth == 24)
-			fmt = DRM_FORMAT_RGB888;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_RGB888,
+						  DRM_FORMAT_BGR888);
 		break;
 
 	case 32:
 		switch (depth) {
 		case 24:
-			fmt = DRM_FORMAT_XRGB8888;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_XRGB8888,
+						  DRM_FORMAT_XBGR8888,
+						  DRM_FORMAT_RGBX8888,
+						  DRM_FORMAT_BGRX8888,
+						  DRM_FORMAT_INVALID);
 			break;
 		case 30:
-			fmt = DRM_FORMAT_XRGB2101010;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_XRGB2101010,
+						  DRM_FORMAT_XBGR2101010,
+						  DRM_FORMAT_RGBX1010102,
+						  DRM_FORMAT_BGRX1010102,
+						  DRM_FORMAT_INVALID);
 			break;
 		case 32:
-			fmt = DRM_FORMAT_ARGB8888;
+			fmt = select_valid_format(dev,
+						  DRM_FORMAT_ARGB8888,
+						  DRM_FORMAT_ABGR8888,
+						  DRM_FORMAT_RGBA8888,
+						  DRM_FORMAT_BGRA8888,
+						  DRM_FORMAT_INVALID);
 			break;
 		default:
 			break;
@@ -119,7 +186,7 @@ EXPORT_SYMBOL(drm_mode_legacy_fb_format);
 uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
 				     uint32_t bpp, uint32_t depth)
 {
-	uint32_t fmt = drm_mode_legacy_fb_format(bpp, depth);
+	uint32_t fmt = drm_mode_legacy_fb_format(dev, bpp, depth);
 
 	if (dev->mode_config.quirk_addfb_prefer_host_byte_order) {
 		if (fmt == DRM_FORMAT_XRGB8888)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index a379c8ca435a..e114ebd44169 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -104,7 +104,8 @@ static int exynos_drm_fbdev_create(struct drm_fb_helper *helper,
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
 	mode_cmd.pitches[0] = sizes->surface_width * (sizes->surface_bpp >> 3);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+	mode_cmd.pixel_format = drm_mode_legacy_fb_format(dev,
+							  sizes->surface_bpp,
 							  sizes->surface_depth);
 
 	size = mode_cmd.pitches[0] * mode_cmd.height;
diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index 98b44974d42d..811ae5cccf2c 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -189,7 +189,7 @@ static int psb_fbdev_fb_probe(struct drm_fb_helper *fb_helper,
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
 	mode_cmd.pitches[0] = ALIGN(mode_cmd.width * DIV_ROUND_UP(bpp, 8), 64);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(bpp, depth);
+	mode_cmd.pixel_format = drm_mode_legacy_fb_format(dev, bpp, depth);
 
 	size = mode_cmd.pitches[0] * mode_cmd.height;
 	size = ALIGN(size, PAGE_SIZE);
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev_fb.c b/drivers/gpu/drm/i915/display/intel_fbdev_fb.c
index 0665f943f65f..cb32fcff8fb5 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev_fb.c
@@ -30,7 +30,8 @@ struct drm_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
 
 	mode_cmd.pitches[0] = ALIGN(mode_cmd.width *
 				    DIV_ROUND_UP(sizes->surface_bpp, 8), 64);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+	mode_cmd.pixel_format = drm_mode_legacy_fb_format(dev,
+							  sizes->surface_bpp,
 							  sizes->surface_depth);
 
 	size = mode_cmd.pitches[0] * mode_cmd.height;
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 030bedac632d..8748610299b4 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -77,7 +77,8 @@ static int msm_fbdev_create(struct drm_fb_helper *helper,
 	uint32_t format;
 	int ret, pitch;
 
-	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_mode_legacy_fb_format(dev,
+					   sizes->surface_bpp, sizes->surface_depth);
 
 	DBG("create fbdev: %dx%d@%d (%dx%d)", sizes->surface_width,
 			sizes->surface_height, sizes->surface_bpp,
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 6b08b137af1a..98f01d80abd8 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -139,7 +139,7 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 			sizes->surface_height, sizes->surface_bpp,
 			sizes->fb_width, sizes->fb_height);
 
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+	mode_cmd.pixel_format = drm_mode_legacy_fb_format(dev, sizes->surface_bpp,
 			sizes->surface_depth);
 
 	mode_cmd.width = sizes->surface_width;
diff --git a/drivers/gpu/drm/radeon/radeon_fbdev.c b/drivers/gpu/drm/radeon/radeon_fbdev.c
index 02bf25759059..bf1843529c7c 100644
--- a/drivers/gpu/drm/radeon/radeon_fbdev.c
+++ b/drivers/gpu/drm/radeon/radeon_fbdev.c
@@ -221,7 +221,8 @@ static int radeon_fbdev_fb_helper_fb_probe(struct drm_fb_helper *fb_helper,
 	if ((sizes->surface_bpp == 24) && ASIC_IS_AVIVO(rdev))
 		sizes->surface_bpp = 32;
 
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+	mode_cmd.pixel_format = drm_mode_legacy_fb_format(dev,
+							  sizes->surface_bpp,
 							  sizes->surface_depth);
 
 	ret = radeon_fbdev_create_pinned_object(fb_helper, &mode_cmd, &gobj);
diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
index db6eaac3d30e..290e8c426b0c 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -87,7 +87,8 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	cmd.pitches[0] = round_up(sizes->surface_width * bytes_per_pixel,
 				  tegra->pitch_align);
 
-	cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+	cmd.pixel_format = drm_mode_legacy_fb_format(dev,
+						     sizes->surface_bpp,
 						     sizes->surface_depth);
 
 	size = cmd.pitches[0] * cmd.height;
diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
index ab89b7fc7bf6..ded868601aea 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -100,14 +100,14 @@ static const struct drm_format_info *display_get_validated_format(struct drm_dev
 
 	switch (depth) {
 	case 8:
-		format = drm_mode_legacy_fb_format(8, 8);
+		format = drm_mode_legacy_fb_format(dev, 8, 8);
 		break;
 	case 15:
 	case 16:
-		format = drm_mode_legacy_fb_format(16, depth);
+		format = drm_mode_legacy_fb_format(dev, 16, depth);
 		break;
 	case 32:
-		format = drm_mode_legacy_fb_format(32, 24);
+		format = drm_mode_legacy_fb_format(dev, 32, 24);
 		break;
 	default:
 		drm_err(dev, "unsupported framebuffer depth %u\n", depth);
diff --git a/drivers/gpu/drm/xe/display/intel_fbdev_fb.c b/drivers/gpu/drm/xe/display/intel_fbdev_fb.c
index 51ae3561fd0d..a38a8143d632 100644
--- a/drivers/gpu/drm/xe/display/intel_fbdev_fb.c
+++ b/drivers/gpu/drm/xe/display/intel_fbdev_fb.c
@@ -32,7 +32,8 @@ struct drm_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
 
 	mode_cmd.pitches[0] = ALIGN(mode_cmd.width *
 				    DIV_ROUND_UP(sizes->surface_bpp, 8), XE_PAGE_SIZE);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+	mode_cmd.pixel_format = drm_mode_legacy_fb_format(dev,
+							  sizes->surface_bpp,
 							  sizes->surface_depth);
 
 	size = mode_cmd.pitches[0] * mode_cmd.height;
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index ccf91daa4307..75d06393a564 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -310,7 +310,8 @@ const struct drm_format_info *drm_format_info(u32 format);
 const struct drm_format_info *
 drm_get_format_info(struct drm_device *dev,
 		    const struct drm_mode_fb_cmd2 *mode_cmd);
-uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
+uint32_t drm_mode_legacy_fb_format(struct drm_device *dev,
+				   uint32_t bpp, uint32_t depth);
 uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
 				     uint32_t bpp, uint32_t depth);
 unsigned int drm_format_info_block_width(const struct drm_format_info *info,

base-commit: b9511c6d277c31b13d4f3128eba46f4e0733d734
-- 
2.44.0


