Return-Path: <stable+bounces-204844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CCCF4D0C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF4C53009D4F
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70CF338581;
	Mon,  5 Jan 2026 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3ixhx8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB6337B8C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627901; cv=none; b=kz8zup9MDkQKPmgGn9/qOJ+Og/NoaAqAWnZrqDPDAvNq8IJoX+qakOUqKUrG9x6bWQZ2JCFcvAGvbhOenPV11jiNq7cn8N+o5HWicKTHakmIleO9slr5j47rba5f5Sc1n3oGoJ8/XzkRIoWSOAUJ77ckBg1uR/QLB7p4Wf7iL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627901; c=relaxed/simple;
	bh=ztoLys4pGDfGhZq8ferx/aXAwLPBEtvCyxRbV+Igpfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8ffryRbYQcscic90lA+Le/ShtQZ5yUI3LKuUfC6h3LB2EqXGG7RQTRIdYPl02/BAaetlpPkEr2REphOil90QMfWhODTbYCAR5xly0l2EzdnfNso9g102bMwLP6so9aZncMQfO5kyuVNImU59oYMRijbCuFmEtTeoyRnwf5A9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3ixhx8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEC9C116D0;
	Mon,  5 Jan 2026 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627899;
	bh=ztoLys4pGDfGhZq8ferx/aXAwLPBEtvCyxRbV+Igpfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3ixhx8UA7rlQNcDQCyYJ5+qkfEKP8rtVig8M20jp8EVRinpSLfiNq6fa8W36nmW7
	 s43npoViMep6F8xlQk6reTuY5rAtQovskuVifGOlqLtlhz2LWmgHcwnYNCnESwx2xz
	 gE4pNIS4bWJZSIA5OAzaQnkq8SaL2wejpPB3X8NGsLfqRJl64GidEszvtiuZPHPFNj
	 wsfjRXkdaeQ6KlGVzCoSAOIbk/G/WwuQJUW4HdOLGkDXIDl6AQJDzBbauNIT0Q3x2D
	 EpfB+sLyAvKsbffVuxsk4Jh/Q1GniGuKZTE5AtcezaqAsif8BTAylwHlN7rk8Orcto
	 FHcLSTwiXi+JQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] iommu/qcom: fix device leak on of_xlate()
Date: Mon,  5 Jan 2026 10:44:53 -0500
Message-ID: <20260105154453.2644685-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105154453.2644685-1-sashal@kernel.org>
References: <2026010519-padlock-footman-35a7@gregkh>
 <20260105154453.2644685-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 0c27de3fd2f6..3d4428e688ee 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -558,14 +558,14 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 
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
@@ -574,10 +574,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
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


