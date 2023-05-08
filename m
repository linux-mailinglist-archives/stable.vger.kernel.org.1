Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15A26FAAE1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjEHLHp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjEHLHC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E6F7AA6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C093262A6A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF50C433EF;
        Mon,  8 May 2023 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543977;
        bh=5f4nbK/hrp9CBAgQU0bptYs6wAEMK8Dc/y0MRXxliYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtMQZ11E9X/+sSEY61SXozZIAyEVt2kf4yps9Fiht9fqq0RuGjkVmFsRFzu5HlLaB
         dN65wznlGUSf7Jn5eeD2vrrP7pstKYB4nRLNF26rwm9KajSRPdlD7HDNPdAaRD9xI1
         pIXs5RKI/uS5Qon2VEUe3OPOhX49ezmDmNqApgGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 263/694] Revert "drm/msm: Fix failure paths in msm_drm_init()"
Date:   Mon,  8 May 2023 11:41:38 +0200
Message-Id: <20230508094440.813452029@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

[ Upstream commit 652eadfde81031c7b3d8b21bdbcfdd6eb217dec8 ]

This reverts commit 8636500300a01740d92b345c680b036b94555b1b.

A recent commit tried to address a drm device leak in the early
msm_drm_uninit() error paths but ended up making things worse.

Specifically, it moved the drm device reference put in msm_drm_uninit()
to msm_drm_init() which means that the drm would now be leaked on normal
unbind.

For reasons that were never spelled out, it also added kms NULL pointer
checks to a couple of helper functions that had nothing to do with the
paths modified by the patch.

Instead of trying to salvage this incrementally, let's revert the bad
commit so that clean and backportable fixes can be added in its place.

Fixes: 8636500300a0 ("drm/msm: Fix failure paths in msm_drm_init()")
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/525092/
Link: https://lore.kernel.org/r/20230306100722.28485-3-johan+linaro@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c |  3 ---
 drivers/gpu/drm/msm/msm_drv.c                | 11 ++++-------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
index b73031cd48e48..e75b97127c0d1 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
@@ -129,9 +129,6 @@ void msm_disp_snapshot_destroy(struct drm_device *drm_dev)
 	}
 
 	priv = drm_dev->dev_private;
-	if (!priv->kms)
-		return;
-
 	kms = priv->kms;
 
 	if (kms->dump_worker)
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index b7f5a78eadd4a..9ded384acba46 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -150,9 +150,6 @@ static void msm_irq_uninstall(struct drm_device *dev)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_kms *kms = priv->kms;
 
-	if (!priv->kms)
-		return;
-
 	kms->funcs->irq_uninstall(kms);
 	if (kms->irq_requested)
 		free_irq(kms->irq, dev);
@@ -270,6 +267,8 @@ static int msm_drm_uninit(struct device *dev)
 	component_unbind_all(dev, ddev);
 
 	ddev->dev_private = NULL;
+	drm_dev_put(ddev);
+
 	destroy_workqueue(priv->wq);
 
 	return 0;
@@ -442,12 +441,12 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 	ret = msm_init_vram(ddev);
 	if (ret)
-		goto err_drm_dev_put;
+		return ret;
 
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
 	if (ret)
-		goto err_drm_dev_put;
+		return ret;
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
@@ -542,8 +541,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 err_msm_uninit:
 	msm_drm_uninit(dev);
-err_drm_dev_put:
-	drm_dev_put(ddev);
 	return ret;
 }
 
-- 
2.39.2



