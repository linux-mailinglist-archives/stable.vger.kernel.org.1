Return-Path: <stable+bounces-77451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1C0985D6C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEE61C24DE5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4EE1E1A34;
	Wed, 25 Sep 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q06Ph0TL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7D1B1D63;
	Wed, 25 Sep 2024 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265815; cv=none; b=ItvdTbwyvQwhY22G3KhZ0Yz5Ta4sWY9x6vnNBZsBcNkyOsK6XMG/TQYJv8yuNTxISPZFiuoeg20uF213ZS5jhhDfKgGhRh2tP1LWeDPV6K9q4vQc5XxKbpnayMSSLNizwl1Hmz5S2hhXmilC4UW5ZTjcXhYpXJl1nhxtwiO7DKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265815; c=relaxed/simple;
	bh=o3U4KoOQmPPsjXHJMwUWVTulpN/T+liSlDbD9IS5vbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyzWKAXSs3z6QKY9DVxlGQBlc1YE2HWuxjJ/Rp2Bo2cvNQ5HgdIDvU6KPFbW+NrHKejGAJmQOk8BMjoozxAt5SXQ8YJNUq56QGdnNm4TFju9yXd1zegcfYRj1ChbFRlIE7KG1YHbolR0isRs+O8EhP+E4FeI6CzY6fttzSHxZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q06Ph0TL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1340AC4CEC3;
	Wed, 25 Sep 2024 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265814;
	bh=o3U4KoOQmPPsjXHJMwUWVTulpN/T+liSlDbD9IS5vbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q06Ph0TL3XzrnxgavEUNIxGiL/JbDXq0Qsd7fWIgH/WkojtwdDakYWholFLk57VEZ
	 iBlSYIi03lRUwRiKINjQU01sPegC1gGuLVmWB1gOhqiF+QoFm/k0Nb6ttJq28TMPpI
	 RpfZ3obSONzYTam4D1AdZwLu7qdb1qrhv3juu9eVHxiV1FQMkcBlGrKqeDCBAHk6f9
	 5Gyl0L9y+QST42+RgpZmy0IMGPuf4lw8B/3pyW3FKgqbGzPziFKv8Qpv/w9P9spPeF
	 ziCh8/JRZySp2htJfayxYjNvzqiHn/FCwW4LYWdMmlj/htqER1H2nWBcih3MpcoLLx
	 4wmNPe3a9Vd4Q==
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
Subject: [PATCH AUTOSEL 6.10 106/197] iommu/arm-smmu-v3: Match Stall behaviour for S2
Date: Wed, 25 Sep 2024 07:52:05 -0400
Message-ID: <20240925115823.1303019-106-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index f456bcf1890ba..1f38669b711d3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1000,7 +1000,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
-				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R);
+				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2S |
+				    STRTAB_STE_2_S2R);
 		used_bits[3] |= cpu_to_le64(STRTAB_STE_3_S2TTB_MASK);
 	}
 
@@ -1629,6 +1630,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 		STRTAB_STE_2_S2ENDI |
 #endif
 		STRTAB_STE_2_S2PTW |
+		(master->stall_enabled ? STRTAB_STE_2_S2S : 0) |
 		STRTAB_STE_2_S2R);
 
 	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr &
@@ -1722,10 +1724,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
 
-	/* Stage-2 is always pinned at the moment */
-	if (evt[1] & EVTQ_1_S2)
-		return -EFAULT;
-
 	if (!(evt[1] & EVTQ_1_STALL))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1242a086c9f94..d9c2f763eaba4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -264,6 +264,7 @@ struct arm_smmu_ste {
 #define STRTAB_STE_2_S2AA64		(1UL << 51)
 #define STRTAB_STE_2_S2ENDI		(1UL << 52)
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
+#define STRTAB_STE_2_S2S		(1UL << 57)
 #define STRTAB_STE_2_S2R		(1UL << 58)
 
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
-- 
2.43.0


