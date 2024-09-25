Return-Path: <stable+bounces-77221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1385F985A96
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BA1281DAA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368891B81C2;
	Wed, 25 Sep 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBi/Ve75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE218CC08;
	Wed, 25 Sep 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264557; cv=none; b=fZjsTFl1TDifQDpfn1u56Wxp53awnvBty/piIqnY4wREKNbwFNnxrtKVNIGLNTjZL1mSjPlkLxZ5vZR40IsPAbOKl6O/jamJ+j0tsikkG2OxAtk4ZQ0F6oIOcPDVamZY3WjIoR1C2E0fbMfc7LUROqOVw92TnYg6QP4zwLrwrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264557; c=relaxed/simple;
	bh=Shmt3mKVkE0PXK6LCkHXSwdxI7U+P22ERvevjRpPH8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVyU+1EzIhJYcXFZMhtFFF8YV6tU/mGgrrrIIXZnuzchS6uQq/FWNscMexDzhMb5UtQ/TDfxmFDG4I+nTlSB5Oz09W9P97cRpUKHU5e/35ny/96o2KTrFaVASIi9iPyrGJ6bT6XaGmikzPcDI/jv0LfLkyn3x+olBxcJexPBn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBi/Ve75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368A5C4CEC3;
	Wed, 25 Sep 2024 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264556;
	bh=Shmt3mKVkE0PXK6LCkHXSwdxI7U+P22ERvevjRpPH8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBi/Ve758p9HdawGAXSWJZ1ku3iYEP/HoxEMDB/7BwyLua7dv3W1drj1DZFOhLaTw
	 hH2De0JpylmN4Xu+WLvSVwWvCqp9kB5vqpZWvdxxZPG35NHrwAEcwGLrAwaezB3QSM
	 y8qHGnrivSn6rEJ4AcWKPQlfsUvtsZiQszs3fyRRGp016IPTsAM2Z/8mdJuPVu9znR
	 a9UGZkW9fhb6Vrwajqm/JTM6UdUtUyprsszmfVH8Y568iBqXcKXYwOwVN20uR/Bt67
	 iw5ZMwMDnCwJwmP2gbIa04r6nwilU+HFsOM7Ll4jiLmmy7hW67sSOLOFjX1iiU8ezs
	 EGnUTmQPSJfzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mostafa Saleh <smostafa@google.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	baolu.lu@linux.intel.com,
	jsnitsel@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 123/244] iommu/arm-smmu-v3: Match Stall behaviour for S2
Date: Wed, 25 Sep 2024 07:25:44 -0400
Message-ID: <20240925113641.1297102-123-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Mostafa Saleh <smostafa@google.com>

[ Upstream commit ce7cb08e22e09f43649b025c849a3ae3b80833c4 ]

According to the spec (ARM IHI 0070 F.b), in
"5.5 Fault configuration (A, R, S bits)":
    A STE with stage 2 translation enabled and STE.S2S == 0 is
    considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.

Also described in the pseudocode “SteIllegal()”
    if STE.Config == '11x' then
        [..]
        if eff_idr0_stall_model == '10' && STE.S2S == '0' then
            // stall_model forcing stall, but S2S == 0
            return TRUE;

Which means, S2S must be set when stall model is
"ARM_SMMU_FEAT_STALL_FORCE", but currently the driver ignores that.

Although, the driver can do the minimum and only set S2S for
“ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
master has requested stalls.

Also, since S2 stalls are enabled now, report them to the IOMMU layer
and for VFIO devices it will fail anyway as VFIO doesn’t register an
iopf handler.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Link: https://lore.kernel.org/r/20240830110349.797399-2-smostafa@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ed2b106e02dd1..a7d2a6b8a4980 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1012,7 +1012,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
-				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R);
+				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2S |
+				    STRTAB_STE_2_S2R);
 		used_bits[3] |= cpu_to_le64(STRTAB_STE_3_S2TTB_MASK);
 	}
 
@@ -1646,6 +1647,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 		STRTAB_STE_2_S2ENDI |
 #endif
 		STRTAB_STE_2_S2PTW |
+		(master->stall_enabled ? STRTAB_STE_2_S2S : 0) |
 		STRTAB_STE_2_S2R);
 
 	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr &
@@ -1739,10 +1741,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
 
-	/* Stage-2 is always pinned at the moment */
-	if (evt[1] & EVTQ_1_S2)
-		return -EFAULT;
-
 	if (!(evt[1] & EVTQ_1_STALL))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 14bca41a981b4..0dc7ad43c64c0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -267,6 +267,7 @@ struct arm_smmu_ste {
 #define STRTAB_STE_2_S2AA64		(1UL << 51)
 #define STRTAB_STE_2_S2ENDI		(1UL << 52)
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
+#define STRTAB_STE_2_S2S		(1UL << 57)
 #define STRTAB_STE_2_S2R		(1UL << 58)
 
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
-- 
2.43.0


