Return-Path: <stable+bounces-241141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJRLMtQy7WmzggAAu9opvQ
	(envelope-from <stable+bounces-241141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:32:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE412467DA2
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C42833002D2B
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C1313E38;
	Sat, 25 Apr 2026 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWI7tokS"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581B846A;
	Sat, 25 Apr 2026 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152718; cv=fail; b=U1YWn/hxKkY4Dm5YCzdwl0um8GiwGOE7rVmBaK++p4ECGXRXjJWCuNemY9ttpq3bPM7ltq9ThRBcvVBqY1joptib4U6GkPpL9GkwqylnRQJ2lfNwMQxjpWtgvWUtfL4wEVE2drwhiRRD4hJBz+DewNamlywN4/ZBNtJt9cJ0OjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152718; c=relaxed/simple;
	bh=j4EmH+KDdB+pPGoMCkjt67IK2qGneg3VnqGkJU+xWCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDtfMOpRHokNWCGMSNUXB+oetDDd921CZ0WiGuxgnYib52vwYZMZvFnecxKNt8jvo5YySz8V9rsnRPlE8PGu+AmS5kBuKD4JDn2PNmHqVsk2UN1gnPIFMzA6RHRaR4hQcPZ5HLOUozRCYewhiHCo4lPojbA4T9Hm4D09wyCjWec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWI7tokS; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NImB9DGnjxr4YQpC+TWOLSXiDhStgpH/6iJxdQZUrP3+llQbVSn0RFCUhl4M6izgXrfaM8ZnxCj33sUuw7uv1OBWcSTJW8vljlIKwOHn5MsCJ1c+oWJuES0B0/v2/Exz4fxxKv2PJhwOhWf5Bia3op6ACv++gYK7CEtwuNP2WliFSvFoW8NJd4SYRBB00W/YFnKLJezEhmWWAJSofxVlka3estuAKmv6Qfu0pSzFBzCoteKpMTt1JfJcwGfI6igoqJSy/w5+n5hKsHnRcx2DG8/Pbp1hhZG86jwAr/UtVhCp6iyVbaQ6+yAiyjfwX3AXi2frnkgNuN1ZFlYj8Wg4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJapC3IJjVeTKWOBNjAYTThH0TwMQf222YcW5gtduDw=;
 b=F7C8dfzdgUqK4VJJjKSKraSQBmo44VStZHU5fs7n3F/6NVTeoTWbeo5xj3/xchrMDxsnWiOjQh96N4VLGFfKMD3qwoZbNSDHYJWk59cZzBZ2Lzm42FS1F9tY4/Mw4XJZWVKxAATVFw6njfi9J8Br6bKKxHduPgB1eC05IDHWTNjRbGb05m/T/i3T/LYLYCzglyresOKgw61hQpsbcrDIUZUopQHnJH0Lhw/PI7wLbe10W+dbfL7n8yLCXH6JNdPFPWG4VZksbGBmxXuKFlXzIIMSlw6RRBTtYJJeVDMBgj0VvmrefJXy46AF4yc720ACdft9WGjAgNWWLMNfHKBaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJapC3IJjVeTKWOBNjAYTThH0TwMQf222YcW5gtduDw=;
 b=KWI7tokS6cuzQqSbnZOYoX430QRNGfthwPkKuNVJ0Z9dNP/t/GAZiIQ7/wGEl8J+GkhKpJzAy33xbo9O1GSe2D1bFsbdBljWT/KsItFSxv61hDCCo3IPj2KKC0Dv5PY8DENU0NO1iAmonFIkPbVYkAHy0GbjV7kbyKpFNz1cdU7XjsBiN7EaAyiHue7fL1R/4dFnBtG+kl1AxErTYFnopI71EWbLDCraL86YtHF/nMGQfZxwrk2tXpzHjk0m+kexh3RK0PfkQqy4hsJNW1Dz1AUtbsPkptb5yk9+syJhBwNxBM9pHPz6VkUI4pZOnCUm4uTSKaWUiAe2LmI5GJoRSw==
Received: from MN2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:23a::14)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 21:31:47 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::d) by MN2PR03CA0009.outlook.office365.com
 (2603:10b6:208:23a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.24 via Frontend Transport; Sat,
 25 Apr 2026 21:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 21:31:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Apr 2026 14:31:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v3 1/5] iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab() for kdump
Date: Sat, 25 Apr 2026 14:30:46 -0700
Message-ID: <9ac81da2ad2fb5795565795759b3e1dd94f0b4bb.1777150307.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777150307.git.nicolinc@nvidia.com>
References: <cover.1777150307.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c49a301-ab12-476c-5797-08dea3120dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bS6auw0ltdEMQo+hrN6TL7JQPvA4EhssCra5MM17uG2TmC3ejn90lNsMVSIupHiRMppq6NwA4PkRLYWIuLA71QkxSzwVULE0UzCC36ntXE9BX1PdaeZ8rvR4RWrhBbnzrtN3tQOpBYG2RAT8E+P11kLzgjWi7CwhNlICiQxkd0Abq1qHD7Qwd+kmilvyJ+Qbcm0qvgkMZUCOZS7Wi28QK2OCO9nTc+sheCzlUH4ctrrdNGyCu+I0HTg6VRXGvr7OvyoFflU1YPJK9rpw/WpYCG+Zj2HvpLPSJzheJ43Y3Ge1x42DeaDcnfGTBectRKwfc8kED765YI2gsHJmHgIw3u+Lp8zPz96sALMcwQv9KswMrj032H/MZOn1XoQ3LM1eYoK8ru1/3XHMkui1CJ7tD0nQ28UG6BjvmNpW0AwOMqjmussxzpnOkXw3pLN7qQqh+OQiHjIRsJG6r32mBTr4Ddr1mfcGSvsj2i6yYN1LkUoJyo3nNmLmXVf/LrlfxsihCCBRx/1Q4QgVhkWOSCECHcSDY65YAiVHs5/nRWJoPpBH/qHUvRZYZ5ZcePOPCPHpL0DP/SutxsrleFqrufeDDIs3ipo4d5+HNx5HaKcxhn0eb3tOrXdzSVDxs5KW68yPe5oWwtRvm+Jt3QPWU+YLen2bpK6d8rRSzn5SCdh8X1XSmkMVd5iY8EGNcV3ASYSBhZzSezioT+P767Iwu4i43yZiEBPuMT3mXIUnhZM63lo89yLxYMlXbVhXbdgoa9SdlV/FrGeBM6S9L7ol5k+QLg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dgTnqkGikJR0eAykHr7FYf837L6oovbCq1lK+BxgwWsBH3sw8N4EFXq4QXXs06NOvOaDUCLyZb2YHCTV1ky7FAhkoJR5YgCCUb8fP7u1h3R0PZRvLhKBPFJ38BY0BQuDZN01KX6AIjSQS9tD1SAAq9GrdVyQfvLQdYEYJDlLLzgess+LTEvsz8khR0w532Zp5BKjdw5X0lwnE/7uyirmYyOLFBMULvqZEWUB6Q2f0jujBOCZDQmrBsT3zrCuiAUvXTfPaltsEGtqlhwqBhmauZBcmk1ZS1kjAk0dcfPyV9vhiQLnLfcnk3SJObWpeOUNponDy3LoXM34VZemR/m4pVu/94P+SjJM0/srpR6ZgGK9Yk2RA//OhyJfipNbY8fdD1VRHzbXvEN3df26wQ1MOw4rCqa1yJt0dy35gO8uIVzGae/3cTRDM7p/tFMteGKr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:31:46.7777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c49a301-ab12-476c-5797-08dea3120dd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Rspamd-Queue-Id: CE412467DA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241141-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMAs, a kdump kernel will have to leave SMMUEN=1
intact and avoid modifying STRTAB_BASE, allowing HW to continue translating
in-flight DMAs reusing the crashed kernel's page tables until the endpoint
device drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

Introduce ARM_SMMU_OPT_KDUMP_ADOPT and its pairing arm_smmu_adopt_strtab(),
which does memremap on all the stream tables extracted from STRTAB_BASE and
STRTAB_BASE_CFG. This new option will be set in arm_smmu_device_hw_probe()
in a following change.

Note that the adoption of the crashed kernel's stream table follows certain
strict rules, since the old stream table might be compromised. Thus, apply
a series of validations against the values read from the registers. If any
address or size doesn't pass the test, it means the stream table cannot be
trusted, so toss it completely.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 187 ++++++++++++++++++++
 2 files changed, 188 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ef42df4753ec4..cd60b692c3901 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -861,6 +861,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+#define ARM_SMMU_OPT_KDUMP_ADOPT	(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f6901c5437edc..bf292e1e0c323 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
+#include <linux/dma-direct.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
@@ -4553,10 +4554,195 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+/*
+ * Adopting the crashed kernel's stream table has risks: the physical addresses
+ * read from ARM_SMMU_STRTAB_BASE / L1 descriptors may be corrupted. Reject any
+ * range that overlaps the kdump kernel's critical regions.
+ *
+ * Note that we cannot reject an overlap on IORESOURCE_MEM, as reserved regions
+ * of the crashed kernel might reside there.
+ */
+static bool arm_smmu_kdump_phys_is_corrupted(phys_addr_t base, size_t size)
+{
+	/* Must NOT overlap kdump kernel's own RAM */
+	return region_intersects(base, size, IORESOURCE_SYSTEM_RAM,
+				 IORES_DESC_NONE) != REGION_DISJOINT;
+}
+
+static int arm_smmu_adopt_strtab_2lvl(struct arm_smmu_device *smmu, u32 cfg_reg,
+				      dma_addr_t dma)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	u32 split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, cfg_reg);
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	phys_addr_t base;
+	u32 num_l1_ents;
+	size_t size;
+	int i;
+
+	/*
+	 * Only a coherent SMMU is supported at this moment. For a non-coherent
+	 * SMMU that wants to support ARM_SMMU_OPT_KDUMP_ADOPT, try MEMREMAP_WC.
+	 */
+	if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_COHERENCY)))
+		return -EOPNOTSUPP;
+
+	if (log2size < split || log2size > smmu->sid_bits) {
+		dev_err(smmu->dev, "kdump: log2size %u out of range [%u, %u]\n",
+			log2size, split, smmu->sid_bits);
+		return -EINVAL;
+	}
+	if (split != STRTAB_SPLIT) {
+		dev_err(smmu->dev,
+			"kdump: unsupported STRTAB_SPLIT %u (expected %u)\n",
+			split, STRTAB_SPLIT);
+		return -EINVAL;
+	}
+
+	num_l1_ents = 1U << (log2size - split);
+	if (num_l1_ents > STRTAB_MAX_L1_ENTRIES) {
+		dev_err(smmu->dev, "kdump: l1 entries %u exceeds max %u\n",
+			num_l1_ents, STRTAB_MAX_L1_ENTRIES);
+		return -EINVAL;
+	}
+
+	cfg->l2.l1_dma = dma;
+	cfg->l2.num_l1_ents = num_l1_ents;
+
+	base = dma_to_phys(smmu->dev, dma);
+	size = num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
+	if (arm_smmu_kdump_phys_is_corrupted(base, size)) {
+		dev_err(smmu->dev, "kdump: l1 stream table is corrupted\n");
+		return -EINVAL;
+	}
+
+	cfg->l2.l1tab = devm_memremap(smmu->dev, base, size, MEMREMAP_WB);
+	if (IS_ERR(cfg->l2.l1tab))
+		return PTR_ERR(cfg->l2.l1tab);
+
+	cfg->l2.l2ptrs = devm_kcalloc(smmu->dev, num_l1_ents,
+				      sizeof(*cfg->l2.l2ptrs), GFP_KERNEL);
+	if (!cfg->l2.l2ptrs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_l1_ents; i++) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+		dma_addr_t l2_dma = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+
+		if (!span || !l2_dma)
+			continue;
+
+		if (span != STRTAB_SPLIT + 1) {
+			dev_err(smmu->dev,
+				"kdump: L1[%u] unsupported span %u (vs %u)\n",
+				i, span, STRTAB_SPLIT + 1);
+			return -EINVAL;
+		}
+
+		base = dma_to_phys(smmu->dev, l2_dma);
+		size = (1UL << (span - 1)) * sizeof(struct arm_smmu_ste);
+		if (arm_smmu_kdump_phys_is_corrupted(base, size)) {
+			dev_err(smmu->dev,
+				"kdump: l2 stream table is corrupted\n");
+			return -EINVAL;
+		}
+
+		cfg->l2.l2ptrs[i] =
+			devm_memremap(smmu->dev, base, size, MEMREMAP_WB);
+		if (IS_ERR(cfg->l2.l2ptrs[i]))
+			return PTR_ERR(cfg->l2.l2ptrs[i]);
+	}
+
+	return 0;
+}
+
+static int arm_smmu_adopt_strtab_linear(struct arm_smmu_device *smmu,
+					u32 cfg_reg, dma_addr_t dma)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	unsigned int max_log2size;
+	phys_addr_t base;
+	size_t size;
+
+	/*
+	 * Only a coherent SMMU is supported at this moment. For a non-coherent
+	 * SMMU that wants to support ARM_SMMU_OPT_KDUMP_ADOPT, try MEMREMAP_WC.
+	 */
+	if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_COHERENCY)))
+		return -EOPNOTSUPP;
+
+	/* cfg->linear.num_ents is unsigned int, so cap log2size at 31 */
+	max_log2size = min(smmu->sid_bits, 31U);
+	if (log2size > max_log2size) {
+		dev_err(smmu->dev, "kdump: unsupported log2size %u (> %u)\n",
+			log2size, max_log2size);
+		return -EINVAL;
+	}
+
+	cfg->linear.ste_dma = dma;
+	cfg->linear.num_ents = 1U << log2size;
+
+	base = dma_to_phys(smmu->dev, dma);
+	size = cfg->linear.num_ents * sizeof(struct arm_smmu_ste);
+	if (arm_smmu_kdump_phys_is_corrupted(base, size)) {
+		dev_err(smmu->dev, "kdump: stream table is corrupted\n");
+		return -EINVAL;
+	}
+
+	cfg->linear.table = devm_memremap(smmu->dev, base, size, MEMREMAP_WB);
+	if (IS_ERR(cfg->linear.table))
+		return PTR_ERR(cfg->linear.table);
+	return 0;
+}
+
+static int arm_smmu_adopt_strtab(struct arm_smmu_device *smmu)
+{
+	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
+	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
+	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
+	dma_addr_t dma = base_reg & STRTAB_BASE_ADDR_MASK;
+	int ret;
+
+	dev_info(smmu->dev, "kdump: adopting crashed kernel's stream table\n");
+
+	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
+		/*
+		 * Both kernels run on the same hardware, so it's impossible for
+		 * kdump kernel to see the support for linear stream table only.
+		 */
+		if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
+			return -EINVAL;
+		ret = arm_smmu_adopt_strtab_2lvl(smmu, cfg_reg, dma);
+	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
+		/*
+		 * In case that the old kernel for some reason used the linear
+		 * format, enforce the same format to match the adopted table.
+		 */
+		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+		ret = arm_smmu_adopt_strtab_linear(smmu, cfg_reg, dma);
+	} else {
+		dev_err(smmu->dev, "kdump: invalid STRTAB format %u\n", fmt);
+		ret = -EINVAL;
+	}
+
+	if (ret) {
+		dev_warn(smmu->dev, "kdump: falling back to full reset\n");
+		smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
+		memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
+	}
+	return ret;
+}
+
 static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	if ((smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	    !arm_smmu_adopt_strtab(smmu))
+		goto out;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
@@ -4564,6 +4750,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+out:
 	ida_init(&smmu->vmid_map);
 
 	return 0;
-- 
2.43.0


