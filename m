Return-Path: <stable+bounces-204610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E608CF2CB6
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0584E3001BE3
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E012727FC;
	Mon,  5 Jan 2026 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gTBBOe1i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91AA27FB1B
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605330; cv=none; b=MSOdUR8EGie15Z8ivSSQ9ITGxncFNbPH5W9oAkV7YCCT7VUEm9F7Hz8rMP2CVpDb+iA1euwRnCKQMT5DNu+SYeRpEEMw9SjavU5jiXtNjr2MFdEZHp9vFrXQDAWZfEXtcbMJp0A3iSqzYPWWIuoE11EmQc5ZUfSKY/cmGE97zEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605330; c=relaxed/simple;
	bh=NJzhgNugZMlX5EQCpAQelHYXK7aN4wDc8b/I8/5TdLE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rCGUVv1pkjE4sR4Uhmt3jMvH5QS9goxqhWnvirm7+WP2CtO7ZpBFphnC+i6rsbEShVH+2WhKk9IOq1af/pk2zgr3oBg2lN39wj5pMQQqChsvldSVYDWAIVWv/5gdrxx5c3WefB1sdSQMq1iUV5ga3BUzyLtkzFZcqIgP5gmwQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gTBBOe1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C870C116D0;
	Mon,  5 Jan 2026 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767605329;
	bh=NJzhgNugZMlX5EQCpAQelHYXK7aN4wDc8b/I8/5TdLE=;
	h=Subject:To:Cc:From:Date:From;
	b=gTBBOe1i26Shh6lfJobW/9sUJmePL4cVouP0NX6Wt6PsOU08a00WkXusmHJDlUiOe
	 k8BIfdPsMshp9kKFWVVXhgFLkUxf+kn5kc33Xavf6utgbsgw/7ugNrn2K4k30dTXXF
	 EQ/BpS0N0UUypab3lYVOmHaCxTJJ3a5x7SAAs4Xk=
Subject: FAILED: patch "[PATCH] iommu/mediatek-v1: fix device leaks on probe()" failed to apply to 6.1-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,honghui.zhang@mediatek.com,joerg.roedel@amd.com,robin.murphy@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:28:45 +0100
Message-ID: <2026010545-bleak-stingily-e2a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 46207625c9f33da0e43bb4ae1e91f0791b6ed633
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010545-bleak-stingily-e2a3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


