Return-Path: <stable+bounces-77455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53199985DBF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7665B2A4F1
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871151E502F;
	Wed, 25 Sep 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As4GbYOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACE1E5022;
	Wed, 25 Sep 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265824; cv=none; b=QBeL7j0Am6tvRjLOzBzU8xBRzdadFFisAMTGIrzFox+h1oTw1/nP7tATCC2uWvoJDsclKmnK3cJi6gJ5nnQ6VJhcJSc1DiAIe+efXC8eCJ1AJpnvThjr37xSDzQsSnnb35BQE81HCSHncV1Zhiv0MCih96iSzAhHg8A1Lcv7aWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265824; c=relaxed/simple;
	bh=4bJ6Ecsr8hDmAVBWVoFuMy8iGnOIvzJGiuRfklYVu5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmAje8nXl7xMBt67xHqNisE/iNgug51RlzOWMFfAqFaZMvXwxy+dr2fqNWJO2DHQ29iUjhCeYjmPSLbdkVbkStJXa5pHRVuH/4c7ZJkhcNZXhvfMtwR/N/IF69w25A9qP2yUrp//NY5U0NUJqXVyfzUxntADwbR03bLRh6hzHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As4GbYOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7ABC4CEC3;
	Wed, 25 Sep 2024 12:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265824;
	bh=4bJ6Ecsr8hDmAVBWVoFuMy8iGnOIvzJGiuRfklYVu5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=As4GbYODHoXA/CSy0nh7/yxXAL7AsO1zoblO/GhA/56L75oqwyCvxLpx/o06j/+pi
	 Gbf8xqKUV4alZqDVLGNDsT3ChXga2cxnqD5Zu7wnR//HEYG2qMzbED9EwsKWx15C+G
	 0b2egKHtyS1tr5zf7cywvUi7jmwwC1lVD0kK9N+GLt8DJKN/DYBCx8RCh7av0HIWco
	 FZoxgm68kl/KGaKBdbwlODGRNEkv3Bv81edPEysHs7UAc14tEmq9OnbG77w3JnAK74
	 kRt8qhcfZDuDZSFliyvFk+PRb+7VNAk1ZFEhKe23OzIp7cvHLeSv2+xtbnyErtL19V
	 NTMxK4CZ/5qZg==
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
Subject: [PATCH AUTOSEL 6.10 110/197] iommu/arm-smmu-v3: Do not use devm for the cd table allocations
Date: Wed, 25 Sep 2024 07:52:09 -0400
Message-ID: <20240925115823.1303019-110-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 1f38669b711d3..a5425519fecb8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1173,8 +1173,8 @@ static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
 {
 	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
 
-	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
-					     &l1_desc->l2ptr_dma, GFP_KERNEL);
+	l1_desc->l2ptr = dma_alloc_coherent(smmu->dev, size,
+					    &l1_desc->l2ptr_dma, GFP_KERNEL);
 	if (!l1_desc->l2ptr) {
 		dev_warn(smmu->dev,
 			 "failed to allocate context descriptor table\n");
@@ -1373,17 +1373,17 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
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
@@ -1394,7 +1394,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 
 err_free_l1:
 	if (cd_table->l1_desc) {
-		devm_kfree(smmu->dev, cd_table->l1_desc);
+		kfree(cd_table->l1_desc);
 		cd_table->l1_desc = NULL;
 	}
 	return ret;
@@ -1414,21 +1414,18 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
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
 
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
-- 
2.43.0


