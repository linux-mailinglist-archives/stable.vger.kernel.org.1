Return-Path: <stable+bounces-187919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98BBEF525
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D6A3BD2FD
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF32C17B4;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfXi8Mzk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2A2C0278;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936197; cv=none; b=h+fT7znlSx746nMuQmVwC69MOJiSnHOeuf+HBpBeVwmTSuJutfmVPXDbcMkGWqXJeN92vlgRe3u25fS8KGru84m4WFMUaDquY3zBF6+wGdIVU1ohsitFCV/wGJeOCh8b9TeaDEPywtT1ioOzoyzoqD9wS8JlLpYUfkLAcx4G2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936197; c=relaxed/simple;
	bh=oLg6WHZ3aWKPMgrdsNiH4CTRs3dtYtjw8ulmKtz/VGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6MbLKcI4BzJuqga++85ttSlftOaETFMxyi/r7Kgpa4WrqR7Ln3urh8a63jllUwC/Q/pewJPglja8pAtFx0edAjn8es8rwF/ywDNaAZv2kcxF3HBlZeBD4hWmKCKyC0TU+WbuZhyEmXmE7ZiWbcyfQ+rbLM3Va/0E/R894bZ2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfXi8Mzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AF5C116C6;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=oLg6WHZ3aWKPMgrdsNiH4CTRs3dtYtjw8ulmKtz/VGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfXi8MzkFkrnoX55/gJrRe9WDImh+XSAdZFrqDh3FsgpzgQifmLU2xHahw+zvizq6
	 1JiNbX8Vb2zNCsbEudJ7uxTkbOTCnMa0kKM0iiLHw6rhzdR7NHulVLp6XYnbA0SspR
	 A7OgzGXv1OxmmzlLfrYHl5syODf0d28OJGKFNqmt3A8CizdrQEqj+DxQDHgyZmH0C7
	 jlsBsQnou/1LJC2S9/RhxX485cR4WMR64ZmOBqn2yiva+EP6Cm+LpAPuz/ptL9vWon
	 quvL2hTALH0WDVDUKjZAS2X3c7da3h7Xqa+l/CJfByzz5P5EnSWLAE/NBX2PU8S0eO
	 VdXqZ+lVlCnYA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwm-00000000833-3mu7;
	Mon, 20 Oct 2025 06:56:40 +0200
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
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v3 02/14] iommu/qcom: fix device leak on of_xlate()
Date: Mon, 20 Oct 2025 06:53:06 +0200
Message-ID: <20251020045318.30690-3-johan@kernel.org>
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

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Note that commit e2eae09939a8 ("iommu/qcom: add missing put_device()
call in qcom_iommu_of_xlate()") fixed the leak in a couple of error
paths, but the reference is still leaking on success and late failures.

Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
Cc: stable@vger.kernel.org	# 4.14: e2eae09939a8
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index c5be95e56031..9c1166a3af6c 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -565,14 +565,14 @@ static int qcom_iommu_of_xlate(struct device *dev,
 
 	qcom_iommu = platform_get_drvdata(iommu_pdev);
 
+	put_device(&iommu_pdev->dev);
+
 	/* make sure the asid specified in dt is valid, so we don't have
 	 * to sanity check this elsewhere:
 	 */
 	if (WARN_ON(asid > qcom_iommu->max_asid) ||
-	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
-		put_device(&iommu_pdev->dev);
+	    WARN_ON(qcom_iommu->ctxs[asid] == NULL))
 		return -EINVAL;
-	}
 
 	if (!dev_iommu_priv_get(dev)) {
 		dev_iommu_priv_set(dev, qcom_iommu);
@@ -581,10 +581,8 @@ static int qcom_iommu_of_xlate(struct device *dev,
 		 * multiple different iommu devices.  Multiple context
 		 * banks are ok, but multiple devices are not:
 		 */
-		if (WARN_ON(qcom_iommu != dev_iommu_priv_get(dev))) {
-			put_device(&iommu_pdev->dev);
+		if (WARN_ON(qcom_iommu != dev_iommu_priv_get(dev)))
 			return -EINVAL;
-		}
 	}
 
 	return iommu_fwspec_add_ids(dev, &asid, 1);
-- 
2.49.1


