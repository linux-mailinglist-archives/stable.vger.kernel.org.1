Return-Path: <stable+bounces-181711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF5B9F3CE
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2081762EB
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C470E302144;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+CSR0+c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDE2FE595;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=duAeJLK4+q79Kt0cOGB7MABR1/Vf7Uo3RqwOg3LYW/f03n5rAZXnra66xwffA73vfDgiNz56VmJ3bq5TT6yzg076GonXUzVUj49r0Szb0WvzSFeBp6bEuob1kLk2jdBb8ZywzXdSbief02eggTdIm4M7IcGDmIvrn6/l0cwms6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=eXCIctV3kzDVCzF1mL6VjkRTk6kPB7+BQFJ+zQFThxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPZiH/IWQiJKyjsfyJOnPlErrv+uBpZtmeiJv8SRG1Y4iXZ1AN5V11a9O7ZU9lOYPeA1OhrvMQ9zYOe4ihn2+dgsot6I3Js537KqyytCjUrfdPdMNSzMEV0oC5mrxIyzxyrp/Qtf8VlfOM3I5sofl7+5TenlaHwF1PAdkclrBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+CSR0+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176B2C2BC9E;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803350;
	bh=eXCIctV3kzDVCzF1mL6VjkRTk6kPB7+BQFJ+zQFThxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+CSR0+cpGxskyZZnboW4u3s6r1U6dFLivzicNr+/4NxOYvcYuFMwEHGN+6dOe2xr
	 cBq9S0BnzECMwWL2OjffXfDLhqndNuSWwNFKMU4CqtCFmm9bnQ4ywKA8YSkrOaGI8A
	 BXrnheivqMJ0LCWhMnYc1Bmxc1vwEY3rlxh9fpFDRn1rZqhJgR3fPnqvoJ0vo1dAe3
	 cPeQjagGOr6bVrQ98K9/EjLcqV1YIcJUF9UuFI4oXLabsCRHVSmpa7hKKb68iFJH/B
	 hDeI/gxz1akXBHAVrP/8f/WEzMZxVnpwKl2SJfvEcRw3ZYmHXM5Tn9Pa2Kflan4rVy
	 7fm6m3QiPmuAQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5q-000000002re-30Sz;
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
	stable@vger.kernel.org
Subject: [PATCH 06/14] iommu/mediatek: fix device leaks on probe()
Date: Thu, 25 Sep 2025 14:27:48 +0200
Message-ID: <20250925122756.10910-7-johan@kernel.org>
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

Note that commit 26593928564c ("iommu/mediatek: Add error path for loop
of mm_dts_parse") fixed the leaks in a couple of error paths, but the
references are still leaking on success and late failures.

Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
Cc: stable@vger.kernel.org	# 4.6
Cc: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 8d8e85186188..20a5ba80f983 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1216,13 +1216,17 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		platform_device_put(plarbdev);
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
@@ -1230,7 +1234,8 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	platform_device_put(pcommdev);
 	if (!link) {
 		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_larbdev_put;
 	}
 	return 0;
 
@@ -1402,8 +1407,12 @@ static int mtk_iommu_probe(struct platform_device *pdev)
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
@@ -1423,6 +1432,9 @@ static void mtk_iommu_remove(struct platform_device *pdev)
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
2.49.1


