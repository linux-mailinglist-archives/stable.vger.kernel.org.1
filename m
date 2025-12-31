Return-Path: <stable+bounces-204400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A81CECAC7
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 00:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C2E030102AF
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 23:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEA930F81B;
	Wed, 31 Dec 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTLTkxYv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1328690
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767224342; cv=none; b=L8La74iC8B87QW2CssCDupWXzVrcu2xdxp+zJmUt/eAw77iPz7FpTZeGmhmDpLvbafO0Uoz8owYg4+lvcgkIFUGTAhIRk6FhntAC0MBbm5jIcKddLwbz6VHdN5S2+w2W7VyFIniJ3vA++zBsyVpSsUef5tiAyQPDo0UWYp3J0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767224342; c=relaxed/simple;
	bh=26iHS2EEIuIvrxpru/KzwbshmLMP2ftBhlMrpEmN0Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGZk99CBdBC/wqFywM/T973sVUSdmSHflQKG92j9CDi8lgU4EGrvA/Eap1ZGCyhIpIiBnAaG66TaMzvth0rKbB41fGgABZWROkOqdSrEl/EB/gEBYU3nrepW8URvKXBDX9u6gZXf4xvW5N0719fMDbIBFMZRl+NVI4cYhl+beGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTLTkxYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96464C19422;
	Wed, 31 Dec 2025 23:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767224342;
	bh=26iHS2EEIuIvrxpru/KzwbshmLMP2ftBhlMrpEmN0Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTLTkxYv53+fs/0vCqXxEWN4ZK6xDiDdv2OswXbkuQV4W1c3Vt+rWHo/dNEpevypW
	 2wXSFTi11Q5B1wTJBeCWr1siggRtWaKd3os5wwo0648yIUnbxH07pGCnP/DaZ4fnUl
	 qXuNgZPTTnpoBbHCVW9j3LWeTKLO3ajrgD2ZmSjl6QC6zo2poVe0k3eX2A4gs8viKT
	 sRTJWyOrtXMktGjRxXH9uO2l9qvR4FR27m9p5EKik8l39FO4ZSqXox0oMbydpiZbbs
	 8DsCAuzXu/xIZ9V8u91ZREU8Va44TdkQamzuGP6s2JxJ2VXa9LWLE+zxhMZWw6TCFx
	 61aRLdD/Ukr+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Robin Murphy <robin.murphy@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iommu/mediatek: fix use-after-free on probe deferral
Date: Wed, 31 Dec 2025 18:38:58 -0500
Message-ID: <20251231233858.3696664-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231233858.3696664-1-sashal@kernel.org>
References: <2025122941-reluctant-exhale-a49f@gregkh>
 <20251231233858.3696664-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit de83d4617f9fe059623e97acf7e1e10d209625b5 ]

The driver is dropping the references taken to the larb devices during
probe after successful lookup as well as on errors. This can
potentially lead to a use-after-free in case a larb device has not yet
been bound to its driver so that the iommu driver probe defers.

Fix this by keeping the references as expected while the iommu driver is
bound.

Fixes: 26593928564c ("iommu/mediatek: Add error path for loop of mm_dts_parse")
Cc: stable@vger.kernel.org
Cc: Yong Wu <yong.wu@mediatek.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 773cbd63ed5c..6e8294985c1f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1132,16 +1132,19 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		}
 
 		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
-		platform_device_put(plarbdev);
 	}
 
-	if (!frst_avail_smicomm_node)
-		return -EINVAL;
+	if (!frst_avail_smicomm_node) {
+		ret = -EINVAL;
+		goto err_larbdev_put;
+	}
 
 	pcommdev = of_find_device_by_node(frst_avail_smicomm_node);
 	of_node_put(frst_avail_smicomm_node);
-	if (!pcommdev)
-		return -ENODEV;
+	if (!pcommdev) {
+		ret = -ENODEV;
+		goto err_larbdev_put;
+	}
 	data->smicomm_dev = &pcommdev->dev;
 
 	link = device_link_add(data->smicomm_dev, dev,
@@ -1149,7 +1152,8 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	platform_device_put(pcommdev);
 	if (!link) {
 		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_larbdev_put;
 	}
 	return 0;
 
@@ -1320,8 +1324,12 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&data->iommu);
 out_list_del:
 	list_del(&data->list);
-	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		device_link_remove(data->smicomm_dev, dev);
+
+		for (i = 0; i < MTK_LARB_NR_MAX; i++)
+			put_device(data->larb_imu[i].dev);
+	}
 out_runtime_disable:
 	pm_runtime_disable(dev);
 	return ret;
@@ -1341,6 +1349,9 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		device_link_remove(data->smicomm_dev, &pdev->dev);
 		component_master_del(&pdev->dev, &mtk_iommu_com_ops);
+
+		for (i = 0; i < MTK_LARB_NR_MAX; i++)
+			put_device(data->larb_imu[i].dev);
 	}
 	pm_runtime_disable(&pdev->dev);
 	for (i = 0; i < data->plat_data->banks_num; i++) {
-- 
2.51.0


