Return-Path: <stable+bounces-110757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC74A1CC26
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6853B162CD9
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F4233142;
	Sun, 26 Jan 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIRV3aUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044B1F91E9;
	Sun, 26 Jan 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904104; cv=none; b=ciwTG8Yce9dx1+ChxmlQv7EeL5eiv+quG31HAj8ev3ykqAL94XYwcBpKjrp5WcUn/Whu5yTrLMkty+ApBMYd88bShtlNc1WbknUQWtjszVQdcfmfB3cnsE6fHoGWyNhiOj53wMTgr9OSTinpBRjDxPHz4Og3IrL5r4kT6tuU9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904104; c=relaxed/simple;
	bh=ww5KYbqmh2q/FNejbSlmIeDcfqTGFh6lqcmJoJClQ4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS/N9wJPp5C2v+ZIMUbYN1CCwkryXry0rEeks9cXtfvb/Km+Z2mM0EoySbnmkjYWL3OvHdIc58uZ34CB6rtiYjIxkaJvLgwkG2rh+99QGCy0xIZtVgSYCZBTovrk0gDqJwDEoBFd7Yy02gvcxx4zPaNDJl4x0Ee8T73HxXRyLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIRV3aUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C73C4CEE5;
	Sun, 26 Jan 2025 15:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904104;
	bh=ww5KYbqmh2q/FNejbSlmIeDcfqTGFh6lqcmJoJClQ4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIRV3aUmtYtvmB83OGt8W2gz99CrDpswbjH3OZKiJfOHOi8RehGbVkzIzd4RysG4R
	 Jmr/Qq9r1PmaDh/SFhMuFAKwJH8eUIQfmX6Eie51GiDrKX0Mds14NqHQZG0Yw8V7fO
	 adGyyZt++wo0W7knk4Z6Z2gSYKf5NWOVCWwMUFlksdZVLhnT7owi2kw+gNqWtj4IX4
	 Zan9g7EB0BGcyKipqbHohPDqG7tnRj2imShUJwwOznKT3XtOEt08xIZC3in6147mOh
	 ZgpsYru+wEIhAK3rNuZjpSSeG86slJXuoQ0xo8Oyk968i2TplqxBfKiJ0R4EOC5LX5
	 gkIF+BPPs1p1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	smostafa@google.com,
	praan@google.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 06/14] iommu/arm-smmu-v3: Clean up more on probe failure
Date: Sun, 26 Jan 2025 10:07:53 -0500
Message-Id: <20250126150803.962459-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150803.962459-1-sashal@kernel.org>
References: <20250126150803.962459-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit fcbd621567420b3a2f21f49bbc056de8b273c625 ]

kmemleak noticed that the iopf queue allocated deep down within
arm_smmu_init_structures() can be leaked by a subsequent error return
from arm_smmu_device_probe(). Furthermore, after arm_smmu_device_reset()
we will also leave the SMMU enabled with an empty Stream Table, silently
blocking all DMA. This proves rather annoying for debugging said probe
failure, so let's handle it a bit better by putting the SMMU back into
(more or less) the same state as if it hadn't probed at all.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/5137901958471cf67f2fad5c2229f8a8f1ae901a.1733406914.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 353fea58cd318..064ef03caa454 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4609,7 +4609,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Initialise in-memory data structures */
 	ret = arm_smmu_init_structures(smmu);
 	if (ret)
-		return ret;
+		goto err_free_iopf;
 
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
@@ -4620,22 +4620,29 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
 	if (ret)
-		return ret;
+		goto err_disable;
 
 	/* And we're up. Go go go! */
 	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
 				     "smmu3.%pa", &ioaddr);
 	if (ret)
-		return ret;
+		goto err_disable;
 
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return ret;
+		goto err_free_sysfs;
 	}
 
 	return 0;
+
+err_free_sysfs:
+	iommu_device_sysfs_remove(&smmu->iommu);
+err_disable:
+	arm_smmu_device_disable(smmu);
+err_free_iopf:
+	iopf_queue_free(smmu->evtq.iopf);
+	return ret;
 }
 
 static void arm_smmu_device_remove(struct platform_device *pdev)
-- 
2.39.5


