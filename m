Return-Path: <stable+bounces-28316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCD887DF1C
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 19:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CE91C209D7
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C11CF8F;
	Sun, 17 Mar 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqul+LUy"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B681CD3D
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710698541; cv=none; b=Ec2PUMtRnfO7a6Tqk3reNFEK13anlvigMuMZKJr4siingXIYV++JTtnz3Nr38iU1jJAMcY94K423GzWTcKcWWpT6movXx2GaPJEUARY8BU3diJhEMuIY75j9tazA5blXN8mMj8KbVPlr4k6U0jnKTx3wAPoQp3GkLRp/HmzvLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710698541; c=relaxed/simple;
	bh=wzpVK10VlEkyB1rsr1P4U6moN69yWHaIGVXvieTERHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDYPPaSYOhUPI8uMsdYjLJTsbJk0M3LgWP86PtWmqKYboHPZ+eXRIXW8FkEes9navom/BmJF4uv6JbJI4BYgimNh3sTNllhuckKR7D2juViKqesCy4h3tS7jjWCJZH317+9KufR8xMsTNwNpju+v2Aaim9HiN+FaZNBfXE+6g5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqul+LUy; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513a6416058so4992035e87.1
        for <stable@vger.kernel.org>; Sun, 17 Mar 2024 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710698538; x=1711303338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwe4ufHc0pD+n/OpX11REypWu/q9308rKbUkBTuj24s=;
        b=Jqul+LUyEBqXl2gE/JdGFMG3LN+guyyBGOp8+IRObV/Hgmw107GJLdFClHrXF8njI7
         MmXlQVR33p8YtDf2BWxkbC0sWB+6Fnu3jL1j5O3qm2PmrUKw5IDHuT9vL8sVO+R60bg6
         7lhc9++AMJMY92WDFTLO5IEFH0n/ZpC5aeKK8SEeKLvdxpYabQ5RlDO0k2yacyJI2T4M
         DrEp4Qvyjsa0Yb50MoqFIFr7NOP7Bv1O3hLcIwjdofWR6TDMqnNLnQal5n3WL3LMD6is
         sW3QcT7D7Hy4MhOrD1jxcJPFLktCWPXJyeSvHmNn5px1HpmKAcFUH9fNdt4UWTJprxl3
         KWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710698538; x=1711303338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwe4ufHc0pD+n/OpX11REypWu/q9308rKbUkBTuj24s=;
        b=axfUJAiwrymQWpVa8IzGlQYmacQB8LKGISqEqin6SuN5SiYx4hrZ/+Vx9jSZ0FLQsc
         S0AY+criuEnYwLps/Bsy9y6GIkMxnRoWu+mTc1Fonv5zPcavZGLl2sp3vFNr+SoiOjXv
         QSD/wt4acyNc60XmLdOipWBFx4e+I5xeSt11r6SzkP/Sz3BEdL2IjtipuuYlP4e0ZhJ+
         CxRZZ9oilkEes7zGuDurwr7Mexm+qTuIRinewgvveobwQuKmADKImjCbYi2b4T0mcndV
         TtJ4FpoZ+Q5mb8WOyHg+zITq7yziWVjbtr+O/I+c0DH9FK8MJBqO14iMCzNUfU4r4t9A
         NVSA==
X-Forwarded-Encrypted: i=1; AJvYcCWNhZwn8PYt9PBJeA/TTPvc3tqVnkhLuxcs7joXIkUHe2QX4UNelI4WFX6Wm27hlLj3/DUb5lGHj2eWlwjV2LiIz8YDIBCk
X-Gm-Message-State: AOJu0Ywx6TgROv/o7n35rWwRa5CuSggtRU4nWdDE37QIPmUB4GWk/fd+
	gYJh8KCwwn3YuyVgYXhooedTKl2XnSUK/BQ/Wrun1tqxv43H7RIp
X-Google-Smtp-Source: AGHT+IGrmVhalw5cQpbpd6edu5GN6B0lfHY1FSWbJ7l48btYZ0089Tvb0jlO97iG+1mEmJFdYKupQA==
X-Received: by 2002:a19:3808:0:b0:513:c85e:2848 with SMTP id f8-20020a193808000000b00513c85e2848mr6727991lfa.34.1710698537599;
        Sun, 17 Mar 2024 11:02:17 -0700 (PDT)
Received: from betty.fdsoft.se (213-67-237-183-no99.tbcn.telia.com. [213.67.237.183])
        by smtp.gmail.com with ESMTPSA id i21-20020a198c55000000b00513137b0178sm1346881lfj.91.2024.03.17.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:02:17 -0700 (PDT)
Received: from ester.fdsoft.se ([192.168.1.2])
	by betty.fdsoft.se with esmtp (Exim 4.97.1)
	(envelope-from <frej.drejhammar@gmail.com>)
	id 1rlups-000000005e0-2uyS;
	Sun, 17 Mar 2024 19:02:16 +0100
From: Frej Drejhammar <frej.drejhammar@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Frej Drejhammar <frej.drejhammar@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/11] drm: Only return supported formats from drm_driver_legacy_fb_format
Date: Sun, 17 Mar 2024 19:01:26 +0100
Message-ID: <e7ef6d422365986f49746b596735f7a0b939574d.1710698387.git.frej.drejhammar@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710698386.git.frej.drejhammar@gmail.com>
References: <cover.1710698386.git.frej.drejhammar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch extends drm_driver_legacy_fb_format() to only return
formats which are supported by the current drm-device. The motivation
for this change is to fix a regression introduced by commit
c91acda3a380 ("drm/gem: Check for valid formats") which stops the Xorg
modesetting driver from working on the Beagleboard Black (it uses the
tilcdc kernel driver).

When the Xorg modesetting driver starts up, it tries to determine the
default bpp for the device. It does this by allocating a dumb 32bpp
frame buffer (using DRM_IOCTL_MODE_CREATE_DUMB) and then calling
drmModeAddFB() with that frame buffer asking for a 24-bit depth and 32
bpp. As the modesetting driver uses drmModeAddFB() which doesn't
supply a format, the kernel's drm_driver_legacy_fb_format() is called,
in drm_mode_addfb(), to provide a format matching the requested depth
and bpp. If the drmModeAddFB() call fails, the modesetting driver
forces both depth and bpp to 24. If drmModeAddFB() succeeds, depth is
assumed to be 24 and bpp 32. The dummy frame buffer is then
removed (using drmModeRmFB()).

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

To fix the regression, this patch extends
drm_driver_legacy_fb_format() to list all formats with a particular
bpp and color depth known to the kernel, and have it probe the current
drm-device for a supported format. This fixes the regression and, as a
bonus, a color depth of 24 bits on the Beagleboard Black is now
working.

This patch has, in addition to the Beagleboard Black, also been tested
with the nouveau and modesetting drivers on a NVIDIA NV96, and with
the Intel and modesetting drivers on an Intel HD Graphics 4000
chipset.

Signed-off-by: Frej Drejhammar <frej.drejhammar@gmail.com>
Fixes: c91acda3a380 ("drm/gem: Check for valid formats")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: stable@vger.kernel.org
---

This is an evolved version of the changes proposed in "drm: Don't
return unsupported formats in drm_mode_legacy_fb_format" [1] following
the suggestions of Thomas Zimmermann.

[1] https://lore.kernel.org/all/20240310152803.3315-1-frej.drejhammar@gmail.com/
---
 drivers/gpu/drm/drm_fourcc.c | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 193cf8ed7912..285388bed990 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -29,6 +29,7 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_plane.h>
 
 /**
  * drm_mode_legacy_fb_format - compute drm fourcc code from legacy description
@@ -105,6 +106,87 @@ uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth)
 }
 EXPORT_SYMBOL(drm_mode_legacy_fb_format);
 
+/*
+ * Internal helper to find a supported format among a list of
+ * potentially supported formats.
+ *
+ * Traverses the variadic arguments until a format supported by dev or
+ * an DRM_FORMAT_INVALID argument is found. If a supported format is
+ * found it is returned, otherwise DRM_FORMAT_INVALID is returned.
+ */
+static uint32_t drm_pick_supported_format(struct drm_device *dev, ...)
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
+
+/*
+ * Internal helper to find a format which has the same depth and bpp
+ * as the input format and is supported by the drm device.
+ */
+static uint32_t drm_supported_format(struct drm_device *dev, uint32_t fmt)
+{
+	switch (fmt) {
+	case DRM_FORMAT_XRGB1555:
+		return drm_pick_supported_format(dev,
+						 fmt,
+						 DRM_FORMAT_RGBX5551,
+						 DRM_FORMAT_BGRX5551,
+						 DRM_FORMAT_INVALID);
+	case DRM_FORMAT_RGB565:
+		return drm_pick_supported_format(dev,
+						 fmt,
+						 DRM_FORMAT_BGR565,
+						 DRM_FORMAT_INVALID);
+	case DRM_FORMAT_RGB888:
+		return drm_pick_supported_format(dev,
+						 fmt,
+						 DRM_FORMAT_BGR888,
+						 DRM_FORMAT_INVALID);
+	case DRM_FORMAT_XRGB8888:
+		return drm_pick_supported_format(dev,
+						 fmt,
+						 DRM_FORMAT_XBGR8888,
+						 DRM_FORMAT_RGBX8888,
+						 DRM_FORMAT_BGRX8888,
+						 DRM_FORMAT_INVALID);
+	case DRM_FORMAT_XRGB2101010:
+		return drm_pick_supported_format(dev,
+						 fmt,
+						 DRM_FORMAT_XBGR2101010,
+						 DRM_FORMAT_RGBX1010102,
+						 DRM_FORMAT_BGRX1010102,
+						 DRM_FORMAT_INVALID);
+	case DRM_FORMAT_ARGB8888:
+		return drm_pick_supported_format(dev,
+						 fmt,
+						 DRM_FORMAT_ABGR8888,
+						 DRM_FORMAT_RGBA8888,
+						 DRM_FORMAT_BGRA8888,
+						 DRM_FORMAT_INVALID);
+	default:
+		return drm_pick_supported_format(dev,
+						 fmt,
+						 DRM_FORMAT_INVALID);
+	}
+}
+
 /**
  * drm_driver_legacy_fb_format - compute drm fourcc code from legacy description
  * @dev: DRM device
@@ -121,6 +203,7 @@ uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
 {
 	uint32_t fmt = drm_mode_legacy_fb_format(bpp, depth);
 
+	fmt = drm_supported_format(dev, fmt);
 	if (dev->mode_config.quirk_addfb_prefer_host_byte_order) {
 		if (fmt == DRM_FORMAT_XRGB8888)
 			fmt = DRM_FORMAT_HOST_XRGB8888;
-- 
2.44.0


