Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71C7014B1
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEMGnz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEMGny (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B51F2D48
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 376CE61030
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC76AC433D2;
        Sat, 13 May 2023 06:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683960232;
        bh=3sHikeLWxVTEZBGG28lnoGvP4td2H6OLMxnKIpvTdMM=;
        h=Subject:To:Cc:From:Date:From;
        b=ceGtEvpCMAB/WmWgp1q9cb+d5B8CkEltKUdujeQZfS9yDSPcz8Dnx0knVd0as7CP0
         HiYWe3U3rnAaHBtRnXyVMIZ4CeWjr/unbDXCO1jyp1TqqYdaVakb65lALqwrxetwQk
         Ax2BlBjGyLekIcdImOGA+5Ec5G46cSiM+F/VEadU=
Subject: FAILED: patch "[PATCH] drm/msm: fix vram leak on bind errors" failed to apply to 5.15-stable tree
To:     johan+linaro@kernel.org, ctatlor97@gmail.com,
        dmitry.baryshkov@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:43:39 +0900
Message-ID: <2023051338-unthawed-shallow-1876@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 60d476af96015891c7959f30838ae7a9749932bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051338-unthawed-shallow-1876@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

60d476af9601 ("drm/msm: fix vram leak on bind errors")
214b09db6197 ("drm/msm: fix drm device leak on bind errors")
652eadfde810 ("Revert "drm/msm: Fix failure paths in msm_drm_init()"")
8636500300a0 ("drm/msm: Fix failure paths in msm_drm_init()")
2027e5b3413d ("drm/msm: Initialize MDSS irq domain at probe time")
ec919e6e7146 ("drm/msm: Allocate msm_drm_private early and pass it as driver data")
83b965d118cb ("Merge remote-tracking branch 'drm/drm-next' into msm-next-staging")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60d476af96015891c7959f30838ae7a9749932bf Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 6 Mar 2023 11:07:18 +0100
Subject: [PATCH] drm/msm: fix vram leak on bind errors

Make sure to release the VRAM buffer also in a case a subcomponent fails
to bind.

Fixes: d863f0c7b536 ("drm/msm: Call msm_init_vram before binding the gpu")
Cc: stable@vger.kernel.org      # 5.11
Cc: Craig Tatlor <ctatlor97@gmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/525094/
Link: https://lore.kernel.org/r/20230306100722.28485-7-johan+linaro@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ee05ba8cbd8e..4d85ca0ba0c1 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -52,6 +52,8 @@
 #define MSM_VERSION_MINOR	10
 #define MSM_VERSION_PATCHLEVEL	0
 
+static void msm_deinit_vram(struct drm_device *ddev);
+
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = msm_framebuffer_create,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
@@ -261,12 +263,7 @@ static int msm_drm_uninit(struct device *dev)
 	if (kms && kms->funcs)
 		kms->funcs->destroy(kms);
 
-	if (priv->vram.paddr) {
-		unsigned long attrs = DMA_ATTR_NO_KERNEL_MAPPING;
-		drm_mm_takedown(&priv->vram.mm);
-		dma_free_attrs(dev, priv->vram.size, NULL,
-			       priv->vram.paddr, attrs);
-	}
+	msm_deinit_vram(ddev);
 
 	component_unbind_all(dev, ddev);
 
@@ -404,6 +401,19 @@ static int msm_init_vram(struct drm_device *dev)
 	return ret;
 }
 
+static void msm_deinit_vram(struct drm_device *ddev)
+{
+	struct msm_drm_private *priv = ddev->dev_private;
+	unsigned long attrs = DMA_ATTR_NO_KERNEL_MAPPING;
+
+	if (!priv->vram.paddr)
+		return;
+
+	drm_mm_takedown(&priv->vram.mm);
+	dma_free_attrs(ddev->dev, priv->vram.size, NULL, priv->vram.paddr,
+			attrs);
+}
+
 static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 {
 	struct msm_drm_private *priv = dev_get_drvdata(dev);
@@ -450,7 +460,7 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
 	if (ret)
-		goto err_put_dev;
+		goto err_deinit_vram;
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
@@ -548,6 +558,8 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 	return ret;
 
+err_deinit_vram:
+	msm_deinit_vram(ddev);
 err_put_dev:
 	drm_dev_put(ddev);
 

