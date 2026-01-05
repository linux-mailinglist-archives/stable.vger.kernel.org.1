Return-Path: <stable+bounces-204611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A200CF2C08
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B36E9300AB3E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C89832D0E1;
	Mon,  5 Jan 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CgRuODZ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A0331A7E1
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605339; cv=none; b=HJai2sYo70bf3FYghsjKz54DH7qPwOoXgBi1Nr6BdaxvWgGmQHGs48nLpSPEujWhXuYQv4quS158Op9rBk1Uv52M8F6FyLMsSlcOvrvjD0ykWSpaEKAobLXr3H4R4q9QQSgpa0XPIIqkv1v88r0/JXaV3yACnqqLPtPkygLyrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605339; c=relaxed/simple;
	bh=AZByXOuUcw1Wn3mtPAJ2qUPHf7WBAH2TXgSAcfACp0c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c0ByXVmqYGqnHblbQM/DlnllvALsjVkzt4b9VIWXVBkSGanlFoqeCIb0gimWm3nhOzDFsFYFWDYF53V6gSE0XuuS3XttTz7cPUc1tb/xd15bgvEJI7XHYnXm5w+BzgE0KQeVDKnzFUnBb7iI/XzaIVjIJ4lTaGbQSENEnI7wRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CgRuODZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF63C116D0;
	Mon,  5 Jan 2026 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767605337;
	bh=AZByXOuUcw1Wn3mtPAJ2qUPHf7WBAH2TXgSAcfACp0c=;
	h=Subject:To:Cc:From:Date:From;
	b=CgRuODZ1mI7eFvPB5rHmekEtCwxVoyyBQs4b4O0rlHhAwH2GS2CGKugzwrsGKuqXS
	 khy/GMwG+emtGaJy3WAB00coKSQV4J7wzKsY7ceeLQePOi44Vw7ZQDGopoyd7xLNWm
	 fusi/lIKkK1CAbRjMGonldsYOJXS/8YXe1vc8MP8=
Subject: FAILED: patch "[PATCH] iommu/mediatek-v1: fix device leaks on probe()" failed to apply to 5.10-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,honghui.zhang@mediatek.com,joerg.roedel@amd.com,robin.murphy@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:28:46 +0100
Message-ID: <2026010546-legal-defensive-40e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 46207625c9f33da0e43bb4ae1e91f0791b6ed633
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010546-legal-defensive-40e8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46207625c9f33da0e43bb4ae1e91f0791b6ed633 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 20 Oct 2025 06:53:13 +0200
Subject: [PATCH] iommu/mediatek-v1: fix device leaks on probe()

Make sure to drop the references taken to the larb devices during
probe on probe failure (e.g. probe deferral) and on driver unbind.

Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
Cc: stable@vger.kernel.org	# 4.8
Cc: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 363c61a0009c..86686455e911 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -651,8 +651,10 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 		struct platform_device *plarbdev;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
-		if (!larbnode)
-			return -EINVAL;
+		if (!larbnode) {
+			ret = -EINVAL;
+			goto out_put_larbs;
+		}
 
 		if (!of_device_is_available(larbnode)) {
 			of_node_put(larbnode);
@@ -662,11 +664,14 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 		plarbdev = of_find_device_by_node(larbnode);
 		if (!plarbdev) {
 			of_node_put(larbnode);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto out_put_larbs;
 		}
 		if (!plarbdev->dev.driver) {
 			of_node_put(larbnode);
-			return -EPROBE_DEFER;
+			put_device(&plarbdev->dev);
+			ret = -EPROBE_DEFER;
+			goto out_put_larbs;
 		}
 		data->larb_imu[i].dev = &plarbdev->dev;
 
@@ -678,7 +683,7 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 
 	ret = mtk_iommu_v1_hw_init(data);
 	if (ret)
-		return ret;
+		goto out_put_larbs;
 
 	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
 				     dev_name(&pdev->dev));
@@ -700,12 +705,17 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&data->iommu);
 out_clk_unprepare:
 	clk_disable_unprepare(data->bclk);
+out_put_larbs:
+	for (i = 0; i < MTK_LARB_NR_MAX; i++)
+		put_device(data->larb_imu[i].dev);
+
 	return ret;
 }
 
 static void mtk_iommu_v1_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_v1_data *data = platform_get_drvdata(pdev);
+	int i;
 
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
@@ -713,6 +723,9 @@ static void mtk_iommu_v1_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_v1_com_ops);
+
+	for (i = 0; i < MTK_LARB_NR_MAX; i++)
+		put_device(data->larb_imu[i].dev);
 }
 
 static int __maybe_unused mtk_iommu_v1_suspend(struct device *dev)


