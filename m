Return-Path: <stable+bounces-98683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBDA9E49F8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEA71881D67
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770D4212B34;
	Wed,  4 Dec 2024 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q52KMq/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD62212B13;
	Wed,  4 Dec 2024 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355329; cv=none; b=GkDMWem5rkMUkVPH3m3XZbdsKknPV/UvXdyRCavgV20IdaWHIAJKLYiC2F4gikinXFBSpjbdjaXVgSZi4ZyCooCF6uzXdmIssX/svxGAAbpfcktJ/uc/fjtEhogRZuZtOgPMDyQ5caVp32+ixFww7k7XqAmno9iEZITwT/DVfRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355329; c=relaxed/simple;
	bh=fM3FuC5MJCayxxy8HgIG2dFsJmZdJELXfV1oQ8EQ6dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLgcFffV14L1rBgKONr9FrIuyXxv1jJIgXI7ajb5BwDkQvBICj1dynRMstQbpqrlJzVCRH8eUOpfM+/P9EBAwla9DjrOoRoEFbjMAgKtQn67XjsfT8qY1FRj34W4SlFb6mZL1z/TVQGrnoXjCJ6poFiidIzdw8qgUfV5SSzE1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q52KMq/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E354C4CECD;
	Wed,  4 Dec 2024 23:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355327;
	bh=fM3FuC5MJCayxxy8HgIG2dFsJmZdJELXfV1oQ8EQ6dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q52KMq/W4IEXl76GqdEAOuPsEJkiRsUtn8tmOHvlfF0vvfZNPn5zF3ulwo1so3Ads
	 LjNN21yXuM7IZf9M54aU62LlTUyGCUH5DHO62xFCpgxNaijS58ehqm7uJAR8Yi7AvK
	 bon/06nliZMuStIoggpnn2pNx1m9Lz7TXZIgj8Keh+9W4DIDVaiNDsp8H/fqKujzmK
	 i3Z0TwJXjfO6ZOJeVN6A3uPonlAmdjcOYTov8lpnjMWhXt9fTvv25/L4PRhgReIT03
	 fpTvUwr5nS9kRIqM5KeUMa9ZSzYZXmBliAkJTDNfqseFMJ5enWOMNjn6ooXo7ftPm5
	 Sitp5/BnPlGyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
	Marc Zyngier <maz@kernel.org>,
	Nianyao Tang <tangnianyao@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 4/7] irqchip/gicv3-its: Add workaround for hip09 ITS erratum 162100801
Date: Wed,  4 Dec 2024 17:23:46 -0500
Message-ID: <20241204222402.2249702-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204222402.2249702-1-sashal@kernel.org>
References: <20241204222402.2249702-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Zhou Wang <wangzhou1@hisilicon.com>

[ Upstream commit f82e62d470cc990ebd9d691f931dd418e4e9cea9 ]

When enabling GICv4.1 in hip09, VMAPP fails to clear some caches during
the unmap operation, which can causes vSGIs to be lost.

To fix the issue, invalidate the related vPE cache through GICR_INVALLR
after VMOVP.

Suggested-by: Marc Zyngier <maz@kernel.org>
Co-developed-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 +
 arch/arm64/Kconfig                          | 11 +++++
 drivers/irqchip/irq-gic-v3-its.c            | 50 ++++++++++++++++-----
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 8cd4f365044b6..8cf9187e435dd 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -258,6 +258,8 @@ stable kernels.
 | Hisilicon      | Hip08 SMMU PMCG | #162001900      | N/A                         |
 |                | Hip09 SMMU PMCG |                 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
+| Hisilicon      | Hip09           | #162100801      | HISILICON_ERRATUM_162100801 |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7d92c0a9c43d4..c5b7835f567c3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1215,6 +1215,17 @@ config HISILICON_ERRATUM_161600802
 
 	  If unsure, say Y.
 
+config HISILICON_ERRATUM_162100801
+	bool "Hip09 162100801 erratum support"
+	default y
+	help
+	  When enabling GICv4.1 in hip09, VMAPP will fail to clear some caches
+	  during unmapping operation, which will cause some vSGIs lost.
+	  To fix the issue, invalidate related vPE cache through GICR_INVALLR
+	  after VMOVP.
+
+	  If unsure, say Y.
+
 config QCOM_FALKOR_ERRATUM_1003
 	bool "Falkor E1003: Incorrect translation due to ASID change"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ab597e74ba08e..80676aa1c6ab5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -44,6 +44,7 @@
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
 #define ITS_FLAGS_FORCE_NON_SHAREABLE		(1ULL << 3)
+#define ITS_FLAGS_WORKAROUND_HISILICON_162100801	(1ULL << 4)
 
 #define RD_LOCAL_LPI_ENABLED                    BIT(0)
 #define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
@@ -61,6 +62,7 @@ static u32 lpi_id_bits;
 #define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
 
 static u8 __ro_after_init lpi_prop_prio;
+static struct its_node *find_4_1_its(void);
 
 /*
  * Collection structure - just an ID, and a redistributor address to
@@ -3797,6 +3799,20 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 	raw_spin_unlock_irqrestore(&vpe_proxy.lock, flags);
 }
 
+static void its_vpe_4_1_invall_locked(int cpu, struct its_vpe *vpe)
+{
+	void __iomem *rdbase;
+	u64 val;
+
+	val  = GICR_INVALLR_V;
+	val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
+
+	guard(raw_spinlock)(&gic_data_rdist_cpu(cpu)->rd_lock);
+	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVALLR);
+	wait_for_syncr(rdbase);
+}
+
 static int its_vpe_set_affinity(struct irq_data *d,
 				const struct cpumask *mask_val,
 				bool force)
@@ -3804,6 +3820,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	unsigned int from, cpu = nr_cpu_ids;
 	struct cpumask *table_mask;
+	struct its_node *its;
 	unsigned long flags;
 
 	/*
@@ -3856,6 +3873,11 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	vpe->col_idx = cpu;
 
 	its_send_vmovp(vpe);
+
+	its = find_4_1_its();
+	if (its && its->flags & ITS_FLAGS_WORKAROUND_HISILICON_162100801)
+		its_vpe_4_1_invall_locked(cpu, vpe);
+
 	its_vpe_db_proxy_move(vpe, from, cpu);
 
 out:
@@ -4163,22 +4185,12 @@ static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
 
 static void its_vpe_4_1_invall(struct its_vpe *vpe)
 {
-	void __iomem *rdbase;
 	unsigned long flags;
-	u64 val;
 	int cpu;
 
-	val  = GICR_INVALLR_V;
-	val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
-
 	/* Target the redistributor this vPE is currently known on */
 	cpu = vpe_to_cpuid_lock(vpe, &flags);
-	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
-	gic_write_lpir(val, rdbase + GICR_INVALLR);
-
-	wait_for_syncr(rdbase);
-	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	its_vpe_4_1_invall_locked(cpu, vpe);
 	vpe_to_cpuid_unlock(vpe, flags);
 }
 
@@ -4771,6 +4783,14 @@ static bool its_set_non_coherent(void *data)
 	return true;
 }
 
+static bool __maybe_unused its_enable_quirk_hip09_162100801(void *data)
+{
+	struct its_node *its = data;
+
+	its->flags |= ITS_FLAGS_WORKAROUND_HISILICON_162100801;
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4817,6 +4837,14 @@ static const struct gic_quirk its_quirks[] = {
 		.init	= its_enable_quirk_hip07_161600802,
 	},
 #endif
+#ifdef CONFIG_HISILICON_ERRATUM_162100801
+	{
+		.desc	= "ITS: Hip09 erratum 162100801",
+		.iidr	= 0x00051736,
+		.mask	= 0xffffffff,
+		.init	= its_enable_quirk_hip09_162100801,
+	},
+#endif
 #ifdef CONFIG_ROCKCHIP_ERRATUM_3588001
 	{
 		.desc   = "ITS: Rockchip erratum RK3588001",
-- 
2.43.0


