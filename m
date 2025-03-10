Return-Path: <stable+bounces-122097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2CA59DE9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963481885DEA
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E51236A6B;
	Mon, 10 Mar 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQnhoPSa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C222D4C3;
	Mon, 10 Mar 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627518; cv=none; b=Lm5erhXniwDQGzqbS5Oauf8M36zInzaKPT1UepG8+DqRL71GNzLpsKXVij2l7Gw8Ye4zwmCoaY4IMnRNiLEeyfGUv1kXlxsjjfD9+wkhgkEsHgBm9ArtXxaB/1Twhqn5JEIrJr4pPxlIObW6RTTuKS42pp4XA4vmoi6h32LTMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627518; c=relaxed/simple;
	bh=xHv2LLpTDW2A/7Br5pTV8D46CCd/LNSPdlzoO2vmJdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiJvaHCqpkkznw+P2A5re7bXFMaecQdinReV3K2195nMF7803u4mxtXBaznCAIz5W2fP6deuzNZf3MY5EB7xTeKbSC03qsRAtZGU4SZAWcFNHtBkgJ/NxOCuoVA5Oxlpo2En+1Q0VW/KVdKlY7qXwzV2ubCpx/dcUq6m6Ka0UcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQnhoPSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CF2C4CEE5;
	Mon, 10 Mar 2025 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627518;
	bh=xHv2LLpTDW2A/7Br5pTV8D46CCd/LNSPdlzoO2vmJdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQnhoPSaggsou9ikzGLHZSWodxifNGuHSaluFxMIonl7frAg+AlXlsmG485YP7iy3
	 2rgT2jFCK+DDsc6TP0CpQGFIilJJLzLTYtLobmiGjQnz++Fb19ZFi08VHD/d2OVSN4
	 +hSVSYJUpkmjPa2fzB1c9xQxkp8oPn16aYc3F4KQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 157/269] drm/fbdev: Add memory-agnostic fbdev client
Date: Mon, 10 Mar 2025 18:05:10 +0100
Message-ID: <20250310170503.980137766@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 5d08c44e47b9d41366714552bdd374ac4b595591 ]

Add an fbdev client that can work with any memory manager. The
client implementation is the same as existing code in fbdev-dma or
fbdev-shmem.

Provide struct drm_driver.fbdev_probe for the new client to allocate
the surface GEM buffer. The new callback replaces fb_probe of struct
drm_fb_helper_funcs, which does the same.

To use the new client, DRM drivers set fbdev_probe in their struct
drm_driver instance and call drm_fbdev_client_setup(). Probing and
creating the fbdev surface buffer is now independent from the other
operations in struct drm_fb_helper. For the pixel format, the fbdev
client either uses a specified format, the value in preferred_depth
or 32-bit RGB.

v2:
- test for struct drm_fb_helper.funcs for NULL (Sui)
- respect struct drm_mode_config.preferred_depth for default format

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.98201-4-tzimmermann@suse.de
Stable-dep-of: 6b481ab0e685 ("drm/nouveau: select FW caching")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/Makefile           |   4 +-
 drivers/gpu/drm/drm_fb_helper.c    |  15 +--
 drivers/gpu/drm/drm_fbdev_client.c | 141 +++++++++++++++++++++++++++++
 include/drm/drm_drv.h              |  18 ++++
 include/drm/drm_fbdev_client.h     |  19 ++++
 5 files changed, 190 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_fbdev_client.c
 create mode 100644 include/drm/drm_fbdev_client.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 84746054c721a..a1dd0909fa38b 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -145,7 +145,9 @@ drm_kms_helper-y := \
 	drm_self_refresh_helper.o \
 	drm_simple_kms_helper.o
 drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
-drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
+drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += \
+	drm_fbdev_client.o \
+	drm_fb_helper.o
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 
 #
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 29b0cf3a3fb19..b15ddbd65e7b5 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -492,8 +492,8 @@ EXPORT_SYMBOL(drm_fb_helper_init);
  * @fb_helper: driver-allocated fbdev helper
  *
  * A helper to alloc fb_info and the member cmap. Called by the driver
- * within the fb_probe fb_helper callback function. Drivers do not
- * need to release the allocated fb_info structure themselves, this is
+ * within the struct &drm_driver.fbdev_probe callback function. Drivers do
+ * not need to release the allocated fb_info structure themselves, this is
  * automatically done when calling drm_fb_helper_fini().
  *
  * RETURNS:
@@ -1610,7 +1610,7 @@ static int drm_fb_helper_find_sizes(struct drm_fb_helper *fb_helper,
 
 /*
  * Allocates the backing storage and sets up the fbdev info structure through
- * the ->fb_probe callback.
+ * the ->fbdev_probe callback.
  */
 static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 {
@@ -1628,7 +1628,10 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 	}
 
 	/* push down into drivers */
-	ret = (*fb_helper->funcs->fb_probe)(fb_helper, &sizes);
+	if (dev->driver->fbdev_probe)
+		ret = dev->driver->fbdev_probe(fb_helper, &sizes);
+	else if (fb_helper->funcs)
+		ret = fb_helper->funcs->fb_probe(fb_helper, &sizes);
 	if (ret < 0)
 		return ret;
 
@@ -1700,7 +1703,7 @@ static void drm_fb_helper_fill_var(struct fb_info *info,
  * instance and the drm framebuffer allocated in &drm_fb_helper.fb.
  *
  * Drivers should call this (or their equivalent setup code) from their
- * &drm_fb_helper_funcs.fb_probe callback after having allocated the fbdev
+ * &drm_driver.fbdev_probe callback after having allocated the fbdev
  * backing storage framebuffer.
  */
 void drm_fb_helper_fill_info(struct fb_info *info,
@@ -1856,7 +1859,7 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper)
  * Note that this also registers the fbdev and so allows userspace to call into
  * the driver through the fbdev interfaces.
  *
- * This function will call down into the &drm_fb_helper_funcs.fb_probe callback
+ * This function will call down into the &drm_driver.fbdev_probe callback
  * to let the driver allocate and initialize the fbdev info structure and the
  * drm framebuffer used to back the fbdev. drm_fb_helper_fill_info() is provided
  * as a helper to setup simple default values for the fbdev info structure.
diff --git a/drivers/gpu/drm/drm_fbdev_client.c b/drivers/gpu/drm/drm_fbdev_client.c
new file mode 100644
index 0000000000000..a09382afe2fb6
--- /dev/null
+++ b/drivers/gpu/drm/drm_fbdev_client.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: MIT
+
+#include <drm/drm_client.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fbdev_client.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_print.h>
+
+/*
+ * struct drm_client_funcs
+ */
+
+static void drm_fbdev_client_unregister(struct drm_client_dev *client)
+{
+	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
+
+	if (fb_helper->info) {
+		drm_fb_helper_unregister_info(fb_helper);
+	} else {
+		drm_client_release(&fb_helper->client);
+		drm_fb_helper_unprepare(fb_helper);
+		kfree(fb_helper);
+	}
+}
+
+static int drm_fbdev_client_restore(struct drm_client_dev *client)
+{
+	drm_fb_helper_lastclose(client->dev);
+
+	return 0;
+}
+
+static int drm_fbdev_client_hotplug(struct drm_client_dev *client)
+{
+	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
+	struct drm_device *dev = client->dev;
+	int ret;
+
+	if (dev->fb_helper)
+		return drm_fb_helper_hotplug_event(dev->fb_helper);
+
+	ret = drm_fb_helper_init(dev, fb_helper);
+	if (ret)
+		goto err_drm_err;
+
+	if (!drm_drv_uses_atomic_modeset(dev))
+		drm_helper_disable_unused_functions(dev);
+
+	ret = drm_fb_helper_initial_config(fb_helper);
+	if (ret)
+		goto err_drm_fb_helper_fini;
+
+	return 0;
+
+err_drm_fb_helper_fini:
+	drm_fb_helper_fini(fb_helper);
+err_drm_err:
+	drm_err(dev, "fbdev: Failed to setup emulation (ret=%d)\n", ret);
+	return ret;
+}
+
+static const struct drm_client_funcs drm_fbdev_client_funcs = {
+	.owner		= THIS_MODULE,
+	.unregister	= drm_fbdev_client_unregister,
+	.restore	= drm_fbdev_client_restore,
+	.hotplug	= drm_fbdev_client_hotplug,
+};
+
+/**
+ * drm_fbdev_client_setup() - Setup fbdev emulation
+ * @dev: DRM device
+ * @format: Preferred color format for the device. DRM_FORMAT_XRGB8888
+ *          is used if this is zero.
+ *
+ * This function sets up fbdev emulation. Restore, hotplug events and
+ * teardown are all taken care of. Drivers that do suspend/resume need
+ * to call drm_fb_helper_set_suspend_unlocked() themselves. Simple
+ * drivers might use drm_mode_config_helper_suspend().
+ *
+ * This function is safe to call even when there are no connectors present.
+ * Setup will be retried on the next hotplug event.
+ *
+ * The fbdev client is destroyed by drm_dev_unregister().
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
+ */
+int drm_fbdev_client_setup(struct drm_device *dev, const struct drm_format_info *format)
+{
+	struct drm_fb_helper *fb_helper;
+	unsigned int color_mode;
+	int ret;
+
+	/* TODO: Use format info throughout DRM */
+	if (format) {
+		unsigned int bpp = drm_format_info_bpp(format, 0);
+
+		switch (bpp) {
+		case 16:
+			color_mode = format->depth; // could also be 15
+			break;
+		default:
+			color_mode = bpp;
+		}
+	} else {
+		switch (dev->mode_config.preferred_depth) {
+		case 0:
+		case 24:
+			color_mode = 32;
+			break;
+		default:
+			color_mode = dev->mode_config.preferred_depth;
+		}
+	}
+
+	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
+	drm_WARN(dev, dev->fb_helper, "fb_helper is already set!\n");
+
+	fb_helper = kzalloc(sizeof(*fb_helper), GFP_KERNEL);
+	if (!fb_helper)
+		return -ENOMEM;
+	drm_fb_helper_prepare(dev, fb_helper, color_mode, NULL);
+
+	ret = drm_client_init(dev, &fb_helper->client, "fbdev", &drm_fbdev_client_funcs);
+	if (ret) {
+		drm_err(dev, "Failed to register client: %d\n", ret);
+		goto err_drm_client_init;
+	}
+
+	drm_client_register(&fb_helper->client);
+
+	return 0;
+
+err_drm_client_init:
+	drm_fb_helper_unprepare(fb_helper);
+	kfree(fb_helper);
+	return ret;
+}
+EXPORT_SYMBOL(drm_fbdev_client_setup);
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 02ea4e3248fdf..36a606af4ba1d 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -34,6 +34,8 @@
 
 #include <drm/drm_device.h>
 
+struct drm_fb_helper;
+struct drm_fb_helper_surface_size;
 struct drm_file;
 struct drm_gem_object;
 struct drm_master;
@@ -366,6 +368,22 @@ struct drm_driver {
 			       struct drm_device *dev, uint32_t handle,
 			       uint64_t *offset);
 
+	/**
+	 * @fbdev_probe
+	 *
+	 * Allocates and initialize the fb_info structure for fbdev emulation.
+	 * Furthermore it also needs to allocate the DRM framebuffer used to
+	 * back the fbdev.
+	 *
+	 * This callback is mandatory for fbdev support.
+	 *
+	 * Returns:
+	 *
+	 * 0 on success ot a negative error code otherwise.
+	 */
+	int (*fbdev_probe)(struct drm_fb_helper *fbdev_helper,
+			   struct drm_fb_helper_surface_size *sizes);
+
 	/**
 	 * @show_fdinfo:
 	 *
diff --git a/include/drm/drm_fbdev_client.h b/include/drm/drm_fbdev_client.h
new file mode 100644
index 0000000000000..e11a5614f127c
--- /dev/null
+++ b/include/drm/drm_fbdev_client.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef DRM_FBDEV_CLIENT_H
+#define DRM_FBDEV_CLIENT_H
+
+struct drm_device;
+struct drm_format_info;
+
+#ifdef CONFIG_DRM_FBDEV_EMULATION
+int drm_fbdev_client_setup(struct drm_device *dev, const struct drm_format_info *format);
+#else
+static inline int drm_fbdev_client_setup(struct drm_device *dev,
+					 const struct drm_format_info *format)
+{
+	return 0;
+}
+#endif
+
+#endif
-- 
2.39.5




