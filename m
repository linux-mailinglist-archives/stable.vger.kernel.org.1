Return-Path: <stable+bounces-128621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01745A7EA03
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B6F3B0501
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0621146F;
	Mon,  7 Apr 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lrgt/2gG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191E21C9EE;
	Mon,  7 Apr 2025 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049518; cv=none; b=UpcY9hsKMfO58eNuPSHOzxeYMRG9nIQFxvpA5v7QddwyHRiuDBL1tg34ccpz2GXSiCLbcTFpdljkRiMNJFKJo5BKKuON1bPNN5l5bxOdaBypdf3huZgW5NN+Y/CX1r+uDafrTQXzS1tHW+olsf6nxlM3R85HLm5vCxXXwgVIjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049518; c=relaxed/simple;
	bh=Pbv0skuYZDrgl8lV7uBRFZi1ziYQNGkyBwUNPQWzd4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WXhVbV7t5K75qGqDsstSD9bzf4XPtOfbXFsfm1yxDi6PTYgolwa0huPn5hY3jmrMgUY+t7mgfowpq9TcyDSb2OMFgbPaaV2vdDY98K7gTLeAn1K8GaZFeTkprP/Dr9hivm9v/W+c0+FF6nC1Sw7DgDNGcmrmloTY2OmfUb8Dcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lrgt/2gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85454C4CEDD;
	Mon,  7 Apr 2025 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049517;
	bh=Pbv0skuYZDrgl8lV7uBRFZi1ziYQNGkyBwUNPQWzd4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lrgt/2gGESUhtsH9Bn/4F+WClFTBPnMLKYV5LsVAxFAq3x7OshyR0NSKaEcj/BSnZ
	 cdZfIcrebyad+2Di7bNqMc3YM3pzK+WTUK/Us90Bdf6j/KhaOLoVI88BnU+EEbS7fY
	 xmBwdDG/tq8KEdotsHPzXM8ZosAveeQk/Kc7a69mNjoE1CQ63P1X744pdF0giuVByx
	 5fVLCCF0hnz7l406JH6zsHVdCmVeG3NUAZJBsk865DyUJetM/k4Zi6iWPKTIA7aAlh
	 nO44jWnCBjUqIg11FwstpQZuAMzXtg114WHY+AP3za4RsRjMfMEl6cYNDJXtnw4Xjg
	 aEblvCQkgS1kA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	nathan@kernel.org,
	peterz@infradead.org,
	yi.l.liu@intel.com,
	jsnitsel@redhat.com,
	mshavit@google.com,
	zhangzekun11@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 24/31] iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations
Date: Mon,  7 Apr 2025 14:10:40 -0400
Message-Id: <20250407181054.3177479-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit da0c56520e880441d0503d0cf0d6853dcfb5f1a4 ]

There is a DoS concern on the shared hardware event queue among devices
passed through to VMs, that too many translation failures that belong to
VMs could overflow the shared hardware event queue if those VMs or their
VMMs don't handle/recover the devices properly.

The MEV bit in the STE allows to configure the SMMU HW to merge similar
event records, though there is no guarantee. Set it in a nested STE for
DoS mitigations.

In the future, we might want to enable the MEV for non-nested cases too
such as domain->type == IOMMU_DOMAIN_UNMANAGED or even IOMMU_DOMAIN_DMA.

Link: https://patch.msgid.link/r/8ed12feef67fc65273d0f5925f401a81f56acebe.1741719725.git.nicolinc@nvidia.com
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 5aa2e7af58b47..34a0be59cd919 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -43,6 +43,8 @@ static void arm_smmu_make_nested_cd_table_ste(
 	target->data[0] |= nested_domain->ste[0] &
 			   ~cpu_to_le64(STRTAB_STE_0_CFG);
 	target->data[1] |= nested_domain->ste[1];
+	/* Merge events for DoS mitigations on eventq */
+	target->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
 }
 
 /*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293e..59749e8180afc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1052,7 +1052,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
 				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
 				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
-				    STRTAB_STE_1_EATS);
+				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
 		used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
 
 		/*
@@ -1068,7 +1068,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 	if (cfg & BIT(1)) {
 		used_bits[1] |=
 			cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
-				    STRTAB_STE_1_SHCFG);
+				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a2..7290bd4c2bb0a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -266,6 +266,7 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_1_S1COR		GENMASK_ULL(5, 4)
 #define STRTAB_STE_1_S1CSH		GENMASK_ULL(7, 6)
 
+#define STRTAB_STE_1_MEV		(1UL << 19)
 #define STRTAB_STE_1_S2FWB		(1UL << 25)
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
-- 
2.39.5


