Return-Path: <stable+bounces-245076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKZ7Al33AGoFPAEAu9opvQ
	(envelope-from <stable+bounces-245076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:23:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106550673F
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9519130034B3
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724433F588;
	Sun, 10 May 2026 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OGI6W1YJ"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED2318EDC;
	Sun, 10 May 2026 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448210; cv=fail; b=hlDwgMJq7ztZAtItHnFII60bkTV6X7/me+I+m+Vyi2mUCLN5zn3qUedqj0MB4tlMfQQAbeL9V0oN4DLCGLggl5TR4gW9+NqPUTVkFmYlwd/xZvHuq+v5rvNI1l9+oSCEdyOG88UOzP/yaz2gtE7g+d1yoP+orYUPXVreOKQrtlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448210; c=relaxed/simple;
	bh=h3iTfLyQt/kUM8JsxhzOh9ecoAE2rCm4vnINJhd+egM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNCeBcd7iD58D+NVjHZxXJh2MiCtQMu5emCYwH7rqGMZDSuwZPYIKBMZADVy4tm2288YLJuiAMBAPoo9krhqPs0CKB/4c8tBUMrNNvMjgmur5wrHVecrh4SgE82MVVS8CFXWIXqSDAWo8no56wmQSa2pfgvnQu1pMXrc2l+RTsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OGI6W1YJ; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+ejbj9lQemU9L6/WZtkDhku83eMlPEGGaTDzwS3AD4GFXeaeqDj7F6Tt8SdeNWa0NHx2Eu/epEEau3Cny5gFx0DSKiF2gXGSa2BNuCj14f+doZjaBkC3qZK4LYwa3mFjIEHNoeszXdr1JKnlw9gEMOe4qis4cYd5gezF3IJgHKIMUZsYOWvEwvUq0QMhjs/YtdVieZ9jXMBITKJFR8VuJzWAYHjDBujfLbKtKpFWB7FKK+Yld7G/j3jr6rvepbE+Pd/kAnWtktkvNO0pVs4eIgPXCy0hBLcAJzcN4qJcvT+e9qwPZpKxqyC//KXNU763uScE75tv4ErxQJvaIwOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrImYHxszUDix6f9bzFRBScmOBcx7pz9u4xca4SVwuk=;
 b=n+sXv3UcObO1CJZyTZHPENf0S1uvrtijhA2hkMNSid09HhBlbVOnca3+bqnhdY5GKI/0+wsOoWqjWevsTwJnI2pK0fGSR/7EZbLBNKvL7aiq7ryHigQ77QrRg5XKTe3+vlc1aotpIdY3YOBjw7ZQps3+OJ49oyP0oI3fdM43NSHMQVypc8xaUFuUxtVPtmAYy/eXmYeolfpa8HcIWQk/tODrCNJwtmM9MaTUgKxkxoWhl/k+g83xr9yNVLHZGjfhxiJd5DlwC5y6WH8JURHHrOCdCfIcDi4hL6KFfiKd2ylFHwrVNFP335GdjYGb98p2N8s9d2dCAtRMHdr+URJwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrImYHxszUDix6f9bzFRBScmOBcx7pz9u4xca4SVwuk=;
 b=OGI6W1YJ3NSeXuUHQuaM2Fz4DdEvfUb7Teg6Rx/T04kU9LOy7Tsccc1+gBOnNnYCuhoLRM/4oHmLpKXj09Cl6krzqoTSyMKwdqzMnyEcVxUyqaI8yZI1e1ZowwrX9M+GaBkfElpS4lQGaPKs2W/jqgfm6UbMSZJ7QJzv3tw+5zOGcoLrdVeGltT+BbqSKRZhh1Rd31y/lbzWNF3KBIq5Gr/TW2TX8o1QxDg157Drine+3/Ii9bQ6H2CF+kJnEsDNyIU7OE1Apldg4lSqI+iZ2fjyqcZetgNqFj9rDCME7SdADWig/UuYCNUBUBPAp066UOgUZrDtj4lLp5njXdAhcw==
Received: from BL1PR13CA0200.namprd13.prod.outlook.com (2603:10b6:208:2be::25)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 21:23:21 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::ac) by BL1PR13CA0200.outlook.office365.com
 (2603:10b6:208:2be::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.14 via Frontend Transport; Sun, 10
 May 2026 21:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 21:23:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 14:23:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 10 May 2026 14:23:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 10 May 2026 14:23:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v5 1/6] iommu/arm-smmu-v3: Add arm_smmu_kdump_adopt_strtab() for kdump
Date: Sun, 10 May 2026 14:23:00 -0700
Message-ID: <0582326eeadd4ae2b16fd4914e9bd46da5a251d3.1778416609.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778416609.git.nicolinc@nvidia.com>
References: <cover.1778416609.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c3449c-85e4-4252-5312-08deaeda5c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xRhzaM7uwg7QM19Fmv2NWxck1APGp28PMe/vPpO/Vit55B7mzNHMuznR6yeIf7MI5v3LMJwDAWZLvAL+HQuQULL1o3sGWqRmujHv796mCWVuSo5f9ukThOFwNtrrawntgj+pfYa2WPCWhbriPvstRzo0RNJOq6jaIvGlU1/t6bCRId2P6OPkByP7GPf4zR+A9HOsvX3nGy7s8mfYPLBFS82n7QpKQnvfFXwTYcOeG01iZAGrDqEKfBcBvhaLDP7BtU+tvZMKMTbs9sIWUdqECYof7m2x8yjB5L/kvMKdXFuAoju5jRVQuRh9F8ky46qCVHE+A0GKIFYH8Of+ruf8YuOGKj3KIi4BhDxTVlbbI3uEAWze7rxwNIvmQ8cSBXLww8du1ZNZjda0h5D1qv02sFAKyB3R67Yj8ks9puqi3hG8MASX2PR0RukXiKEJfgt+10B6Va1Raal7KQa6OLRwBN0HQ3V1f3OHUqBZKvqx79B0gVg9q11M1KzTzwyIxbJQgRIIOC8tH4CZShXS866vs1et9v+Hssyw+aTpoH4ZLUxldXvevYZr8nDDiXdUOLQfSbyFh4TYvkJahbibETt7R1OyhSUupOF02mVZN4cLGhdEcCvAIywYzJxneppeuIH+IexWo+WRshyEJZKDaWnbOn9UXAH0Zb1Uby6WAi2NJH+rlggoc5CKlB7RO0YySKkWAzEOcYIrbk2lxJkFCNJBETX8g5am+n/4MHYr7gPPtSg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UaF6QBh1rQyW9hmoflTiQLegFjsMaIagnpoAAcM6NKe/1oItOmp113qZCAsauiZQ0oKsbyaAOTIXSYrSmjXdiGeL4RjYFSo39R0PncmIz9TYpzaKD/6tlzW9tcuiRiuIAceznoolFNuvsAZ7m8B1kb/Ud1NwtD+I5/v0lpA2BFrwn5T4J0xWLnGcYvS37/KrFC1prHlbyrSzhLXLefmdeAIOvzBmrX2kX9JynqDxoRIHGevWjSQd8qkUINMEDSIm9soJF+CX+7j/L9fatwqPhgK+H856OZJovYYhf/v5kmjE9ozs3RNUW3TGvTv9gy/HLkW0qItp1mhUrvR8HKuD+sU8JLWfCLNEsHAUeADS7A4DhVmBw7Zax+XahgUDD48P0mZN9Jz37ty7XUKVKnchXgRjzi9JX7K/er9oJZr/hfhGRGY6X89xdo9O7QTbW2/N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 21:23:21.0051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c3449c-85e4-4252-5312-08deaeda5c8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
X-Rspamd-Queue-Id: 1106550673F
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
	TAGGED_FROM(0.00)[bounces-245076-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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

Introduce ARM_SMMU_OPT_KDUMP_ADOPT and adopt functions memremapping all the
stream tables extracted from STRTAB_BASE and STRTAB_BASE_CFG.

Note that the adoption of the crashed kernel's stream table follows certain
strict rules, since the old stream table might be compromised. Thus, apply
a series of validations against the values read from the registers. If any
address or size doesn't pass the test, it means the stream table cannot be
trusted, so toss it entirely. To avoid OOM due to a deeply corrupted stream
table, the memremap for l2 tables is done on the kdump kernel's demand.

The new option will be set in a following change.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 305 +++++++++++++++++++-
 2 files changed, 303 insertions(+), 3 deletions(-)

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
index e8d7dbe495f03..bab60e4b91716 100644
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
@@ -2040,16 +2041,111 @@ static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
 	}
 }
 
+/*
+ * Adopting the crashed kernel's stream table has risks: the physical addresses
+ * read from ARM_SMMU_STRTAB_BASE / L1 descriptors may be corrupted. Reject any
+ * range that overlaps the kdump kernel's critical regions.
+ */
+static bool arm_smmu_kdump_phys_is_corrupted(phys_addr_t base, size_t size)
+{
+	/*
+	 * On arm64 kdump, iomem_resource entries are typically:
+	 * ------------------------------------------------------------
+	 * | Entry           | IORESOURCE_ Flags   | IORES_DESC_ Desc |
+	 * ------------------------------------------------------------
+	 * | System RAM      | MEM + BUSY + SYSRAM | NONE             |
+	 * | MMIO regions    | MEM + BUSY          | NONE             |
+	 * | Reserved memory | MEM                 | NONE             |
+	 * ------------------------------------------------------------
+	 *
+	 * Test and reject any overlap with MEM + BUSY, covering/excluding:
+	 *  + System RAM: silent corruption of kdump kernel's own memory
+	 *  + MMIO regions: fatal SError on cacheable speculative access
+	 *  - Reserved memory: crashed kernel's stream table might reside
+	 */
+	if (region_intersects(base, size, IORESOURCE_MEM | IORESOURCE_BUSY,
+			      IORES_DESC_NONE) != REGION_DISJOINT)
+		return true;
+
+	/*
+	 * Note: physical holes are absent from iomem_resource, so a corrupted
+	 * address pointing into one will not be caught here. Closing that gap
+	 * requires a firmware memory map and is left as a future improvement.
+	 */
+	return false;
+}
+
+static int arm_smmu_kdump_adopt_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
+					  u32 l1_idx, u64 l2_dma, u32 span,
+					  struct arm_smmu_strtab_l2 **l2table)
+{
+	phys_addr_t base = dma_to_phys(smmu->dev, l2_dma);
+	struct arm_smmu_strtab_l2 *table;
+	size_t size;
+
+	/*
+	 * Only a coherent SMMU is supported at this moment. For a non-coherent
+	 * SMMU that wants to support ARM_SMMU_OPT_KDUMP_ADOPT, try MEMREMAP_WC.
+	 */
+	if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_COHERENCY)))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Retest the memremap inputs in case the L1 descriptor was overwritten
+	 * since adopt. Reject this master's insert; panic or SMMU-disable would
+	 * either lose the vmcore or cascade aborts. Do not try to fix it, as it
+	 * would break all other SIDs in the same bus (PCI case). The corruption
+	 * blast radius is already bounded to that bus range.
+	 */
+	if (span != STRTAB_SPLIT + 1) {
+		dev_err(smmu->dev,
+			"kdump: L1[%u] span %u changed since adopt (was %u)\n",
+			l1_idx, span, STRTAB_SPLIT + 1);
+		return -EINVAL;
+	}
+
+	size = (1UL << (span - 1)) * sizeof(struct arm_smmu_ste);
+	if (arm_smmu_kdump_phys_is_corrupted(base, size)) {
+		dev_err(smmu->dev,
+			"kdump: L1[%u] now points at a corrupt range\n",
+			l1_idx);
+		return -EINVAL;
+	}
+
+	table = devm_memremap(smmu->dev, base, size, MEMREMAP_WB);
+	if (IS_ERR(table)) {
+		dev_err(smmu->dev,
+			"kdump: failed to adopt l2 stream table for SID %u\n",
+			sid);
+		return PTR_ERR(table);
+	}
+
+	*l2table = table;
+	return 0;
+}
+
 static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 {
 	dma_addr_t l2ptr_dma;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	struct arm_smmu_strtab_l2 **l2table;
+	u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
 
-	l2table = &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)];
+	l2table = &cfg->l2.l2ptrs[l1_idx];
 	if (*l2table)
 		return 0;
 
+	/* Deferred adoption of the crashed kernel's L2 table */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[l1_idx].l2ptr);
+		dma_addr_t l2_dma = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+
+		if (span && l2_dma)
+			return arm_smmu_kdump_adopt_l2_strtab(
+				smmu, sid, l1_idx, l2_dma, span, l2table);
+	}
+
 	*l2table = dmam_alloc_coherent(smmu->dev, sizeof(**l2table),
 				       &l2ptr_dma, GFP_KERNEL);
 	if (!*l2table) {
@@ -2061,8 +2157,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	arm_smmu_init_initial_stes((*l2table)->stes,
 				   ARRAY_SIZE((*l2table)->stes));
-	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
-				      l2ptr_dma);
+	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[l1_idx], l2ptr_dma);
 	return 0;
 }
 
@@ -4556,10 +4651,213 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
+					    u32 cfg_reg, dma_addr_t dma)
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
+		/*
+		 * If the crashed kernel's l1 descriptors are deeply corrupted,
+		 * blindly memremapping every l2 table here could lead to OOM.
+		 *
+		 * Defer the l2 memremap to arm_smmu_init_l2_strtab(), so peak
+		 * memory is bounded by the kdump kernel's actual demand.
+		 */
+	}
+
+	return 0;
+}
+
+static int arm_smmu_kdump_adopt_strtab_linear(struct arm_smmu_device *smmu,
+					      u32 cfg_reg, dma_addr_t dma)
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
+	/* Cap the size at what the kdump kernel itself would have allocated */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		max_log2size =
+			ilog2(STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES);
+	else
+		max_log2size = smmu->sid_bits;
+
+	/* cfg->linear.num_ents is unsigned int, so cap log2size at 31 */
+	max_log2size = min(max_log2size, 31U);
+	if (log2size > max_log2size) {
+		dev_err(smmu->dev, "kdump: unsupported log2size %u (> %u)\n",
+			log2size, max_log2size);
+		return -EINVAL;
+	}
+
+	/*
+	 * We might end up with a num_ents != sid_bits, which is fine. In the
+	 * ARM_SMMU_OPT_KDUMP_ADOPT case, arm_smmu_write_strtab() is bypassed.
+	 */
+	cfg->linear.num_ents = 1U << log2size;
+	cfg->linear.ste_dma = dma;
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
+static void arm_smmu_kdump_adopt_cleanup(struct arm_smmu_device *smmu, u32 fmt)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
+		if (cfg->l2.l2ptrs)
+			devm_kfree(smmu->dev, cfg->l2.l2ptrs);
+		if (!IS_ERR_OR_NULL(cfg->l2.l1tab))
+			devm_memunmap(smmu->dev, cfg->l2.l1tab);
+	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
+		if (!IS_ERR_OR_NULL(cfg->linear.table))
+			devm_memunmap(smmu->dev, cfg->linear.table);
+	}
+}
+
+static int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
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
+			ret = -EINVAL;
+		else
+			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
+							       dma);
+	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
+		/*
+		 * In case that the old kernel for some reason used the linear
+		 * format, enforce the same format to match the adopted table.
+		 */
+		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, dma);
+		if (!ret)
+			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+	} else {
+		dev_err(smmu->dev, "kdump: invalid STRTAB format %u\n", fmt);
+		ret = -EINVAL;
+	}
+
+	if (ret) {
+		dev_warn(smmu->dev, "kdump: falling back to full reset\n");
+		arm_smmu_kdump_adopt_cleanup(smmu, fmt);
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
+	    !arm_smmu_kdump_adopt_strtab(smmu))
+		goto out;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
@@ -4567,6 +4865,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+out:
 	ida_init(&smmu->vmid_map);
 
 	return 0;
-- 
2.43.0


