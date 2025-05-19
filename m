Return-Path: <stable+bounces-144883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A2ABC497
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 18:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7B41713F9
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFA1289351;
	Mon, 19 May 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In3W8znt"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF7288C9F
	for <stable@vger.kernel.org>; Mon, 19 May 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672361; cv=none; b=UPGb/KULraQ+euAEMxGpdM4huruckZ6M31B3+yHn1av/ktQuguxTAvM0FWJDd9Ec8e3+A58BsbeH8thJLGqdU5Ym/vGhGUPoioZ9zs/+GZrGfEHz9mi8B+5stteJL9CqQ5IZYTfIwqAAXIAMABMmrZxllAbh4YRZGEAsPSgu8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672361; c=relaxed/simple;
	bh=GdzLD2j09q7BxN5UmU/lcUz3BKP97oYolAE0+LtTfiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VUkBwo0bU9IYNbn+NNcFu8YdjwSm8fFwhZIF7viztk7TUEk74Go0a0HaU0su1IWxOb5ZZQbSNpOELlFI6mEiw4WHRrg+E86JKzqjKNl7knlqpp7Zl1YJtOrP545UINuhtoTxkS6QBMFZMNEQNMYLBWQQMiOvPRtmGwFbi5zYZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In3W8znt; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-52617ceae0dso1156750e0c.0
        for <stable@vger.kernel.org>; Mon, 19 May 2025 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747672357; x=1748277157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tfIHEprCo24XS4h0n5bH3dzs60Jgef4hBKbhILnIABU=;
        b=In3W8zntXqoJvaGzIp/in1UXKKcw2Jq4kmDh/MOdiBpAFt6sSUG0hpaL3hpDmt0unE
         S2sgiOQXqqQ5JYnrcXvEa+xUGUfVnvjRMctmbb1VaRIcPH7EAPnSaI9oIOaJdQf4StZI
         d8SN4QKVVMhr+psKTjT+K2DXXf6Dn6pDsRGz5xNFUuyKuNO7p+B7hL26w5yLvIchXAkA
         0enVoWYvMe2SjLpE077k2e34BYzG/li9tG1fVNYOa+mTqZHYRmTzdU7GjNEmr9sIkrDP
         0bB/dHFCooOFutNISamuvpldJq7IDP8I3dDGrALhcD9QoRuRY1YTQ8Qy83khmMVLfXzh
         nQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747672357; x=1748277157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfIHEprCo24XS4h0n5bH3dzs60Jgef4hBKbhILnIABU=;
        b=t2SrtsbrZSPzTWsIQD1DCG42VDwbMH1AkaW5vMU0IjDfPwZzTgzYkd+uDdC2YfM9KH
         UZ3yvvKvPa9gWPxb/3636U9whv//8ni/tzOzGqC9Lc0ADN9L/OCx/iQvA6uKAL9VrOx3
         vWN9ZQ7p92rQ3RFK+OkIzd6H7wFHNVMCxmgcR/fO/wDO9PU5g33TQn/uSdE1JS8qjk1V
         dEHcdF15GER08np2lJBp17UpW1fWStCvJ1Mmlbc3DrurSQ6BhLz5X+EsYuzakscnCTGE
         O8yguumvID5bEvxVWRl9cvsbxQQBXBpvRnt5I+SGD/4U41uTQPkh30aSgIwUklcBsohw
         atqQ==
X-Gm-Message-State: AOJu0Yw23K6VYVBcaJYRxYgPBG+wfKmnEpsQz40IzxpsDprWM+Lz5fas
	DgMNAmPA1Xg4s3i/+Gp+Zde022I8Kb+kmv3Y0EsBswSR3sReWfEhIB4DNNERAA==
X-Gm-Gg: ASbGncuW2uUz1JfBarEFics5l3WhDOOZ914kdGPDZ/uw0zEAviRDaIXpQ1oDAiIzQU1
	70vtAteUEjYjs3NHA6MCBCdMyLViVQomjSLcIGm1Hm86xHzdurLS2PBpY8aAqAOW1L560IuZ6Qs
	gPAcvofzXHpUKQxp5iW3Yy88kPIpjBhBSAaBLU5q6pkLWz/tHovFFQzbOSkNoSgIfDP2k9bChth
	lbJQLxW/PSPmHnWTwqt4TzGJ4R8NgaT6sA6TQHqi68U3ptbyfX81YPUstT9czidNck1n/RYHIuK
	djWkgdsL5Kt7uCK63u8of6DmR9vmGp6wu4OESSSGeMgSsVMnjDUes9hpd3eZlrxEMg==
X-Google-Smtp-Source: AGHT+IFgYw1QM3M9auwS6GA/+Lw0isov5Z1ZyqJ2NvjE9GLNLo5yfCQQANZ891uwFuPaB0YIYkp95g==
X-Received: by 2002:a05:6122:178e:b0:52c:5062:c84d with SMTP id 71dfb90a1353d-52dbcab408amr10134135e0c.0.1747672357483;
        Mon, 19 May 2025 09:32:37 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:276e:c8c9:6d13:9b45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbab4e953sm6906606e0c.38.2025.05.19.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:32:37 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: tzimmermann@suse.de,
	javierm@redhat.com,
	gregkh@linuxfoundation.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 6.12.y 1/3] drm/fbdev-dma: Support struct drm_driver.fbdev_probe
Date: Mon, 19 May 2025 13:32:28 -0300
Message-Id: <20250519163230.1303438-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 8998eedda2539d2528cfebdc7c17eed0ad35b714 upstream.

Rework fbdev probing to support fbdev_probe in struct drm_driver
and reimplement the old fb_probe callback on top of it. Provide an
initializer macro for struct drm_driver that sets the callback
according to the kernel configuration.

This change allows the common fbdev client to run on top of DMA-
based DRM drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.98201-6-tzimmermann@suse.de
Signed-off-by: Fabio Estevam <festevam@denx.de> 
---
 drivers/gpu/drm/drm_fbdev_dma.c | 60 ++++++++++++++++++++-------------
 include/drm/drm_fbdev_dma.h     | 12 +++++++
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index 51c2d742d199..7c8287c18e38 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -105,6 +105,40 @@ static const struct fb_ops drm_fbdev_dma_deferred_fb_ops = {
 
 static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
 					 struct drm_fb_helper_surface_size *sizes)
+{
+	return drm_fbdev_dma_driver_fbdev_probe(fb_helper, sizes);
+}
+
+static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
+					 struct drm_clip_rect *clip)
+{
+	struct drm_device *dev = helper->dev;
+	int ret;
+
+	/* Call damage handlers only if necessary */
+	if (!(clip->x1 < clip->x2 && clip->y1 < clip->y2))
+		return 0;
+
+	if (helper->fb->funcs->dirty) {
+		ret = helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
+		if (drm_WARN_ONCE(dev, ret, "Dirty helper failed: ret=%d\n", ret))
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
+	.fb_probe = drm_fbdev_dma_helper_fb_probe,
+	.fb_dirty = drm_fbdev_dma_helper_fb_dirty,
+};
+
+/*
+ * struct drm_fb_helper
+ */
+
+int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
+				     struct drm_fb_helper_surface_size *sizes)
 {
 	struct drm_client_dev *client = &fb_helper->client;
 	struct drm_device *dev = fb_helper->dev;
@@ -148,6 +182,7 @@ static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
 		goto err_drm_client_buffer_delete;
 	}
 
+	fb_helper->funcs = &drm_fbdev_dma_helper_funcs;
 	fb_helper->buffer = buffer;
 	fb_helper->fb = fb;
 
@@ -211,30 +246,7 @@ static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
 	drm_client_framebuffer_delete(buffer);
 	return ret;
 }
-
-static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
-					 struct drm_clip_rect *clip)
-{
-	struct drm_device *dev = helper->dev;
-	int ret;
-
-	/* Call damage handlers only if necessary */
-	if (!(clip->x1 < clip->x2 && clip->y1 < clip->y2))
-		return 0;
-
-	if (helper->fb->funcs->dirty) {
-		ret = helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
-		if (drm_WARN_ONCE(dev, ret, "Dirty helper failed: ret=%d\n", ret))
-			return ret;
-	}
-
-	return 0;
-}
-
-static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
-	.fb_probe = drm_fbdev_dma_helper_fb_probe,
-	.fb_dirty = drm_fbdev_dma_helper_fb_dirty,
-};
+EXPORT_SYMBOL(drm_fbdev_dma_driver_fbdev_probe);
 
 /*
  * struct drm_client_funcs
diff --git a/include/drm/drm_fbdev_dma.h b/include/drm/drm_fbdev_dma.h
index 2da7ee784133..6ae4de46497c 100644
--- a/include/drm/drm_fbdev_dma.h
+++ b/include/drm/drm_fbdev_dma.h
@@ -4,12 +4,24 @@
 #define DRM_FBDEV_DMA_H
 
 struct drm_device;
+struct drm_fb_helper;
+struct drm_fb_helper_surface_size;
 
 #ifdef CONFIG_DRM_FBDEV_EMULATION
+int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
+				     struct drm_fb_helper_surface_size *sizes);
+
+#define DRM_FBDEV_DMA_DRIVER_OPS \
+	.fbdev_probe = drm_fbdev_dma_driver_fbdev_probe
+
 void drm_fbdev_dma_setup(struct drm_device *dev, unsigned int preferred_bpp);
 #else
 static inline void drm_fbdev_dma_setup(struct drm_device *dev, unsigned int preferred_bpp)
 { }
+
+#define DRM_FBDEV_DMA_DRIVER_OPS \
+	.fbdev_probe = NULL
+
 #endif
 
 #endif
-- 
2.34.1


