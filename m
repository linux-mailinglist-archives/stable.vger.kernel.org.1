Return-Path: <stable+bounces-187922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083DBEF53D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89612189931F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237DF2C3260;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMVW3WAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13842C0F92;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936197; cv=none; b=hR7U0w40fLxIy1+Ug5Qvr7OClmKqTNwo/gmlhXF70UVvH+uEZg/akHRonjO8CmpLmGnMPhxFcF/odigzPrID4Utf3WP/ubXnhge4RmSxJ7Mhz7RFbcoIl6oewoqYZL/GSaMDfjpWYarxF19d5ADg07t3AN7oSu7IvQY4frb9Yks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936197; c=relaxed/simple;
	bh=4nJz45e/2tb3rsqBi1FGg7jxKLaVlWYuDQzcHcXUw2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcovDCMKIL0xc+ALP5blHDDw2ihYTZmSl1aFMovujV+oJDOoTQTtgkX5q+NkpDoxfMYvKeueNaEXqdEE/jEZgiolqcaTYAwn1xa7l51wYyJg4qPPTZTPfyksExdjQVCdT/bdAIOWaAfkZNWr/3vPPZ0aG07fumDtgh+JTypLpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMVW3WAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDA7C4CEFB;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=4nJz45e/2tb3rsqBi1FGg7jxKLaVlWYuDQzcHcXUw2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMVW3WACgvVpiecGOj9ZfELxTZ08BJCPHoAGgS3nNQZ988hWxlg/+v5hyYs7+Z7Cx
	 1mEkxTTA8iUoGSMYNdVY2GX8S6PAE8VI8QQZZMMFd7BmEsWEwDZBnwOEJC6GSSLRNP
	 Lk4jsQcheR2gmt9QghskgqRvLmIzh5OwWRRcf7WkUdwESNp9cHi3DxEoTbEuDvihht
	 F1ztnNNFYIiwE7g4gv3WigO+q4vWM8hJvSJWkanZdlmfj2tP2xabfz73q/WaCe2Q2C
	 6nvRPIU1xloyBRj51CFgbXOkcLKaQiGdGf0vOTxaCmRDm4gZzWdiGTNgimFRmUVlFG
	 7fPfxDhxd+XDQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-0000000083M-2SGu;
	Mon, 20 Oct 2025 06:56:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH v3 09/14] iommu/mediatek-v1: fix device leaks on probe()
Date: Mon, 20 Oct 2025 06:53:13 +0200
Message-ID: <20251020045318.30690-10-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251020045318.30690-1-johan@kernel.org>
References: <20251020045318.30690-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the references taken to the larb devices during
probe on probe failure (e.g. probe deferral) and on driver unbind.

Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
Cc: stable@vger.kernel.org	# 4.8
Cc: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/mtk_iommu_v1.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index de9153c0a82f..44b965a2db92 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -648,8 +648,10 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
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
@@ -659,11 +661,14 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
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
 
@@ -675,7 +680,7 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 
 	ret = mtk_iommu_v1_hw_init(data);
 	if (ret)
-		return ret;
+		goto out_put_larbs;
 
 	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
 				     dev_name(&pdev->dev));
@@ -697,12 +702,17 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
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
@@ -710,6 +720,9 @@ static void mtk_iommu_v1_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_v1_com_ops);
+
+	for (i = 0; i < MTK_LARB_NR_MAX; i++)
+		put_device(data->larb_imu[i].dev);
 }
 
 static int __maybe_unused mtk_iommu_v1_suspend(struct device *dev)
-- 
2.49.1


