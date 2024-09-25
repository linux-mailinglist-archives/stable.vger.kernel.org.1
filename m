Return-Path: <stable+bounces-77225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8DD985A9E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F31C23A8C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018A1B9836;
	Wed, 25 Sep 2024 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmuZnRqw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5418D62A;
	Wed, 25 Sep 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264567; cv=none; b=sJDHLUsZuECGoxtMIBTD+rnVzuAyowccdCj4dZ+/bw/CRRWT0fhqYaeyhzCAz8XO1Zy1EEsiKOri8lIQzGqxaYVJSUGmvvWM3XnsgMgv/YaNv7q3esrmd778DO9SV9gE3ScUMs9bU7S8ANYyKlrcqvdP9MXIhJlMsWO2MQA/3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264567; c=relaxed/simple;
	bh=xms7ViOyUI70csMqmncv45lshdBzXLRmzelz18ADYcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlYfvuo/R8cUdMFyS5H/cBPaEAoclOiQL6DfY47MKk2cSQq6t/3DAtWNF9yhN4swZMDS8wR4vKUnqiklm3tcwRiIXPzE/gEVz2jJA9Lsp5nbjc18l5cKCD9K9ynj0fWHUqN7h3dvSYS4G5MmyhoyWvYbKyCk+MY+tZG6cPYK1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmuZnRqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B04C4CEC7;
	Wed, 25 Sep 2024 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264566;
	bh=xms7ViOyUI70csMqmncv45lshdBzXLRmzelz18ADYcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmuZnRqwmGPNLMGCRUfHgp2fStytm79mNKKp4VZtV6Xxu0aWWXdsTGiNQeN9hUKeV
	 GVzhHPjvmgjkOMdafKV+9E3IttGbc8/iOX+ipUe0V4XB2dneKGhGtRhIhCg57dqZE3
	 JYnf/Css4i9OM5Fu1oCB9jkOruI0tX0ayd1g0CBKS0+TvxUVpxZVqfh18iI7ZfkKRz
	 xIVOWpE3fywz/GnDcinq8v8Ve3rYpt+8uiAW66UD10BeJB13mVUsZ8FecmMt4upub6
	 QRWP1p8OpVBQnQ/SMSM6JnDRlRuoO72Au276kzscj/RkFNZOI36BXydXZb1Y7DX5kx
	 4gv8ezSA4K9zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	jgg@ziepe.ca,
	mshavit@google.com,
	smostafa@google.com,
	baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 127/244] iommu/arm-smmu-v3: Do not use devm for the cd table allocations
Date: Wed, 25 Sep 2024 07:25:48 -0400
Message-ID: <20240925113641.1297102-127-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 47b2de35cab2b683f69d03515c2658c2d8515323 ]

The master->cd_table is entirely contained within the struct
arm_smmu_master which is guaranteed to be freed by the core code under
arm_smmu_release_device().

There is no reason to use devm here, arm_smmu_free_cd_tables() is reliably
called to free the CD related memory. Remove it and save some memory.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/5-v4-6416877274e1+1af-smmuv3_tidy_jgg@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 +++++++++------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a7d2a6b8a4980..8a419e88a920e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1185,8 +1185,8 @@ static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
 {
 	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
 
-	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
-					     &l1_desc->l2ptr_dma, GFP_KERNEL);
+	l1_desc->l2ptr = dma_alloc_coherent(smmu->dev, size,
+					    &l1_desc->l2ptr_dma, GFP_KERNEL);
 	if (!l1_desc->l2ptr) {
 		dev_warn(smmu->dev,
 			 "failed to allocate context descriptor table\n");
@@ -1400,17 +1400,17 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 		cd_table->num_l1_ents = DIV_ROUND_UP(max_contexts,
 						  CTXDESC_L2_ENTRIES);
 
-		cd_table->l1_desc = devm_kcalloc(smmu->dev, cd_table->num_l1_ents,
-					      sizeof(*cd_table->l1_desc),
-					      GFP_KERNEL);
+		cd_table->l1_desc = kcalloc(cd_table->num_l1_ents,
+					    sizeof(*cd_table->l1_desc),
+					    GFP_KERNEL);
 		if (!cd_table->l1_desc)
 			return -ENOMEM;
 
 		l1size = cd_table->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	}
 
-	cd_table->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cd_table->cdtab_dma,
-					   GFP_KERNEL);
+	cd_table->cdtab = dma_alloc_coherent(smmu->dev, l1size,
+					     &cd_table->cdtab_dma, GFP_KERNEL);
 	if (!cd_table->cdtab) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
@@ -1421,7 +1421,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 
 err_free_l1:
 	if (cd_table->l1_desc) {
-		devm_kfree(smmu->dev, cd_table->l1_desc);
+		kfree(cd_table->l1_desc);
 		cd_table->l1_desc = NULL;
 	}
 	return ret;
@@ -1441,21 +1441,18 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 			if (!cd_table->l1_desc[i].l2ptr)
 				continue;
 
-			dmam_free_coherent(smmu->dev, size,
-					   cd_table->l1_desc[i].l2ptr,
-					   cd_table->l1_desc[i].l2ptr_dma);
+			dma_free_coherent(smmu->dev, size,
+					  cd_table->l1_desc[i].l2ptr,
+					  cd_table->l1_desc[i].l2ptr_dma);
 		}
-		devm_kfree(smmu->dev, cd_table->l1_desc);
-		cd_table->l1_desc = NULL;
+		kfree(cd_table->l1_desc);
 
 		l1size = cd_table->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	} else {
 		l1size = cd_table->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
 	}
 
-	dmam_free_coherent(smmu->dev, l1size, cd_table->cdtab, cd_table->cdtab_dma);
-	cd_table->cdtab_dma = 0;
-	cd_table->cdtab = NULL;
+	dma_free_coherent(smmu->dev, l1size, cd_table->cdtab, cd_table->cdtab_dma);
 }
 
 /* Stream table manipulation functions */
-- 
2.43.0


