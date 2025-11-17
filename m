Return-Path: <stable+bounces-194932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7C1C62D19
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 08:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A563B3742
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B231A577;
	Mon, 17 Nov 2025 07:57:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445521C160;
	Mon, 17 Nov 2025 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366274; cv=none; b=LzMgGka2HEVU4OadIfC5E19csMvfikQkgBTUhPJzsbqyJcM0O1YVl3o3SqpyJqKrq5ovFbD62VRDMmxZw2Q1ncPzWpHsF1wauAJLGEKQXDgRuCb20rRobV4hi3YqGKS+qKgzbnuwTQkiqnsxu39D63EGFgbFG0eHvOTvpHUsZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366274; c=relaxed/simple;
	bh=i8q+m09GwUEEZoxOJKaz9w8iBQ6VSGJmRsH+HNHGMqM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=InTlVDQRreTg8gUYOe6euaymasP0yySVpBrPErRl/26Uc6h8HHh4yI8PMUuF830jnzQPLWypsw8mCehzvhNwja7H6QG0SgJkSux7Gp4reErM9gPPxmdWj/+aTNIndeNObtlBSl51et7B/NCt+lhuOqS0GQ6eegnggVfeYs9hEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-01 (Coremail) with SMTP id qwCowABH4M9W1Rppg5AGAQ--.247S2;
	Mon, 17 Nov 2025 15:57:21 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: anitha.chrisanthus@intel.com,
	edmund.j.dea@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/kmb: Fix error handling in kmb_probe
Date: Mon, 17 Nov 2025 15:57:08 +0800
Message-Id: <20251117075708.37414-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:qwCowABH4M9W1Rppg5AGAQ--.247S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry8uF43tryftrWkXF4fZrb_yoW8tF1DpF
	ZrGFyrtrW8Gr4IkrW7Z3W8Za43Aa17tayfursrG34kWr4Yyr9FgF97Z3W2yayrJFW8WFWx
	tFZrKa18uF4DXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbsmitUU
	UUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

kmb_probe() obtain a reference to a platform device by
of_find_device_by_node(). This call increases the reference count of
the returned device, which should be dropped by calling put_device()
when the device is no longer needed. However, the code fails to call
put_device() in several error handling paths and the normal device
removal path. This could result in reference count leaks that prevent
the proper cleanup of the platform device when the driver is unloaded
or during error recovery.

Add put_device() in all code paths where dsi_pdev is no longer needed,
including error paths and the normal removal path.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 32cda134ae3e..4fc9fdf92118 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -473,6 +473,8 @@ static void kmb_remove(struct platform_device *pdev)
 
 	/* Unregister DSI host */
 	kmb_dsi_host_unregister(kmb->kmb_dsi);
+	if (kmb->kmb_dsi && kmb->kmb_dsi->pdev)
+		put_device(&kmb->kmb_dsi->pdev->dev);
 	drm_atomic_helper_shutdown(drm);
 }
 
@@ -517,17 +519,20 @@ static int kmb_probe(struct platform_device *pdev)
 	ret = kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));
 
 	if (ret == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto err_free2;
 	} else if (ret) {
 		DRM_ERROR("probe failed to initialize DSI host bridge\n");
-		return ret;
+		goto err_free2;
 	}
 
 	/* Create DRM device */
 	kmb = devm_drm_dev_alloc(dev, &kmb_driver,
 				 struct kmb_drm_private, drm);
-	if (IS_ERR(kmb))
-		return PTR_ERR(kmb);
+	if (IS_ERR(kmb)) {
+		ret = PTR_ERR(kmb);
+		goto err_free2;
+	}
 
 	dev_set_drvdata(dev, &kmb->drm);
 
@@ -576,7 +581,8 @@ static int kmb_probe(struct platform_device *pdev)
  err_free1:
 	dev_set_drvdata(dev, NULL);
 	kmb_dsi_host_unregister(kmb->kmb_dsi);
-
+ err_free2:
+	put_device(&dsi_pdev->dev);
 	return ret;
 }
 
-- 
2.17.1


