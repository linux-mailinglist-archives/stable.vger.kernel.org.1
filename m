Return-Path: <stable+bounces-204838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60798CF480C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 184FD3121073
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592BB3148DF;
	Mon,  5 Jan 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiAqtTcd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D6314A65
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627144; cv=none; b=jd3qPHm88qYl9J4Lpbeazmn/y1fkw+9AP/5eqt4C3J4bG4xW+GFJdAXF6VLra5ZuCg6TQGHX7I+bLIk3d6D49O7x8gjHXiKgf54peMr5m4Comz/hnjwlFguAfFvgEJB4W2ejKbcun807doY39QHKL916xuSx8ayReYXCQYJ0aDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627144; c=relaxed/simple;
	bh=NAzmhoupjmG+4CPF3AVlecWu8w9J5FitUzYLprvW4K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1yVWdxEFGKnhm7xzYIiVeBbPpojI6WOevGnwYlaPRVPJ5mWju1oNpzfRpgzPZQvwUZBkdyXqiUR02Yc0AHvQl3wA7sAj7eeILJlSC5bPYH4wxas1RIupceuSA5tCWCgjQsHHW3Ui8QwIeZUzmQlRULJfcHmIwv3mIeCjlg6uHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiAqtTcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB81C19424;
	Mon,  5 Jan 2026 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627144;
	bh=NAzmhoupjmG+4CPF3AVlecWu8w9J5FitUzYLprvW4K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LiAqtTcdHVd9ywwE3iqy4TKwRP13It3hA2PVf9/0MqQidMWxhSpTpA61yT/9rQMEY
	 hq0uDcUMXCEQW0dD9kBAq+zUcPM3EhE52KoclilDj/ZOHHqkp2t8mCSHU4TY1HdQil
	 zkzeNKSrWtts+r5fdT21WeObLOvGW/qgbM2YM4jwDwRnF5WGPQifDaSPmBc44vZ2OS
	 5g6nFujSECk3SCuUG4z4EjzXB3U9WI8kSk3Xd/c5VrdUBnbxq6c05/Oy7ynXSqWrDy
	 559bGWYFnHoE3d/jlPCgkL3kvnMPLbh+kPJD25xhZumh/Be+t3cD9A4qZXk7h4e6TE
	 kTm66cSn1DSTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Honghui Zhang <honghui.zhang@mediatek.com>,
	Robin Murphy <robin.murphy@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iommu/mediatek-v1: fix device leaks on probe()
Date: Mon,  5 Jan 2026 10:32:20 -0500
Message-ID: <20260105153220.2637603-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105153220.2637603-1-sashal@kernel.org>
References: <2026010545-bleak-stingily-e2a3@gregkh>
 <20260105153220.2637603-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 46207625c9f33da0e43bb4ae1e91f0791b6ed633 ]

Make sure to drop the references taken to the larb devices during
probe on probe failure (e.g. probe deferral) and on driver unbind.

Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
Cc: stable@vger.kernel.org	# 4.8
Cc: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu_v1.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 47334c3d41e6..ead2d06aaf62 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -654,8 +654,10 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
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
@@ -665,11 +667,14 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
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
 
@@ -681,7 +686,7 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 
 	ret = mtk_iommu_v1_hw_init(data);
 	if (ret)
-		return ret;
+		goto out_put_larbs;
 
 	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
 				     dev_name(&pdev->dev));
@@ -703,12 +708,17 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
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
@@ -716,6 +726,9 @@ static void mtk_iommu_v1_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_v1_com_ops);
+
+	for (i = 0; i < MTK_LARB_NR_MAX; i++)
+		put_device(data->larb_imu[i].dev);
 }
 
 static int __maybe_unused mtk_iommu_v1_suspend(struct device *dev)
-- 
2.51.0


