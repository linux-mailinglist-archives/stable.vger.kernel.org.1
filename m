Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF57A7EE9
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjITMV5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjITMV4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:21:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5FCA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:21:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A449AC433C7;
        Wed, 20 Sep 2023 12:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212509;
        bh=pA4i2nlgU5+O6P1XPELUzGK2FBBrB8uY0tTPksl1Grk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1HhaURj0Bwz0EPt6TFjMO8KqbaaFOYNHaVuwy/3Dvfq5ZSX64PCztP+rHLk7tdls
         qigN3pYM0G2G94XTTK0I09jIZIH+tt6J8jVum7W1908N6NLoKIg2G4624kDgw4QCPX
         WjqF6dcqE0WFhzWqxU7+wjBnIwwYN6qdz90JbTCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yicong Yang <yangyicong@hisilicon.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 09/83] perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09
Date:   Wed, 20 Sep 2023 13:30:59 +0200
Message-ID: <20230920112827.023874380@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit 0242737dc4eb9f6e9a5ea594b3f93efa0b12f28d ]

Some HiSilicon SMMU PMCG suffers the erratum 162001900 that the PMU
disable control sometimes fail to disable the counters. This will lead
to error or inaccurate data since before we enable the counters the
counter's still counting for the event used in last perf session.

This patch tries to fix this by hardening the global disable process.
Before disable the PMU, writing an invalid event type (0xffff) to
focibly stop the counters. Correspondingly restore each events on
pmu::pmu_enable().

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Link: https://lore.kernel.org/r/20230814124012.58013-1-yangyicong@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/acpi/arm64/iort.c              |  5 ++-
 drivers/perf/arm_smmuv3_pmu.c          | 46 +++++++++++++++++++++++++-
 include/linux/acpi_iort.h              |  1 +
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 4f3206495217c..10a26d44ef4a9 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -149,6 +149,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| Hisilicon      | Hip08 SMMU PMCG | #162001900      | N/A                         |
+|                | Hip09 SMMU PMCG |                 |                             |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 50ed949dc1449..554943be26984 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1474,7 +1474,10 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 static struct acpi_platform_list pmcg_plat_info[] __initdata = {
 	/* HiSilicon Hip08 Platform */
 	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
-	 "Erratum #162001800", IORT_SMMU_V3_PMCG_HISI_HIP08},
+	 "Erratum #162001800, Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP08},
+	/* HiSilicon Hip09 Platform */
+	{"HISI  ", "HIP09   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
+	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
 	{ }
 };
 
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index f5a33dbe7acb9..6ebe72b862661 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -95,6 +95,7 @@
 #define SMMU_PMCG_PA_SHIFT              12
 
 #define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
+#define SMMU_PMCG_HARDEN_DISABLE        BIT(1)
 
 static int cpuhp_state_num;
 
@@ -138,6 +139,20 @@ static inline void smmu_pmu_enable(struct pmu *pmu)
 	writel(SMMU_PMCG_CR_ENABLE, smmu_pmu->reg_base + SMMU_PMCG_CR);
 }
 
+static int smmu_pmu_apply_event_filter(struct smmu_pmu *smmu_pmu,
+				       struct perf_event *event, int idx);
+
+static inline void smmu_pmu_enable_quirk_hip08_09(struct pmu *pmu)
+{
+	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
+	unsigned int idx;
+
+	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
+		smmu_pmu_apply_event_filter(smmu_pmu, smmu_pmu->events[idx], idx);
+
+	smmu_pmu_enable(pmu);
+}
+
 static inline void smmu_pmu_disable(struct pmu *pmu)
 {
 	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
@@ -146,6 +161,22 @@ static inline void smmu_pmu_disable(struct pmu *pmu)
 	writel(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
 }
 
+static inline void smmu_pmu_disable_quirk_hip08_09(struct pmu *pmu)
+{
+	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
+	unsigned int idx;
+
+	/*
+	 * The global disable of PMU sometimes fail to stop the counting.
+	 * Harden this by writing an invalid event type to each used counter
+	 * to forcibly stop counting.
+	 */
+	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
+		writel(0xffff, smmu_pmu->reg_base + SMMU_PMCG_EVTYPER(idx));
+
+	smmu_pmu_disable(pmu);
+}
+
 static inline void smmu_pmu_counter_set_value(struct smmu_pmu *smmu_pmu,
 					      u32 idx, u64 value)
 {
@@ -719,7 +750,10 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 	switch (model) {
 	case IORT_SMMU_V3_PMCG_HISI_HIP08:
 		/* HiSilicon Erratum 162001800 */
-		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
+		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY | SMMU_PMCG_HARDEN_DISABLE;
+		break;
+	case IORT_SMMU_V3_PMCG_HISI_HIP09:
+		smmu_pmu->options |= SMMU_PMCG_HARDEN_DISABLE;
 		break;
 	}
 
@@ -806,6 +840,16 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
 	smmu_pmu_get_acpi_options(smmu_pmu);
 
+	/*
+	 * For platforms suffer this quirk, the PMU disable sometimes fails to
+	 * stop the counters. This will leads to inaccurate or error counting.
+	 * Forcibly disable the counters with these quirk handler.
+	 */
+	if (smmu_pmu->options & SMMU_PMCG_HARDEN_DISABLE) {
+		smmu_pmu->pmu.pmu_enable = smmu_pmu_enable_quirk_hip08_09;
+		smmu_pmu->pmu.pmu_disable = smmu_pmu_disable_quirk_hip08_09;
+	}
+
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = raw_smp_processor_id();
 	WARN_ON(irq_set_affinity_hint(smmu_pmu->irq,
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1a12baa58e409..136dba94c646f 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -21,6 +21,7 @@
  */
 #define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
 #define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
+#define IORT_SMMU_V3_PMCG_HISI_HIP09     0x00000002 /* HiSilicon HIP09 PMCG */
 
 int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
-- 
2.40.1



