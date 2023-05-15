Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61A7037E7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbjEORZC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbjEORYm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828BC11DA0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 605C262C92
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EADC433D2;
        Mon, 15 May 2023 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171422;
        bh=qRacf3d9zqa8JPCICGZ9g6cRbmCDnT/mRzFISU6SVus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqfFIcyM9HdZ1DUqdr6CwMVfHgv92iaL0wY8gaNJvWM45NIXSaySv7zFeBE11Tumr
         KeOkTR6uyhSxroWEt212M/VVreeJOUesrMXL7qy2pEiKhTCNpFlOI19DZFnRleBuOM
         KFJpuvBtXmihgR4sRMIzKJSPhUBfW36iLBWC8FiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Craig Tatlor <ctatlor97@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 6.2 174/242] drm/msm: fix vram leak on bind errors
Date:   Mon, 15 May 2023 18:28:20 +0200
Message-Id: <20230515161727.097492076@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

commit 60d476af96015891c7959f30838ae7a9749932bf upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_drv.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -50,6 +50,8 @@
 #define MSM_VERSION_MINOR	9
 #define MSM_VERSION_PATCHLEVEL	0
 
+static void msm_deinit_vram(struct drm_device *ddev);
+
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = msm_framebuffer_create,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
@@ -259,12 +261,7 @@ static int msm_drm_uninit(struct device
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
 
@@ -402,6 +399,19 @@ static int msm_init_vram(struct drm_devi
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
@@ -448,7 +458,7 @@ static int msm_drm_init(struct device *d
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
 	if (ret)
-		goto err_put_dev;
+		goto err_deinit_vram;
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
@@ -546,6 +556,8 @@ err_msm_uninit:
 
 	return ret;
 
+err_deinit_vram:
+	msm_deinit_vram(ddev);
 err_put_dev:
 	drm_dev_put(ddev);
 


