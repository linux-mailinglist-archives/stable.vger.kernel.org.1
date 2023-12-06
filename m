Return-Path: <stable+bounces-4821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA878069B0
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 09:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38C71F215AE
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3444C182A7;
	Wed,  6 Dec 2023 08:35:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 00:35:08 PST
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E81D3
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 00:35:08 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
	id 23B922F2024F; Wed,  6 Dec 2023 08:27:54 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 7F5B12F20242;
	Wed,  6 Dec 2023 08:27:50 +0000 (UTC)
From: kovalev@altlinux.org
To: kovalev@altlinux.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 1/1] Revert "drm/edid: Fix csync detailed mode parsing"
Date: Wed,  6 Dec 2023 11:27:46 +0300
Message-Id: <20231206082746.110903-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20231206082746.110903-1-kovalev@altlinux.org>
References: <20231206082746.110903-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

This reverts commit 5a46dc8e4a064769e916d87bf9bccae75afc7289.

Commit 50b6f2c8297793f7f3315623db78dcff85158e96 upstream.

Commit 5a46dc8e4a0647 ("drm/edid: Fix csync detailed mode parsing") fixed
EDID detailed mode sync parsing. Unfortunately, there are quite a few
displays out there that have bogus (zero) sync field that are broken by
the change. Zero means analog composite sync, which is not right for
digital displays, and the modes get rejected. Regardless, it used to
work, and it needs to continue to work. Revert the change.

Rejecting modes with analog composite sync was the part that fixed the
gitlab issue 8146 [1]. We'll need to get back to the drawing board with
that.

[1] https://gitlab.freedesktop.org/drm/intel/-/issues/8146

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8789
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8930
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9044
Fixes: 5a46dc8e4a0647 ("drm/edid: Fix csync detailed mode parsing")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.4+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230815101907.2900768-1-jani.nikula@intel.com
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/gpu/drm/drm_edid.c | 26 +++++++-------------------
 include/drm/drm_edid.h     | 12 +++---------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index a26c6c57a627c0..5ed77e3361fd72 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3307,6 +3307,9 @@ static struct drm_display_mode *drm_mode_detailed(struct drm_device *dev,
 		DRM_DEBUG_KMS("stereo mode not supported\n");
 		return NULL;
 	}
+	if (!(pt->misc & DRM_EDID_PT_SEPARATE_SYNC)) {
+		DRM_DEBUG_KMS("composite sync not supported\n");
+	}
 
 	/* it is incorrect if hsync/vsync width is zero */
 	if (!hsync_pulse_width || !vsync_pulse_width) {
@@ -3353,25 +3356,10 @@ static struct drm_display_mode *drm_mode_detailed(struct drm_device *dev,
 	if (quirks & EDID_QUIRK_DETAILED_SYNC_PP) {
 		mode->flags |= DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC;
 	} else {
-		switch (pt->misc & DRM_EDID_PT_SYNC_MASK) {
-		case DRM_EDID_PT_ANALOG_CSYNC:
-		case DRM_EDID_PT_BIPOLAR_ANALOG_CSYNC:
-			drm_dbg_kms(dev, "Analog composite sync!\n");
-			mode->flags |= DRM_MODE_FLAG_CSYNC | DRM_MODE_FLAG_NCSYNC;
-			break;
-		case DRM_EDID_PT_DIGITAL_CSYNC:
-			drm_dbg_kms(dev, "Digital composite sync!\n");
-			mode->flags |= DRM_MODE_FLAG_CSYNC;
-			mode->flags |= (pt->misc & DRM_EDID_PT_HSYNC_POSITIVE) ?
-				DRM_MODE_FLAG_PCSYNC : DRM_MODE_FLAG_NCSYNC;
-			break;
-		case DRM_EDID_PT_DIGITAL_SEPARATE_SYNC:
-			mode->flags |= (pt->misc & DRM_EDID_PT_HSYNC_POSITIVE) ?
-				DRM_MODE_FLAG_PHSYNC : DRM_MODE_FLAG_NHSYNC;
-			mode->flags |= (pt->misc & DRM_EDID_PT_VSYNC_POSITIVE) ?
-				DRM_MODE_FLAG_PVSYNC : DRM_MODE_FLAG_NVSYNC;
-			break;
-		}
+		mode->flags |= (pt->misc & DRM_EDID_PT_HSYNC_POSITIVE) ?
+			DRM_MODE_FLAG_PHSYNC : DRM_MODE_FLAG_NHSYNC;
+		mode->flags |= (pt->misc & DRM_EDID_PT_VSYNC_POSITIVE) ?
+			DRM_MODE_FLAG_PVSYNC : DRM_MODE_FLAG_NVSYNC;
 	}
 
 set_size:
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 008d2ed39822ec..1ed61e2b30a41c 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -61,15 +61,9 @@ struct std_timing {
 	u8 vfreq_aspect;
 } __attribute__((packed));
 
-#define DRM_EDID_PT_SYNC_MASK              (3 << 3)
-# define DRM_EDID_PT_ANALOG_CSYNC          (0 << 3)
-# define DRM_EDID_PT_BIPOLAR_ANALOG_CSYNC  (1 << 3)
-# define DRM_EDID_PT_DIGITAL_CSYNC         (2 << 3)
-#  define DRM_EDID_PT_CSYNC_ON_RGB         (1 << 1) /* analog csync only */
-#  define DRM_EDID_PT_CSYNC_SERRATE        (1 << 2)
-# define DRM_EDID_PT_DIGITAL_SEPARATE_SYNC (3 << 3)
-#  define DRM_EDID_PT_HSYNC_POSITIVE       (1 << 1) /* also digital csync */
-#  define DRM_EDID_PT_VSYNC_POSITIVE       (1 << 2)
+#define DRM_EDID_PT_HSYNC_POSITIVE (1 << 1)
+#define DRM_EDID_PT_VSYNC_POSITIVE (1 << 2)
+#define DRM_EDID_PT_SEPARATE_SYNC  (3 << 3)
 #define DRM_EDID_PT_STEREO         (1 << 5)
 #define DRM_EDID_PT_INTERLACED     (1 << 7)
 
-- 
2.33.8


