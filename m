Return-Path: <stable+bounces-203462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF877CE59D0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 01:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 959FD30062EB
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 00:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE33478F4A;
	Mon, 29 Dec 2025 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aVIXTmTt"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA74502F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766967869; cv=none; b=LGzQFbimi/wihxE1AtRbtRM2J/H8dOCzL/A037pdEfSA/bcI39bJiGl/T0UgFTUso4+bLoP7VLQ9QZG6LuRiN5l/W4oOsnQbRy1STnnimDp7RFwgIEsNHJihVoIjgoE4uSwO4DfxxoHVYeonWd6cQfB87GEK+LXjbXeSll5Yv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766967869; c=relaxed/simple;
	bh=p44zMAaQA3706C6e60sgshJT+wKqGAuDom3r5AgBApI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QQ3xKlFkC12vll5SyssXkrUEsjH/2rhhrEQSpMXZ1RYDFJV+Vt0mulVZ+teH815Nu/4CysV4rGqnVrA6rF6vjsK8E7N2bcidw30zya4CteVAUf2hMrZT1eyVsyPMbfUfJUEGkVgA9GEoMZBG38xZoHm5R+ul056dWNoNfQ9cCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aVIXTmTt; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766967855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bjYKwcZ3h3Z3aY45ZL0FzjkQV2PYU/9nrtqQgH9rJac=;
	b=aVIXTmTtG+FkNdvUIBZdEBobwoJv/sOs2O1zD/2hMDxBdLuoIxhXWBcN+t34niidSR/THV
	Jtgt8HSZIU0B87WpWYtdWuM11vVRCSYUrR+twZh/IZYk4Zce4yPEpXKHzuigGwunELYHnq
	8cXkA5TlQj7yMWcScq26GK1xEBBfhqo=
From: Dawei Li <dawei.li@linux.dev>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Cc: jgg@ziepe.ca,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com,
	Dawei Li <dawei.li@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for non-coherent SMMU
Date: Mon, 29 Dec 2025 08:23:54 +0800
Message-Id: <20251229002354.162872-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

According to SMMUv3 architecture specification, IO-coherent access for
SMMU is supported for:
- Translation table walks.
- Fetches of L1STD, STE, L1CD and CD.
- Command queue, Event queue and PRI queue access.
- GERROR, CMD_SYNC, Event queue and PRI queue MSIs, if supported

In other words, if a SMMU implementation doesn't support IO coherent
access(SMMUIDR0.COHACC==0), all fields above accessed by SMMU is
expected to be non-coherent and S/W is supposed to maintain proper
access attributes to achieve expected behavior.

Unfortunately, for non-coherent SMMU implementation, current codebase
only takes care of translation table walking. Fix it by providing right
attributes(cacheability, shareablility, cache allocation hints, e.g) to
other fields.

Fixes: 4f41845b3407 ("iommu/io-pgtable: Replace IO_PGTABLE_QUIRK_NO_DMA with specific flag")
Fixes: 9e6ea59f3ff3 ("iommu/io-pgtable: Support non-coherent page tables")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Li <dawei.li@linux.dev>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 73 +++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..4f00bf53d26c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -265,8 +265,14 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 	return 0;
 }
 
+static __always_inline bool smmu_coherent(struct arm_smmu_device *smmu)
+{
+	return !!(smmu->features & ARM_SMMU_FEAT_COHERENCY);
+}
+
 /* High-level queue accessors */
-static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
+static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent,
+				   struct arm_smmu_device *smmu)
 {
 	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
 	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
@@ -358,8 +364,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		} else {
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		}
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
+		if (smmu_coherent(smmu)) {
+			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
+			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
+		} else {
+			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_OSH);
+			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OINC);
+		}
 		break;
 	default:
 		return -ENOENT;
@@ -405,7 +416,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 				   q->ent_dwords * 8;
 	}
 
-	arm_smmu_cmdq_build_cmd(cmd, &ent);
+	arm_smmu_cmdq_build_cmd(cmd, &ent, smmu);
 	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
 		u64p_replace_bits(cmd, CMDQ_SYNC_0_CS_NONE, CMDQ_SYNC_0_CS);
 }
@@ -461,7 +472,7 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
 
 	/* Convert the erroneous command into a CMD_SYNC */
-	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync);
+	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync, smmu);
 	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
 		u64p_replace_bits(cmd, CMDQ_SYNC_0_CS_NONE, CMDQ_SYNC_0_CS);
 
@@ -913,7 +924,7 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
 
-	if (unlikely(arm_smmu_cmdq_build_cmd(cmd, ent))) {
+	if (unlikely(arm_smmu_cmdq_build_cmd(cmd, ent, smmu))) {
 		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
 			 ent->opcode);
 		return -EINVAL;
@@ -965,7 +976,7 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 	}
 
 	index = cmds->num * CMDQ_ENT_DWORDS;
-	if (unlikely(arm_smmu_cmdq_build_cmd(&cmds->cmds[index], cmd))) {
+	if (unlikely(arm_smmu_cmdq_build_cmd(&cmds->cmds[index], cmd, smmu))) {
 		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
 			 cmd->opcode);
 		return;
@@ -1603,6 +1614,7 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 {
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 	struct arm_smmu_device *smmu = master->smmu;
+	u64 val;
 
 	memset(target, 0, sizeof(*target));
 	target->data[0] = cpu_to_le64(
@@ -1612,11 +1624,18 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
 
+	if (smmu_coherent(smmu)) {
+		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
+		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
+		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
+	} else {
+		val = FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_NC) |
+		      FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_NC) |
+		      FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_OSH);
+	}
+
 	target->data[1] = cpu_to_le64(
-		FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) |
-		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
-		FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
-		FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
+		FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) | val |
 		((smmu->features & ARM_SMMU_FEAT_STALLS &&
 		  !master->stall_enabled) ?
 			 STRTAB_STE_1_S1STALLD :
@@ -3746,7 +3765,7 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	q->cons_reg	= page + cons_off;
 	q->ent_dwords	= dwords;
 
-	q->q_base  = Q_BASE_RWA;
+	q->q_base  = smmu_coherent(smmu) ? Q_BASE_RWA : 0;
 	q->q_base |= q->base_dma & Q_BASE_ADDR_MASK;
 	q->q_base |= FIELD_PREP(Q_BASE_LOG2SIZE, q->llq.max_n_shift);
 
@@ -4093,6 +4112,7 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	dma_addr_t dma;
 	u32 reg;
+	u64 val;
 
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
 		reg = FIELD_PREP(STRTAB_BASE_CFG_FMT,
@@ -4107,8 +4127,12 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 		      FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
 		dma = cfg->linear.ste_dma;
 	}
-	writeq_relaxed((dma & STRTAB_BASE_ADDR_MASK) | STRTAB_BASE_RA,
-		       smmu->base + ARM_SMMU_STRTAB_BASE);
+
+	val = dma & STRTAB_BASE_ADDR_MASK;
+	if (smmu_coherent(smmu))
+		val |= STRTAB_BASE_RA;
+
+	writeq_relaxed(val, smmu->base + ARM_SMMU_STRTAB_BASE);
 	writel_relaxed(reg, smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
 }
 
@@ -4130,12 +4154,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 
 	/* CR1 (table and queue memory attributes) */
-	reg = FIELD_PREP(CR1_TABLE_SH, ARM_SMMU_SH_ISH) |
-	      FIELD_PREP(CR1_TABLE_OC, CR1_CACHE_WB) |
-	      FIELD_PREP(CR1_TABLE_IC, CR1_CACHE_WB) |
-	      FIELD_PREP(CR1_QUEUE_SH, ARM_SMMU_SH_ISH) |
-	      FIELD_PREP(CR1_QUEUE_OC, CR1_CACHE_WB) |
-	      FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_WB);
+	if (smmu_coherent(smmu)) {
+		reg = FIELD_PREP(CR1_TABLE_SH, ARM_SMMU_SH_ISH) |
+		      FIELD_PREP(CR1_TABLE_OC, CR1_CACHE_WB) |
+		      FIELD_PREP(CR1_TABLE_IC, CR1_CACHE_WB) |
+		      FIELD_PREP(CR1_QUEUE_SH, ARM_SMMU_SH_ISH) |
+		      FIELD_PREP(CR1_QUEUE_OC, CR1_CACHE_WB) |
+		      FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_WB);
+	} else {
+		reg = FIELD_PREP(CR1_TABLE_SH, ARM_SMMU_SH_OSH) |
+		      FIELD_PREP(CR1_TABLE_OC, CR1_CACHE_NC) |
+		      FIELD_PREP(CR1_TABLE_IC, CR1_CACHE_NC) |
+		      FIELD_PREP(CR1_QUEUE_SH, ARM_SMMU_SH_OSH) |
+		      FIELD_PREP(CR1_QUEUE_OC, CR1_CACHE_NC) |
+		      FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_NC);
+	}
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);
 
 	/* CR2 (random crap) */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..7a5f76e165dc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -183,6 +183,7 @@ struct arm_vsmmu;
 #define ARM_SMMU_SH_ISH			3
 #define ARM_SMMU_MEMATTR_DEVICE_nGnRE	0x1
 #define ARM_SMMU_MEMATTR_OIWB		0xf
+#define ARM_SMMU_MEMATTR_OINC		0x5
 
 #define Q_IDX(llq, p)			((p) & ((1 << (llq)->max_n_shift) - 1))
 #define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
-- 
2.25.1


