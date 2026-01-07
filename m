Return-Path: <stable+bounces-206180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F38CFF05B
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 18:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A39435382AA
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F34B3570B2;
	Wed,  7 Jan 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlOgrwSx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22501F9F70
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802453; cv=none; b=TFaaJ1Li+mTLxUPH5qMGK7Uuzn7FrXfC6okDaAO6mhuHIBUaq+odl5qCYHjb3djV2+HBIutDRlEiw0xuAJWEsSK+f9xHqISx4fNSgVK3pqHNxZqKDh8li86UsffjdOlU6OewvtswXcDcqzuyasgdE2CXte3UUbePv3NICTc770M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802453; c=relaxed/simple;
	bh=3e9u4e1kPFjcp+9lsoVFxIzPjiKHkHn0BoOG3rYNjg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv+FwNzcoZB8JLv2u8Oubiavrjov+1vhJ8j5rfMx8xXED/Idm2tKBT3/O6RTTXqNG7bhfm5FCBVGqiuG9i8qOAT1b1Yy5fbkvIZZoPBy1a99CGm5eogpZVLc04EKYtRaoD+o8fGRdLxggm9KOl7yVqZuVBYv4KHHtux4Yv/fFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlOgrwSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AED3C4CEF7;
	Wed,  7 Jan 2026 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767802451;
	bh=3e9u4e1kPFjcp+9lsoVFxIzPjiKHkHn0BoOG3rYNjg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlOgrwSxpD1rmSNLI2OyVNtri+dRpaZxR43Gi6fqPGTYl9hzatqb+h+bn3ZGentgq
	 vYD6CZ0lXGFEWbzC3TrHLQE1Ue1h2KcXX9Z9MBD6emiO5gnexDkxr1x5KxULYqYqmV
	 6Vuv3yg20YOWRizTX43aKcop3C6gmLo9zTDqeSsWF02DBQrbfdu9e9a4m76MmFaXiH
	 SY1Rdsznv/DSsY+b4O97vLCzBFDa7V7tXgP6ckfN3p7zx1vW0p6nrjY9lxR1GTNV2+
	 /LKQ1/balNNg/kFVo2w/XbQhZ9Z0LDh9TPSy1rGfk1Kq6uSEkJbzkZ9kupcaQTcA7D
	 JFxb4VhgHDuqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
	Douglas Anderson <dianders@chromium.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm/tilcdc: Fix removal actions in case of failed probe
Date: Wed,  7 Jan 2026 11:14:08 -0500
Message-ID: <20260107161408.4074126-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107161408.4074126-1-sashal@kernel.org>
References: <2026010530-discard-saggy-15cd@gregkh>
 <20260107161408.4074126-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>

[ Upstream commit a585c7ef9cabda58088916baedc6573e9a5cd2a7 ]

The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpers
should only be called when the device has been successfully registered.
Currently, these functions are called unconditionally in tilcdc_fini(),
which causes warnings during probe deferral scenarios.

[    7.972317] WARNING: CPU: 0 PID: 23 at drivers/gpu/drm/drm_atomic_state_helper.c:175 drm_atomic_helper_crtc_duplicate_state+0x60/0x68
...
[    8.005820]  drm_atomic_helper_crtc_duplicate_state from drm_atomic_get_crtc_state+0x68/0x108
[    8.005858]  drm_atomic_get_crtc_state from drm_atomic_helper_disable_all+0x90/0x1c8
[    8.005885]  drm_atomic_helper_disable_all from drm_atomic_helper_shutdown+0x90/0x144
[    8.005911]  drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [tilcdc]
[    8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [tilcdc]

Fix this by rewriting the failed probe cleanup path using the standard
goto error handling pattern, which ensures that cleanup functions are
only called on successfully initialized resources. Additionally, remove
the now-unnecessary is_registered flag.

Cc: stable@vger.kernel.org
Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at shutdown/remove time for misc drivers")
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20251125090546.137193-1-kory.maincent@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c  | 53 ++++++++++++++++++----------
 drivers/gpu/drm/tilcdc/tilcdc_drv.h  |  2 +-
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index b5f60b2b2d0e..41802c9bd147 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -586,7 +586,7 @@ static void tilcdc_crtc_recover_work(struct work_struct *work)
 	drm_modeset_unlock(&crtc->mutex);
 }
 
-static void tilcdc_crtc_destroy(struct drm_crtc *crtc)
+void tilcdc_crtc_destroy(struct drm_crtc *crtc)
 {
 	struct tilcdc_drm_private *priv = crtc->dev->dev_private;
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index c79613b66154..7bae0cddf088 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -171,8 +171,7 @@ static void tilcdc_fini(struct drm_device *dev)
 	if (priv->crtc)
 		tilcdc_crtc_shutdown(priv->crtc);
 
-	if (priv->is_registered)
-		drm_dev_unregister(dev);
+	drm_dev_unregister(dev);
 
 	drm_kms_helper_poll_fini(dev);
 	drm_atomic_helper_shutdown(dev);
@@ -219,21 +218,21 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 	priv->wq = alloc_ordered_workqueue("tilcdc", 0);
 	if (!priv->wq) {
 		ret = -ENOMEM;
-		goto init_failed;
+		goto put_drm;
 	}
 
 	priv->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->mmio)) {
 		dev_err(dev, "failed to request / ioremap\n");
 		ret = PTR_ERR(priv->mmio);
-		goto init_failed;
+		goto free_wq;
 	}
 
 	priv->clk = clk_get(dev, "fck");
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "failed to get functional clock\n");
 		ret = -ENODEV;
-		goto init_failed;
+		goto free_wq;
 	}
 
 	pm_runtime_enable(dev);
@@ -312,7 +311,7 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 	ret = tilcdc_crtc_create(ddev);
 	if (ret < 0) {
 		dev_err(dev, "failed to create crtc\n");
-		goto init_failed;
+		goto disable_pm;
 	}
 	modeset_init(ddev);
 
@@ -323,46 +322,46 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 	if (ret) {
 		dev_err(dev, "failed to register cpufreq notifier\n");
 		priv->freq_transition.notifier_call = NULL;
-		goto init_failed;
+		goto destroy_crtc;
 	}
 #endif
 
 	if (priv->is_componentized) {
 		ret = component_bind_all(dev, ddev);
 		if (ret < 0)
-			goto init_failed;
+			goto unregister_cpufreq_notif;
 
 		ret = tilcdc_add_component_encoder(ddev);
 		if (ret < 0)
-			goto init_failed;
+			goto unbind_component;
 	} else {
 		ret = tilcdc_attach_external_device(ddev);
 		if (ret)
-			goto init_failed;
+			goto unregister_cpufreq_notif;
 	}
 
 	if (!priv->external_connector &&
 	    ((priv->num_encoders == 0) || (priv->num_connectors == 0))) {
 		dev_err(dev, "no encoders/connectors found\n");
 		ret = -EPROBE_DEFER;
-		goto init_failed;
+		goto unbind_component;
 	}
 
 	ret = drm_vblank_init(ddev, 1);
 	if (ret < 0) {
 		dev_err(dev, "failed to initialize vblank\n");
-		goto init_failed;
+		goto unbind_component;
 	}
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto init_failed;
+		goto unbind_component;
 	priv->irq = ret;
 
 	ret = tilcdc_irq_install(ddev, priv->irq);
 	if (ret < 0) {
 		dev_err(dev, "failed to install IRQ handler\n");
-		goto init_failed;
+		goto unbind_component;
 	}
 
 	drm_mode_config_reset(ddev);
@@ -371,15 +370,33 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
-		goto init_failed;
-	priv->is_registered = true;
+		goto stop_poll;
 
 	drm_fbdev_dma_setup(ddev, bpp);
 	return 0;
 
-init_failed:
-	tilcdc_fini(ddev);
+stop_poll:
+	drm_kms_helper_poll_fini(ddev);
+	tilcdc_irq_uninstall(ddev);
+unbind_component:
+	if (priv->is_componentized)
+		component_unbind_all(dev, ddev);
+unregister_cpufreq_notif:
+#ifdef CONFIG_CPU_FREQ
+	cpufreq_unregister_notifier(&priv->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+destroy_crtc:
+#endif
+	tilcdc_crtc_destroy(priv->crtc);
+disable_pm:
+	pm_runtime_disable(dev);
+	clk_put(priv->clk);
+free_wq:
+	destroy_workqueue(priv->wq);
+put_drm:
 	platform_set_drvdata(pdev, NULL);
+	ddev->dev_private = NULL;
+	drm_dev_put(ddev);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
index b818448c83f6..58b276f82a66 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -82,7 +82,6 @@ struct tilcdc_drm_private {
 	struct drm_encoder *external_encoder;
 	struct drm_connector *external_connector;
 
-	bool is_registered;
 	bool is_componentized;
 	bool irq_enabled;
 };
@@ -164,6 +163,7 @@ void tilcdc_crtc_set_panel_info(struct drm_crtc *crtc,
 void tilcdc_crtc_set_simulate_vesa_sync(struct drm_crtc *crtc,
 					bool simulate_vesa_sync);
 void tilcdc_crtc_shutdown(struct drm_crtc *crtc);
+void tilcdc_crtc_destroy(struct drm_crtc *crtc);
 int tilcdc_crtc_update_fb(struct drm_crtc *crtc,
 		struct drm_framebuffer *fb,
 		struct drm_pending_vblank_event *event);
-- 
2.51.0


