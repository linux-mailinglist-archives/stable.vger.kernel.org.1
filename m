Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9979E8AB
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbjIMNIA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 09:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbjIMNIA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 09:08:00 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0227119BD
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 06:07:55 -0700 (PDT)
Received: from mchehab by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <mchehab@linuxtv.org>)
        id 1qgPaz-003iNB-Rg; Wed, 13 Sep 2023 13:07:53 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Wed, 13 Sep 2023 13:04:03 +0000
Subject: [git:media_stage/master] media: qcom: camss: Fix genpd cleanup
To:     linuxtv-commits@linuxtv.org
Cc:     stable@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qgPaz-003iNB-Rg@www.linuxtv.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: qcom: camss: Fix genpd cleanup
Author:  Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:    Wed Aug 30 16:16:08 2023 +0100

Right now we never release the power-domains properly on the error path.
Add a routine to be reused for this purpose and appropriate jumps in
probe() to run that routine where necessary.

Fixes: 2f6f8af67203 ("media: camss: Refactor VFE power domain toggling")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/qcom/camss/camss.c | 35 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

---

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index a925b2bfd898..c6df862c79e3 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1538,6 +1538,20 @@ static int camss_icc_get(struct camss *camss)
 	return 0;
 }
 
+static void camss_genpd_cleanup(struct camss *camss)
+{
+	int i;
+
+	if (camss->genpd_num == 1)
+		return;
+
+	if (camss->genpd_num > camss->vfe_num)
+		device_link_del(camss->genpd_link[camss->genpd_num - 1]);
+
+	for (i = 0; i < camss->genpd_num; i++)
+		dev_pm_domain_detach(camss->genpd[i], true);
+}
+
 /*
  * camss_probe - Probe CAMSS platform device
  * @pdev: Pointer to CAMSS platform device
@@ -1627,11 +1641,11 @@ static int camss_probe(struct platform_device *pdev)
 
 	ret = camss_init_subdevices(camss);
 	if (ret < 0)
-		return ret;
+		goto err_genpd_cleanup;
 
 	ret = dma_set_mask_and_coherent(dev, 0xffffffff);
 	if (ret)
-		return ret;
+		goto err_genpd_cleanup;
 
 	camss->media_dev.dev = camss->dev;
 	strscpy(camss->media_dev.model, "Qualcomm Camera Subsystem",
@@ -1643,7 +1657,7 @@ static int camss_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		return ret;
+		goto err_genpd_cleanup;
 	}
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
@@ -1693,28 +1707,19 @@ err_register_subdevs:
 err_v4l2_device_unregister:
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
+err_genpd_cleanup:
+	camss_genpd_cleanup(camss);
 
 	return ret;
 }
 
 void camss_delete(struct camss *camss)
 {
-	int i;
-
 	v4l2_device_unregister(&camss->v4l2_dev);
 	media_device_unregister(&camss->media_dev);
 	media_device_cleanup(&camss->media_dev);
 
 	pm_runtime_disable(camss->dev);
-
-	if (camss->genpd_num == 1)
-		return;
-
-	if (camss->genpd_num > camss->vfe_num)
-		device_link_del(camss->genpd_link[camss->genpd_num - 1]);
-
-	for (i = 0; i < camss->genpd_num; i++)
-		dev_pm_domain_detach(camss->genpd[i], true);
 }
 
 /*
@@ -1733,6 +1738,8 @@ static void camss_remove(struct platform_device *pdev)
 
 	if (atomic_read(&camss->ref_count) == 0)
 		camss_delete(camss);
+
+	camss_genpd_cleanup(camss);
 }
 
 static const struct of_device_id camss_dt_match[] = {
