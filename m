Return-Path: <stable+bounces-54546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9890EEC1
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55631F21254
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E514388B;
	Wed, 19 Jun 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKfTPZZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852B1E526;
	Wed, 19 Jun 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803899; cv=none; b=RqMFG/BNFLHV83+cSUhR1k6p1RTds1bJXjZRtAD9lZcFkmjz1mmYQvGdxmGR11NAEVN7Xd7OqlEuMfdOvgxFd7ENdEYEglHgSBFr5Xxsoz7dLWEq4EIVL/qHAyOKlgHkoOw3y2evjuIoSQhvBPWTO0o5hCIJVLAgIMR4PGALGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803899; c=relaxed/simple;
	bh=GCLBgqMz4eZXXLgFmsXhgf0PvRIdiQTN2q2KI7uwVvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lA4Zx62riuI6N2q7ZI8x7M7dqKrEPMqis6yLC2j/r5bkHyjrTxWBPgKowIky0qLVDzH92AtdZkziuskiSOnFVUC2kEmhKNlliZnBae5oSiLglEduRuP/vCXfJ31iqpDId4IHvQLw2+KdWNtZ1Ws93gOd7/QSS+k2XlmcYtMSI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZKfTPZZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D280EC2BBFC;
	Wed, 19 Jun 2024 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803899;
	bh=GCLBgqMz4eZXXLgFmsXhgf0PvRIdiQTN2q2KI7uwVvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKfTPZZZsBrpmmnPlBa6AmlhYF+Az5vS586O3qtCrm4Y2d4oTVv4QRt8oNbwIE59q
	 7KClC6IdlWpxZWpTsMUaUQGUpIBW5lx/Kx8X5rvJi6hAPim91WXI+TXojbi3ypCg1p
	 M+fryLnGINY/cTrUwU331nsHVilR23VXmUC81JYY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Krastev <martin.krastev@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 134/217] drm/vmwgfx: Refactor drm connector probing for display modes
Date: Wed, 19 Jun 2024 14:56:17 +0200
Message-ID: <20240619125601.861451274@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Krastev <martin.krastev@broadcom.com>

[ Upstream commit 935f795045a6f9b13d28d46ebdad04bfea8750dd ]

Implement drm_connector_helper_funcs.mode_valid and .get_modes,
replacing custom drm_connector_funcs.fill_modes code with
drm_helper_probe_single_connector_modes; for STDU, LDU & SOU
display units.

Signed-off-by: Martin Krastev <martin.krastev@broadcom.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240126200804.732454-2-zack.rusin@broadcom.com
Stable-dep-of: 426826933109 ("drm/vmwgfx: Filter modes which exceed graphics memory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 272 +++++++++------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |   6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |   4 +-
 5 files changed, 101 insertions(+), 191 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 77c6700da0087..7a2d29370a534 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -31,6 +31,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_sysfs.h>
+#include <drm/drm_edid.h>
 
 #include "vmwgfx_kms.h"
 
@@ -2213,107 +2214,6 @@ vmw_du_connector_detect(struct drm_connector *connector, bool force)
 		connector_status_connected : connector_status_disconnected);
 }
 
-static struct drm_display_mode vmw_kms_connector_builtin[] = {
-	/* 640x480@60Hz */
-	{ DRM_MODE("640x480", DRM_MODE_TYPE_DRIVER, 25175, 640, 656,
-		   752, 800, 0, 480, 489, 492, 525, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 800x600@60Hz */
-	{ DRM_MODE("800x600", DRM_MODE_TYPE_DRIVER, 40000, 800, 840,
-		   968, 1056, 0, 600, 601, 605, 628, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1024x768@60Hz */
-	{ DRM_MODE("1024x768", DRM_MODE_TYPE_DRIVER, 65000, 1024, 1048,
-		   1184, 1344, 0, 768, 771, 777, 806, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 1152x864@75Hz */
-	{ DRM_MODE("1152x864", DRM_MODE_TYPE_DRIVER, 108000, 1152, 1216,
-		   1344, 1600, 0, 864, 865, 868, 900, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1280x720@60Hz */
-	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74500, 1280, 1344,
-		   1472, 1664, 0, 720, 723, 728, 748, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1280x768@60Hz */
-	{ DRM_MODE("1280x768", DRM_MODE_TYPE_DRIVER, 79500, 1280, 1344,
-		   1472, 1664, 0, 768, 771, 778, 798, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1280x800@60Hz */
-	{ DRM_MODE("1280x800", DRM_MODE_TYPE_DRIVER, 83500, 1280, 1352,
-		   1480, 1680, 0, 800, 803, 809, 831, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 1280x960@60Hz */
-	{ DRM_MODE("1280x960", DRM_MODE_TYPE_DRIVER, 108000, 1280, 1376,
-		   1488, 1800, 0, 960, 961, 964, 1000, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1280x1024@60Hz */
-	{ DRM_MODE("1280x1024", DRM_MODE_TYPE_DRIVER, 108000, 1280, 1328,
-		   1440, 1688, 0, 1024, 1025, 1028, 1066, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1360x768@60Hz */
-	{ DRM_MODE("1360x768", DRM_MODE_TYPE_DRIVER, 85500, 1360, 1424,
-		   1536, 1792, 0, 768, 771, 777, 795, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1440x1050@60Hz */
-	{ DRM_MODE("1400x1050", DRM_MODE_TYPE_DRIVER, 121750, 1400, 1488,
-		   1632, 1864, 0, 1050, 1053, 1057, 1089, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1440x900@60Hz */
-	{ DRM_MODE("1440x900", DRM_MODE_TYPE_DRIVER, 106500, 1440, 1520,
-		   1672, 1904, 0, 900, 903, 909, 934, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1600x1200@60Hz */
-	{ DRM_MODE("1600x1200", DRM_MODE_TYPE_DRIVER, 162000, 1600, 1664,
-		   1856, 2160, 0, 1200, 1201, 1204, 1250, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1680x1050@60Hz */
-	{ DRM_MODE("1680x1050", DRM_MODE_TYPE_DRIVER, 146250, 1680, 1784,
-		   1960, 2240, 0, 1050, 1053, 1059, 1089, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1792x1344@60Hz */
-	{ DRM_MODE("1792x1344", DRM_MODE_TYPE_DRIVER, 204750, 1792, 1920,
-		   2120, 2448, 0, 1344, 1345, 1348, 1394, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1853x1392@60Hz */
-	{ DRM_MODE("1856x1392", DRM_MODE_TYPE_DRIVER, 218250, 1856, 1952,
-		   2176, 2528, 0, 1392, 1393, 1396, 1439, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1920x1080@60Hz */
-	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 173000, 1920, 2048,
-		   2248, 2576, 0, 1080, 1083, 1088, 1120, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1920x1200@60Hz */
-	{ DRM_MODE("1920x1200", DRM_MODE_TYPE_DRIVER, 193250, 1920, 2056,
-		   2256, 2592, 0, 1200, 1203, 1209, 1245, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 1920x1440@60Hz */
-	{ DRM_MODE("1920x1440", DRM_MODE_TYPE_DRIVER, 234000, 1920, 2048,
-		   2256, 2600, 0, 1440, 1441, 1444, 1500, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 2560x1440@60Hz */
-	{ DRM_MODE("2560x1440", DRM_MODE_TYPE_DRIVER, 241500, 2560, 2608,
-		   2640, 2720, 0, 1440, 1443, 1448, 1481, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 2560x1600@60Hz */
-	{ DRM_MODE("2560x1600", DRM_MODE_TYPE_DRIVER, 348500, 2560, 2752,
-		   3032, 3504, 0, 1600, 1603, 1609, 1658, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC) },
-	/* 2880x1800@60Hz */
-	{ DRM_MODE("2880x1800", DRM_MODE_TYPE_DRIVER, 337500, 2880, 2928,
-		   2960, 3040, 0, 1800, 1803, 1809, 1852, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 3840x2160@60Hz */
-	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 533000, 3840, 3888,
-		   3920, 4000, 0, 2160, 2163, 2168, 2222, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* 3840x2400@60Hz */
-	{ DRM_MODE("3840x2400", DRM_MODE_TYPE_DRIVER, 592250, 3840, 3888,
-		   3920, 4000, 0, 2400, 2403, 2409, 2469, 0,
-		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC) },
-	/* Terminate */
-	{ DRM_MODE("", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) },
-};
-
 /**
  * vmw_guess_mode_timing - Provide fake timings for a
  * 60Hz vrefresh mode.
@@ -2335,88 +2235,6 @@ void vmw_guess_mode_timing(struct drm_display_mode *mode)
 }
 
 
-int vmw_du_connector_fill_modes(struct drm_connector *connector,
-				uint32_t max_width, uint32_t max_height)
-{
-	struct vmw_display_unit *du = vmw_connector_to_du(connector);
-	struct drm_device *dev = connector->dev;
-	struct vmw_private *dev_priv = vmw_priv(dev);
-	struct drm_display_mode *mode = NULL;
-	struct drm_display_mode *bmode;
-	struct drm_display_mode prefmode = { DRM_MODE("preferred",
-		DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-		DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC)
-	};
-	int i;
-	u32 assumed_bpp = 4;
-
-	if (dev_priv->assume_16bpp)
-		assumed_bpp = 2;
-
-	max_width  = min(max_width,  dev_priv->texture_max_width);
-	max_height = min(max_height, dev_priv->texture_max_height);
-
-	/*
-	 * For STDU extra limit for a mode on SVGA_REG_SCREENTARGET_MAX_WIDTH/
-	 * HEIGHT registers.
-	 */
-	if (dev_priv->active_display_unit == vmw_du_screen_target) {
-		max_width  = min(max_width,  dev_priv->stdu_max_width);
-		max_height = min(max_height, dev_priv->stdu_max_height);
-	}
-
-	/* Add preferred mode */
-	mode = drm_mode_duplicate(dev, &prefmode);
-	if (!mode)
-		return 0;
-	mode->hdisplay = du->pref_width;
-	mode->vdisplay = du->pref_height;
-	vmw_guess_mode_timing(mode);
-	drm_mode_set_name(mode);
-
-	if (vmw_kms_validate_mode_vram(dev_priv,
-					mode->hdisplay * assumed_bpp,
-					mode->vdisplay)) {
-		drm_mode_probed_add(connector, mode);
-	} else {
-		drm_mode_destroy(dev, mode);
-		mode = NULL;
-	}
-
-	if (du->pref_mode) {
-		list_del_init(&du->pref_mode->head);
-		drm_mode_destroy(dev, du->pref_mode);
-	}
-
-	/* mode might be null here, this is intended */
-	du->pref_mode = mode;
-
-	for (i = 0; vmw_kms_connector_builtin[i].type != 0; i++) {
-		bmode = &vmw_kms_connector_builtin[i];
-		if (bmode->hdisplay > max_width ||
-		    bmode->vdisplay > max_height)
-			continue;
-
-		if (!vmw_kms_validate_mode_vram(dev_priv,
-						bmode->hdisplay * assumed_bpp,
-						bmode->vdisplay))
-			continue;
-
-		mode = drm_mode_duplicate(dev, bmode);
-		if (!mode)
-			return 0;
-
-		drm_mode_probed_add(connector, mode);
-	}
-
-	drm_connector_list_update(connector);
-	/* Move the prefered mode first, help apps pick the right mode. */
-	drm_mode_sort(&connector->modes);
-
-	return 1;
-}
-
 /**
  * vmw_kms_update_layout_ioctl - Handler for DRM_VMW_UPDATE_LAYOUT ioctl
  * @dev: drm device for the ioctl
@@ -2945,3 +2763,91 @@ int vmw_du_helper_plane_update(struct vmw_du_update_plane *update)
 	vmw_validation_unref_lists(&val_ctx);
 	return ret;
 }
+
+/**
+ * vmw_connector_mode_valid - implements drm_connector_helper_funcs.mode_valid callback
+ *
+ * @connector: the drm connector, part of a DU container
+ * @mode: drm mode to check
+ *
+ * Returns MODE_OK on success, or a drm_mode_status error code.
+ */
+enum drm_mode_status vmw_connector_mode_valid(struct drm_connector *connector,
+					      struct drm_display_mode *mode)
+{
+	struct drm_device *dev = connector->dev;
+	struct vmw_private *dev_priv = vmw_priv(dev);
+	u32 max_width = dev_priv->texture_max_width;
+	u32 max_height = dev_priv->texture_max_height;
+	u32 assumed_cpp = 4;
+
+	if (dev_priv->assume_16bpp)
+		assumed_cpp = 2;
+
+	if (dev_priv->active_display_unit == vmw_du_screen_target) {
+		max_width  = min(dev_priv->stdu_max_width,  max_width);
+		max_height = min(dev_priv->stdu_max_height, max_height);
+	}
+
+	if (max_width < mode->hdisplay)
+		return MODE_BAD_HVALUE;
+
+	if (max_height < mode->vdisplay)
+		return MODE_BAD_VVALUE;
+
+	if (!vmw_kms_validate_mode_vram(dev_priv,
+					mode->hdisplay * assumed_cpp,
+					mode->vdisplay))
+		return MODE_MEM;
+
+	return MODE_OK;
+}
+
+/**
+ * vmw_connector_get_modes - implements drm_connector_helper_funcs.get_modes callback
+ *
+ * @connector: the drm connector, part of a DU container
+ *
+ * Returns the number of added modes.
+ */
+int vmw_connector_get_modes(struct drm_connector *connector)
+{
+	struct vmw_display_unit *du = vmw_connector_to_du(connector);
+	struct drm_device *dev = connector->dev;
+	struct vmw_private *dev_priv = vmw_priv(dev);
+	struct drm_display_mode *mode = NULL;
+	struct drm_display_mode prefmode = { DRM_MODE("preferred",
+		DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC)
+	};
+	u32 max_width;
+	u32 max_height;
+	u32 num_modes;
+
+	/* Add preferred mode */
+	mode = drm_mode_duplicate(dev, &prefmode);
+	if (!mode)
+		return 0;
+
+	mode->hdisplay = du->pref_width;
+	mode->vdisplay = du->pref_height;
+	vmw_guess_mode_timing(mode);
+	drm_mode_set_name(mode);
+
+	drm_mode_probed_add(connector, mode);
+	drm_dbg_kms(dev, "preferred mode " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
+
+	/* Probe connector for all modes not exceeding our geom limits */
+	max_width  = dev_priv->texture_max_width;
+	max_height = dev_priv->texture_max_height;
+
+	if (dev_priv->active_display_unit == vmw_du_screen_target) {
+		max_width  = min(dev_priv->stdu_max_width,  max_width);
+		max_height = min(dev_priv->stdu_max_height, max_height);
+	}
+
+	num_modes = 1 + drm_add_modes_noedid(connector, max_width, max_height);
+
+	return num_modes;
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 7e15c851871f2..1099de1ece4b3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -379,7 +379,6 @@ struct vmw_display_unit {
 	unsigned pref_width;
 	unsigned pref_height;
 	bool pref_active;
-	struct drm_display_mode *pref_mode;
 
 	/*
 	 * Gui positioning
@@ -429,8 +428,6 @@ void vmw_du_connector_save(struct drm_connector *connector);
 void vmw_du_connector_restore(struct drm_connector *connector);
 enum drm_connector_status
 vmw_du_connector_detect(struct drm_connector *connector, bool force);
-int vmw_du_connector_fill_modes(struct drm_connector *connector,
-				uint32_t max_width, uint32_t max_height);
 int vmw_kms_helper_dirty(struct vmw_private *dev_priv,
 			 struct vmw_framebuffer *framebuffer,
 			 const struct drm_clip_rect *clips,
@@ -439,6 +436,9 @@ int vmw_kms_helper_dirty(struct vmw_private *dev_priv,
 			 int num_clips,
 			 int increment,
 			 struct vmw_kms_dirty *dirty);
+enum drm_mode_status vmw_connector_mode_valid(struct drm_connector *connector,
+					      struct drm_display_mode *mode);
+int vmw_connector_get_modes(struct drm_connector *connector);
 
 void vmw_kms_helper_validation_finish(struct vmw_private *dev_priv,
 				      struct drm_file *file_priv,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index ac72c20715f32..fdaf7d28cb211 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -263,7 +263,7 @@ static void vmw_ldu_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs vmw_legacy_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
-	.fill_modes = vmw_du_connector_fill_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = vmw_ldu_connector_destroy,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
@@ -272,6 +272,8 @@ static const struct drm_connector_funcs vmw_legacy_connector_funcs = {
 
 static const struct
 drm_connector_helper_funcs vmw_ldu_connector_helper_funcs = {
+	.get_modes = vmw_connector_get_modes,
+	.mode_valid = vmw_connector_mode_valid
 };
 
 static int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
@@ -408,7 +410,6 @@ static int vmw_ldu_init(struct vmw_private *dev_priv, unsigned unit)
 	ldu->base.pref_active = (unit == 0);
 	ldu->base.pref_width = dev_priv->initial_width;
 	ldu->base.pref_height = dev_priv->initial_height;
-	ldu->base.pref_mode = NULL;
 
 	/*
 	 * Remove this after enabling atomic because property values can
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index e1f36a09c59c1..e33684f56eda8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -346,7 +346,7 @@ static void vmw_sou_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs vmw_sou_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
-	.fill_modes = vmw_du_connector_fill_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = vmw_sou_connector_destroy,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
@@ -356,6 +356,8 @@ static const struct drm_connector_funcs vmw_sou_connector_funcs = {
 
 static const struct
 drm_connector_helper_funcs vmw_sou_connector_helper_funcs = {
+	.get_modes = vmw_connector_get_modes,
+	.mode_valid = vmw_connector_mode_valid
 };
 
 
@@ -827,7 +829,6 @@ static int vmw_sou_init(struct vmw_private *dev_priv, unsigned unit)
 	sou->base.pref_active = (unit == 0);
 	sou->base.pref_width = dev_priv->initial_width;
 	sou->base.pref_height = dev_priv->initial_height;
-	sou->base.pref_mode = NULL;
 
 	/*
 	 * Remove this after enabling atomic because property values can
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 0090abe892548..b3e70ace6d9b0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -977,7 +977,7 @@ static void vmw_stdu_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs vmw_stdu_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
-	.fill_modes = vmw_du_connector_fill_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = vmw_stdu_connector_destroy,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
@@ -987,6 +987,8 @@ static const struct drm_connector_funcs vmw_stdu_connector_funcs = {
 
 static const struct
 drm_connector_helper_funcs vmw_stdu_connector_helper_funcs = {
+	.get_modes = vmw_connector_get_modes,
+	.mode_valid = vmw_connector_mode_valid
 };
 
 
-- 
2.43.0




