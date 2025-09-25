Return-Path: <stable+bounces-181716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965EB9F3E0
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD4019C764C
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECBC3043B0;
	Thu, 25 Sep 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaj/Sszk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD4301718;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=T1pUXKZP8KF+kAHDq/HJoexs0gfKvj37O9aHpsG1/Lbpo0xJOEjw5PYKgyJyVpmMMAbWksYX9OHpZe0UMm8fc2vH5qmGzCtFpXzp1dytCNIcMa8f9I3IP9jn+pYSMoBktT4OvMNkGeVIc3qCHW5rQ78csHFu/pS7o8awhQWcZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=jqLOzkXzV8GyacDpHN3Ijll0a2FogTVBOSmIT38pEq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY2nP6Mgwjujz+Xset2byNFfLoAKg5rppdiv1NWXoV9JLWyXTE3T5W2Pr3ozCIfDQGam7saJ19cekp4AjWzC8UtXUHttzKoNvL9lsvZZCwVV93Ks0i0HgXpKIXju4KPRGvTDMef4X8Ep5U3uRwrVWxRYKrV5IsMyof8MFZrGODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaj/Sszk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA49C113CF;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803350;
	bh=jqLOzkXzV8GyacDpHN3Ijll0a2FogTVBOSmIT38pEq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaj/SszkRpJVA0QEGh85hCG9gXW2Z5NClefZ64xfeNId/dS3Va6R0j2yMwoNhnDMm
	 VxfuWdZaOW9dmxMFj/hLjDFje5SaBRtxkcvp/iAUqjpqEQ3FrnUZFgSb5RfIPKEEKE
	 Rw5eiXLu7NZooOaGyOM5a6Gu9wrMC0L0dpZkkjcsVFf8WcqqRsaU0+sGYFjhU6FaUT
	 8ZZYiIaGs0Pr8eL3tHTisPr5ZEkGYAHX/Dt+GrKYQfj0FNH+Drfd12R5ZM+GhiG3v+
	 AB6DudQ8yfR+lz3ewUfRGuYgaXAhRo1DiTN51Ikg+5Yoh5gDQw8ojDcnsD73yor9e4
	 dpikZ02lUinxw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5q-000000002rn-42KM;
	Thu, 25 Sep 2025 14:29:02 +0200
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
Subject: [PATCH 09/14] iommu/mediatek-v1: fix device leaks on probe()
Date: Thu, 25 Sep 2025 14:27:51 +0200
Message-ID: <20250925122756.10910-10-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250925122756.10910-1-johan@kernel.org>
References: <20250925122756.10910-1-johan@kernel.org>
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


