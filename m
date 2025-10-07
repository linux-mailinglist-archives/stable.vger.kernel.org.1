Return-Path: <stable+bounces-183518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D692BC0E4C
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 11:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9198189FD7E
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA072D8DC4;
	Tue,  7 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciSifD/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A12D7DE0;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830295; cv=none; b=hGQNifrqX1+1rkQUWZ6sx/4090TiN+dyqTCDAqvCI0ePopajhW1zGHhqK4CaoFaZuUrNEKyrlmEVYVuqnX8Gi/ZFUVHmElG78NY7yrGXk0yZ/YvVuujNq+jIPZQ4NZc/4DiLO+MStQrK4ljO68LFSvQ3BWmM7dL06YlrKN/Bmb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830295; c=relaxed/simple;
	bh=oLg6WHZ3aWKPMgrdsNiH4CTRs3dtYtjw8ulmKtz/VGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVAn1+NZdhoBzAnTv8S7Nx8IZ/t1w3RcWAMn8m1S4mIwk8w/VgMANGp0VSDLbvp3sOxDV8Ogh0OgSzQJXKfexj/VBr8fuuG4yIPOzJuHOnOmZ3iqfSDkY/j3z/tdPIs/ixzflgljtqrci0Zq8k7DAxCCWUvxuRfMHNj5IGVoV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciSifD/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4E8C116B1;
	Tue,  7 Oct 2025 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830295;
	bh=oLg6WHZ3aWKPMgrdsNiH4CTRs3dtYtjw8ulmKtz/VGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ciSifD/9G8aluNdrww4LNEUCsP5f9eQRfK3QVMAgfFnezv2XQoNKFmSjwXebS/5pl
	 2R/DlOzFsNOXTGU0UiB6Iu13yGSslCcQl3GKl4eRwkGOTV4/VEk2H6VoDoiwmyqekk
	 /xQZ5cw8uPbax+Wz1WPsdEH6HEu3SZ1uN6xt49+We7zL89RmB+RToBVUoKGGSi0zs0
	 LQM3sd6Tg57caIEeqEOAIcFlnb5epKc3BpbZ009TkeRIEm6klEXamMj+ljMZbeCL2C
	 J47u0No/mdcinicIk1lWCRTCs1wM/nLDBBIk2y2YVzj7HA1IUc3fUHezuZD+OV80tZ
	 Oop73befgmkEw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FY-0000000035b-3oSY;
	Tue, 07 Oct 2025 11:44:52 +0200
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
Subject: [PATCH v2 02/14] iommu/qcom: fix device leak on of_xlate()
Date: Tue,  7 Oct 2025 11:43:15 +0200
Message-ID: <20251007094327.11734-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251007094327.11734-1-johan@kernel.org>
References: <20251007094327.11734-1-johan@kernel.org>
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


