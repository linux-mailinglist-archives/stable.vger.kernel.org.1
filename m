Return-Path: <stable+bounces-235498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO1nHGQC2Gm2WAgAu9opvQ
	(envelope-from <stable+bounces-235498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:47:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2363CF19C
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1793D300D444
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B404320CD3;
	Thu,  9 Apr 2026 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8oIvR5v"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9292DF132;
	Thu,  9 Apr 2026 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764051; cv=fail; b=CT8XGHQ73QmtlLbRocqsgiudpmcde/AdjxEcotgqtzoxV0w6zXWncOUM71up5Syic4v+1wOZa6CoTqHFUWwmLdD7d3pe8g8iyR3fKDRJYkIxbPUj0eLisfZjlRKM+HaTizTwJVfGhcUQ4vazQsRbP8r88GZ1pMyNRmrCc9R5XpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764051; c=relaxed/simple;
	bh=ZIsomVXw82iTGS0aYFfzWNq3Zs4RTTQDG38pXsut/ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klqQY9JkQdYLl16YFUj0NjyZPnlHsFjNjwRqTPIlcuKvCnilypomx9Fzl/NOLKYKYgj7aXCzfV2S7Nm4zXEH2N8FbWH5ljxJiyxXZnbwouE5vufwSpjAfumhOX0FYJ2t4v7JPXvw1RReRcZ86rwg5Xz4LDH8EDP3gyA2sC+GMkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M8oIvR5v; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3nK8LDfuj9SjBnxs+i/grogITEwoH9fD43Q2ejBX0Bw3LKp3P5rv+qu0srmP7dCFaV74Il793fEtB3Ph5t0dPS/jcmENHiZtclR51oZzr1wwKdx2iQL1v4Ot+IxQXXhVNQXyfZCzsDmItFeYAvpj7/j6TlGvHKUAp4pALmTRsvQ2Lu0BeDe6S7fgHTrtn5XW9eSW9NKx6OTsI/hSsRulBozqTR0fY+FlizRRjykBMTK6EL7PCdWFAxnGphZaHngNtPhDJlE8S58mhH/pakduoFpOmrFrDBpsyKGMTpv33Ci/i8F4DdaQt6sKmW+nn7PQ+2v3/OE60aPpuqUOpUjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ/Gqg6jqYmEDe5NzgGKhFYnU1Mg9VMvHAH67YKla2Y=;
 b=We/D9B9NfBQggIGk72NqylTm7VviR9gdEpkUN4urj+CZN+YU0xnzX2uY1h84YS/EjpEYsP4U81ZE7XiUctxKv1G7iC2SRWj3bK1IcOFqAWi6ZySxEJ/CVupv8HMypfkQDN77QLF09w85BN0s2WXHT55aIYOH5yB5OfdBBIvbgwfjw6zT4jBab+St28fK48F4M4pSJA130oOtxHGDckUsBsHmsjBNMbNal3SxJh6WB1EFhi06hFD0L9uN0nd++zYSBzNfHmGhIP/Bqt6hhH1udmehtP1J8+J6Zn5n6CwQk++iItwFny4cRXw/G55r1JsqDFXHBsMH/1QbQGXOtUhV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ/Gqg6jqYmEDe5NzgGKhFYnU1Mg9VMvHAH67YKla2Y=;
 b=M8oIvR5vsqkRHQgoq/Xt7q4ESLHJL5BalxKXKtXRLYWkNGziZ/RX8Q6yS4ssAPfjOHhsw2M8A/kTac5Z1lIlBMz5fxDC62B2pHWy2C1S83p2jjkGRZK3/x2Ls/Jv+PiGOLkww+Wqb8dFZdC2CVd6RuUCe7OJBZ11xNZdiy/bDp0wBHchMSDkcrZN8PeVqb1qrcydXrA5kIpQ03kYmPlKN9DqgOOISqjNgbGOEo5F1b1rv/pqla1vVla/bF8QKgl342svRutPJqydvRq7xKCsbddhUe4e2QsNF1fWng3vokrErv758ZU/7Gz1bPwco59l/CmpKlZ7MdtrROUoRwrKbA==
Received: from BYAPR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:c0::44)
 by DSVPR12MB999192.namprd12.prod.outlook.com (2603:10b6:8:496::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 19:47:25 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::20) by BYAPR05CA0031.outlook.office365.com
 (2603:10b6:a03:c0::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Thu,
 9 Apr 2026 19:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 19:47:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 12:47:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <jamien@nvidia.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH rc v1 3/4] iommu/arm-smmu-v3: Retain SMMUEN during kdump device reset
Date: Thu, 9 Apr 2026 12:46:52 -0700
Message-ID: <c116eba01bcd88ba3b8ba47dc08132c4546e91f5.1775763475.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DSVPR12MB999192:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7f8777-30de-40e6-1b87-08de9670d309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	60LccGDMmAWk2MQGqR9kuez4Yj6uxrgAOMQ9EHqhOCqnYQBIacpOeA+kbQn/tVfwQDGIOjoIkubZlSMb4mCC8KxG5G9yH2cWu2px75V/MKdL2VKTmjThXw34MQSGN8aMCrj+0oTGMd7NwMRqwWVaKvGIXZ4Ogi8vcCDwWxgzqMN1lOFuHsqMcMkVRf6mr+Ai9zzvf/MyDrcTqWficmBiH5StUKtT5O6OB/Ky5OklVeRz+M22n3W+BoWENisVtxTmLLtom/B2Yp7YmZQIgceQHppSvVnQVfLPrvx7NAkZ/5b0ZBiKlhpCoAgAkDW3QcbA9QxyezdguvxdRm55VIGmcS2y06ExhiWI8n61lfGabX8vnWGHU5i/VGtUMZYEy6dOgWdU5Zm4H11H5QaBzQhRbvcXVjQosSejmexMtiBzuMUMAKX3TzNuo+L0tTJUFs3LYfrQJlKjJN2FoV3oeGRBDYcs4Xv/kmnM8ysUtTcqoA18cRChQPjtlSkZLXU4YQ0Q86ez82i0mhgsdY4Cq6O0j2dBQA/qSvS3oWTFqh9KIc+uChyWiZ4PhONHnv7lNflPn0mJ2m0QYaBIOF6MGXGsN01lQsyM/AVb2+h7q5zMhXH8hWJlOWgdf86uPo5ksrdd1ZHfpLUORkP0ziiVHTOMsnZvZ+05E9pc1N1tY8MbfejHdtI8okzLHN5oWZjjbsGC91MQERQMo6h4Sgo4bhd8UZh8rAnipa9wFosiwQsBHMySNhOIniTU8KKnnmcmN9uB3OFM+SAJMW72iQaH00KvJQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0zlzX59H6lXZZyUSCoOWklLsNWfYa+5gd/D6L0SseOpTAnJubkxkGD05duqXnoENgKjuM50GpcnDKDApt6yOrXNTiFVKFUNwr+uuXcyEHyaMwr6S2ZbAyMSCS8DERQf3BP15fOCImUJ3ZWtC63gsqWQULwTOA49EEjhikbVwNseuQrOviLshbDMkPt11v0vecmcobYkQpCUsJ3kJjbIun4czTmYo9zMcuzuqQqHqkeY5LMQVYDZpoFgMsASyAkhqUFgAkWJBnT6EpIp5KosM+6n3yfYjiiJhCJA3dpSXx5vtXEZvsJCBNorkXyR4WjOS/7QRaV3e6kLH8KGDWMFp2PkD2xjIAisVewSFuabyXhIpvlFHZPnCoSWvuvHFtOtKlObxNfUap/ZrJpXlnFoX70ibyzaMEmQGgVBziK1PlsD3qIHLiyRU1tU26m+QlZDe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 19:47:25.3880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7f8777-30de-40e6-1b87-08de9670d309
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999192
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
	TAGGED_FROM(0.00)[bounces-235498-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: DD2363CF19C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ARM_SMMU_OPT_KDUMP is set, skip the GBPA/disable/CR1/CR2/STRTAB_BASE
update sequence in arm_smmu_device_reset(). Those register writes are all
CONSTRAINED UNPREDICTABLE while SMMUEN==1, so leaving them untouched lets
in-flight DMA continue to be translated by the adopted stream table.

Initialize 'enables' to 0 so it can carry CR0_SMMUEN in kdump case. Then,
preserve that when enabling the command queue.

Also add a comment explaining why EVTQ/PRIQ are disabled in kdump cases.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ff3c1beb3739e..d0ef8fb876978 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4931,13 +4931,28 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
-	u32 reg, enables;
+	u32 reg, enables = 0;
 	struct arm_smmu_cmdq_ent cmd;
 
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
 	if (reg & CR0_SMMUEN) {
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
+
+		/*
+		 * In a kdump case, retain SMMUEN to avoid transiently aborting
+		 * in-flight DMA. According to spec, updating STRTAB_BASE, CR1,
+		 * or CR2 while SMMUEN==1 is CONSTRAINED UNPREDICTABLE. So skip
+		 * those register updates and rely on the adopted stream table
+		 * from the crashed kernel.
+		 */
+		if (smmu->options & ARM_SMMU_OPT_KDUMP) {
+			dev_info(smmu->dev,
+				 "kdump: retaining SMMUEN for in-flight DMA\n");
+			enables = CR0_SMMUEN;
+			goto reset_queues;
+		}
+
 		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
 	}
 
@@ -4965,12 +4980,23 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Stream table */
 	arm_smmu_write_strtab(smmu);
 
+reset_queues:
+	if (smmu->options & ARM_SMMU_OPT_KDUMP) {
+		/* Disable queues since arm_smmu_device_disable() was skipped */
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to disable queues\n");
+			return ret;
+		}
+	}
+
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
 	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
-	enables = CR0_CMDQEN;
+	enables |= CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
 	if (ret) {
@@ -5038,6 +5064,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/*
+	 * Disable EVTQ and PRIQ in kdump kernel. The old kernel's CDs and page
+	 * tables may be corrupted, which could trigger event spamming. PRIQ is
+	 * also useless since we cannot service page requests during kdump.
+	 */
 	if (is_kdump_kernel())
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
-- 
2.43.0


