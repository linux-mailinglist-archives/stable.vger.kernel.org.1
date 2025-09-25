Return-Path: <stable+bounces-181715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C158B9F3E6
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015F27A9019
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7693043A5;
	Thu, 25 Sep 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUnu9aK1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848430170D;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=TEyQqJ3KmfzKvl61zGaRnyXMUOL5EinDv31VoM8u7AmG67LYvbQIsBCloAihP8A5PAe2bX7SWMS+LU1hvTZ2HkI8KJihngmf18Fi7heuI9QaUj36ytcQO6TyDx3zf3L9yccuw3bRY/E/YYJdV9OFgvjTNOYXIjIpfPI51hHxtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=f/1Rw/znaTZwRuQsTBACfXiJL0QSB5DXvUS+XMaPG78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVlviBRJQIxjezV9VoJyPjQVyyHRc4qpNzwz5erDWTdWeNkLyCxwKUGF0sWtPDLCG5/e/b8643oGtSBAFxxBbUmWa6OUfwaTFjjdHq1HBbck6ggXnHVBkljWUfjBwEpghBGsABAd8C8l0rNwTs3ov5Kg47fzaZP0FUchw2d9XFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUnu9aK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFB0C116D0;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803350;
	bh=f/1Rw/znaTZwRuQsTBACfXiJL0QSB5DXvUS+XMaPG78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUnu9aK1qUTu4sn4yylT/yBMTvNuUqpACxSFQRb5sEruuEQLKg4iF4DyawTTO9YwU
	 Q9CTjWhMrxfpl5BeUDiQg13wFlDhofM4LvazAWweEe56Al8O+OnhoywECg86NZ9/9K
	 IWT6+hnVAvoY86ZjGUSiJXw6GrwRmvjcZ2arsxDf1JLX5PQ67TU70VD4apoEv9Zs6v
	 Sc5FZ2dOX1QgazbwU51yxhuOE5hiEdC6U4+860AOcYcwNLAa6XGmADf/qdacEpxMLm
	 EYr9YvJ6DCbzVq8JRZZJXCVTFr+ZOrWW5jAS9vYJtRthvEMZJKmHTqf4RUH5pRayW4
	 cqKeCgIsqFO+w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5r-000000002ru-0ahz;
	Thu, 25 Sep 2025 14:29:03 +0200
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
	Suman Anna <s-anna@ti.com>
Subject: [PATCH 11/14] iommu/omap: fix device leaks on probe_device()
Date: Thu, 25 Sep 2025 14:27:53 +0200
Message-ID: <20250925122756.10910-12-johan@kernel.org>
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

Make sure to drop the reference taken to the iommu platform devices
during probe_device() on errors and when the device is later released.

Fixes: 9d5018deec86 ("iommu/omap: Add support to program multiple iommus")
Fixes: 7d6827748d54 ("iommu/omap: Fix iommu archdata name for DT-based devices")
Cc: stable@vger.kernel.org	# 3.18
Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/omap-iommu.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6fb93927bdb9..77023d49bd24 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1636,7 +1636,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 	struct platform_device *pdev;
 	struct omap_iommu *oiommu;
 	struct device_node *np;
-	int num_iommus, i;
+	int num_iommus, i, ret;
 
 	/*
 	 * Allocate the per-device iommu structure for DT-based devices.
@@ -1663,22 +1663,22 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 	for (i = 0, tmp = arch_data; i < num_iommus; i++, tmp++) {
 		np = of_parse_phandle(dev->of_node, "iommus", i);
 		if (!np) {
-			kfree(arch_data);
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto err_put_iommus;
 		}
 
 		pdev = of_find_device_by_node(np);
 		if (!pdev) {
 			of_node_put(np);
-			kfree(arch_data);
-			return ERR_PTR(-ENODEV);
+			ret = -ENODEV;
+			goto err_put_iommus;
 		}
 
 		oiommu = platform_get_drvdata(pdev);
 		if (!oiommu) {
 			of_node_put(np);
-			kfree(arch_data);
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto err_put_iommus;
 		}
 
 		tmp->iommu_dev = oiommu;
@@ -1697,17 +1697,28 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 	oiommu = arch_data->iommu_dev;
 
 	return &oiommu->iommu;
+
+err_put_iommus:
+	for (tmp = arch_data; tmp->dev; tmp++)
+		put_device(tmp->dev);
+
+	kfree(arch_data);
+
+	return ERR_PTR(ret);
 }
 
 static void omap_iommu_release_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data = dev_iommu_priv_get(dev);
+	struct omap_iommu_arch_data *tmp;
 
 	if (!dev->of_node || !arch_data)
 		return;
 
-	kfree(arch_data);
+	for (tmp = arch_data; tmp->dev; tmp++)
+		put_device(tmp->dev);
 
+	kfree(arch_data);
 }
 
 static int omap_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
-- 
2.49.1


