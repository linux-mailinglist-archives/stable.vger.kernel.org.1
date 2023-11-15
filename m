Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0997ECC09
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjKOT0g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjKOT0U (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264F2D42
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927CCC433C7;
        Wed, 15 Nov 2023 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076375;
        bh=T9McuUp16hqTAs+a++2BMTTFuBidE5Ro9yO+XukuD0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCXHp3zXnHHQA5i+K35tGC6R+7wXS/bD9FDBwqoEt5w1e8yTHQqOTjuJmFfdbnb/u
         RREcW19XJlqxa3qvKNvqMcjn+3MBoR+/j956hd1suIb3TC/jbATzkEQfdaP2NV9+zz
         dDcLGDodPmpT/Me2+1OHXdXI15YA3HhWGi3jy2k4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 228/550] drm: Call drm_atomic_helper_shutdown() at shutdown/remove time for misc drivers
Date:   Wed, 15 Nov 2023 14:13:32 -0500
Message-ID: <20231115191616.555277941@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 3c4babae3c4a1ae05f8f3f5f3d50c440ead7ca6a ]

Based on grepping through the source code these drivers appear to be
missing a call to drm_atomic_helper_shutdown() at system shutdown time
and at driver remove (or unbind) time. Among other things, this means
that if a panel is in use that it won't be cleanly powered off at
system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart and at driver remove (or unbind) time comes
straight out of the kernel doc "driver instance overview" in
drm_drv.c.

A few notes about these fixes:
- I confirmed that these drivers were all DRIVER_MODESET type drivers,
  which I believe makes this relevant.
- I confirmed that these drivers were all DRIVER_ATOMIC.
- When adding drm_atomic_helper_shutdown() to the remove/unbind path,
  I added it after drm_kms_helper_poll_fini() when the driver had
  it. This seemed to be what other drivers did. If
  drm_kms_helper_poll_fini() wasn't there I added it straight after
  drm_dev_unregister().
- This patch deals with drivers using the component model in similar
  ways as the patch ("drm: Call drm_atomic_helper_shutdown() at
  shutdown time for misc drivers")
- These fixes rely on the patch ("drm/atomic-helper:
  drm_atomic_helper_shutdown(NULL) should be a noop") to simplify
  shutdown.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # tilcdc
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c |  7 +++++++
 drivers/gpu/drm/mgag200/mgag200_drv.c   |  8 ++++++++
 drivers/gpu/drm/pl111/pl111_drv.c       |  7 +++++++
 drivers/gpu/drm/stm/drv.c               |  7 +++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.c     | 11 ++++++++++-
 drivers/gpu/drm/tve200/tve200_drv.c     |  7 +++++++
 drivers/gpu/drm/vboxvideo/vbox_drv.c    | 10 ++++++++++
 7 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d207b03f8357c..78122b35a0cbb 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -358,11 +358,18 @@ static void aspeed_gfx_remove(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &aspeed_sysfs_attr_group);
 	drm_dev_unregister(drm);
 	aspeed_gfx_unload(drm);
+	drm_atomic_helper_shutdown(drm);
+}
+
+static void aspeed_gfx_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
 }
 
 static struct platform_driver aspeed_gfx_platform_driver = {
 	.probe		= aspeed_gfx_probe,
 	.remove_new	= aspeed_gfx_remove,
+	.shutdown	= aspeed_gfx_shutdown,
 	.driver = {
 		.name = "aspeed_gfx",
 		.of_match_table = aspeed_gfx_match,
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 976f0ab2006b5..797f7a0623178 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 
 #include <drm/drm_aperture.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_generic.h>
 #include <drm/drm_file.h>
@@ -278,6 +279,12 @@ static void mgag200_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
 	drm_dev_unregister(dev);
+	drm_atomic_helper_shutdown(dev);
+}
+
+static void mgag200_pci_shutdown(struct pci_dev *pdev)
+{
+	drm_atomic_helper_shutdown(pci_get_drvdata(pdev));
 }
 
 static struct pci_driver mgag200_pci_driver = {
@@ -285,6 +292,7 @@ static struct pci_driver mgag200_pci_driver = {
 	.id_table = mgag200_pciidlist,
 	.probe = mgag200_pci_probe,
 	.remove = mgag200_pci_remove,
+	.shutdown = mgag200_pci_shutdown,
 };
 
 drm_module_pci_driver_if_modeset(mgag200_pci_driver, mgag200_modeset);
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 43049c8028b21..57a7e6b93c717 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -326,12 +326,18 @@ static void pl111_amba_remove(struct amba_device *amba_dev)
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
 	drm_dev_unregister(drm);
+	drm_atomic_helper_shutdown(drm);
 	if (priv->panel)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_dev_put(drm);
 	of_reserved_mem_device_release(dev);
 }
 
+static void pl111_amba_shutdown(struct amba_device *amba_dev)
+{
+	drm_atomic_helper_shutdown(amba_get_drvdata(amba_dev));
+}
+
 /*
  * This early variant lacks the 565 and 444 pixel formats.
  */
@@ -434,6 +440,7 @@ static struct amba_driver pl111_amba_driver __maybe_unused = {
 	},
 	.probe = pl111_amba_probe,
 	.remove = pl111_amba_remove,
+	.shutdown = pl111_amba_shutdown,
 	.id_table = pl111_id_table,
 };
 
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index c387fb5a87c3d..477ea58557a2d 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -113,6 +113,7 @@ static void drv_unload(struct drm_device *ddev)
 	DRM_DEBUG("%s\n", __func__);
 
 	drm_kms_helper_poll_fini(ddev);
+	drm_atomic_helper_shutdown(ddev);
 	ltdc_unload(ddev);
 }
 
@@ -224,6 +225,11 @@ static void stm_drm_platform_remove(struct platform_device *pdev)
 	drm_dev_put(ddev);
 }
 
+static void stm_drm_platform_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id drv_dt_ids[] = {
 	{ .compatible = "st,stm32-ltdc"},
 	{ /* end node */ },
@@ -233,6 +239,7 @@ MODULE_DEVICE_TABLE(of, drv_dt_ids);
 static struct platform_driver stm_drm_platform_driver = {
 	.probe = stm_drm_platform_probe,
 	.remove_new = stm_drm_platform_remove,
+	.shutdown = stm_drm_platform_shutdown,
 	.driver = {
 		.name = "stm32-display",
 		.of_match_table = drv_dt_ids,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index fe56beea3e93f..8ebd7134ee21b 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -175,6 +175,7 @@ static void tilcdc_fini(struct drm_device *dev)
 		drm_dev_unregister(dev);
 
 	drm_kms_helper_poll_fini(dev);
+	drm_atomic_helper_shutdown(dev);
 	tilcdc_irq_uninstall(dev);
 	drm_mode_config_cleanup(dev);
 
@@ -389,6 +390,7 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 
 init_failed:
 	tilcdc_fini(ddev);
+	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
@@ -537,7 +539,8 @@ static void tilcdc_unbind(struct device *dev)
 	if (!ddev->dev_private)
 		return;
 
-	tilcdc_fini(dev_get_drvdata(dev));
+	tilcdc_fini(ddev);
+	dev_set_drvdata(dev, NULL);
 }
 
 static const struct component_master_ops tilcdc_comp_ops = {
@@ -582,6 +585,11 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void tilcdc_pdev_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id tilcdc_of_match[] = {
 		{ .compatible = "ti,am33xx-tilcdc", },
 		{ .compatible = "ti,da850-tilcdc", },
@@ -592,6 +600,7 @@ MODULE_DEVICE_TABLE(of, tilcdc_of_match);
 static struct platform_driver tilcdc_platform_driver = {
 	.probe      = tilcdc_pdev_probe,
 	.remove     = tilcdc_pdev_remove,
+	.shutdown   = tilcdc_pdev_shutdown,
 	.driver     = {
 		.name   = "tilcdc",
 		.pm     = pm_sleep_ptr(&tilcdc_pm_ops),
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 984aa8f0a5427..9fa6ea3ba9759 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -242,6 +242,7 @@ static void tve200_remove(struct platform_device *pdev)
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
 	drm_dev_unregister(drm);
+	drm_atomic_helper_shutdown(drm);
 	if (priv->panel)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_mode_config_cleanup(drm);
@@ -249,6 +250,11 @@ static void tve200_remove(struct platform_device *pdev)
 	drm_dev_put(drm);
 }
 
+static void tve200_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id tve200_of_match[] = {
 	{
 		.compatible = "faraday,tve200",
@@ -263,6 +269,7 @@ static struct platform_driver tve200_driver = {
 	},
 	.probe = tve200_probe,
 	.remove_new = tve200_remove,
+	.shutdown = tve200_shutdown,
 };
 drm_module_platform_driver(tve200_driver);
 
diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
index 4fee15c97c341..047b958123341 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -12,6 +12,7 @@
 #include <linux/vt_kern.h>
 
 #include <drm/drm_aperture.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_generic.h>
 #include <drm/drm_file.h>
@@ -97,11 +98,19 @@ static void vbox_pci_remove(struct pci_dev *pdev)
 	struct vbox_private *vbox = pci_get_drvdata(pdev);
 
 	drm_dev_unregister(&vbox->ddev);
+	drm_atomic_helper_shutdown(&vbox->ddev);
 	vbox_irq_fini(vbox);
 	vbox_mode_fini(vbox);
 	vbox_hw_fini(vbox);
 }
 
+static void vbox_pci_shutdown(struct pci_dev *pdev)
+{
+	struct vbox_private *vbox = pci_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(&vbox->ddev);
+}
+
 static int vbox_pm_suspend(struct device *dev)
 {
 	struct vbox_private *vbox = dev_get_drvdata(dev);
@@ -165,6 +174,7 @@ static struct pci_driver vbox_pci_driver = {
 	.id_table = pciidlist,
 	.probe = vbox_pci_probe,
 	.remove = vbox_pci_remove,
+	.shutdown = vbox_pci_shutdown,
 	.driver.pm = pm_sleep_ptr(&vbox_pm_ops),
 };
 
-- 
2.42.0



