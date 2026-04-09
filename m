Return-Path: <stable+bounces-235500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFUAHIAC2Gm2WAgAu9opvQ
	(envelope-from <stable+bounces-235500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:48:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03E3CF1C8
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33C593029E74
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C17A33ADA9;
	Thu,  9 Apr 2026 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OQ/MmDkr"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F41336EF8;
	Thu,  9 Apr 2026 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764054; cv=fail; b=qbi+9MQ0wEehHoMpU+HtyGxNo+UVk93S3hPx3rtiIRZ4A6Mtnt5hrhpZvVnsxJPkFe1n8/kKr3G3GwhO7DkMxAygC2f/9P6tggbRX7EvsCeCdpjPUs0+NtwelB9EHvA5gStXHi2XcFh8DL1McnK9vTAMnebwc/iz7+isx+xQ8SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764054; c=relaxed/simple;
	bh=5fY2m7tDPUb6Zqba3BPYED6TJYi6tSXLza+eL69VRDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3uWQazxmAsL+iJhAybFHTRarw2hQ1mtn3qTc6b/2K82F72EXwgUWxcun5gSeFB38wpik/JpBYHXuNtLl24wDAGd2EIXYkMFHU+xTVi/VsEfjwB3rsE9k9B3x7USvYqrcuEGpIqqdXffKaZifcnqL5lxcCwWPI09DK7nawiTenk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OQ/MmDkr; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9D0O7+wycgpMPQOlSBBVCixBJQJOL5jvKlOQaG9P/rg6ISfSNItiRS4O3NJ9CjV3UyH2MocdSBHJ6Pm5Ze+wLOzxfJpTQooOO/5CSxcDh8fBHhFhwjermSlJJObdSp0xYU+bUgf4PM0l8ylE9plpYQgAsF+a/rSBO0pIRsMEqw7Bxww+JLQgquAYCTXi/tq55o41anVxX+d53tTptKTYPowdTjtFF7/lbue5Y2QYRXHi1/aWYb42Uifs0gvOzpRBDwDVe4QiJHsxI0ghyTwFk8dJ55B/1Y+YwQrxJmL8dxnw3LOXbLlEuH7sF+xRVT2yjqAbOBjNFw8l7NrYRLASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x07r8VwaVwP1ur3rwdzfgwsdYnvs9VluKudbFuuN5PM=;
 b=jAJOq87OuKEwktMUsXi8Lh2eR+1OfQhz84ChknfYtQCY+TZQYCcP8416cgtm4t/e8f9nVmg3SarwCT0cbtlwAMd13ToKb3PqjpJ8VzgqHmUlk/9ZlOSE37TOG5bMkqymclg5MMTMzryXKmcG6Ndi2H7UyFRlNLGArSTawHQ7PL2hpQTJFBi1U54BQ3FOvaUrYkkhzEG/mb0mVK7UDnKND/dDBgSBXU3prbAm1CGuZ7y2SasoPJ9RtRMsT7rbOiQQA3lL09SlmLkVAwTmqSsi+dOBJtX/+Vbq5qsMaz+Vg6TyepT1mr2dSVLYWAc2HogBob3qPNgsBcJy9BYA+nAmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x07r8VwaVwP1ur3rwdzfgwsdYnvs9VluKudbFuuN5PM=;
 b=OQ/MmDkrc378HYRp4epNd4FftOdb+O+J5/DKyQBiQtEN5Y+NinGukOynyrhuVr7L1OjhkYuFGtCbRY99xe3udB0xDglimQG47GngxXIVecOhadO3GUuSharA3dSBfBoE9mhqhuG5JhmgzMU0KK6y8yk6nPJ1R9844Jui/kN0VU71AYbNdVciD9eyH2f3Nlq3MW/gnOrdWp1nzdMRc2PHZpV1pwitQP1Exrdh8n1iwM5G/+m12PPO6UQSv4kMALtuiEh9arDRgvLiunbHG4xC8LHRsJAP4S+UuVlOsbdAm247QhwAkdyQKna1rklcA5N5B7N+4VpvXguzeOfcSjHiNw==
Received: from SJ0PR05CA0202.namprd05.prod.outlook.com (2603:10b6:a03:330::27)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 19:47:27 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::3e) by SJ0PR05CA0202.outlook.office365.com
 (2603:10b6:a03:330::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 19:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 19:47:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 12:47:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <jamien@nvidia.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH rc v1 1/4] iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab() for kdump
Date: Thu, 9 Apr 2026 12:46:50 -0700
Message-ID: <30c7c51c8771722813a9cf54dae7a1b5d0aeb65d.1775763475.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775763475.git.nicolinc@nvidia.com>
References: <cover.1775763475.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec4d40f-4795-4b99-50d8-08de9670d410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UQmwfwn4EVP8rAfyrJhGQFJlSn5r3NAVFgf/iwRJxmmL1oiirWmcHuALkUtLdjhjV+YOqkMZfnltDgGHxt5Qf+SqESVKjhKjWpMelCU7JpI5uS0WwjgthJAdIeoBRnmFwCsmixOamXf96ET9WApUzXUkpPkBsIsoDgSv8AJ6QOnt5OB9yVh880aCcviV6U8M/Dqzp2/rrdIGBY3DILn9ijN98xoVySbZx3rx36mlfxNrZ29TnE1xWYg1OHLBL3G8uN+HRayrDxXSqbXI5cyxHZl6qhvJ+bOWgOZVV3uL9FVf/lKphoVBd0pHNS00JXWtmUsh0tOtviPEprJutQVAWybA7VcYCRxwqx/NLDgQLCTP8nQU8hubzQ6lfBErPywSF6ymAoysdYJoEEvk+1lU/Qpqb6EGRmk2I8Wc+tPg+QSAIMaKI++PNSnVy070Ujjd3LqJkmgA1F4Y12q7lvZQGYuUw9AeiM0kEYF+2J7qzkPlFnUrt828zhWucgN97ty6eAsDesSWJzJCiCLcku4sUt3nD5hskao3o7MRTUAdbi6s+tD8cwWcenb9YZKVEy3ig7hRnHIQIiTm8sV20f+nsPpbRx5VjrLC9FuHK9pvxqY7jwXz5sm8rSZ59YHo92E3SMrl87w0+L9I9hWwZlYUnFJQykcD99wDxR00Se5lFCjsos+F3V7lY0G1zpukkkZIiQjyXjhMzlf9xaNXkGKOD2rGEV0BIoTS42wf+YN6Lfb1mNC7CiFjQB0TzdyAmXLEJeA+97SrL6Md5Q0BrWMfqQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+viQYQPo88ZkpyXPrtmjrEiNSRji5apPXMoKNRKrnUf6/5x9fW7qmoHcBxzodNAdZ6nOrgjvHBOcmVVMJGtq/Gul1Az5aKnFfRwIn4bKLjmk3PhnYI5N06dRsyWa0Yk8CNEWhKYIg3ZvlANhF0iYpxAMwfsei4QSSX1ljKQlMg2TXUeBkY9RIvNuJ58h0sJS5R4OD6bj1OZgWKTIWpaVEOh6kydge7hzTkdVIfNjXeddNI0oy6Rn6LCPfqegl2Aqngl+o+11gqGV1/yiBPycrKzcMQcu9eAsW9Wna97YYApwk4RrWmOa1UFKEEkEZO0qSt0LXi+U+OOqqb73IeexvJh9jZp/ptb9699Wvd2VyYP0LdbSyf7+lzFrbAlKbCFZJ6/TfKcyGAYdx0Nyyn9Jq0DnybctxgPeCAloe0ohPDk//+O17cTzHs2hbWwBWhs0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 19:47:27.1121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec4d40f-4795-4b99-50d8-08de9670d410
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235500-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0E03E3CF1C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
flight DMA using the crashed kernel's page tables until the endpoint device
drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

Introduce ARM_SMMU_OPT_KDUMP and arm_smmu_adopt_strtab() that does memremap
on all the stream tables extracted from STRTAB_BASE and STRTAB_BASE_CFG.

The option will be set in arm_smmu_device_hw_probe().

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 99 ++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ef42df4753ec4..74950d98ba09f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -861,6 +861,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+#define ARM_SMMU_OPT_KDUMP		(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f6901c5437edc..8a1de3a67f78c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4553,11 +4553,108 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int arm_smmu_adopt_strtab_2lvl(struct arm_smmu_device *smmu, u32 cfg_reg,
+				      dma_addr_t dma)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	u32 split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, cfg_reg);
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 num_l1_ents;
+	int i;
+
+	if (log2size < split) {
+		dev_err(smmu->dev, "kdump: invalid log2size %u < split %u\n",
+			log2size, split);
+		return -EINVAL;
+	}
+
+	if (split != STRTAB_SPLIT) {
+		dev_err(smmu->dev,
+			"kdump: unsupported STRTAB_SPLIT %u (expected %u)\n",
+			split, STRTAB_SPLIT);
+		return -EINVAL;
+	}
+
+	num_l1_ents = 1 << (log2size - split);
+	cfg->l2.l1_dma = dma;
+	cfg->l2.num_l1_ents = num_l1_ents;
+	cfg->l2.l1tab = devm_memremap(
+		smmu->dev, dma, num_l1_ents * sizeof(struct arm_smmu_strtab_l1),
+		MEMREMAP_WB);
+	if (!cfg->l2.l1tab)
+		return -ENOMEM;
+
+	cfg->l2.l2ptrs = devm_kcalloc(smmu->dev, num_l1_ents,
+				      sizeof(*cfg->l2.l2ptrs), GFP_KERNEL);
+	if (!cfg->l2.l2ptrs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_l1_ents; i++) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+		dma_addr_t l2_dma = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+
+		if (span && l2_dma) {
+			cfg->l2.l2ptrs[i] = devm_memremap(
+				smmu->dev, l2_dma,
+				sizeof(struct arm_smmu_strtab_l2), MEMREMAP_WB);
+			if (!cfg->l2.l2ptrs[i])
+				return -ENOMEM;
+		}
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
+
+	cfg->linear.ste_dma = dma;
+	cfg->linear.num_ents = 1 << log2size;
+	cfg->linear.table = devm_memremap(smmu->dev, dma,
+					  cfg->linear.num_ents *
+						  sizeof(struct arm_smmu_ste),
+					  MEMREMAP_WB);
+	if (!cfg->linear.table)
+		return -ENOMEM;
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
+		/* Enforce 2-level feature flag to match the adopted table */
+		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+		ret = arm_smmu_adopt_strtab_2lvl(smmu, cfg_reg, dma);
+	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
+		/* Force linear feature flag to match the adopted table */
+		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+		ret = arm_smmu_adopt_strtab_linear(smmu, cfg_reg, dma);
+	} else {
+		dev_err(smmu->dev, "kdump: invalid STRTAB format %u\n", fmt);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
 static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+	if (smmu->options & ARM_SMMU_OPT_KDUMP)
+		ret = arm_smmu_adopt_strtab(smmu);
+	else if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
 		ret = arm_smmu_init_strtab_linear(smmu);
-- 
2.43.0


