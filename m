Return-Path: <stable+bounces-77457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA624985D95
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEAFB25E0A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50561E6DE1;
	Wed, 25 Sep 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmJqpAXb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716001E6DDC;
	Wed, 25 Sep 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265828; cv=none; b=Q6u6Dy3Z1xaYfzwfbla225oSvlzwg7HXLp9w8Bu3bw4omg5zEw9Abj+5wMDrdpOI1ZNNCK2eUOsYgyyDTwYmn+X3+hXKriaNXVv6IFfWm7iHP9HYzOq/9Zc30UTln5b2s0rurBLxrHduM3gOqP31vAnTQtuX/3jBcwMBmsoaHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265828; c=relaxed/simple;
	bh=87LRPNhJ7JCbcWne8xhLvjpZMk3kUth7gjKHHeBbdf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0jxjE3HaZMwQnF26rGvw515Ghlm6c7IrtS0rRHOYiEqRZovsjhmvO5Lu7cFsvgYCCzRRNDpS6y7O9cu6f4Fd0XUplO68loPv/1i8qt4421hyck0nERo5XprLkIvm/Ghm62xIzbMhECdVJLYqm+oW2l7+Ihjsro1nlMJR53fbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmJqpAXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543A4C4CEC3;
	Wed, 25 Sep 2024 12:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265828;
	bh=87LRPNhJ7JCbcWne8xhLvjpZMk3kUth7gjKHHeBbdf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmJqpAXbSkNN5o61u2zQUChdtyU9MBhrGfVj5EHDKHqePoLFb+D/H5ZDOmfh8mRdB
	 dLxJqXPtS7bOq4VWDuokn8yYmMDR06dfd0zG1z8WloO9RT8yRjkHZ4fFxguzbBrgkk
	 EPX4eVb2rFSElNRBxM/tRFC6fIIE6Bq+TSJb85S60aEZUlubLDv2v0KN/stc4yMy8p
	 kLC2U+Phl2kbh03szDd6aebRihxANfaLknFQSxQdm+ZaXRlciFrLPtFKipbbL4isGK
	 iTh0J+2pntdfxtUg53nX2PAisdq0Ckf7aeWZ4uSc6fw3Okh1wjp0UtYef8dv/Y75jZ
	 KTtU/9CQ5KyYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Katya Orlova <e.orlova@ispras.ru>,
	=?UTF-8?q?Rapha=C3=ABl=20Gallais-Pou?= <raphael.gallais-pou@foss.st.com>,
	Sasha Levin <sashal@kernel.org>,
	yannick.fertre@foss.st.com,
	philippe.cornu@foss.st.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 112/197] drm/stm: Avoid use-after-free issues with crtc and plane
Date: Wed, 25 Sep 2024 07:52:11 -0400
Message-ID: <20240925115823.1303019-112-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Katya Orlova <e.orlova@ispras.ru>

[ Upstream commit 19dd9780b7ac673be95bf6fd6892a184c9db611f ]

ltdc_load() calls functions drm_crtc_init_with_planes(),
drm_universal_plane_init() and drm_encoder_init(). These functions
should not be called with parameters allocated with devm_kzalloc()
to avoid use-after-free issues [1].

Use allocations managed by the DRM framework.

Found by Linux Verification Center (linuxtesting.org).

[1]
https://lore.kernel.org/lkml/u366i76e3qhh3ra5oxrtngjtm2u5lterkekcz6y2jkndhuxzli@diujon4h7qwb/

Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
Acked-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240216125040.8968-1-e.orlova@ispras.ru
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/stm/drv.c  |  3 +-
 drivers/gpu/drm/stm/ltdc.c | 73 ++++++++++----------------------------
 2 files changed, 20 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index e8523abef27a5..152bec2c02385 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -25,6 +25,7 @@
 #include <drm/drm_module.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_managed.h>
 
 #include "ltdc.h"
 
@@ -75,7 +76,7 @@ static int drv_load(struct drm_device *ddev)
 
 	DRM_DEBUG("%s\n", __func__);
 
-	ldev = devm_kzalloc(ddev->dev, sizeof(*ldev), GFP_KERNEL);
+	ldev = drmm_kzalloc(ddev, sizeof(*ldev), GFP_KERNEL);
 	if (!ldev)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5576fdae49623..eeaabb4e10d3e 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -36,6 +36,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_managed.h>
 
 #include <video/videomode.h>
 
@@ -1199,7 +1200,6 @@ static void ltdc_crtc_atomic_print_state(struct drm_printer *p,
 }
 
 static const struct drm_crtc_funcs ltdc_crtc_funcs = {
-	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
@@ -1212,7 +1212,6 @@ static const struct drm_crtc_funcs ltdc_crtc_funcs = {
 };
 
 static const struct drm_crtc_funcs ltdc_crtc_with_crc_support_funcs = {
-	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
@@ -1545,7 +1544,6 @@ static void ltdc_plane_atomic_print_state(struct drm_printer *p,
 static const struct drm_plane_funcs ltdc_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = drm_plane_cleanup,
 	.reset = drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
@@ -1572,7 +1570,6 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 	const u64 *modifiers = ltdc_format_modifiers;
 	u32 lofs = index * LAY_OFS;
 	u32 val;
-	int ret;
 
 	/* Allocate the biggest size according to supported color formats */
 	formats = devm_kzalloc(dev, (ldev->caps.pix_fmt_nb +
@@ -1613,14 +1610,10 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 		}
 	}
 
-	plane = devm_kzalloc(dev, sizeof(*plane), GFP_KERNEL);
-	if (!plane)
-		return NULL;
-
-	ret = drm_universal_plane_init(ddev, plane, possible_crtcs,
-				       &ltdc_plane_funcs, formats, nb_fmt,
-				       modifiers, type, NULL);
-	if (ret < 0)
+	plane = drmm_universal_plane_alloc(ddev, struct drm_plane, dev,
+					   possible_crtcs, &ltdc_plane_funcs, formats,
+					   nb_fmt, modifiers, type, NULL);
+	if (IS_ERR(plane))
 		return NULL;
 
 	if (ldev->caps.ycbcr_input) {
@@ -1643,15 +1636,6 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 	return plane;
 }
 
-static void ltdc_plane_destroy_all(struct drm_device *ddev)
-{
-	struct drm_plane *plane, *plane_temp;
-
-	list_for_each_entry_safe(plane, plane_temp,
-				 &ddev->mode_config.plane_list, head)
-		drm_plane_cleanup(plane);
-}
-
 static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 {
 	struct ltdc_device *ldev = ddev->dev_private;
@@ -1677,14 +1661,14 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 
 	/* Init CRTC according to its hardware features */
 	if (ldev->caps.crc)
-		ret = drm_crtc_init_with_planes(ddev, crtc, primary, NULL,
-						&ltdc_crtc_with_crc_support_funcs, NULL);
+		ret = drmm_crtc_init_with_planes(ddev, crtc, primary, NULL,
+						 &ltdc_crtc_with_crc_support_funcs, NULL);
 	else
-		ret = drm_crtc_init_with_planes(ddev, crtc, primary, NULL,
-						&ltdc_crtc_funcs, NULL);
+		ret = drmm_crtc_init_with_planes(ddev, crtc, primary, NULL,
+						 &ltdc_crtc_funcs, NULL);
 	if (ret) {
 		DRM_ERROR("Can not initialize CRTC\n");
-		goto cleanup;
+		return ret;
 	}
 
 	drm_crtc_helper_add(crtc, &ltdc_crtc_helper_funcs);
@@ -1698,9 +1682,8 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 	for (i = 1; i < ldev->caps.nb_layers; i++) {
 		overlay = ltdc_plane_create(ddev, DRM_PLANE_TYPE_OVERLAY, i);
 		if (!overlay) {
-			ret = -ENOMEM;
 			DRM_ERROR("Can not create overlay plane %d\n", i);
-			goto cleanup;
+			return -ENOMEM;
 		}
 		if (ldev->caps.dynamic_zorder)
 			drm_plane_create_zpos_property(overlay, i, 0, ldev->caps.nb_layers - 1);
@@ -1713,10 +1696,6 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 	}
 
 	return 0;
-
-cleanup:
-	ltdc_plane_destroy_all(ddev);
-	return ret;
 }
 
 static void ltdc_encoder_disable(struct drm_encoder *encoder)
@@ -1776,23 +1755,19 @@ static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge *bridge)
 	struct drm_encoder *encoder;
 	int ret;
 
-	encoder = devm_kzalloc(ddev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder)
-		return -ENOMEM;
+	encoder = drmm_simple_encoder_alloc(ddev, struct drm_encoder, dev,
+					    DRM_MODE_ENCODER_DPI);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
 
 	encoder->possible_crtcs = CRTC_MASK;
 	encoder->possible_clones = 0;	/* No cloning support */
 
-	drm_simple_encoder_init(ddev, encoder, DRM_MODE_ENCODER_DPI);
-
 	drm_encoder_helper_add(encoder, &ltdc_encoder_helper_funcs);
 
 	ret = drm_bridge_attach(encoder, bridge, NULL, 0);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			drm_encoder_cleanup(encoder);
+	if (ret)
 		return ret;
-	}
 
 	DRM_DEBUG_DRIVER("Bridge encoder:%d created\n", encoder->base.id);
 
@@ -1962,8 +1937,7 @@ int ltdc_load(struct drm_device *ddev)
 			goto err;
 
 		if (panel) {
-			bridge = drm_panel_bridge_add_typed(panel,
-							    DRM_MODE_CONNECTOR_DPI);
+			bridge = drmm_panel_bridge_add(ddev, panel);
 			if (IS_ERR(bridge)) {
 				DRM_ERROR("panel-bridge endpoint %d\n", i);
 				ret = PTR_ERR(bridge);
@@ -2045,7 +2019,7 @@ int ltdc_load(struct drm_device *ddev)
 		}
 	}
 
-	crtc = devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
+	crtc = drmm_kzalloc(ddev, sizeof(*crtc), GFP_KERNEL);
 	if (!crtc) {
 		DRM_ERROR("Failed to allocate crtc\n");
 		ret = -ENOMEM;
@@ -2072,9 +2046,6 @@ int ltdc_load(struct drm_device *ddev)
 
 	return 0;
 err:
-	for (i = 0; i < nb_endpoints; i++)
-		drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
-
 	clk_disable_unprepare(ldev->pixel_clk);
 
 	return ret;
@@ -2082,16 +2053,8 @@ int ltdc_load(struct drm_device *ddev)
 
 void ltdc_unload(struct drm_device *ddev)
 {
-	struct device *dev = ddev->dev;
-	int nb_endpoints, i;
-
 	DRM_DEBUG_DRIVER("\n");
 
-	nb_endpoints = of_graph_get_endpoint_count(dev->of_node);
-
-	for (i = 0; i < nb_endpoints; i++)
-		drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
-
 	pm_runtime_disable(ddev->dev);
 }
 
-- 
2.43.0


