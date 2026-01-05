Return-Path: <stable+bounces-204848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E680BCF4B53
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FB8730BCA51
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA132F12BA;
	Mon,  5 Jan 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeyvN4fR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B82765F8
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629354; cv=none; b=Y0nJubdEpWygXdvO02oTmtFBDgpy+sjfMlVlrRon5Qa8zVurSN97bshswKxjVwYn39pzy2N3cJZqqjzEmoCt6gr/KoCs33d2oN3hEpjKccGUZa+x5E2kkvH1elS5gCnGZWen5WNGbYpWiDxG3zRkCh0isIQJ3GVp/vxO5MRdNrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629354; c=relaxed/simple;
	bh=yTkSY8a9RbmsAhWmLiy5Af+HV875Onr8lrQNtHwirJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciW0fpO9Q8eTqfvUYaXDKJPDRb8OiTEqjhuNjLFJgkqqSrcvBekT+aROKdTs02zO27ulTMTKbdsC11qY3xzrmmCk6NL5WnaHolpoRuDotOiyA1648/wo1PNybQ5ku+WH7GsTh37k+DDYzU1jVVzfeEPZLF9eoSzFqYRXKQ52K6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeyvN4fR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940FCC116D0;
	Mon,  5 Jan 2026 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767629354;
	bh=yTkSY8a9RbmsAhWmLiy5Af+HV875Onr8lrQNtHwirJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DeyvN4fRY5TtH5P1wHST4PQr2ojTcFSArsoAIlPdsiYJP77KGnZvGBBgyE1wTCODy
	 0LdmkFA9aCq1fW0FCRydDSEh7ceXzC7zEf+txe8Tx8wM2jfR1wYM4nPVFN6LIV2U5Q
	 HcQeB9BCUCUIrvEC1ZhqSe7Mz1rASHm984XU88+ConxkbC3EyRIsRMWAnqKGF0BLoH
	 XRG56DCH0lzk+ARoVDWW1faM+GUbZAu+6rL2/qWZT7abSEbTTsLf6xv2jnXL8vssad
	 /gNxWblGPyv3J9KtGYh8kfLVNFdsoG0gVe/7PCRoohkTkLmBkgFKP6rexB9kZc+FEJ
	 beA7Kaa5PQBhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iommu/qcom: fix device leak on of_xlate()
Date: Mon,  5 Jan 2026 11:09:11 -0500
Message-ID: <20260105160912.2661912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010520-snowdrop-judgingly-e0c4@gregkh>
References: <2026010520-snowdrop-judgingly-e0c4@gregkh>
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
index 9438203f08de..c4379109f11d 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -568,15 +568,15 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 
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
@@ -585,10 +585,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
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


