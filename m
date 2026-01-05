Return-Path: <stable+bounces-204849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBABBCF4C2B
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4195A30F1317
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F82285C89;
	Mon,  5 Jan 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7D8LSpO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB327FB25
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630150; cv=none; b=EG0WJO3JNI7xJb4NRk5iTSXSIR4xq+veM+FY3sVKuw0UOf9xVQzXI+a5F91dnuvYbA5StPPmMI62viRSbXP7YHVd3qs6QHESwDSBM4qWc2cYw5+4wmxPqH9a8G8YDbVp9b/24OVmGAlfFXaPXQUb0CwwIeZKt7tDW3bkR95Ck/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630150; c=relaxed/simple;
	bh=FEtfnCniyiHmJU1t+TJzy0E8RynO2U73xogvVuP9dx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSbbnTcqOvid1CGTOqmQOUOdTdMdZKDXWhQaVl7oxYTjZ7xbuPgrBiSfxGsQ38ng300NU0e8GwSptmYBU+5WPem0NLVHbvpVWsV1JL/f2GhPULUGFlq9B3QK46yasSwrJO2L7gf4rDXqPQydf78THMw+tYg8DJuFbOOO+TObRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7D8LSpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F49DC116D0;
	Mon,  5 Jan 2026 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767630150;
	bh=FEtfnCniyiHmJU1t+TJzy0E8RynO2U73xogvVuP9dx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7D8LSpOkpFH3jMCPTu2JDl9VMzBd1n+STsXBFgraBJaretdn7LhSuetpEmaVnhXY
	 XXx98EeD76HfC9ntf96j4VB6btaA9cIKV/Jy1DXgT90r+TklQnPONQX8pRvszCBoLv
	 Dq9C6axaSaxmkNS219v4qZ7IwmhklN4kP7evHp4EYPW3QUOFqYiV4WBWPzTIeEHe/C
	 998OMbpN2N2NPPakr0n1+NRi9hQvXmMz7/uAPmZUBfrUgJPFYImqwlVoPPtrlOeM4j
	 qMM2Qr/0TZeHY3Ir0EUiW2TU4jLIrAUgDVhClNql8XK7n6QogO0LzbeVoVhe/+ONfR
	 1eKMZQ08sUBCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iommu/qcom: fix device leak on of_xlate()
Date: Mon,  5 Jan 2026 11:22:27 -0500
Message-ID: <20260105162227.2665126-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010520-happily-sycamore-0e22@gregkh>
References: <2026010520-happily-sycamore-0e22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 6a3908ce56e6879920b44ef136252b2f0c954194 ]

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
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
[ adapted validation logic from max_asid to num_ctxs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 37c8f75a3580..369a34cb75b5 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -586,15 +586,15 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 
 	qcom_iommu = platform_get_drvdata(iommu_pdev);
 
+	put_device(&iommu_pdev->dev);
+
 	/* make sure the asid specified in dt is valid, so we don't have
 	 * to sanity check this elsewhere, since 'asid - 1' is used to
 	 * index into qcom_iommu->ctxs:
 	 */
 	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs)) {
-		put_device(&iommu_pdev->dev);
+	    WARN_ON(asid > qcom_iommu->num_ctxs))
 		return -EINVAL;
-	}
 
 	if (!dev_iommu_priv_get(dev)) {
 		dev_iommu_priv_set(dev, qcom_iommu);
@@ -603,10 +603,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
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
2.51.0


