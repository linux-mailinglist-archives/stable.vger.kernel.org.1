Return-Path: <stable+bounces-241143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKPsFuQy7WmzggAAu9opvQ
	(envelope-from <stable+bounces-241143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:32:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AC2467DC8
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0B223006907
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2A31A7E2;
	Sat, 25 Apr 2026 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OxMoXcFk"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34515318BB3;
	Sat, 25 Apr 2026 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152721; cv=fail; b=t6TkSQKJuBcr/RNzfqiYad3DiNrTV/+I7vQTBEWGzDb6AKoYi3nMt5HAJwWoyZTWZFCqLIgVX9ANwfZLdZ+DCuotW4booj6NoLrBJE7l7WwbM84VzlmOj+Qow8OTJ1k+IP8Q0u0FaguXKdups+lWU2YaGpuC9Frff79xsqXq/lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152721; c=relaxed/simple;
	bh=/uY0kptIgCD5XoEXe+nJoKSeSfA5yvoBu2qdqp3B5JA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POlmGBeBFe6EGfr7Br659rMh9qKvbFfp7n4ai+25agb2FDymeeKxH8HZVTZgrU5rbxIe1bdRd5OH492ql4LNGC4+tVrdCGVbiCho+rg/nCs2+vU8i9XeYqBrzjduzAwR8k6QZbip3WkBR+9IA4UBisUDabCqDfeFmwxgJt7KQIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OxMoXcFk; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjj//V4Gq/0dBO88DRBqLr5XQRsCIBtpvH2wW7P507ylfoqX03zi3LQZhKDtKg0fHIgV1P/cMkQyDzaV6fWPcQB4zgBSPTORBJe7QZsNYqApoFyQtQOa9CG9IAmEcIPfU7YjRRnBYp3WYaJr9+KwCx5P2KPUQhE8plrdNh64WZT3Mgtn+Qf8CmOJSWEOLxFXSRiVr8wOr+PBzQgagxM7O4c9Iakcrgb/AKb1S4esqbfD/xqBTchd20JDNtXqqmQREKxPFn3LqsP7ui9T45TTJ+yJO7XDDgMgAfp3CkgH2YFRuiHfkUejUoweG5uUTicjCDp6JuYeaSnql76TZJW2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA/D+kXiH/QqINGgKJ2gzlENfO1y9ui02RxRBoep5zw=;
 b=H61pfyvBhYC+UE8WG1cTlirCDGifdT7234VjxnIJ+oXUz7vh6WLYYvDXMRzLkdltWuOPMsm+pMbKPi1Vs0p5NLGlnx685CsOKsaZNHLnnp+YD3hxXUT/yl/9mqk5PjJZUy9gHBUgnnrO2YRD+ZU4VnArz0jz+pIBqZERHgxHOfKb9r8T1cCKKqmISSXkPLjJfk52/GlYnWN7Po/ervKM/BwFBlur7OZ/MWTHnI2iAenfMTD8Qy7iG4SZ+fRJsABfUri2+oU5uyRjaxiVhXgHKygkMmzzrnzaU6OMESRd+3e0auLjZo4vU+SRwigOShD5cnvfTSHGRBVbmub0YI8hBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA/D+kXiH/QqINGgKJ2gzlENfO1y9ui02RxRBoep5zw=;
 b=OxMoXcFkqLu8FetIg7cH9lDLTvz+yRiyYdp/ye5sJ2XOlCVclTZc6eVTWwo7Sz+ijUuXI5izzjn1a2ZTZES8vmSx7DSb1gsZi++8WTCRTHJbAE8jKvZ9J8EEXashHXmDqMaEw/RgojUxjwTdej1xcXFTrIHDW4mRFXS1RDFlfetB0NX0OU0E6KyRGxT8i7CEo3Tw8QA883ib1H7oIG1EPyK8fx3SUE+WpiuCwItlb5N43NYgZIejRQw3pb3OJZnmSGYY0RTzI/joHS2qmhP2EF7uu2+ibcE80VPzDcC3LQSdN7X7vpgOX2k2MvMcrm/XllUTLSK9o7CnYnHxzJCIWQ==
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 21:31:55 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::2b) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.24 via Frontend Transport; Sat,
 25 Apr 2026 21:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Sat, 25 Apr 2026 21:31:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:45 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Apr 2026 14:31:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v3 3/5] iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
Date: Sat, 25 Apr 2026 14:30:48 -0700
Message-ID: <1429cebde1bdc3577ef24ee4f95e64397d538b31.1777150307.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd93daa-d9a5-4257-af2a-08dea31212c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|22082099003|56012099003|18002099003|18096099003;
X-Microsoft-Antispam-Message-Info:
	/XTxRgAqP0LmuvwtBrb2rkLUUsNidBF4LPC8lfit1gRXGVFjCHVASgNlmSWUW8k5e2P0QV1nHy9qfU4ulPn4ZAVIARqAKOx/iJJT/qIJy35w6pKQX5+tby9CGLMpCUMT+MjWOYIi3GPe2ALxHWsBFLO743VcgSg1+AsWwXu2rKEJDSU66wwjEPqodgOGQ5KjVw1IvTnzBxqfP23v73ibO6SogTgoLVWRMckNMcSupjJFG4gcEC6SSQHsglcUjPjygp5ep6ayGK4lZ4kopsmuKztlNZZNmStdskAL7O6Z5z2e6pl/M4YMKsvGAZOzys9K9T+pVAIS6I1El4zTqVnnv/xI7yKQjGFVDTKln2z+sSZj3BwrSXCv7IhNTaXtI+6/M1fpq0Bn/GPCOksRg4JwGBfoNlhgrlu31qmEkV56PCQB1UtzTf1V1QmZkxCsbZIdJE9hXwiqPYVb+Cw8NEE4VD6b7Mfi/p5dAs5DIPiTVLqRr1NFkKo+SUa4dPG5donuMESumRCt938oHrpKfbUrhHpYD/aH0EYSJbwVIZPqcGBLvgwd+/knB1KQg6Im8WKmEpYne4d0H6klqeWA+uB1dJW9/Hol+sAxattRMmnz6QYiA+08K1jGyGI6pgS7J0pddMvwTFCGC3cA3My3ExJTyTurHXb5HxDs6C50Mtw/Oj3sxEu8i+XpCY0QW4Nw+8TPcKuomJTcecQ1jPy0EOC10hxjnapmGkJmqDJAsZ0vbd3Nb9sjPH4ar9+LfXEM8SCkMSGu8QqjbZYI+SuDvx2CeA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(22082099003)(56012099003)(18002099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9SRQqZeod9zpO4ctiKUE+0Y5PgZIyshTF/v5xZW2yLFW8YxKK1/ieojfHPJZtM+pd6piZhewWd5ZRrDQp/vYOOtjBuIhQna5zc8aIOmYHrIB1me/pKTDD3OYIWIqQdyPPz0saOa1cOqwqui1o6LlnR73YS/tAsa03R2N8jYpzi+gQZZyKEBoRqG1J9olxB/QIX4mb8abUFMBfG1jxGeNDyKZSr26izwosEktVSuD3mwOJhV/Wia55ERtij5AmLlUkGGadBMhpjKANkoLCseyU1CZ/xXT6r9HXvE9ba+Gi8QXBEXJ2L5iLybnVuQYthrAbzu5GUyODqLPbC2VGJ6mGi5xdxD5fC5FKf4EtFfID6PsiZlZhZ1FguQy0hU8jGm+5rF7tgyz8ZBAEf+vV8S7iBUd7WzuYp5zyUGbJhsK1mDOVuSk3Cuuqn0hHWkEZK2o
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:31:55.1395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd93daa-d9a5-4257-af2a-08dea31212c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644
X-Rspamd-Queue-Id: 93AC2467DC8
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
	TAGGED_FROM(0.00)[bounces-241143-lists,stable=lfdr.de];
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

When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
leaving them intact lets in-flight DMAs continue to be translated by the
adopted stream table.

Initialize 'enables' to 0 so it can carry CR0_SMMUEN in kdump case. Then,
preserve that when enabling the command queue.

Clear latched gerror bits if necessary.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 47 +++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8423bcc4be69e..b6aade469a6b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5017,11 +5017,28 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
-	u32 reg, enables;
+	u32 reg, enables = 0;
 	struct arm_smmu_cmdq_ent cmd;
 
-	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
+
+	/*
+	 * In a kdump case (set when CR0_SMMUEN=1 and !GERROR_SFM_ERR), retain
+	 * CR0_SMMUEN to avoid aborting in-flight DMA, and CR0_ATSCHK to carry
+	 * on the ATS-check policy.
+	 *
+	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
+	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
+	 * on the adopted stream table from the crashed kernel.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		dev_info(smmu->dev,
+			 "kdump: retaining SMMUEN for in-flight DMA\n");
+		enables = reg & (CR0_SMMUEN | CR0_ATSCHK);
+		goto reset_queues;
+	}
+
+	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	if (reg & CR0_SMMUEN) {
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
@@ -5051,12 +5068,36 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Stream table */
 	arm_smmu_write_strtab(smmu);
 
+reset_queues:
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		/* Disable queues since arm_smmu_device_disable() was skipped */
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to disable queues\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * GERROR bits are latched. Read after queue disabling so that unhandled
+	 * errors would be visible. Ack everything prior to re-enabling the CMDQ
+	 * as a stale CMDQ_ERR would halt the CMDQ and new command will timeout.
+	 */
+	if (is_kdump_kernel()) {
+		u32 gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+		u32 gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+
+		if ((gerror ^ gerrorn) & GERROR_ERR_MASK)
+			writel(gerror, smmu->base + ARM_SMMU_GERRORN);
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
-- 
2.43.0


