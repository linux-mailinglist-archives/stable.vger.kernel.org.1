Return-Path: <stable+bounces-194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A62B67F7527
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35063B210F6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A22228DCC;
	Fri, 24 Nov 2023 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcijxXsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50172286B0
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639BFC433CD;
	Fri, 24 Nov 2023 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700832714;
	bh=FW6D1yNpWqPEh03+r96AM7AXfO9H5IumWNwqYsXpghc=;
	h=Subject:To:Cc:From:Date:From;
	b=hcijxXsXh0AAGT1o5xrpCcl/ODUrWjAUrDkMWOWaEEQ0M51xmcK3DBV8MLre4OQO0
	 knAmUIK73NSP/nwSVub78o+Rg2aP1IkPfmIjOg4fsot6UtMI3/ukAiDZ1eYm280NeR
	 VaA/WMtQZg3NO5MwzstJNJKkVhD3O4FxP/UYNSyk=
Subject: FAILED: patch "[PATCH] media: qcom: camss: Fix genpd cleanup" failed to apply to 5.15-stable tree
To: bryan.odonoghue@linaro.org,hverkuil-cisco@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:31:41 +0000
Message-ID: <2023112440-vanquish-unusual-1564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f69791c39745e64621216fe8919cb73c0065002b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112440-vanquish-unusual-1564@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f69791c39745 ("media: qcom: camss: Fix genpd cleanup")
b278080a89f4 ("media: qcom: camss: Fix V4L2 async notifier error path")
7405116519ad ("media: qcom: camss: Fix pm_domain_on sequence in probe")
5651bab6890a ("media: qcom: Initialise V4L2 async notifier later")
428bbf4be401 ("media: camss: Convert to platform remove callback returning void")
46cc03175498 ("media: camss: Split power domain management")
3d658980e6da ("media: camss: Do not attach an already attached power domain on MSM8916 platform")
cf295629e3d6 ("media: camss: Allocate camss struct as a managed device resource")
6b1814e26989 ("media: camss: Allocate power domain resources dynamically")
5ba38efb2622 ("media: camss: Add SM8250 bandwdith configuration support")
b4436a18eedb ("media: camss: add support for SM8250 camss")
4edc8eae715c ("media: camss: Add initial support for VFE hardware version Titan 480")
3c8c15391481 ("media: v4l: async: Rename async nf functions, clean up long lines")
2070893aed11 ("media: rcar-vin: Move group async notifier")
161b56a82dba ("media: rcar-vin: Rename array storing subdevice information")
6df305779291 ("media: rcar-vin: Improve async notifier cleanup paths")
b2dc5680aeb4 ("media: rcar-vin: Refactor controls creation for video device")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f69791c39745e64621216fe8919cb73c0065002b Mon Sep 17 00:00:00 2001
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 30 Aug 2023 16:16:08 +0100
Subject: [PATCH] media: qcom: camss: Fix genpd cleanup

Right now we never release the power-domains properly on the error path.
Add a routine to be reused for this purpose and appropriate jumps in
probe() to run that routine where necessary.

Fixes: 2f6f8af67203 ("media: camss: Refactor VFE power domain toggling")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

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
@@ -1693,28 +1707,19 @@ static int camss_probe(struct platform_device *pdev)
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


