Return-Path: <stable+bounces-204790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D22CF3D7F
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B226930C613B
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197751EA65;
	Mon,  5 Jan 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDxezBtB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845719E968
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619601; cv=none; b=LXTmrK1oBdV/kowwpRbpK3kNySLz+HZ6JGn2XiosdQ7ONSYRDqT7F9BxRBiq18peZH5C6eoXuplbTzNTc4SY6A977TPuSL/mQCnZGiWt/xOZoS8wh+6o9ZlmwdTfbdNRK7BEWsAc398XooKX1FTN4zgThDzK2dCjPBUfR0uUMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619601; c=relaxed/simple;
	bh=t+MdaM0bKQwqPJzCqD44zFAGHLgpyKW8GXxCA9Jecqk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iEq4W3agutl0PKTgQoEJebI2YsaQ/FgR2mCTRYN5RdBtfLW1pxJsrNMpdqfYIjJNZY0wsDg0Ls5sWQdz5QIgZCjfAlHtT9JcYSTAuJ4/uWpWwS/u+f5gk3UNfASuz3a3OLO9ekAPsh1m5ilnvS59cRK+pmV+fk01roS4TX2MES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDxezBtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01C3C116D0;
	Mon,  5 Jan 2026 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619601;
	bh=t+MdaM0bKQwqPJzCqD44zFAGHLgpyKW8GXxCA9Jecqk=;
	h=Subject:To:Cc:From:Date:From;
	b=dDxezBtBTyq+9KwNXCEk6NuakshRedA/hpJoN0Xwp6cLRP6ZCddxLuhB/9l4ub6bf
	 mcJWZTuOrXGeAhCmcujIqfwQd7PWf0/3+GHLEYWQGeMhHet5dzNz7lTdyUD9e+25p2
	 zb9AestOv3CMJCnuhpbvbb37+iLswi4YR8rL+XjQ=
Subject: FAILED: patch "[PATCH] drm/tilcdc: Fix removal actions in case of failed probe" failed to apply to 6.6-stable tree
To: kory.maincent@bootlin.com,dianders@chromium.org,luca.ceresoli@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:26:30 +0100
Message-ID: <2026010530-discard-saggy-15cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a585c7ef9cabda58088916baedc6573e9a5cd2a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010530-discard-saggy-15cd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a585c7ef9cabda58088916baedc6573e9a5cd2a7 Mon Sep 17 00:00:00 2001
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Tue, 25 Nov 2025 10:05:44 +0100
Subject: [PATCH] drm/tilcdc: Fix removal actions in case of failed probe

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
index 7caec4d38ddf..3dcbec312bac 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -172,8 +172,7 @@ static void tilcdc_fini(struct drm_device *dev)
 	if (priv->crtc)
 		tilcdc_crtc_shutdown(priv->crtc);
 
-	if (priv->is_registered)
-		drm_dev_unregister(dev);
+	drm_dev_unregister(dev);
 
 	drm_kms_helper_poll_fini(dev);
 	drm_atomic_helper_shutdown(dev);
@@ -220,21 +219,21 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
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
@@ -313,7 +312,7 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 	ret = tilcdc_crtc_create(ddev);
 	if (ret < 0) {
 		dev_err(dev, "failed to create crtc\n");
-		goto init_failed;
+		goto disable_pm;
 	}
 	modeset_init(ddev);
 
@@ -324,46 +323,46 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
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
@@ -372,16 +371,34 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
-		goto init_failed;
-	priv->is_registered = true;
+		goto stop_poll;
 
 	drm_client_setup_with_color_mode(ddev, bpp);
 
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


