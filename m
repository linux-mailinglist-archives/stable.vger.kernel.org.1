Return-Path: <stable+bounces-204840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E96CF4D40
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E26923031669
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1813093CA;
	Mon,  5 Jan 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE/eBVSN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2029309EE7
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627896; cv=none; b=tlFCqGAN/5zQ1BKEEVUbOPHnVkHDSRbcn6CzGrKidZxmoKWhY98wB211hYgo+mVkZNwiiuemIm71/lzKVTZ1hxN1f6njsKU/CO/kd6Eqd8wNP92c3fZ/VfWKZ0OVAMB6e+jCKnOkW+JsutyoXEySzALp4tpnk9e8XLq/DAr6KWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627896; c=relaxed/simple;
	bh=XQBAVNX3e+mGYGMC5YzptuXh6zUoPTmZc/LlbKa9StM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uu7axTkvgLCeWaoDmJFXujlwuCxAHM3YSvTHV0XjZDEMCb/AyXWnO4kyanWQvGO6pM36GLQSN5S5YQbRuJ5iCh7UjJ0YyGJw2JhVekeE8geCmRr3oUDY6Ak00Ozb+570Q0tYNW5KtqZgZUvTy8xAgSnvg/ZJfttiIbeqmfuCtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE/eBVSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACEEC116D0;
	Mon,  5 Jan 2026 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627895;
	bh=XQBAVNX3e+mGYGMC5YzptuXh6zUoPTmZc/LlbKa9StM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nE/eBVSN8zWuo7SSXD3awCCt/lXn+pJ4FVxh7wdUwDBuM6tat93856TjWJUYH24u6
	 UGOr1zbk/n10lB1b+fAln/byDkeoYNYHN9IJe8WFr0JpWaxvqxx46SRjMxRLSERSWY
	 DBXDYATQbsj/lGczcdSdMJkGAym2B+yezR9WSDdSAP4KMfBIxT6mvo4cI1IEZ7AW+y
	 jr+h2fz09NQQglj8SPlg197aeANbtWhiGiJJBJ8tRd+N4l7fcDym3enX95noP4BHbx
	 9uLgfftWZ2A4+5VIlEoZRqu1wfPlDUV2YPZO4EXERI5rA1AWdtAewCwz8WnLMgAyax
	 KHZFtfU34lQnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] iommu/arm-smmu: Drop if with an always false condition
Date: Mon,  5 Jan 2026 10:44:49 -0500
Message-ID: <20260105154453.2644685-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010519-padlock-footman-35a7@gregkh>
References: <2026010519-padlock-footman-35a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit a2972cb89935160bfe515b15d28a77694723ac06 ]

The remove and shutdown callback are only called after probe completed
successfully. In this case platform_set_drvdata() was called with a
non-NULL argument and so smmu is never NULL. Other functions in this
driver also don't check for smmu being non-NULL before using it.

Also note that returning an error code from a remove callback doesn't
result in the device staying bound. It's still removed and devm allocated
resources are freed (among others *smmu and the register mapping). So
after an early exit to iommu device stayed around and using it probably
oopses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20230321084125.337021-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 6a3908ce56e6 ("iommu/qcom: fix device leak on of_xlate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 294120049750..fcd2cfd12e7f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2209,9 +2209,6 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	if (!smmu)
-		return;
-
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_notice(&pdev->dev, "disabling translation\n");
 
@@ -2232,9 +2229,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	if (!smmu)
-		return -ENODEV;
-
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 
-- 
2.51.0


